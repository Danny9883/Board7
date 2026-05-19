<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib  prefix="c" uri="jakarta.tags.core" %>  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="/img/favicon.png" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<link href="/css/common.css" rel="stylesheet" />

<style>
	
	table { width: 100%; }
	
	td {
		padding: 5px 10px;
		text-align: center;
		&:nth-of-type(1) {
			background-color: black;
			color: white;
			border: 1px solid white;
		}
	}
	
	
	#table1 {
		margin-bottom: 150px;
		td {
			&:nth-of-type(1) {
				width: 150px;
				background: black;
				color: white;
				border-left: 1px solid black;
			}
			&:nth-of-type(2) {
				width: 150px;
				background: white;
				color: black;
			}
			&:nth-of-type(3) {
				width: 150px;
				background: black;
				color: white;
				border-bottom: 1px solid white;
			}
			&:nth-of-type(4) {
				width: 150px;
				background: white;
				color: black;
			}
		}
	}
	

  #table1	tr:last-child >td {
		background: white;
		border: 1px solid black;
		a, input[type="submit"] { margin: 0px 15px; }
	}
	
	#table1 tr:first-of-type td {
		border-top: 1px solid black;
	}
	
  #table1	tr:nth-of-type(2) td:nth-of-type(3) {
  	border-bottom: 1px solid black;
  }
  
  #table1	tr:nth-of-type(3) td:nth-of-type(2) {
  	text-align: left;
  }
  
  #table1	tr:nth-of-type(4){
  	height: 300px;
  	td:nth-of-type(1) {border-bottom: 1px solid white;}
  	td:nth-of-type(2) {border-bottom: 1px solid black;}
  }
  
   #table1 tr:nth-of-type(5) {
  	td {border-bottom: 1px solid black;}
  }
  
 	input[name="title"] {
		width: 100%;
	}
	
	textarea {
		width: 100%;
		height: 300px; 		
	}
	
	input[name="title"], 
	textarea {
		padding: 5px;
	}

	
	.menu tr:first-of-type {
	background-color: black;
	color: white;
	td {
		border : 1px solid white;
		text-align: center;
	}
	
	
  
</style>
<body> 
  <main>
    <%@include file="/WEB-INF/include/menuspdspaging.jsp" %>  
  
    <h2 class="h2"><b id="mname"></b> 자료실 게시글 수정</h2>
    <form  action="/Pds/Update" method="post"
           enctype = "multipart/form-data" >
     <input type="hidden" name="idx"     value="${ map.idx }" />
     <input type="hidden" name="menu_id" value="${ map.menu_id }" />
     <input type="hidden" name="nowpage" value="${ map.nowpage }" />
     <table id="table1">
     	<tr>
     		<td>글 번호</td>
     		<td>${ pds.idx }</td>
     		<td>조회수</td>
     		<td>${ pds.hit }</td>
     	</tr>
     	<tr>
     		<td>작성자</td>
     		<td>${ pds.writer}</td>
     		<td>작성일</td>
     		<td>${ pds.regdate }</td>
     	</tr>
      <tr>
        <td><span class="red">*</span>제목</td>
        <td colspan="3">
          <input type="text"     name="title"  value="${ pds.title }"/>
        </td>
      </tr>
      <tr>
        <td>내용</td>
        <td colspan="3"><textarea name="content" >${ pds.content }</textarea></td>        
      </tr> 
      <tr> 
        <td>파일</td>  
        <td id = "tdfile" colspan="3">
        	<c:forEach  var="file" items="${ fileList }" >
						<div class="text-start" >
							<a class="aDelete"
								 style="text-decoration:none;" 
							   href="/deleteFile?file_num=${ file.file_num }">❌</a>
							<a href="/Pds/filedownload/${ file.file_num }">${ file.filename }</a>		
						</div>
        	</c:forEach>
        	
        	<hr />
        	<!-- 새 파일을 추가-->
          <input type="button"  id="btnAddFile"  value="파일추가(최대 100MByte)" /><br><br>
          <input type="file"    name="upfile"    class="upfile" multiple /><br>
        </td>  
      </tr>  
				<tr>
					<td colspan="4">
						<input type="submit" value="수정" class="btn btn-warning" />
						<a href="/Pds/View?idx=${map.idx}&menu_id=${map.menu_id}&nowpage=${map.nowpage}" class="btn btn-info">이전</a>
						<a href="/Pds/List?menu_id=${map.menu_id}&nowpage=${map.nowpage}" class="btn btn-info">글 목록</a>
						<a href="/" class="btn btn-success">Home</a>
					</td>
				</tr>
     </table>    
    </form>
  
  </main>
  
    <script>
      // 메뉴제목출력
	  const  mnameEl    =  document.querySelector('#mname');
	  let    menunameEl =  document.querySelector('.menu .active')
	  mnameEl.innerHTML =  menunameEl.innerHTML;
	  
	  // 목록으로 이동
	  const  goListEl  = document.querySelector('#goList')
	  goListEl.onclick = function() {
		  location.href='/Pds/List?menu_id=${map.menu_id}&nowpage=${map.nowpage}'
	  }	  
	  
	  // 파일입력창 추가
	  const  btnAddFileEl  =  document.querySelector('#btnAddFile')
	  const  tdfileEl      =  document.querySelector('#tdfile')
	  let    tag           =  '<input type="file" name="upfile" class="upfile" multiple /><br>'  
	  let    html          =  tdfileEl.innerHTML 
		// js 에서 실행할때 새로 추가된 버튼은 이벤트가 한번만 작동
		// 해결 : 이벤트를 부모 element 에 설정
	  tdfileEl.addEventListener('click', function(e) {
		  console.dir(e.target) // td#tdfile  input#btnAddFile  input.upfile
		  if (e.target.id == 'btnAddFile') {
		 		html               +=  tag
		  	tdfileEl.innerHTML  =  html 			   
		  }
	  })
	  
	  // 입력항목 체크
	  
	</script>
  
  
  
  
</body>
</html>    















