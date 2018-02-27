<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Formularz.aspx.cs" Inherits="_Default" %>

<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Filtry pasywne</title>
     <link rel="Stylesheet" type="text/css" href="StyleSheet01.css" />
</head>
<body>
    <!-- STRONA GŁÓWNA -->
    <form id="form1" runat="server">
    <div>
     <asp:Panel ID="Panel1" runat="server" CssClass="Panel1">
         <asp:Image  ID="Naglowek" runat="server" ImageUrl="~/Nagłówek.png" Width="1200px" AlternateText="Nagłówek" CssClass="Naglowek"/><br />
         </asp:Panel> 
         <asp:MultiView ID="MultiView1" runat="server">
             <asp:View ID="V_Glowna" runat="server">
                 <asp:Label ID="L_Glowna" runat="server" Text="Strona Główna" CssClass="Active" ></asp:Label>
                 <asp:LinkButton ID="Lb1_Symulacja" runat="server" Text="Symulacja" CssClass="Inactive" OnCommand="Link_Button_Command" CommandName="Symulacja"></asp:LinkButton>
                 <asp:LinkButton ID="Lb1_Teoria" runat="server" Text="Teoria" CssClass="Inactive" OnCommand="Link_Button_Command" CommandName="Teoria"></asp:LinkButton>   
               
             <asp:Panel ID="Panel2" runat="server" CssClass="Panel2">
            <h2>Temat: Filtr pasywny złożony z kombinacji dwóch rezystorów R1, R2, cewki magnetycznej L i kondensatora C.</h2>
            <h3>Aplikacja internetowa ASP.net powstała wykorzystując narzędzia jakie oferuje środowisko Microsoft Visual Studio, wykonano ją w ramach projektu zaliczającego przedmiot: Programowanie aplikacji internetowych.</h3>
            <h3>Zakres projektu:</h3>
              <ul>  
                <li>Rysunek schematu ideowego</li>
                <li>Opisanie elementów filtru</li>
                <li>Edycja wartości parametrów filtru: R1, R2, L i C</li>
                <li>Edycja wartości parametrów napięcia zasilającego U1 (przebieg sinusoidalny) oraz zakresu częstotliwości f</li>
                <li>Prezentacja graficzna widma amplitudowego U2/U1 w funkcji częstotliwości f dla stanu ustalonego</li>
                <li>Prezentacja graficzna obwiedni prądu zasilającego I1 w funkcji częstotliwości</li>
                <li>Prezentacja graficzna widma fazowego filtru U2/U1</li>
                <li>Inne elementy nadające aplikacji atrybuty dydaktyczne i poznawcze</li>               
             </ul>
                 <h4>Aplikację wykonał:<br /> Szymon Firlinger <br />Eleketrotechnika i Automatyka<br />Nr albumu: 149951</h4>
                 </asp:Panel>          
             </asp:View>




<!--         ===================================================================================                             -->



              <asp:View ID="V_Symulacja" runat="server">
                 <asp:LinkButton ID="Lb2_Glowna" runat="server" Text="Strona Główna" CssClass="Inactive" OnCommand="Link_Button_Command" CommandName="Strona_Glowna" CausesValidation="false" ></asp:LinkButton>
                 <asp:Label ID="L_Symulacja" runat="server" Text="Symulacja" CssClass="Active"></asp:Label>
                 <asp:LinkButton ID="Lb2_Teoria" runat="server" Text="Teoria" CssClass="Inactive" OnCommand="Link_Button_Command" CommandName="Teoria" CausesValidation="false"></asp:LinkButton>   
               
                 <asp:Panel ID="Panel4" runat="server" CssClass="Panel4"> 

                     
<!--         ===================================================================================                             -->
                      <div id="lewo">
                          <asp:Panel ID="nowy" runat="server">
                          <asp:LinkButton ID="Edycja" runat="server" Text="Edycja parametrów filtru" OnCommand="Edycja_Button_Command" CssClass="mlewo"></asp:LinkButton><br />                          
                          <asp:LinkButton ID="Grafika1" runat="server" Text="Widmo amplitudowe" OnCommand="Widm_amp_Button_Command" CssClass="mlewo"></asp:LinkButton> 
                          <asp:LinkButton ID="Grafika2" runat="server" Text="Obwiednia prądu zasilającego" OnCommand="Edycja2_Button_Command" CssClass="mlewo"></asp:LinkButton> 
                          <asp:LinkButton ID="Grafika3" runat="server" Text="Widmo fazowe" OnCommand="Widm_faz_Button_Command" CssClass="mlewo"></asp:LinkButton>   
                          </asp:Panel>                                                       
                      </div> 
                  
