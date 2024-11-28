<#       --> LAPS Password Finder <--        #>
<#    IHK Projektprüfung Winter 2024/2025    #>

<#  Projekt von Louis Gleim @ UBFFM - 2024   #>
<#          Icon von Gob Wolter              #>


# Windows Grundbausteine für ein PowerShell Program
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Windows Fenster 
$WindowForm = New-Object System.Windows.Forms.Form
$WindowForm.ClientSize = '480,220'
$WindowForm.FormBorderStyle = 'FixedDialog'
$WindowForm.Text = 'LAPS Password Finder'
$WindowForm.StartPosition = "CenterScreen"
$WindowForm.BackColor = "#E6E6E6"

# Windows Form und Schrift Vereinheitlichung
$LabelObject = [System.Windows.Forms.Label]
$ButtonObject = [System.Windows.Forms.Button]
$DefaultFont = 'Verdana,10'

# Computer Beschriftung
$ComputerLabel = New-Object $LabelObject
$ComputerLabel.Text = 'Computer:'
$ComputerLabel.AutoSize = $true
$ComputerLabel.Font = $DefaultFont
$ComputerLabel.Location = New-Object System.Drawing.Point(20,20)

# Passwort Beschriftung
$PasswordLabel = New-Object $LabelObject
$PasswordLabel.Text = 'Password:'
$PasswordLabel.AutoSize = $true
$PasswordLabel.Font = $DefaultFont
$PasswordLabel.Location = New-Object System.Drawing.Point(20,110)

# Error Anzeige (Unsichtbar solange es keinen Fehler gibt)
$ErrorLabel = New-Object $LabelObject
$ErrorLabel.Text = ''
$ErrorLabel.AutoSize = $true
$ErrorLabel.Font = $DefaultFont
$ErrorLabel.ForeColor = '#FF0000'
$ErrorLabel.Location = New-Object System.Drawing.Point(98,142)

# TextBox um den gesuchten ComputerNamen einzugeben
$ComputerNameTextBox = New-Object System.Windows.Forms.ComboBox
$ComputerNameTextBox.Size = New-Object System.Drawing.Size(360, 24)
$ComputerNameTextBox.Location = New-Object System.Drawing.Point(100, 20)
$ComputerNameTextBox.Text = ''
$ComputerNameTextBox.AutoCompleteMode = 'Suggest'
$ComputerNameTextBox.AutoCompleteSource = 'ListItems'
$ComputerNameTextBox.Add_TextChanged({Update-ComputerNames})

<# # Test Funktion mit vorgegeben Namen
function Get-ComputerNames-Test {
    param ($ComputerName)
    return ('PC-0123', 'PC-0456', 'PC-0789', 'PC-0420','PC-0404')  -like ($ComputerName + "*")    
} #>

# Funktion um Computernamen in der Active Directory zu finden
function Get-ComputerNames-AD {
    param ($ComputerName)
    $ComputerNameObject = [adsisearcher]""
    $ComputerNameObject.Filter = "(&(objectCategory=computer)(objectClass=computer)(sAMAccountName=" + $ComputerName + "*))"
    $Garbage = $ComputerNameObject.PropertiesToLoad.Add("samaccountname")
    $ComputerNameSuggestion = $ComputerNameObject.FindAll().properties.samaccountname
    return $ComputerNameSuggestion  
}

# Funktion fuer das Namenseingabefenster, die Faehigkeit Namensvorschlaege geben zu koennen und das Passwortfenster und die Erroranzeige zu leeren
function Update-ComputerNames {
    $ErrorLabel.Text = ''
    $PasswordTextBox.Text = ''
    $ShowPasswordButton.Enabled = $false
    $CopyPasswordButton.Enabled = $false 
    if ($This.Text.Length -ge 3){
        $ComputerNames = Get-ComputerNames-AD($This.Text)
        if ($ComputerNames) {
            if (@($ComputerNames).Length -eq 1){
                $ShowPasswordButton.Enabled = $true
            }
            $This.Items.AddRange($ComputerNames)
        } else {
            $ErrorLabel.Text = 'Error: Computer not found!'
        }
    }
}

# Passwort Textbox
$PasswordTextBox = New-Object System.Windows.Forms.TextBox
$PasswordTextBox.Size = New-Object System.Drawing.Size(320, 24)
$PasswordTextBox.Location = New-Object System.Drawing.Point(100, 110)
$PasswordTextBox.ReadOnly = $true
$PasswordTextBox.Text = ''

