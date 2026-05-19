/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Optional;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import negocio.UsuarioBO;
import negocio.interfaces.IUsuarioBO;

/**
 *
 * @author USER
 */
@WebServlet(name = "loginServlet", urlPatterns = {"/login"})
public class loginServlet extends HttpServlet {

    private IUsuarioBO usuarioBo;

    public loginServlet() {
        this.usuarioBo = new UsuarioBO();
    }

    //nota esto redirige
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/loginView.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String correo = request.getParameter("email");
        String password = request.getParameter("password");

        String token = usuarioBo.autentificarGenerarToken(correo, password);

        if (token != null) {
            HttpSession sesion = request.getSession();
            sesion.setAttribute("token", token);
            sesion.setAttribute("usuario", correo);

            Optional<model.Usuario> usuarioOpt = usuarioBo.obtenerUsuarioPorCorreo(correo);
            if (usuarioOpt.isPresent()) {
                model.Usuario usuario = usuarioOpt.get();
                String rol = usuario.getRol();
                sesion.setAttribute("rol", rol);

                boolean esAdmin = rol != null && rol.trim().equalsIgnoreCase("ADMIN");
                sesion.setAttribute("esAdmin", esAdmin);

                if (esAdmin) {
                    request.setAttribute("exito", "Inicio de sesión exitoso. Redirigiendo al panel de control...");
                    request.setAttribute("urlDestino", request.getContextPath() + "/admin/dashboard");
                    request.getRequestDispatcher("/loginView.jsp").forward(request, response);
                    return;
                }
            } else {
                System.out.println("Usuario NO encontrado en BD despues de autenticacion");
            }

            request.setAttribute("exito", "Inicio de sesión exitoso. Redirigiendo al catálogo...");
            request.setAttribute("urlDestino", request.getContextPath() + "/catalogo");
            request.getRequestDispatcher("/loginView.jsp").forward(request, response);
            return;

        } else {
            request.setAttribute("error", "correo o contrasena incorrectos");
            request.getRequestDispatcher("/loginView.jsp").forward(request, response);
        }
    }

}