<!--         ===================================================================================                             -->

                     <div id="prawo">
                      <h2 id="sim_tytul">Schemat ideowy badanego filtru</h2>
                     <asp:Image ID="Schemat" runat="server" CssClass="Schemat" ImageUrl="~/Schemat.png" />  
                     

                         <asp:Panel ID="pole_edycja" runat="server">
                         <h4 id="Param">Edycja wartości parametrów filtru</h4><br />

                         <asp:Label ID="labR1" runat="server" Text="Rezystancja R1 [Ω]:&nbsp"></asp:Label>
                         <asp:TextBox ID="txtR1" runat="server" Width="100px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqR1" runat="server" ControlToValidate="txtR1" ForeColor="Red" SetFocusOnError="true" Text="*" ErrorMessage="Nie podano rezystancji R1"></asp:RequiredFieldValidator>  
                            <asp:CompareValidator ID="compR1" runat="server" ControlToValidate="txtR1" Type="Double" Operator="GreaterThan" ValueToCompare="0" ForeColor="Red" Text="*" ErrorMessage="Błędna wartość rezystancji R1"></asp:CompareValidator>



                         
                         <asp:Label ID="labR2" runat="server" Text="Rezystancja R2 [Ω]:&nbsp"></asp:Label>
                         <asp:TextBox ID="txtR2" runat="server" Width="100px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqR2" runat="server" ControlToValidate="txtR2" ForeColor="Red" SetFocusOnError="true" Text="*" ErrorMessage="Nie podano rezystancji R2"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="compR2" runat="server" ControlToValidate="txtR2" Type="Double" Operator="GreaterThan" ValueToCompare="0" ForeColor="Red" Text="*" ErrorMessage="Błędna wartość rezystancji R2"></asp:CompareValidator>
                         <br /><br />
                           
                         <asp:Label ID="labC" runat="server" Text="Pojemność C [F]:&nbsp"></asp:Label>
                         <asp:TextBox ID="txtC" runat="server" Width="100px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqC" runat="server" ControlToValidate="txtC" ForeColor="Red" SetFocusOnError="true" Text="*" ErrorMessage="Nie podano pojemności C"></asp:RequiredFieldValidator>
                             <asp:CompareValidator ID="compC" runat="server" ControlToValidate="txtC" Type="Double" Operator="GreaterThan" ValueToCompare="0" ForeColor="Red" Text="*" ErrorMessage="Błędna wartość pojemności C"></asp:CompareValidator>  
                                
                         <asp:Label ID="labL" runat="server" Text="Indukcyjność L [H]:&nbsp"></asp:Label>
                         <asp:TextBox ID="txtL" runat="server" Width="100px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqL" runat="server" ControlToValidate="txtL" ForeColor="Red" SetFocusOnError="true" Text="*" ErrorMessage="Nie podano indukcyjności L"></asp:RequiredFieldValidator>             
                             <asp:CompareValidator ID="compL" runat="server" ControlToValidate="txtL" Type="Double" Operator="GreaterThan" ValueToCompare="0" ForeColor="Red" Text="*" ErrorMessage="Błędna wartość indukcyjności L"></asp:CompareValidator>
                             <br /><br />
                               <h4 id="Param2">Edycja wartości parametrów napięcia zasilającego</h4><br />
                         <asp:Label ID="labAmp" runat="server" Text="Amplituda Am [V]:&nbsp"></asp:Label>
                         <asp:TextBox ID="txtAmp" runat="server" Width="100px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqAmp" runat="server" ControlToValidate="txtAmp" ForeColor="Red" SetFocusOnError="true" Text="*" ErrorMessage="Nie podano amplitudy napięcia"></asp:RequiredFieldValidator>  
                         <asp:CompareValidator ID="compAmp" runat="server" ControlToValidate="txtAmp" Type="Double" Operator="GreaterThan" ValueToCompare="0" ForeColor="Red" Text="*" ErrorMessage="Błędna wartość amplitudy Am"></asp:CompareValidator>
                         
                         <asp:Label ID="labF" runat="server" Text="Częstotilwość zasilania [Hz]:&nbsp"></asp:Label>
                         <asp:TextBox ID="txtF" runat="server" Width="100px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqF" runat="server" ControlToValidate="txtF" ForeColor="Red" SetFocusOnError="true" Text="*" ErrorMessage="Nie podano częstotliwości zasilania"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="compF" runat="server" ControlToValidate="txtF" Type="Double" Operator="GreaterThan" ValueToCompare="0" ForeColor="Red" Text="*" ErrorMessage="Błędna wartość częstotliwości zasilania"></asp:CompareValidator>
                             
                             
                              <br /><br />
                          <asp:Label ID="labfstart" runat="server" Text="Częstotilwość początkowa [Hz]:&nbsp"></asp:Label>
                         <asp:TextBox ID="txtfstart" runat="server" Width="100px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqfstart" runat="server" ControlToValidate="txtfstart" ForeColor="Red" SetFocusOnError="true" Text="*" ErrorMessage="Nie podano częstotliwości początkowej"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="compfstart" runat="server" ControlToValidate="txtfstart" Type="Double" Operator="GreaterThan" ValueToCompare="0" ForeColor="Red" Text="*" ErrorMessage="Błędna wartość częstotliwości początkowej"></asp:CompareValidator>
                            <asp:CompareValidator ID="compfstart1" runat="server" ControlToValidate="txtfstart" Type="Double" Operator="LessThan" ControlToCompare="txtfzakres" ForeColor="Red" Text="*" ErrorMessage="Częstotliwość początkowa nie może być większa od częstotliwości końcowej"></asp:CompareValidator>
                            <asp:CompareValidator ID="compfstart2" runat="server" ControlToValidate="txtfstart" Type="Double" Operator="GreaterThanEqual" ValueToCompare="0,001" ForeColor="Red" Text="*" ErrorMessage="Częstotliwość początkowa powinna być większa niż 0,001 Hz"></asp:CompareValidator>

                           <asp:Label ID="labfzakres" runat="server" Text="Częstotilwość końcowa [Hz]:&nbsp"></asp:Label>   
                         <asp:TextBox ID="txtfzakres" runat="server" Width="100px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqfzakres" runat="server" ControlToValidate="txtfzakres" ForeColor="Red" SetFocusOnError="true" Text="*" ErrorMessage="Nie podano częstotliwości końcowej"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="compfzakres" runat="server" ControlToValidate="txtfzakres" Type="Double" Operator="GreaterThan" ValueToCompare="0" ForeColor="Red" Text="*" ErrorMessage="Błędna wartość częstotilwości końcowej"></asp:CompareValidator>
                            <asp:CompareValidator ID="compfzakres1" runat="server" ControlToValidate="txtfzakres" Type="Double" Operator="LessThanEqual" ValueToCompare="100000" ForeColor="Red" Text="*" ErrorMessage="Maksymalna częstotliwość końcowa to 100 000 Hz"></asp:CompareValidator>
 

                              <br /><br />
                            <asp:Button ID="reset" runat="server" Text="Resetuj" OnClick="reset_Click" CausesValidation="false" /><br /><br />
                             <h4 id="pspice1">Autouzupelnianie danych użytych do symulacji w programie PSPICE, której wyniki przedstawiono<br /> w zakładce TEORIA<br /></h4><br />
                            
                            <asp:Button ID="PSPICE" runat="server" Text="Parametry PSPICE" CausesValidation="false" OnClick="PSPICE_Click" />
                              </asp:Panel>


