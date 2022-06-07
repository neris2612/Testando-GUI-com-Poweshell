Add-Type -assembly System.Windows.Forms

###ocultando janela do console(está desabilitado para testes, pois fecha a janela do IDE também rsrs)
#$t = '[DllImport("user32.dll")] public static extern bool ShowWindow(int handle, int state);'
#add-type -name win -member $t -namespace native
#[native.win]::ShowWindow(([System.Diagnostics.Process]::GetCurrentProcess() | Get-Process).MainWindowHandle, 0)

# janela principal da interface
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text = 'Backup_GUI'
$main_form.Width = 600
$main_form.Height = 600
$main_form.AutoSize = $false

#criando a primeira label
$source = New-Object System.Windows.Forms.Label
$source.Text = 'Origem: '
$source.Location = New-Object System.Drawing.Point(10, 100)
$main_form.Controls.Add($source)

#criando textInput da Label origem
$caixa_texto = New-Object System.Windows.Forms.Label
$caixa_texto.Text = ''
$caixa_texto.Location = New-Object System.Drawing.Point(120, 100)
#$caixa_texto.
$main_form.Controls.Add($caixa_texto)

#criando o botão para abrir os diretórios
$button = New-Object System.Windows.Forms.Button
$button.Text = 'Abrir'
$button.Location = New-Object System.Drawing.Point(150,500)
$button.Add_Click(
{
$a = New-Object System.Windows.Forms.FolderBrowserDialog
$b = $a.ShowDialog()
#$b.GetDirectoryName("c:\")
#$c.Location = New-Object System.Drawing.Point(120,100)
#$c = New-Object System.Windows.Forms.DialogResult
#$c.ToString($b)
#$main_form.Controls.Add($c)
}
)
$main_form.Controls.Add($button)

#carregar diretórios
#$dir = Path.GetIt-1020-005@ad

#botão para fechar janela
$button2 = New-Object System.Windows.Forms.Button
$button2.Text = 'Sair'
$button2.Location = New-Object System.Drawing.Point(250,500)
$button2.Add_Click(
{
$main_form.Close()
}
)
$main_form.Controls.Add($button2)

#New-Object System.Web.UI.WebControls

#comando para exibir a janela principal e seu conteúdo
$main_form.ShowDialog()