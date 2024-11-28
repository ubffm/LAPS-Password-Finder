# Erzeugen der LAPS Password Finder.exe

### Vorraussetzungen:

- PowerShell mit administrativer Berechtigung
- Die `.ps1`-Datei die dem Code beinhaltet
- Die `.ico`-Datei für das Icon


## Installation des PS2EXE Moduls
Öffnen Sie als Administrator die PowerShell Console.
Geben Sie folgendes in die Console ein und bestätigen mit `Enter`:
```ps
Set-ExecutionPolicy -ExecutionPolicy AllSigned
```
Damit wird die Berechtigung gegeben um das `ps2exe`-Modul zu installieren.
Um die Installation der ps2exe zu starten geben Sie folgendes in die Console ein:

```ps
Install-Module -Name ps2exe
```
Nachdem Sie die Sicherheitsbestätigungen gegeben haben wird das Modul installiert. \
***Diese Schritte müssen nur einmalig Ausgeführt werden und gelten fortlaufend.***

## Erzeugen der .EXE
Nun kann mit folgendem Befehl das "PowerShell to EXE" Modul ausgeführt werden:
```ps
win-ps2exe
```
Dieser Befehl wird eine neues Fenster öffnen, in dem Sie den Dateipfad mit dem Namen und der Endung der `.ps1`-Datei angeben können, die in `.exe` umgeschrieben werden soll. Dazu muss auch der Dateipfad für die erzeugte `.exe`-Datei angegeben werden. 

***Auf den Dateipfad, den Namen und die Endungen ( `.ps1` / `.exe` / `.ico` ) muss genaustens geachtet werden! Wenn die Endung in einem Dateipfad oder der Dateipfad selbst nicht stimmt kann es zu Fehlern kommen!*** 

Wenn Vorhanden, kann in dem dritten Dateipfadfenster eine `.ico`-Datei angeben werden, um die `.exe`-Datei mit einem Icon zu erzeugen. \
Anschließend gibt es Textfelder um Copyright, Name der Datei, Beschreibung der Datei und eine Versionsnummer einzutragen. Dies findet man unter den Eigenschaften der Datei nachdem sie erzeugt wurde.
Dazu kommen verschieden Haken die man setzen kann um Regeln und arbeitsweisen der zu erzeugenden Datei festzulegen. \
Darunter fällt z.B.: Nur als Administrator ausführbar, Thread Arpartment State, CPU Platform und ob bei der Erzeugung der `.exe`-Datei eine configFile miterzeugt werden soll.

Alternativ kann in der PowerShell Console zu dem Ordner der Komponenten gewechselt werden und folgender Code benutzt werden um die `.exe` direkt zu erzeugen:
```ps
ps2exe -inputFile .\LAPS_Password_Finder.ps1 -iconFile .\LAPS_PWF_Projekt-Icon.ico -outputFile '.\LAPS Password Finder.exe' -noConsole -description 'Search engine for LAPS passwords' -company 'UBFFM' -product 'LAPS Password Finder' -copyright 'UBFFM, Louis Gleim - 2024' -version '1.0.0.0' -noOutput -noError
```