@ECHO OFF
ECHO  !--- venvGen_py311_HWR.bat ---------------------------------------------------------------! 
ECHO  !                                                                                         !
ECHO  ! 1. Diese Batch-Datei automatisiert die Installation und Konfiguration von Bibliotheken  !
ECHO  !    in einer lokalen Python Virtual-Enviroment fuer die allgemeine Entwicklung an der    !
ECHO  !    HWR-Berlin, Fachbereich 2, Studiengang Industrielle Elektrotechnik: py311_HWR.       !
ECHO  ! 2. Python Version 3.11 muss bereits auf Ihrem Rechner installiert sein.                 !
ECHO  ! 3. Das kann einige Zeit dauern. Holen Sie sich in der Zwischenzeit einen Kaffee :)      !
ECHO  ! 4. Wenn die Installation beendet ist, wird dieser Terminal automatisch geschlossen.     !
ECHO  !                                                                                         !
ECHO  !-------------------------------------- Prof. Dr. L. F. F. Furtado, Berlin, 21.08.2025 ---!
PAUSE 
ECHO.
ECHO 1/5  Erstellung der Python-Virtual-Enviroment "py311_HWR" im "C:\" 
py -3.11 -m venv C:\py311_HWR
cd C:\py311_HWR
copy %0 venvGen_py311_HWR.bat

ECHO 2/5  Erstellung der Requirements im "C:\requirements.txt"
ECHO numpy==2.0.2 >> requirements.txt
ECHO pandas==2.2.2 >> requirements.txt
ECHO matplotlib==3.10.0 >> requirements.txt
ECHO scipy==1.15.3 >> requirements.txt
ECHO si-prefix==1.3.3 >> requirements.txt
ECHO plotly==5.24.1 >> requirements.txt
ECHO sympy==1.13.1 >> requirements.txt
ECHO notebook==7.4.4 >> requirements.txt
ECHO ipywidgets==8.1.2 >> requirements.txt
ECHO librosa==0.11.0 >> requirements.txt
ECHO pyserial==3.5 >> requirements.txt

ECHO 3/5  Erstellung der Datei zur Ausfuehrung des Jupyter-Notebooks im "C:\py311_HWR_notebook.bat"
ECHO @ECHO OFF > py311_HWR_notebook.bat
ECHO ECHO  !--- py311_HWR_notebook.bat ---------------------------------------------------! >> py311_HWR_notebook.bat
ECHO ECHO  !                                                                              ! >> py311_HWR_notebook.bat
ECHO ECHO  ! -------- Autorun des Jupyter-Notebooks in der Virtual-Enviroment ----------- ! >> py311_HWR_notebook.bat
ECHO ECHO  ! 1. Python Version 3.11 muss bereits auf Ihrem Rechner installiert sein.      ! >> py311_HWR_notebook.bat
ECHO ECHO  ! 2. Die Virtual-Enviroment "py311_HWR" muss ebenfalls installiert sein.       ! >> py311_HWR_notebook.bat
ECHO ECHO  !                                                                              ! >> py311_HWR_notebook.bat
ECHO ECHO  !--------------------------- Prof. Dr. L. F. F. Furtado, Berlin, 21.08.2025 ---! >> py311_HWR_notebook.bat  
ECHO ECHO. >> py311_HWR_notebook.bat
ECHO C:\py311_HWR\Scripts\activate ^>^> py311_HWR_notebook.bat ^&^& jupyter notebook --notebook-dir=C:\ --KernelSpecManager.allowed_kernelspecs=py311_hwr --KernelSpecManager.ensure_native_kernel=false >> py311_HWR_notebook.bat

ECHO 4/5  Alle erforderlichen Python-Bibliotheken werden im naechsten Schritt installiert :)
C:\py311_HWR\Scripts\activate && python -m pip install --upgrade pip && pip install -r C:\py311_HWR\requirements.txt && python -m ipykernel install --user --name=py311_HWR && deactivate

ECHO 5/5  Ihre Virtual-Enviroment ist jetzt bereit unter C:\py311_HWR\