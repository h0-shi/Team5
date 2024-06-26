package com.team5.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.team5.dao.MemberDAO;
import com.team5.dto.MemberDTO;


@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public Login() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
		rd.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getParameter("id") != null && request.getParameter("pw") != null) {
			MemberDTO dto = new MemberDTO();
			dto.setMid(request.getParameter("id"));
			dto.setMpw(request.getParameter("pw"));
			
			MemberDAO dao = new MemberDAO();
			//로그인 확인 count불러오기
			dto = dao.login(dto);
			
			if (dto.getCount() == 1) {
			    // 로그인 성공, index 페이지 이동, 로그인 세션 저장
			    HttpSession session = request.getSession();
			    session.setAttribute("mname", dto.getMname()); // mname이라는 이름으로 세션 만들기
			    session.setAttribute("mid", dto.getMid()); // mid라는 이름으로 세션 만듬
			    session.setAttribute("mno", dto.getMno());
				// Referer 헤더를 확인하여 이전 페이지로 Redirect
			    String referer = request.getHeader("Referer");
			    String originalReferer = (String) session.getAttribute("originalReferer");

			    // 원래의 이전 페이지로 Redirect
			    if (originalReferer != null && !originalReferer.contains("/login")) {
			        response.sendRedirect(originalReferer);
			    } else if (referer != null && !referer.contains("/login")) {
			        // 현재 페이지의 Referer가 로그인 페이지가 아닌 경우에는 이전 페이지로 Redirect
			        response.sendRedirect(referer);
			    } else {
			        // Referer가 없거나 로그인 페이지에서 왔다면 기본적으로 index 페이지로 Redirect
			        response.sendRedirect("./index");
			    }
			} else {
			    // 로그인 실패
			    // 에러페이지로 Redirect
			    response.sendRedirect("./login?error=4567");
			}

			

			
		}

	}
}
