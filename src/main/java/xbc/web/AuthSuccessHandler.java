package xbc.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

import xbc.model.User;
import xbc.service.UserService;

public class AuthSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

    @Autowired
    private UserService userService;
    
    @Override
    public void onAuthenticationSuccess(
            HttpServletRequest request, 
            HttpServletResponse response, 
            Authentication authentication) throws IOException, ServletException {
        
        User currentUser = userService.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        
        HttpSession session = request.getSession(true);
        session.setAttribute("sessionId", currentUser.getId());
        session.setAttribute("sessionUsername", currentUser.getUsername());
        session.setAttribute("sessionEmail", currentUser.getEmail());
        session.setAttribute("sessionRole", currentUser.getRole());
        
        super.onAuthenticationSuccess(request, response, authentication);
    }
   
}