<!--         ===================================================================================                             -->                 

<br />
                <asp:Label ID="uwaga" runat="server" BackColor="Red"></asp:Label>
<!--         ===================================================================================                             -->
                         
                        <asp:Panel ID="Pan_amp" runat="server">
                           
                            <asp:Chart ID="Ch_amp" runat="server" Width="900px" Height="600px">
                                <series>
                                    <asp:Series ChartType="Line" Name="Series1" Legend="Legend1">
                                    </asp:Series>
                                </series>
                                <chartareas>
    
                                    <asp:ChartArea Name="ChartArea1">
                                    </asp:ChartArea>
                                </chartareas>
                                
                            </asp:Chart>
                           
                            </asp:Panel>


  <!--         ===================================================================================                             -->

<!--         ===================================================================================                             -->
                        <asp:Panel ID="Pan_I" runat="server">
                           
                            <asp:Chart ID="Ch_I" runat="server" Width="900px" Height="600px">
                                <series>
                                    <asp:Series ChartType="Line" Name="Series1" Legend="Legend1">
                                    </asp:Series>
                                </series>
                                <chartareas>
    
                                    <asp:ChartArea Name="ChartArea1">
                                    </asp:ChartArea>
                                </chartareas>
                                
                            </asp:Chart>
                           
                            </asp:Panel>


  <!--         ===================================================================================                             -->
  <!--         ===================================================================================                             -->
                        <asp:Panel ID="Pan_faz" runat="server">
                           
                            <asp:Chart ID="Ch_faz" runat="server" Width="900px" Height="600px">
                                <series>
                                    <asp:Series ChartType="Line" Name="Series1" Legend="Legend1">
                                    </asp:Series>
                                </series>
                                <chartareas>
    
                                    <asp:ChartArea Name="ChartArea1">
                                    </asp:ChartArea>
                                </chartareas>
                                
                            </asp:Chart>

                         

                            </asp:Panel>
                        
              
  <!--         ===================================================================================                             -->


  <!--         ===================================================================================                             -->
                     


  <!--         ===================================================================================                             -->
                                               
                <asp:ValidationSummary ID="Vsum1" runat="server" HeaderText="Wykryto następujące błędy:" ForeColor="Red" DisplayMode="BulletList" ShowSummary="true" ShowMessageBox="false"/>
