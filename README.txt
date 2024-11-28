########################################################### LAPS Password Finder  #############################################################################


Der LAPS Password Finder ist eine schlichte und schlichte Windows Software um schnell das Tagespasswort
für Administratorenrechte von Computern der Active Direktory zu erfahren.

Damit die Software funktioniert, wird eine Lesebrechtigung der Active Directory benötigt.

Die Software wurde mit Powershell realisiert.

###############################################################################################################################################################

Anwendung:
Das Ausführen der "LAPS Password Finder.exe" startet die Software.
Geben Sie einen Computernamen in die Computer Textbox ein.
Sobald die Software einen Computer in der Active Directory findet, kann der "Show Password" Button gedrückt werden.
Der "Show Password" Button kann nur betätigt werden, wenn die Software exakt einen Computernamen finden kann.
Nun wird das gesuchte Passwort in der Passwort Textbox angezeigt und kann entweder mit der Maus, dem Tastaturbefehl (strg + c)
oder mit dem "Copy" Button kopiert werden.
Der "Copy" Button kann nur betätigt werden, wenn die Software ein Passwort finden kann.
Sollte die Software den angegebenen Computernamen nicht finden wird eine Fehlermeldung in roter Schrift unter der Passwort Textbox angezeigt.
Sollte die Software kein Passwort zum angegebenen Computernamen finden wird eine Fehlermeldung in roter Schrift unter der Passwort Textbox angezeigt.
Um die Suche zurückzusetzen und alle Aktionsfelder der Software zu leeren klicken Sie auf den "Reset" Button
oder löschen Sie den Computername aus der Computer Textbox. Der Inhalt der Passwort Textbox wird dabei ebenfalls automatisch gelöscht.
Zum Beenden der Software klicken Sie auf den "Close" Button oder auf das rote 'X' oben in der rechten Ecke des Fensters.

###############################################################################################################################################################

Dieses Projekt steht unter MIT-Lizenz.

Version 1.0
Copyright: 			Louis Gleim, Universitätsbibliothek J.C. Senkenberg in Frankfurt am Main (UBFFM) 2024
Icon erstellt von: 	Gob Wolter

###############################################################################################################################################################