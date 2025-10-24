/*
Hochschule für Wirtschaft und Recht Berlin
Fachbereich Duales Studium Wirtschaft | Technik
ET1031 Mathematische Grundlagen III (Signale und Systeme)
Prof. Dr. Luis Fernando Ferreira Furtado
18.10.2024
*/

// Define variables to measure the average amplitude offset
unsigned int offset_cycle_counter = 25000; // The amount of points to be measured (ca. 2~3 seconds)
double offset_amp = 0; // The average amplitude

void setup()
{
  // Set the baud rate
  Serial.begin(115200);

  // Sum and average the measurements calculate the amplitude offset
  for(unsigned int n=0; n < offset_cycle_counter; n++){
     offset_amp += analogRead(A0);
  }
  offset_amp = offset_amp / offset_cycle_counter;

  // Print the amplitude offset
  Serial.println(offset_amp);

}

void loop()
{ 
  // Create a double float point variable to match with the amplitude offset variable type
  double analog_input = analogRead(A0);
  // Stream the value of the analog input with the corrected offset
  Serial.println(analog_input - offset_amp);
}