</div> 
                                                                               
          </asp:Panel> 

             </asp:View>
             
             <asp:View ID="V_Teoria" runat="server">
                 <asp:LinkButton ID="Lb3_Glowna" runat="server" Text="Strona Główna" CssClass="Inactive" OnCommand="Link_Button_Command" CommandName="Strona_Glowna" ></asp:LinkButton>                
                 <asp:LinkButton ID="Lb3_Symulacja" runat="server" Text="Symulacja" CssClass="Inactive" OnCommand="Link_Button_Command" CommandName="Symulacja"></asp:LinkButton>   
                 <asp:Label ID="L_Teoria" runat="server" Text="Teoria" CssClass="Active"></asp:Label>
              
                 <asp:Panel ID="Panel5" runat="server" CssClass="Panel5">
                     
                     <h2 id="ogolne">1. Wiadomości ogólne</h2> <br />
                     <asp:Panel ID="wiadomosci" runat="server">
                         <b>Filtr częstotliwości</b> to układ, pełniący rolę czwórnika, tzn. posiadający cztery pary zacisków: jedna para to wejście druga zaś to wyjście.
                         Układy tego typu przepuszczają bez tłumienia lub z małym tłumieniem napięcia i prądy o określonym paśmie częstotlwości, zwanym pasem przepustowym. Poza wspomnianym pasmem
                         napięcia oraz prądy zostają tłumione. Rozróżnia sie różne typu filtrów ze względu na położenie pasma przenoszenia:<br /><br />
                         - dolnoprzepustowe – pasmo przepustowe od częstotliwości f=0 Hz do częstotliwości granicznej,<br /><br />
                         - górnoprzepustowe – pasmo przepustowe od częstotliwości granicznej do nieskończoności, <br /><br />
                         - środkowoprzepustowe (pasmowe) – pasmo przepustowe od częstotliwości granicznej fg1 do częstotliwości granicznej fg2, <br /><br />
                         - środkowozaporowe (zaporowe) – pasmo tłumieniowe od częstotliwości granicznej fg1 do częstotliwości granicznej fg2.<br /><br />
                         Filtry pasywne zbudowane są jedynie z elementów pasywnych tzn. cewek, kondensatorów oraz rezystorów.
                         Znajdują one zazwyczaj zastosowanie w układach zasilających, pomiarowych głównie w celu ograniczenia emisji harmonicznych w układach prostownikowych.<br /><br />
                 Źródło: <a href="http://elektron.pol.lublin.pl/keo/dydaktyk/Ins/Cw05pdf.pdf">Elektron Lublin </a>
                     <h2 id="porownanie">2. Porównanie charakterystyk z profesjonalnym programem symulacyjnym PSPICE</h2><br />
                           Wykonano badanie symulacyjne w programie PSPICE przyjmując poniższe parametry, w celu sprawdzenia poprawności zaimplementowanych wzorów:<br />
                            <li>R1=20 Ω;</li>
                            <li>R1=30 Ω;</li>
                            <li>L=0,01 H;</li>
                            <li>C=0,0002 F;</li>
                            <li>Am=230 V;</li>
                            <li>fzas=50 Hz;</li>
                            <li>f_początkowa=0,001 Hz;</li>
                            <li>f_końcowa=100000 Hz.</li><br />
                       </asp:Panel>     
                            <asp:Image ID="amp" runat="server" ImageUrl="~/amp.png" Width="1100" Height="500"/>
                            <asp:Image ID="faz" runat="server" ImageUrl="~/faz.png" Width="1100" Height="500" />
                            <asp:Image ID="prad" runat="server" ImageUrl="~/prad.png" Width="1100" Height="500"/>
                       </asp:Panel>    
             </asp:View>


          
                
             


         </asp:MultiView>
        
            
       

        

           <asp:Panel ID="Panel3" runat="server" CssClass="Panel3">
            <a href="https://pg.edu.pl/">
            <asp:Image ID="Logo" runat="server" ImageUrl="~/logoPG.png" AlternateText="LogoPG" CssClass="Logo"/></a>  
           <h5>@ Copyright Szymon Firlinger, Politechnika Gdańska  2018</h5>
          
        </asp:Panel> 
    </div>
    </form>
</body>
</html>
