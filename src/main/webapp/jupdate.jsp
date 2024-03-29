<%@page import="com.team5.dto.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.team5.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정하기</title>
<link href="./css/index.css" rel="stylesheet"/>
<link href="./css/header.css" rel="stylesheet"/>
<script type="text/javascript" src="./js/header.js"></script>
<script type="text/javascript" src="./js/menu.js"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<style type="text/css">
#title{
	width: 100%;
	height: 30px;
	margin-bottom: 10px;	
}
</style>
</head>
<body>
	<div class="container1">
		<header>
			<%@ include file="menu.jsp"%>
		</header>
		<div class="main">
			<div class="mainStyle">
				<article>
					<h1>글수정하기</h1>
					<div class="writeFORM">
						<form action="./jupdate" method="post">
							<select name="salesStatus">
       							 <option value="1">판매미완료</option>
        						<option value="0">판매완료</option>
    						</select>
							<input type="text" id="jtitle" name="jtitle" value="${jupdate.jtitle }">
							<textarea id="summernote" name="jcontent">${jupdate.jcontent }</textarea>
							<button type="submit">글수정하기</button>
							<input type="hidden" name="jno" value="${jupdate.jno }">
						</form>
					</div>
				</article>
			</div>
		</div>
	</div>
	<script>
    $(document).ready(function() {
        $('#summernote').summernote({
        	height: 500
        });
    });
  </script>
</body>
</html>