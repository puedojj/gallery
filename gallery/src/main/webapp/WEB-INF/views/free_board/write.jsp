<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>✍️ 자유게시판 - 글쓰기</title>

<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

<style type="text/css">
.body-container {
	max-width: 800px;
}



</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">

<script type="text/javascript">
function sendOk() {
    const f = document.boardForm;
	let str;
	
    str = f.subject.value.trim();
    if(!str) {
        alert("제목을 입력하세요. ");
        f.subject.focus();
        return;
    }

    str = f.content.value.trim();
    if(!str) {
        alert("내용을 입력하세요. ");
        f.content.focus();
        return;
    }
    
    f.content.value = f.content.value.replace(/\n/g, "<br>");

    f.action = "${pageContext.request.contextPath}/free_board/${mode}";
    f.submit();
}
</script>
<c:if test="${mode == 'update'}">
<script type="text/javascript">
function deleteFile(fileNum) {
	if(! confirm('파일을 삭제하시겠습니까?')){
		return;
	}
	
	let q = 'num=${dto.num}&page=${page}&size=${size}&fileNum=' + fileNum;
	location.href = '${pageContext.request.contextPath}/free_board/deleteFile?' + q;
}
</script>
</c:if>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
	<div class="container">
		<div class="body-container">	
			<div>
				<h3>🔺 자유 게시판 </h3>
				<hr class="border border-warning border-2 opacity-75">
			</div>
			
			<div class="body-main">
				<form name="boardForm" method="post" enctype="multipart/form-data">
					<table class="table write-form mt-5">
						<tr>
							<td class="bg-warning-subtle col-sm-2" scope="row">제 목</td>
							<td>
								<input type="text" name="subject" class="form-control" value="${dto.subject}">
							</td>
						</tr>
	        
						<tr>
							<td class="bg-warning-subtle col-sm-2" scope="row">작성자명</td>
	 						<td>
								<p class="form-control-plaintext">${sessionScope.member.userName}</p>
							</td>
						</tr>
						
						<tr>
							<c:if test="${sessionScope.member.userRole==0}">
							<td class="bg-warning-subtle col-sm-2" scope="row">공지선택</td>
							<td>
								<input type="checkbox" class="form-check-input" name="notice" id="notice" value="1" ${dto.notice==1 ? "checked ":"" } >
								<label class="form-check-label" for="notice"> 공지</label>
							</td>
							</c:if>
						</tr>
	
						<tr>
							<td class="bg-warning-subtle col-sm-2" scope="row">내 용</td>
							<td>
								<textarea name="content" id="content" class="form-control">${dto.content}</textarea>
							</td>
						</tr>
						
						<tr>
							<td class="bg-warning-subtle col-sm-2">첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
							<td> 
								<input type="file" name="selectFile" class="form-control">
							</td>
						</tr>
						<c:if test="${mode=='update'}">
							<tr>
								<td class="bg-warning-subtle col-sm-2" scope="row">첨부된파일</td>
								<td> 
									<p class="form-control-plaintext">
										<c:if test="${not empty dto.saveFileName}">
											<a href="javascript:deleteFile('${dto.num}');"><i class="bi bi-trash"></i></a>
											${dto.uploadFileName}
										</c:if>
										&nbsp;
									</p>
								</td>
							</tr>
						</c:if>
					</table>
					
					<table class="table table-borderless">
	 					<tr>
							<td class="text-center">
								<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
								<button type="reset" class="btn btn-light">다시입력</button>
								<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/free_board/list';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
								<c:if test="${mode=='update'}">
									<input type="hidden" name="num" value="${dto.num}">
									<input type="hidden" name="page" value="${page}">
									<input type="hidden" name="fileSize" value="${dto.fileSize}">
									<input type="hidden" name="saveFileName" value="${dto.saveFileName}">
									<input type="hidden" name="uploadFileName" value="${dto.uploadFileName}">
								</c:if>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>

</body>
</html>