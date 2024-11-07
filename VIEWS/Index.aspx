<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="WebApplication36.VIEWS.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><h1>Agregar Producto</h1></title>
     <style>
        /* Diseño básico para el formulario */
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f9;
        }
        #formContainer {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 300px;
        }
        label {
            font-weight: bold;
        }
        .form-field {
            margin-bottom: 15px;
        }
        .form-field input[type="text"], 
        .form-field input[type="number"] {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .form-field input[type="file"] {
            margin-top: 5px;
        }
        .btn-submit {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn-submit:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <form id="formAgregarProducto" runat="server" enctype="multipart/form-data">
        <div id="formContainer">
            <div class="form-field">
                <label for="txtNombre">Nombre: </label>
                <asp:TextBox ID="txtNombre" runat="server" required="true" />
            </div>
            
            <div class="form-field">
                <label for="txtCantidad">Cantidad: </label>
                <asp:TextBox ID="txtCantidad" runat="server" TextMode="Number" required="true" />
            </div>
            

             <!--
            <div class="form-field">
                <label for="txtCosto">Costo: </label>
                <asp:TextBox ID="TextBox1" runat="server" TextMode="SingleLine" required="true" />

            </div>
            -->

            <div class="form-field">
                <label for="txtCosto">Costo: </label>
                <asp:TextBox ID="txtCosto" runat="server" TextMode="Number" required="true" />
            </div>
            <div class="form-field">
                <label for="fileImagen">Imagen: </label>
                <asp:FileUpload ID="fileImagen" runat="server" />
            </div>
            <asp:Button ID="btnAgregarProducto" runat="server" Text="Agregar Producto" CssClass="btn-submit" OnClick="btnAgregarProducto_Click" />
        </div>

        <asp:Button ID="btnMostrarProductos" runat="server" Text="Mostrar" OnClick="btnMostrarProductos_Click" CssClass="btn-submit" />
            <br /><br />
            <asp:GridView ID="gvProductos" runat="server" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
                    <asp:BoundField DataField="Costo" HeaderText="Costo" DataFormatString="{0:C}" />
                    <asp:TemplateField HeaderText="Imagen">
                        <ItemTemplate>
                            <asp:Image ID="imgProducto" runat="server" ImageUrl='<%# Eval("ImagenUrl") %>' Width="100px" Height="100px" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>


    </form>
</body>
</html>
