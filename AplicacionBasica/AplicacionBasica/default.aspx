<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="AplicacionBasica._default" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    

</head>
<body >
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="contenedor">
        <asp:GridView ID="gvUsuarios" runat="server" DataKeyNames="id,rol" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField HeaderText="Usuario" DataField="user" />
                <asp:HyperLinkField HeaderText="Nombre" DataTextField="firstName" DataNavigateUrlFields="id, firstName" DataNavigateUrlFormatString="default.aspx?id={0}&name={1}" />
                <asp:BoundField HeaderText="Apellido" DataField="lastName" />
                <asp:BoundField HeaderText="Telefono" DataField="telephone" />
                <asp:BoundField HeaderText="Email" DataField="email" />
                <asp:BoundField HeaderText="Rol" DataField="rol" Visible="false" />
                <asp:TemplateField HeaderText="Rol" > 
                    <ItemTemplate>
                        <asp:Label ID="lblRol" Text='<%# Eval("rol") + string.Concat(" - "+Eval("email"))%>' runat="server" />
                    </ItemTemplate >
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Editar"> 
                    <ItemTemplate>
                        <asp:Button ID="Editar" CommandArgument='<%# Eval("id") %>' OnCommand="Editar_Command" runat="server" Text="Editar" />
                    </ItemTemplate >
                </asp:TemplateField>
                <asp:HyperLinkField HeaderText="Eliminar" Text="Eliminar" DataNavigateUrlFields="id" DataNavigateUrlFormatString="default.aspx?id={0}&accion=3" />
                
            </Columns>
            
        </asp:GridView>
        

           
    </div>
        <asp:Button ID="AgregarUsuario" runat="server" Text="Agregar usuario" OnClick="AgregarUsuario_Click"  />
        
            <asp:UpdatePanel ID="formulario" runat="server" UpdateMode="Conditional" >
                <ContentTemplate>
                    <asp:Panel ID="pnlFormulario" runat="server" Visible="false">
                    <h1><asp:Literal ID="titulo" Text="Agregar" runat="server"></asp:Literal> Usuario</h1>
                    <asp:HiddenField ID="idUsuario" Value="0" runat="server" />
                    <div class="etiqueta">Nombre: </div>
                    <asp:TextBox ID="nombre" ToolTip="Nombre" CssClass="cuadroTexto" runat="server"></asp:TextBox>
                    <div class="etiqueta">Apellido: </div>
                    <asp:TextBox ID="apellido" CssClass="cuadroTexto" runat="server"></asp:TextBox>
                    <div class="etiqueta">Usuario: </div>
                    <asp:TextBox ID="usuario" CssClass="cuadroTexto" runat="server"></asp:TextBox>
                    <div class="etiqueta">Telefono: </div>
                    <asp:TextBox ID="telefono" CssClass="cuadroTexto" runat="server"></asp:TextBox>
                    <div class="etiqueta">Email: </div>
                    <asp:TextBox ID="email" CssClass="cuadroTexto" runat="server"></asp:TextBox>
                    <div class="etiqueta">Rol: </div>
                    <!-- *Pendiente: hacer que se llene automaticamente -->
                    <asp:DropDownList ID="rol" runat="server">
                        <asp:ListItem Text="student" Value="1"></asp:ListItem>
                        <asp:ListItem Text="teacher" Value="2"></asp:ListItem>
                        <asp:ListItem Text="secretary" Value="3"></asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="guardar" runat="server" OnClick="guardar_Click">Guardar</asp:LinkButton>
                    <asp:Button ID="cerrarFormulario" runat="server" Text="Cerrar" OnClick="cerrarFormulario_Click" />
                        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                    </asp:Panel>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="gvUsuarios" />
                    <asp:PostBackTrigger ControlID="guardar" />
                </Triggers>
            </asp:UpdatePanel>
        

    </form>
    
</body>
</html>
