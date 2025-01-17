<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>💖작가게시판💖</title>

<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

<style type="text/css">
.body-container {
	max-width: 800px;
}
.body-title {
	text-align: center;
}
.body-title h3 {
	 font-size: 50px;
	 padding-bottom: 20px;
}
.hover:hover {
	cursor: pointer;
	background: #eee;
}
.page-navigation ul {
    display: flex;
    flex-direction: row;
    padding: 0;
}
.page-navigation li {
    list-style-type: none;
}
.body-container h3 {
	font-family: DNFBitBitv2;
}
</style>

<c:import url="/WEB-INF/views/layout/staticHeader.jsp"/>

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">

<script type="text/javascript">
function searchList() {
	const f = document.searchForm;
	f.submit();
}
</script>

</head>
<body>

<header>
	<c:import url="/WEB-INF/views/layout/header.jsp"/>
</header>
	
<main>
	<div class="container">
		<div class="body-container">
			 <div>
				<h3><i class="fa-solid fa-comment-dots"></i> 작가 게시판 </h3>
				<hr class="border border-danger border-2 opacity-75">
			</div>
			
			<div class="body-main">
		        <div class="row board-list-header">
		            <div class="col-auto me-auto">${dataCount}개(${page}/${total_page} 페이지)</div>
		            <div class="col-auto">&nbsp;</div>
		   		</div>				
				
				<table class="table table-hover board-list">
					<thead class="table-warning">
						<tr>
							<th class="num">번호</th>
							<th class="subject">제목</th>
							<th class="name">작성자</th>
							<th class="date">작성일</th>
							<th class="hit">조회수</th>
							<th class="file">첨부</th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach var="dto" items="${list}" varStatus="status">
							<tr>
								<td>${dataCount - (page-1) * size - status.index}</td>
								<td class="left">
									<a href="${articleUrl}&num=${dto.num}" class="text-reset">${dto.subject}</a>
								</td>
								<td>${dto.name}</td>
								<td>${dto.reg_date}</td>
								<td>${dto.hitcount}</td>
								<td>
									<c:if test="${not empty dto.saveFilename}">
										<a href="${pageContext.request.contextPath}/art_board/download?num=${dto.num}" class="text-reset"><i class="bi bi-file-arrow-down"></i></a>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<div class="page-navigation">
					${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
				</div>

				<div class="row board-list-footer">
					<div class="col">
						<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/art_board/list';"><i class="bi bi-arrow-clockwise"></i></button>
					</div>
					<div class="col-6 text-center">
						<form class="row" name="searchForm" action="${pageContext.request.contextPath}/art_board/list" method="post">
							<div class="col-auto p-1">
								<select name="schType" class="form-select">
									<option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
									<option value="name" ${schType=="name"?"selected":""}>작성자</option>
									<option value="subject" ${schType=="subject"?"selected":""}>제목</option>
									<option value="content" ${schType=="content"?"selected":""}>내용</option>
								</select>
							</div>
							<div class="col-auto p-1">
								<input type="text" name="kwd" value="${kwd}" class="form-control">
							</div>
							<div class="col-auto p-1">
								<button type="button" class="btn btn-light" onclick="searchList()">검색</button>
							</div>
						</form>
					</div>
					<div class="col text-end">
					<c:if test="${sessionScope.member.userRole==1}">
						<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/art_board/write';">글올리기</button>
					</c:if>
					</div>
				</div>
				
			</div>
		</div>
	</div>
</main>

<footer>
	<c:import url="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<c:import url="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>