# Passwort anzeigen Button
$ShowPasswordButton = New-Object $ButtonObject
$ShowPasswordButton.Text = 'Show Password'
$ShowPasswordButton.Size = New-Object System.Drawing.Size(174,24)
$ShowPasswordButton.Font = $DefaultFont
$ShowPasswordButton.Location = New-Object System.Drawing.Point(286,60)
$ShowPasswordButton.Enabled = $false
$ShowPasswordButton.Add_Click({Update-Password})

<# # Test Funktion mit vorgegebenen Passwoertern
function Get-Password-Test {
    param ($ComputerName)
    if ($ComputerName -eq 'PC-0123') {
        return ('PW0123works')
    }
    elseif ($ComputerName -eq 'PC-0456') {
        return ('PW0456workz')
    }
    elseif ($ComputerName -eq 'PC-0789') {
        return ('PW0789wurkse')
    }
    elseif ($ComputerName -eq 'PC-042') {
        return ('Lebenworkz')
    }
} #>

# Funktion zum auslesen der Computer Passwoerter
function Get-Password-AD {
    param ($ComputerName)
    $ComputerNameObject = [adsisearcher]""
    $ComputerNameObject.Filter = "(&(objectCategory=computer)(objectClass=computer)(sAMAccountName=" + $ComputerName + "*))"
    $Garbage = $ComputerNameObject.PropertiesToLoad.Add("mslaps-password")
    $JsonObject = $ComputerNameObject.FindOne().properties."mslaps-password"
    $UnJsonObject = $JsonObject | ConvertFrom-Json
    $Password = $UnJsonObject.p
    return ($Password)
}

# Funktion um Passwort anzuzeigen oder Error abzufangen und anzuzeigen
function Update-Password {
    $ComputerPassword = Get-Password-AD($ComputerNameTextBox.Text)   
    if ($ComputerPassword) {
        $PasswordTextBox.Text = $ComputerPassword
        $CopyPasswordButton.Enabled = $true
    } else {
        $ErrorLabel.Text = 'Error: Password not found!'
    }
}

# Passwort kopieren Button
$CopyPasswordButton = New-Object $ButtonObject
$CopyPasswordButton.Size = New-Object System.Drawing.Size(40,20) 
$CopyPasswordButton.Location = New-Object System.Drawing.Point(420,110)
$CopyPasswordButton.Text = 'Copy'
$CopyPasswordButton.Font = 'Verdana,8'
$CopyPasswordButton.Enabled = $false
$CopyPasswordButton.Add_Click({Set-Clipboard -Value $PasswordTextBox.Text})

# Reset Button
$ResetButton = New-Object $ButtonObject
$ResetButton.Size = New-Object System.Drawing.Size(174,24)
$ResetButton.Location = New-Object System.Drawing.Point(100,60)
$ResetButton.Font = $DefaultFont
$ResetButton.Text = 'Reset'
$ResetButton.Add_Click({$ComputerNameTextBox.Text = ''})
$ResetButton.Add_Click({$PasswordTextBox.Text = ''})
$ResetButton.Add_Click({$ErrorLabel.Text = ''})
$ResetButton.Add_Click({$ShowPasswordButton.Enabled = $false})
$ResetButton.Add_Click({$CopyPasswordButton.Enabled = $false})

# Schließen Button
$CloseButton = New-Object $ButtonObject
$CloseButton.Text = 'Close'
$CloseButton.Size = New-Object System.Drawing.Size(84,24)
$CloseButton.Font = $DefaultFont
$CloseButton.Location = New-Object System.Drawing.Point(376,180)
$CloseButton.Add_Click({$WindowForm.Close()})

# Signatur 
$SignaturWatermark = New-Object $LabelObject
$SignaturWatermark.Text = 'Developed by Louis Gleim @ UBFFM - 2024'
$SignaturWatermark.AutoSize = $true
$SignaturWatermark.Font = 'Verdana,6'
$SignaturWatermark.ForeColor = '#424242'
$SignaturWatermark.Location = New-Object System.Drawing.Point(20,192)

# Elemente um das Windows Fenster zu laden
$WindowForm.Controls.AddRange(@($ComputerLabel, $PasswordLabel, $SignaturWatermark, $ErrorLabel, $ComputerNameTextBox,
$ShowPasswordButton, $PasswordTextBox, $CopyPasswordButton, $ResetButton, $CloseButton))
$Garbage = $WindowForm.ShowDialog()  <# -> $Garbage <- ist eine Abfangvariable um unerwünschte Nebeneffekte des darin gespeicherten Codes abzufangen. #>
$WindowForm.Dispose()