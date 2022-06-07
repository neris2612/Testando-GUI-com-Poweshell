﻿Add-Type -assembly System.Windows.Forms

$result = Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "IPEnabled=TRUE"
foreach ($nic in $result)
{
#$nic
}

$main_form = New-Object System.Windows.Forms.Form
$main_form.Text = 'Scripts'
$main_form.Width = 600
$main_form.Height = 600
$main_form.AutoSize = $false

$Label = New-Object System.Windows.Forms.Label
$Label.Text = 'Backup'
$Label.Location = New-Object System.Drawing.Point(0,0)
$Label.AutoSize = $true
$main_form.Controls.Add($Label)

$ComboBox = New-Object System.Windows.Forms.ComboBox
$ComboBox.Width = 300
$ComboBox.Location = New-Object System.Drawing.Point(110,183)
$shell = New-Object -ComObject Shell.Application
$selectedfolder = $shell.BrowseForFolder( 0, 'Selecione uma pasta para prosseguir', 16, $shell.NameSpace( 17 ).Self.Path ).Self.Path
foreach($shell in $shell){
$ComboBox.Items.Add($shell)
}
#adiciona itens dentro do menu suspenso
$ComboBox.Items.Add("Teste")

$main_form.Controls.Add($ComboBox)

$data = New-Object System.Windows.Forms.Label
$data.Text = Get-date
$data.Location = New-Object System.Drawing.Point(200,80)
$main_form.Controls.Add($data)

$abrir_explorer = New-Object System.Windows.Forms.Button
$abrir_explorer.Text = 'Abrir Explorer'
$abrir_explorer.Width = 90
$abrir_explorer.Location = New-Object System.Drawing.Point(10,80)
$abrir_explorer.Add_Click(
{
explorer.exe
}
)
$main_form.Controls.Add($abrir_explorer)

$mudar_data = New-Object System.Windows.Forms.Button
$mudar_data.Text = 'Mudar data'
$mudar_data.Width = 90
$mudar_data.Location = New-Object System.Drawing.Point(10,110)
$mudar_data.Add_Click(
{
(Get-Date).AddDays(1)
}
)
$main_form.Controls.Add($mudar_data)

$box = New-Object System.Windows.Forms.Button
$box.Text = 'BOX'
$box.Location = New-Object System.Drawing.Point(10,135)
$box.Width = 90
$box.Add_Click(
{
$answer = [System.Windows.MessageBox]::Show("Você conseguiu!", "Script completo", "OK", "Information")
}
)
$main_form.Controls.Add($box)

#$menu = New-Object System.Windows.Forms.MainMenu

##iniciando a inclusão do codigo de backup
$fun = New-Object System.Windows.Forms.Button
$fun.Text = 'Fun'
$fun.Width = 90
$fun.Location = New-Object System.Drawing.Point(10,160)
$fun.Add_Click(
{
MSG * /SERVER:LT-0322-002 “Sua sessão será finalizada em alguns minutos. Salve seus arquivos e encerre os programas.”
}
)
$main_form.Controls.Add($fun)

$abrir_janela = New-Object System.Windows.Forms.Button
$abrir_janela.Text = 'Abrir Janela'
$abrir_janela.Width = 90
$abrir_janela.Location = New-Object System.Drawing.Point(10,182)
$abrir_janela.Add_Click(
{
$shell = New-Object -ComObject Shell.Application

$selectedfolder = $shell.BrowseForFolder( 0, 'Selecione uma pasta para prosseguir', 16, $shell.NameSpace( 17 ).Self.Path ).Self.Path
}
)
$main_form.Controls.Add($abrir_janela)

$copiar = New-Object System.Windows.Forms.Button
$copiar.Text = 'Copiar'
$copiar.Width = 90
$copiar.Location = New-Object System.Drawing.Point(10,205)
$copiar.Add_Click(
{
Copy-Item -Path "C:\Users\matheus.silva\Desktop\Teste\a.txt" -Destination "C:\Users\matheus.silva\Desktop\Teste2"
}
)
$main_form.Controls.Add($copiar)

$mover = New-Object System.Windows.Forms.Button
$mover.Text = 'mover'
$mover.Width = 90
$mover.Location = New-Object System.Drawing.Point(10,230)
$mover.Add_Click(
{
Get-ChildItem -Path "C:\Users\matheus.silva\Desktop\Teste" -Recurse | Move-Item -Destination "C:\Users\matheus.silva\Desktop\Teste2"
Move-Item -Path "C:\Users\matheus.silva\Desktop\Teste\a.txt" -Destination "C:\Users\matheus.silva\Desktop\Teste2" 
}
)
$main_form.Controls.Add($mover)

$main_form.ShowDialog()