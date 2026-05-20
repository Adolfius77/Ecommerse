/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Usuario;
import negocio.UsuarioBO;
import negocio.interfaces.IUsuarioBO;
import util.PasswordUtil;

/**
 *
 * @author USER
 */
@WebServlet(name = "RegistroServlet", urlPatterns = {"/Registro"})
public class RegistroServlet extends HttpServlet {

    private IUsuarioBO usuarioBo;

    public RegistroServlet() {
        this.usuarioBo = new UsuarioBO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/registroView.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String correo = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String password = request.getParameter("password");
        String confirmar = request.getParameter("confirmar");
        String direccion = request.getParameter("direccion");

        if (password == null || !password.equals(confirmar)) {
            request.setAttribute("error", "las contrasenas no coinciden");
            request.getRequestDispatcher("/registroView.jsp").forward(request, response);
            return;
        }
       
        Usuario nuevoUsuario = new Usuario();
        nuevoUsuario.setNombre(nombre.trim() + " " + (apellido != null ? apellido.trim() : ""));
        nuevoUsuario.setCorreo(correo.trim());
        nuevoUsuario.setContrasena(PasswordUtil.hashPassword(password));
        nuevoUsuario.setTelefono(telefono);
        nuevoUsuario.setDireccion(direccion);
        nuevoUsuario.setRol("CLIENTE");

        try {
            usuarioBo.registrarUsuario(nuevoUsuario);
            request.setAttribute("exito", "registro exitososo");
            request.setAttribute("urlDestino", request.getContextPath() + "/loginView.jsp?registrado=true");
            request.getRequestDispatcher("/registroView.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Error al registrar el usuario: " + e.getMessage());
            request.getRequestDispatcher("/registroView.jsp").forward(request, response);
        }
    }

}
