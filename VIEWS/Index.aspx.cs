using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace WebApplication36.VIEWS
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAgregarProducto_Click(object sender, EventArgs e)
        {
            string nombre = txtNombre.Text;
            int cantidad = int.Parse(txtCantidad.Text);
            decimal costo = decimal.Parse(txtCosto.Text);
            byte[] imagenData = null;

            if (fileImagen.HasFile)
            {
                using (BinaryReader br = new BinaryReader(fileImagen.PostedFile.InputStream))
                {
                    imagenData = br.ReadBytes((int)fileImagen.PostedFile.InputStream.Length);
                }
            }

            // Usar la cadena de conexión "tiendaConnectionString" del archivo Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["tiendaConnectionString"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "INSERT INTO Productos (Nombre, Cantidad, Costo, Imagen) VALUES (@Nombre, @Cantidad, @Costo, @Imagen)";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Nombre", nombre);
                    cmd.Parameters.AddWithValue("@Cantidad", cantidad);
                    cmd.Parameters.AddWithValue("@Costo", costo);
                    cmd.Parameters.AddWithValue("@Imagen", imagenData ?? (object)DBNull.Value);

                    cmd.ExecuteNonQuery();
                }
            }

            // Opcional: muestra un mensaje de confirmación
            Response.Write("<script>alert('Producto agregado con éxito');</script>");
        }

        protected void btnMostrarProductos_Click(object sender, EventArgs e)
        {
            CargarProductos();
        }

        private void CargarProductos()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["tiendaConnectionString"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT Nombre, Cantidad, Costo, Imagen FROM Productos";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                using (MySqlDataReader reader = cmd.ExecuteReader())
                {
                    DataTable dt = new DataTable();
                    dt.Load(reader);

                    // Crear columna adicional para URL de imagen en base64
                    dt.Columns.Add("ImagenUrl", typeof(string));
                    foreach (DataRow row in dt.Rows)
                    {
                        if (row["Imagen"] != DBNull.Value)
                        {
                            byte[] imagenData = (byte[])row["Imagen"];
                            string base64String = Convert.ToBase64String(imagenData);
                            row["ImagenUrl"] = "data:image/png;base64," + base64String;
                        }
                    }

                    gvProductos.DataSource = dt;
                    gvProductos.DataBind();
                }
            }
        }
    }
}