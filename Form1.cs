using System;
using System.Collections.Generic;
using System.IO;

namespace Backup
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        static long arquivos = 0;
        static long diretorios = 0;

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            //FolderBrowserDialog fbd1 = new FolderBrowserDialog();
            //fbd1.Description = "Selecione um diretório";
            //fbd1.RootFolder = Environment.SpecialFolder.MyComputer;
            //fbd1.ShowNewFolderButton = true;
            //
            //DialogResult resultado = fbd1.ShowDialog();
            //
            //if (resultado == DialogResult.OK)
            //{
            //    textBox1.Text = fbd1.SelectedPath;
            //}
            OpenFileDialog ofd1 = new OpenFileDialog();
            //define as propriedades do controle OpenFileDialog
            ofd1.Multiselect = false;
            ofd1.Title = "Selecionar Arquivo";
            ofd1.InitialDirectory = @"C:\dados\txt";
            //filtra para exibir todos os arquivos
            ofd1.Filter = "All files (*.*)|*.*";
            ofd1.CheckFileExists = true;
            ofd1.CheckPathExists = true;
            ofd1.FilterIndex = 1;
            ofd1.RestoreDirectory = true;
            ofd1.ReadOnlyChecked = true;
            ofd1.ShowReadOnly = true;
            DialogResult dr = ofd1.ShowDialog();
            if (dr == DialogResult.OK)
            {
                //atribui o nome do arquivo ao arquivo texto
                textBox1.Text = ofd1.FileName;
            }
        }

        private void listBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        public static class ProcessaInfo
        {
            public static IEnumerable<FileSystemInfo> GetArquivosDiretorios(string dir)
            {
                if (string.IsNullOrWhiteSpace(dir))
                {
                    throw new ArgumentNullException(nameof(dir));
                }
                //define uma instância da classe DirectoryInfo
                DirectoryInfo dirInfo = new DirectoryInfo(dir);
                //define uma pilha de objetos FileSystemInfo e insere o objeto no topo da pilha
                Stack<FileSystemInfo> stack = new Stack<FileSystemInfo>();
                stack.Push(dirInfo);
                //itera enquanto for diferente de null e o contador da pilha for maior que zero
                while (dirInfo != null || stack.Count > 0)
                {
                    //retorna o objeto do topo da pilha e remove
                    FileSystemInfo fileSystemInfo = stack.Pop();
                    DirectoryInfo subDiretorioInfo = fileSystemInfo as DirectoryInfo;
                    if (subDiretorioInfo != null)
                    {
                        //retorna cada elemento individualmente
                        yield return subDiretorioInfo;
                        foreach (FileSystemInfo fsi in subDiretorioInfo.GetFileSystemInfos())
                        {
                            //insere o objeto no topo da pilha
                            stack.Push(fsi);
                        }
                        dirInfo = subDiretorioInfo;
                    }
                    else
                    {
                        //retorna cada elemento individualmente
                        yield return fileSystemInfo;
                        dirInfo = null;
                    }
                }
            }
        }
        private void button2_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(textBox1.Text) && !string.IsNullOrEmpty(textBox2.Text))
            {
                try
                {
                    string origem = textBox1.Text;
                    string arquivo = Path.GetFileName(origem);
                    string destino = Path.Combine(textBox2.Text, arquivo);
                    if (checkBox1.Checked)
                    {
                        //copia o arquivo e sobrescreve se ja existir
                        File.Copy(origem, destino, true);
                        MessageBox.Show($"Arquivo {origem} Copiado com sucesso \npara {destino}");
                    }
                    else if (checkBox2.Checked)
                    {
                        if (File.Exists(destino))
                        {
                            if (MessageBox.Show("O arquivo já existe. Deseja deletar o arquivo e continuar ?", "Confirma",
     MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) == DialogResult.Yes)
                            {
                                try
                                {
                                    File.Delete(destino);
                                }
                                catch (IOException ex)
                                {
                                    Console.WriteLine(ex.Message);
                                    return;
                                }
                            }
                            else
                            {
                                return;
                            }
                        }
                        File.Move(origem, destino);
                        MessageBox.Show($"Arquivo {origem} Movido com sucesso \npara {destino}");
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Erro : " + ex.Message);
                }
            }
            else
            {
                MessageBox.Show("Selecione um arquivo e um diretório de destino");
            }
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void button3_Click(object sender, EventArgs e)
        {
            FolderBrowserDialog fbd2 = new FolderBrowserDialog();
            fbd2.Description = "Selecione um diretório";
            fbd2.RootFolder = Environment.SpecialFolder.MyComputer;
            fbd2.ShowNewFolderButton = true;

            DialogResult resultado = fbd2.ShowDialog();

            if (resultado == DialogResult.OK)
            {
                textBox2.Text = fbd2.SelectedPath;
            }
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void checkBox2_CheckedChanged(object sender, EventArgs e)
        {

        }
    }
}