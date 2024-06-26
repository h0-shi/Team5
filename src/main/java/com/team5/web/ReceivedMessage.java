package com.team5.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team5.dao.MessageDAO;
import com.team5.dto.MessageDTO;

@WebServlet("/receivedmessage")
public class ReceivedMessage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ReceivedMessage() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MessageDAO dao = new MessageDAO();
		List<MessageDTO> list = dao.receivedList();
		
		request.setAttribute("list", list);
		
		RequestDispatcher rd = request.getRequestDispatcher("receivedmessage.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
