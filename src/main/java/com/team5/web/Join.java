package com.team5.web;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team5.dao.MemberDAO;
import com.team5.dto.MemberDTO;

@WebServlet("/join")
public class Join extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public Join() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("join.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println(request.getParameter("pw1"));
		
		MemberDTO dto = new MemberDTO();
		dto.setMid(request.getParameter("id"));
		dto.setMname(request.getParameter("name"));
		dto.setMpw(request.getParameter("pw1"));
		dto.setMemail(request.getParameter("email"));
		
		MemberDAO dao = new MemberDAO();
		int result = dao.join(dto);
		
		//정상적으로 데이터 입력을 완료했다면 로그인 페이지로, 비정상이라면 에러로
		if(result == 1) {
			response.sendRedirect("./login");
		} else {
			//오류고치면 풀 예정입니다.
			//response.sendRedirect("./error.jsp");
			System.out.println("회원가입 오류입니다.");
		}
	}
}
