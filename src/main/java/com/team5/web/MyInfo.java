package com.team5.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.team5.dao.InfoDAO;
import com.team5.dao.MemberDAO;
import com.team5.dto.BoardDTO;
import com.team5.dto.MemberDTO;

@WebServlet("/myInfo")
public class MyInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public MyInfo() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		HttpSession session = request.getSession();
		
		if (session.getAttribute("mid") != null) {			
			InfoDAO dao = new InfoDAO();
			String mid = (String)(session.getAttribute("mid"));

			//내 정보 보기
			MemberDTO mdto = new MemberDTO();
			mdto = dao.myInfo(mid);
			request.setAttribute("myInfo", mdto);
			
			//내가 쓴 글 보기
			BoardDTO bdto = new BoardDTO();
			List<BoardDTO> myBoard = dao.myBoard(mid);
			request.setAttribute("myBoard", myBoard);			
			
			//내가 참여중인 소모임
			
			
			
			//내 중고거래내역 보기  내가 판 물건, 내가 산 물건
			
			

			RequestDispatcher rd = request.getRequestDispatcher("/myInfo.jsp");
			rd.forward(request, response);
			
		} else {
			response.sendRedirect("./index");
		}
		
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		//내 정보 수정
/*		if (session.getAttribute("mid") != null) {
			MemberDTO dto = new MemberDTO();
			dto.setMid((String)(session.getAttribute("mid")));
			
			MemberDAO dao = new MemberDAO();
			int result = dao.changeInfo();
		} */
		
	}

}