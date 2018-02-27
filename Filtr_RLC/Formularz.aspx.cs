using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Numerics;
using System.Data;
using System.Web.UI.DataVisualization.Charting;


public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MultiView1.SetActiveView(V_Glowna);
            pole_edycja.Visible = false;
            Pan_amp.Visible = false;
            Pan_I.Visible = false;
            Pan_faz.Visible = false;    
        }
    }

    protected void Link_Button_Command(object sender, CommandEventArgs e)
    {

        switch ((String)e.CommandName)
        {
            case "Strona_Glowna":
                {
                    MultiView1.SetActiveView(V_Glowna);
                    break;
                }
            case "Symulacja":
                {
                    MultiView1.SetActiveView(V_Symulacja);
                    break;
                }
            case "Teoria":
                {
                    MultiView1.SetActiveView(V_Teoria);
                    break;
                }                 
        }
    }


    protected void Edycja_Button_Command(object sender, CommandEventArgs e)
    {
        pole_edycja.Visible = true;
        Pan_amp.Visible = false;
        Pan_I.Visible = false;
        Pan_faz.Visible = false;
        Panel3.Focus();
        uwaga.Text = "";

    }


    private double Am = 0;  //amplituda
    private double fzas = 0;  //czes zasilania
    private double fzakres = 0;
    private double f = 0;   //czestowliosc w danym punkcie
    private double fstart = 0;
    private double t = 0;
    private double R1 = 0;
    private double R2 = 0;
    private double L = 0;
    private double C = 0;
    private double U1 = 0;
    private double w = 0;   //pulsacja
    private double[,] Results;
    private double[,] Results1;
    private int size = 100000;


    protected void Widm_amp_Button_Command(object sender, CommandEventArgs e)
    {
        if (pole_edycja.Visible)
        {
            
            Panel3.Focus();
            Pan_amp.Visible = true;
            Pan_I.Visible = false;
            Pan_faz.Visible = false;
            kompilacja();
        }
        else
        {
            uwaga.Text = "Najpierw należy przeprowadzić symulację, edytując jej parametry!";
        }
    }

    protected void Edycja2_Button_Command(object sender, CommandEventArgs e)
    {

        if (pole_edycja.Visible)
        {
            
            Panel3.Focus();
            Pan_amp.Visible = false;
            Pan_I.Visible = true;
            Pan_faz.Visible = false;
            kompilacja();

        }
        else
        {
            uwaga.Text = "Najpierw należy przeprowadzić symulację, edytując jej parametry!";
        }



    }
    protected void Widm_faz_Button_Command(object sender, CommandEventArgs e)
    {

        if (pole_edycja.Visible)
        {
            
            Panel3.Focus();
            Pan_amp.Visible = false;
            Pan_I.Visible = false;
            Pan_faz.Visible = true;
            kompilacja();
            
        }
        else
        {
            uwaga.Text = "Najpierw należy przeprowadzić symulację, edytując jej parametry!";
        }


    }
    protected void kompilacja()
    {


        Double.TryParse(txtR1.Text, out R1);
        Double.TryParse(txtR2.Text, out R2);
        Double.TryParse(txtL.Text, out L);
        Double.TryParse(txtC.Text, out C);
        Double.TryParse(txtF.Text, out fzas);
        Double.TryParse(txtAmp.Text, out Am);
        Double.TryParse(txtfzakres.Text, out fzakres);
        Double.TryParse(txtfstart.Text, out fstart);


        Results = new double[size, 2];
        Results1 = new double[size, 2];

        for (int i = 0; i < fzakres; i++)
        {
            f = fstart;
            w = 2 * Math.PI * f;
            t = (1 / fzas) / 4;
            U1 = Am * Math.Sin(2 * Math.PI * fzas * t);
            Complex Xc = new Complex(0, -1 / (w * C));
            Complex Xl = new Complex(0, w * L);
            Complex R11 = new Complex(R1, 0);
            Complex R22 = new Complex(R2, 0);
            Complex Z1 = Complex.Add(Xl, R22);
            Complex Z2 = Complex.Divide(Complex.Multiply(R11, Z1), Complex.Add(R11, Z1));
            Complex Z3 = Complex.Add(Z2, Xc);

            Complex I = Complex.Divide(U1, Z3);
            Complex Stosunek = Complex.Multiply(Complex.Divide(Z2, Complex.Add(Z2, Xc)), Complex.Divide(Xl, Complex.Add(Xl, R22)));

            Results[i, 0] = f;
            Results[i, 1] = I.Magnitude;
            Results1[i, 0] = Stosunek.Phase * 180 / Math.PI;
            Results1[i, 1] = 20 * (Math.Log10(Stosunek.Magnitude));

            if (fstart < 1)
                fstart = fstart * 10;
            else
            {
                fstart = fstart + 1;
            }
        }
        Rysuj();
    }
    private void Rysuj()
    {
        //Przebieg pradu
        DataTable table;
        DataView dView;
        //----
        table = new DataTable();
        DataColumn column;
        DataRow row;
        //---
        column = new DataColumn();
        column.DataType = System.Type.GetType("System.Double");
        column.ColumnName = "Częstotilwość";
        table.Columns.Add(column);
        //---
        column = new DataColumn();
        column.DataType = System.Type.GetType("System.Double");
        column.ColumnName = "Prad+";
        table.Columns.Add(column);
        //---
        column = new DataColumn();
        column.DataType = System.Type.GetType("System.Double");
        column.ColumnName = "Prad-";
        table.Columns.Add(column);
        for (int i = 0; i < fzakres; i++)
        {
            row = table.NewRow();
            row["Częstotilwość"] = Results[i, 0];
            row["Prad+"] = Results[i, 1];
            row["Prad-"] = -Results[i, 1];
            table.Rows.Add(row);
        }
        dView = new DataView(table);

        Ch_I.Series.Clear();
        Ch_I.DataBindTable(dView, "Częstotilwość");
        Ch_I.Series["Prad+"].ChartType = SeriesChartType.Line;
        Ch_I.Series["Prad-"].ChartType = SeriesChartType.Line;
        Ch_I.ChartAreas[0].AxisX.LabelStyle.Format = "{#0.000}";
        Ch_I.ChartAreas[0].AxisX.ArrowStyle = System.Web.UI.DataVisualization.Charting.AxisArrowStyle.Triangle;
        Ch_I.ChartAreas[0].AxisY.ArrowStyle = System.Web.UI.DataVisualization.Charting.AxisArrowStyle.Triangle;
        Ch_I.ChartAreas[0].AxisX.Title = "Częstotliwość f [Hz]";
        Ch_I.ChartAreas[0].AxisY.Title = "Prąd zasilający I1 [A]";
        Ch_I.ChartAreas[0].AxisX.LogarithmBase = 10;
        Ch_I.ChartAreas[0].AxisX.IsLogarithmic = true;
        Ch_I.ChartAreas[0].AxisX.TitleFont = new System.Drawing.Font("Arial", 12f, System.Drawing.FontStyle.Regular);
        Ch_I.ChartAreas[0].AxisY.TitleFont = new System.Drawing.Font("Arial", 12f, System.Drawing.FontStyle.Regular);
        Title title=Ch_I.Titles.Add("Obwiednia prądu zasilającego");
        title.Font = new System.Drawing.Font("Arial", 12f, System.Drawing.FontStyle.Bold);


        Ch_I.Legends.Add(new Legend("Obwiednia dodatnia"));
        Ch_I.Series["Prad+"].Legend = "Obwiednia dodatnia";
        Ch_I.Series["Prad+"].IsVisibleInLegend = true;
        //====================================================================================================================

        DataTable table1;
        DataView dView1;
        //----
        table1 = new DataTable();
        DataColumn column1;
        DataRow row1;
        //---
        column1 = new DataColumn();
        column1.DataType = System.Type.GetType("System.Double");
        column1.ColumnName = "Częstotilwość";
        table1.Columns.Add(column1);
        //---
        column1 = new DataColumn();
        column1.DataType = System.Type.GetType("System.Double");
        column1.ColumnName = "U2/U1";
        table1.Columns.Add(column1);
        //---
        for (int i = 0; i < fzakres; i++)
        {
            row1 = table1.NewRow();
            row1["Częstotilwość"] = Results[i, 0];
            row1["U2/U1"] = Results1[i, 1];
            table1.Rows.Add(row1);
        }
        dView1 = new DataView(table1);

        Ch_amp.Series.Clear();
        Ch_amp.DataBindTable(dView1, "Częstotilwość");
        Ch_amp.Series["U2/U1"].ChartType = SeriesChartType.Line;
        Ch_amp.ChartAreas[0].AxisX.LabelStyle.Format = "{#0.000}";
        Ch_amp.ChartAreas[0].AxisX.ArrowStyle = System.Web.UI.DataVisualization.Charting.AxisArrowStyle.Triangle;
        Ch_amp.ChartAreas[0].AxisY.ArrowStyle = System.Web.UI.DataVisualization.Charting.AxisArrowStyle.Triangle;
        Ch_amp.ChartAreas[0].AxisX.Title = "Częstotliwość f [Hz]";
        Ch_amp.ChartAreas[0].AxisY.Title = "Am(ω) [dB]";
        Ch_amp.ChartAreas[0].AxisX.LogarithmBase = 10;
        Ch_amp.ChartAreas[0].AxisX.IsLogarithmic = true;
        Ch_amp.ChartAreas[0].AxisX.TitleFont = new System.Drawing.Font("Arial", 12f, System.Drawing.FontStyle.Regular);
        Ch_amp.ChartAreas[0].AxisY.TitleFont = new System.Drawing.Font("Arial", 12f, System.Drawing.FontStyle.Regular);
        Title title1=Ch_amp.Titles.Add("Widmo amplitudowe");
        title1.Font = new System.Drawing.Font("Arial", 12f, System.Drawing.FontStyle.Bold);

        //====================================================================================================================

        DataTable table2;
        DataView dView2;
        //----
        table2 = new DataTable();
        DataColumn column2;
        DataRow row2;
        //---
        column2 = new DataColumn();
        column2.DataType = System.Type.GetType("System.Double");
        column2.ColumnName = "Częstotilwość";
        table2.Columns.Add(column2);
        //---
        column2 = new DataColumn();
        column2.DataType = System.Type.GetType("System.Double");
        column2.ColumnName = "Widm_faz";
        table2.Columns.Add(column2);
        //---
        for (int i = 0; i < fzakres; i++)
        {
            row2 = table2.NewRow();
            row2["Częstotilwość"] = Results[i, 0];
            row2["Widm_faz"] = Results1[i, 0];
            table2.Rows.Add(row2);
        }
        dView2 = new DataView(table2);

        Ch_faz.Series.Clear();
        Ch_faz.DataBindTable(dView2, "Częstotilwość");
        Ch_faz.Series["Widm_faz"].ChartType = SeriesChartType.Line;
        Ch_faz.ChartAreas[0].AxisX.LabelStyle.Format = "{#0.000}";
        Ch_faz.ChartAreas[0].AxisX.ArrowStyle = System.Web.UI.DataVisualization.Charting.AxisArrowStyle.Triangle;
        Ch_faz.ChartAreas[0].AxisY.ArrowStyle = System.Web.UI.DataVisualization.Charting.AxisArrowStyle.Triangle;
        Ch_faz.ChartAreas[0].AxisX.Title = "Częstotliwość f [Hz]";
        Ch_faz.ChartAreas[0].AxisY.Title = "φ(ω) [°]";
        Ch_faz.ChartAreas[0].AxisX.LogarithmBase = 10;
        Ch_faz.ChartAreas[0].AxisX.IsLogarithmic = true;
        Ch_faz.ChartAreas[0].AxisX.TitleFont = new System.Drawing.Font("Arial", 12f, System.Drawing.FontStyle.Regular);
        Ch_faz.ChartAreas[0].AxisY.TitleFont = new System.Drawing.Font("Arial", 12f, System.Drawing.FontStyle.Regular);
        Title title2=Ch_faz.Titles.Add("Widmo fazowe");
        title2.Font = new System.Drawing.Font("Arial", 12f, System.Drawing.FontStyle.Bold);
      
    }

    protected void reset_Click(object sender, EventArgs e)
    {
        
        Ch_faz.Series.Clear();
        Ch_amp.Series.Clear();
        Ch_I.Series.Clear();
        txtR1.Text = "";
        txtR2.Text = "";
        txtL.Text = "";
        txtC.Text = "";
        txtAmp.Text = "";
        txtF.Text = "";
        txtfstart.Text = "";
        txtfzakres.Text = "";
        uwaga.Text = "";
        pole_edycja.Visible = true;
        Pan_amp.Visible = false;
        Pan_I.Visible = false;
        Pan_faz.Visible = false;


    }

    protected void PSPICE_Click(object sender, EventArgs e)
    {
        txtR1.Text = "20";
        txtR2.Text = "30";
        txtL.Text = "0,01";
        txtC.Text = "0,0002";
        txtAmp.Text = "230";
        txtF.Text = "50";
        txtfstart.Text = "0,001";
        txtfzakres.Text = "100000";
        Panel3.Focus();
    }
}