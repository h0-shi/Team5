<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		<nav>
			<ul>
				<li onclick="url('./index')">홈</li>
				<li onclick="url('./board')">게시판</li>
				<li onclick="url('./somoim')">소모임</li>
				<li onclick="url('./chatting')">채팅</li>
				<li onclick="url('./jboard')">중고거래</li><c:choose><c:when test="${sessionScope.mname eq null}">
				<li onclick="url('./login')">로그인</li></c:when><c:otherwise>
				<li onclick="url('./logout')">로그아웃</li></c:otherwise></c:choose>
			</ul>
		</nav>