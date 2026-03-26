<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Redirect based on session
    if (session.getAttribute("username") != null) {
        response.sendRedirect(request.getContextPath() + "/library");
    } else {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
%>
