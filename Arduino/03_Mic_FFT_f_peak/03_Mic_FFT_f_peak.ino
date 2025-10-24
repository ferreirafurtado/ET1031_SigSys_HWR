/*
Hochschule für Wirtschaft und Recht Berlin
Fachbereich Duales Studium Wirtschaft | Technik
ET1031 Mathematische Grundlagen III (Signale und Systeme)
Prof. Dr. Luis Fernando Ferreira Furtado
18.10.2024

Beispiel 11.2 - Arduino als Spektrometer

Code and library reference:
  [1] Condés, E.; Homb, R.R.. "Arduino FFT libray". 2018.
      Retrieved Oktober 6, 2022 from https://github.com/kosme/arduinoFFT
*/

#include "arduinoFFT.h"

// Set a delay between executions of the FFT to not overload the jupyter notebook with the serial communication
const int delay_serial = 100;

// Configure the slicing size of the samples and the sampling frequency of the FFT
const uint16_t samples = 128; // N samples: this value MUST ALWAYS be a power of 2 for FFT
const double samplingFrequency = 800;  // Sampling frequency in Hz (max. Arduino samplingFrequency = 9615 Hz)

// Define general use variables
unsigned int sampling_period_us;
unsigned long microseconds;
unsigned long starttime;  

// Define two arrays to store the real and imaginary values of the complex numbers for each sample
double vReal[samples];
double vImag[samples];

// Create FFT-object
ArduinoFFT<double> FFT = ArduinoFFT<double>(vReal, vImag, samples, samplingFrequency);

// Define variables to measure the average amplitude offset
unsigned int offset_cycle_counter = 25000; // The amount of points to be measured (ca. 2~3 seconds)
double offset_amp = 0; // The average amplitude

// Set up the sampling period in microseconds and configure the serial baudrate
void setup() {
  // Calculate the sampling period
  sampling_period_us = round(1000000*(1.0/samplingFrequency));

  // Set the baud rate
  Serial.begin(115200);

  // Sum and average the measurements calculate the amplitude offset
  for(unsigned int n=0; n < offset_cycle_counter; n++){
     offset_amp += analogRead(A0);
  }
  offset_amp = offset_amp / offset_cycle_counter;
}

// Execute the loop
void loop() {

  // Sample the data x[n] in the time domain
  // Get N samples of the microphone in time domain.
  for(int n=0; n<samples; n++) {
    
    // Read analog input and fill the array with real microphone data
    vReal[n] = analogRead(0) - offset_amp;
    vImag[n] = 0;   

    // Update the variable microseconds with the internal time counter of the microcontroler
    microseconds = micros();  
    while(micros() < (microseconds + sampling_period_us)){
      // Wait the sampling period to keep executing the microphone sampling process
    }
  }

  // Fourier-Transformation: transorm the data from the time domain x[n] to the frequency domain X(f)
  // Execute the windowing of the time signal with the Hamming method, to contribute to the pulse sharping
  FFT.windowing(vReal, samples, FFT_WIN_TYP_HAMMING, FFT_FORWARD);
  // Compute the FFT
  FFT.compute(vReal, vImag, samples, FFT_FORWARD);
  // Convert the complex values to real magnitude values
  FFT.complexToMagnitude(vReal, vImag, samples);
  // Find the dominant frequency in the sampled signal and save it in the variable peak
  double f_peak = FFT.majorPeak(vReal, samples, samplingFrequency);
  // Result a: the array vReal has an array with the magnitude for each frequency bin (0 to samplingFrequency/2)
  // Result b: the variable f_peak has the value in Hz of the most dominant frequency

  // Print only the value of the peak with the most dominant frequency
  Serial.println(f_peak, 1);

  // Wait the configured time, then repeat the process
  delay(delay_serial);  
}
