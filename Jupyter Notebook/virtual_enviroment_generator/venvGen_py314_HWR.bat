@ECHO OFF
ECHO  !--- venvGen_py314_HWR.bat ---------------------------------------------------------------! 
ECHO  !                                                                                         !
ECHO  ! 1. Diese Batch-Datei automatisiert die Installation und Konfiguration von Bibliotheken  !
ECHO  !    in einer lokalen Python Virtual-Enviroment fuer die allgemeine Entwicklung an der    !
ECHO  !    HWR-Berlin, Fachbereich 2, Studiengang Industrielle Elektrotechnik: py314_HWR.       !
ECHO  ! 2. Python Version 3.14 muss bereits auf Ihrem Rechner installiert sein.                 !
ECHO  ! 3. Das kann einige Zeit dauern. Holen Sie sich in der Zwischenzeit einen Kaffee :)      !
ECHO  ! 4. Wenn die Installation beendet ist, wird dieser Terminal automatisch geschlossen.     !
ECHO  !                                                                                         !
ECHO  !-------------------------------------- Prof. Dr. L. F. F. Furtado, Berlin, 01.08.2026 ---!
PAUSE 
ECHO.
ECHO 1/5  Erstellung der Python-Virtual-Enviroment "py314_HWR" im "C:\" 
py -3.14 -m venv C:\py314_HWR
cd C:\py314_HWR
copy %0 venvGen_py314_HWR.bat

ECHO 2/5  Erstellung der Requirements im "C:\py314_HWR\requirements.txt"
ECHO numpy==2.4.6 >> requirements.txt
ECHO pandas==3.0.5 >> requirements.txt
ECHO matplotlib==3.11.1 >> requirements.txt
ECHO scipy==1.18.0 >> requirements.txt
ECHO si-prefix==1.3.3 >> requirements.txt
ECHO plotly==6.9.0 >> requirements.txt
ECHO sympy==1.14.0 >> requirements.txt
ECHO notebook==7.6.1 >> requirements.txt
ECHO ipywidgets==8.1.8 >> requirements.txt
ECHO librosa==0.11.0 >> requirements.txt
ECHO pyserial==3.5 >> requirements.txt

ECHO 3/5  Erstellung der Datei zur Ausfuehrung des Jupyter-Notebooks im "C:\py314_HWR\py314_HWR_notebook.bat"
ECHO @ECHO OFF > py314_HWR_notebook.bat
ECHO ECHO  !--- py314_HWR_notebook.bat ---------------------------------------------------! >> py314_HWR_notebook.bat
ECHO ECHO  !                                                                              ! >> py314_HWR_notebook.bat
ECHO ECHO  ! -------- Autorun des Jupyter-Notebooks in der Virtual-Enviroment ----------- ! >> py314_HWR_notebook.bat
ECHO ECHO  ! 1. Python Version 3.14 muss bereits auf Ihrem Rechner installiert sein.      ! >> py314_HWR_notebook.bat
ECHO ECHO  ! 2. Die Virtual-Enviroment "py314_HWR" muss ebenfalls installiert sein.       ! >> py314_HWR_notebook.bat
ECHO ECHO  !                                                                              ! >> py314_HWR_notebook.bat
ECHO ECHO  !--------------------------- Prof. Dr. L. F. F. Furtado, Berlin, 01.08.2026 ---! >> py314_HWR_notebook.bat  
ECHO ECHO. >> py314_HWR_notebook.bat
ECHO C:\py314_HWR\Scripts\activate ^>^> py314_HWR_notebook.bat ^&^& jupyter notebook --notebook-dir=C:\ --KernelSpecManager.allowed_kernelspecs=py314_hwr --KernelSpecManager.ensure_native_kernel=false >> py314_HWR_notebook.bat

ECHO 4/5  Alle erforderlichen Python-Bibliotheken werden im naechsten Schritt installiert :)
C:\py314_HWR\Scripts\activate && python -m pip install --upgrade pip && pip install -r C:\py314_HWR\requirements.txt && python -m ipykernel install --user --name=py314_HWR && deactivate

ECHO 5/5  Ihre Virtual-Enviroment ist jetzt bereit unter C:\py314_HWR\