<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>채팅</title>
<script>function url(url) {window.location.href = url;}</script>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link href="./css/receivedmessage.css" rel="stylesheet"/>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
$(function(){

$(".userBtn").click(function (){
	$(".userBtn").removeClass("selected");
    $(this).addClass("selected");
    
	let mno = $(this).data("mno");
    let mname = $(this).data("mname");
    $(".overlay").text(mname);
	
    $.ajax({
        url: './trashmessage',
        type: 'get', // 혹은 'post'에 맞게 변경할 수 있습니다.
        dataType: 'html', // 예상되는 응답의 형식에 맞게 변경
        data: {'mno': mno, 'mname': mname},
        success: function(response){
            // 성공적으로 응답을 받았을 때 수행할 작업
			$(".chatData").html(response);
        },
        error: function() {
            alert("에러 발생");
        }
    });
});
$("#chattingBtn").click(function (){
    let selectedUser = $(".userBtn.selected");
    let mno = selectedUser.data("mno");
    let mname = selectedUser.data("mname");

    let chatting = $("#chatting").val();
    
    $("#chatting").val('');
    
    $.ajax({
    	url : './trashmessage',
    	type : 'post',
    	//dataType : 'text',
    	contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
    	data : {'mscontent' : chatting, 'mno' : mno, 'mname' : mname},
    	success : function(){
			$.ajax({
				url: './trashmessage',
	            type: 'get',
	            dataType: 'html',
	            data: {'mno': mno, 'mname': mname},
	            success: function(response){
	            	$(".overlay").text(mname);
	                $(".chatData").html(response);
	            },
	            error: function() {
	                alert("에러 발생");
	            }
			});
			// 중복으로 버튼이 추가되는 부분 수정
			$("#chattingBtn").off('click'); // 이전 이벤트 핸들러 제거
			$("#chattingBtn").click(chatButtonClickHandler);
    	},
    	error : function() {
    		alert("실패하였습니다.");
    	}
    });
});

//클릭 이벤트 핸들러 함수 추가
function chatButtonClickHandler() {
    let selectedUser = $(".userBtn.selected");
    let mno = selectedUser.data("mno");
    let mname = selectedUser.data("mname");

    let chatting = $("#chatting").val();
    
    $("#chatting").val('');
    
    $.ajax({
    	url : './trashmessage',
    	type : 'post',
    	contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
    	data : {'mscontent' : chatting, 'mno' : mno, 'mname' : mname},
    	success : function(){
			$.ajax({
				url: './trashmessage',
	            type: 'get',
	            dataType: 'html',
	            data: {'mno': mno, 'mname': mname},
	            success: function(response){
	            	$(".overlay").text(mname);
	                $(".chatData").html(response);
	            },
	            error: function() {
	                alert("에러 발생");
	            }
			});
    	},
    	error : function() {
    		alert("실패하였습니다.");
    	}
    });
}

// 초기에 클릭 이벤트 핸들러 등록
$("#chattingBtn").click(chatButtonClickHandler);

$("#chatting").keyup(function(){
    let text = $(this).val();
    if(text.length > 15){
       alert("15자 넘었어요.");
       $(this).val(  text.substr(0, 15)   );   
    }
    $("#chattingBtn").text("전송 " + text.length +  "/15");
 });
})
</script>
<style>
.main {
 background-image: url('img/friends2.gif');
 background-size: cover;
}
.chat {
	width: 300px;
	height: 500px;
	margin: 0 auto;
}
.chatData {
	margin-top: 10px;
	overflow-y: auto;
	height: 450px;
}
.chat img {
      width: 100%;
      height: 100%;
      object-fit: cover; /* 이미지 비율 유지하면서 채우기 */
    }
.image-container {
	background-image: url('img/kakao.jpg');
 	background-size: cover;
  	position: relative;
  	width: 100%;
 	height: 100%;
}
.chatContent {
	width: 300px;
	margin: 0 auto;
	overflow-y: auto;
}
#chatting {
	width: 292px;
	height: 40px;
	background-color: white;
}
#chattingBtn {
	width: 100%;
	height: 20px;
	border-radius: 0;
}
.overlay {
  position: absolute;
  top: 5%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 100%;
  height: 10%;
  background-color: rgba(255, 255, 0, 0.7); /* 투명한 흰색 배경 */
  align-items: center;
  color: black; /* 텍스트 색상 지정 */
  z-index: 1;
 }
 .userBtn.selected .overlay {
  background-color: rgba(255, 255, 0, 0.7);
}
 h5{
 	color: black;
 	text-align: right;
 }
</style>
</head>
<body>
	<div class="wrap">
		<div class="menu">
			<nav>
				<ul>
					<li onclick="url('./message')"><i class="xi-home"></i> 홈</li>
					<li onclick="url('./messagewrite')"><i class="xi-send"></i> 쪽지 쓰기</li>
					<li onclick="url('./receivedmessage')"><i class="xi-reply"></i> 받은 쪽지함</li>
					<li onclick="url('./sentmessage')"><i class="xi-share"></i> 보낸 쪽지함</li>
					<li onclick="url('./trashmessage')"><i class="xi-forum"></i> 채팅</li>
				</ul>
				<ul>
				<c:forEach var="user" items="${namelist}">
  					<li class="userBtn" data-mno="${user.mno}" data-mname="${user.mname}">
    				<small><i class="xi-user"></i> ${user.mname } 님</small>
					</li>
				</c:forEach>
				</ul>
				<button class="homeBtn" onclick="location.href='./trashmessage'"><i class="xi-home"></i> 채팅 홈</button>
			</nav>
		</div>
		<div class="main">
			<article>
				<h2>채팅기능 테스트</h2>
				<div class="chat">
         			 <div class="image-container">
         			 <br><br>
         			 <div class="overlay"></div>
         			 <div class="chatData">
           				 <c:forEach var="chat" items="${fromchatlist}"><h5><small>${chat.sendDate }</small>
  							${chat.mscontent }&nbsp;&nbsp;&nbsp;</h5>
							</c:forEach>
         			 </div>
           				 <div>
           				 </div>
         				 </div>
        				</div>
				<div class="chatContent">
				<input type="text" name="mscontent" id="chatting" placeholder="이곳에 입력하세요.">
  				<button type="submit" id="chattingBtn">전송</button>
				</div>
			</article>
		</div>
	</div>
</body>
<script>
  $(document).ready(function() {
    // 문서가 로드된 후 스크롤을 마지막으로 이동
    $('.chatData').scrollTop($('.chatData')[0].scrollHeight);
  });
</script>
</html>