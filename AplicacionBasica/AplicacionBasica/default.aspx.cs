using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AplicacionBasica
{
    public partial class _default : System.Web.UI.Page
    {
        #region variables globales
        string accion = null;
        string id = null;
        #endregion


        #region eventos
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                Usuario_listado();

                if (Request.QueryString["accion"] != null)
                {
                    accion = Request.QueryString["accion"];
                    id = (Request.QueryString["id"] != null) ? Request.QueryString["id"] : "0";
                    // Podrian enlistarse mas acciones por el numde accion
                    // en teoria 1=alta, 2=consultar/Modificar, 3=baja
                    switch (accion) {
                        case "3": Usuario_eliminar(id);
                            break;
                        
                    }
                }
                

            }
              
    
            ScriptManager1.RegisterAsyncPostBackControl(AgregarUsuario);

        }

        protected void guardar_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = null;
            SqlConnection conn = null;
            try
            {
                using (conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
                {
                    cmd = new SqlCommand("usuario_guardar", conn);

                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlParameter parametroId = new SqlParameter("@id", DbType.Int32);
                    parametroId.Value = String.IsNullOrEmpty(idUsuario.Value) ? 0 : int.Parse(idUsuario.Value);
                    cmd.Parameters.Add(parametroId);

                    SqlParameter parametroUsuario = new SqlParameter("@user", DbType.String);
                    parametroUsuario.Value = usuario.Text;
                    cmd.Parameters.Add(parametroUsuario);

                    SqlParameter parametroNombre = new SqlParameter("@firstName", DbType.String);
                    parametroNombre.Value = nombre.Text;
                    cmd.Parameters.Add(parametroNombre);

                    SqlParameter parametroApellido = new SqlParameter("@lastName", DbType.String);
                    parametroApellido.Value = apellido.Text;
                    cmd.Parameters.Add(parametroApellido);

                    SqlParameter parametroTelefono = new SqlParameter("@telephone", DbType.String);
                    parametroTelefono.Value = telefono.Text;
                    cmd.Parameters.Add(parametroTelefono);

                    SqlParameter parametroEmail = new SqlParameter("@email", DbType.String);
                    parametroEmail.Value = email.Text;
                    cmd.Parameters.Add(parametroEmail);

                    SqlParameter parametroRol = new SqlParameter("@rol", DbType.Int32);
                    parametroRol.Value = int.Parse(rol.SelectedValue);
                    cmd.Parameters.Add(parametroRol);

                    SqlParameter parametroUsuarioId = new SqlParameter("@usuarioId", DbType.Int32);
                    parametroUsuarioId.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(parametroUsuarioId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    int idRegistro = Convert.ToInt32(cmd.Parameters["@usuarioId"].Value);
                    Literal1.Text = idRegistro.ToString();
                }
            }
            catch (Exception ex)
            {

                Literal1.Text = ex.Message;
            }

            finally {
                if (conn != null && conn.State != ConnectionState.Closed)
                {
                    conn.Close();
                }
                Usuario_listado();   
            }

        }

        protected void Editar_Command(object sender, CommandEventArgs e)
        {
            pnlFormulario.Visible = true;
            int idUsuario = int.Parse(e.CommandArgument.ToString());
            titulo.Text = "Editar ";
            Usuario_detalle(idUsuario);
            formulario.Update();
            
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "MostrarFormulario()", true);            
        }

        protected void AgregarUsuario_Click(object sender, EventArgs e)
        {

            pnlFormulario.Visible = true;
            titulo.Text = "Agregar";
            nombre.Text = String.Empty;
            apellido.Text = String.Empty;
            usuario.Text = String.Empty;
            telefono.Text = String.Empty;
            email.Text = String.Empty;
            rol.SelectedIndex = 0;
            idUsuario.Value = String.Empty;
            formulario.Update();
        }

        protected void cerrarFormulario_Click(object sender, EventArgs e)
        {
            pnlFormulario.Visible = false;
        }

        #endregion

        #region metodos
        
        // Llenado del grid - Listar usuarios
        protected void Usuario_listado()
        {
            try
            {
                SqlCommand cmd = new SqlCommand("usuario_listado", new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString));
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter adp = new SqlDataAdapter(cmd);
                DataTable dtUsuarios = new DataTable();
                adp.Fill(dtUsuarios);
                gvUsuarios.DataSource = dtUsuarios;
                gvUsuarios.DataBind();
            }
            catch (Exception)
            {
                // escribir exception handler
            }
        }

        protected void Usuario_detalle(int id) {
            //generar nuevo objeto tiposql comand e indicarle que es de tipo sp
            SqlCommand cmd = new SqlCommand("usuario_detalle", new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString));
            cmd.CommandType = CommandType.StoredProcedure;
            //agregar parametros a sp
            SqlParameter parametroIdUsuario = new SqlParameter("idUsuario", DbType.Int32);
            parametroIdUsuario.Value = id;
            cmd.Parameters.Add(parametroIdUsuario);
            // ejecutar sp
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            // Obtener rersultados
            DataTable dtUsuario = new DataTable();
            adp.Fill(dtUsuario);
            DataRow drUsuario = dtUsuario.Rows[0];
            nombre.Text = drUsuario["firstName"].ToString();
            apellido.Text = drUsuario["lastName"].ToString();
            usuario.Text = drUsuario["user"].ToString();
            telefono.Text = drUsuario["telephone"].ToString();
            email.Text = drUsuario["email"].ToString();
            rol.SelectedValue = drUsuario["rol"].ToString();
            idUsuario.Value = drUsuario["id"].ToString();
        }

        protected void Usuario_eliminar(string id){
            int idUsuario = 0;
            idUsuario = int.Parse(id);
            SqlCommand cmd = null;
            SqlConnection conn = null;
            try
            {
                using(conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString)){
                    cmd = new SqlCommand("usuario_eliminar", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter idEliminar = new SqlParameter("@idUsuario", DbType.Int32);
                    idEliminar.Value = idUsuario;
                    cmd.Parameters.Add(idEliminar);
                    conn.Open();
                    cmd.ExecuteNonQuery();

                }
            }
            catch(Exception ex)
            {
                Literal1.Text = ex.Message;
            }
            finally {
                if (conn != null && conn.State != ConnectionState.Closed)
                {
                    conn.Close();
                }
                Usuario_listado(); 
            }
        }

        #endregion

        

       // Guardar formulario - Agregar nuevos usuarios

       
    }
}