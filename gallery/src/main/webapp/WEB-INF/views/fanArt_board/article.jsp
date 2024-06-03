<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">

<c:if test="${sessionScope.member.userId==dto.member_id || sessionScope.member.userRole==0}">
	<script type="text/javascript">
		function deleteBoard() {
		    if(confirm("게시글을 삭제 하시 겠습니까 ? ")) {
		    	let query = "num=${dto.num}&page=${page}";
			    let url = "${pageContext.request.contextPath}/fanArt_board/delete?" + query;
		    	location.href = url;
		    }
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
			<div class="body-title">
				<h3><i class="bi bi-image"></i> 팬아트 </h3>
			</div>
			
			<div class="body-main">
				
				<table class="table">
					<thead>
						<tr>
							<td colspan="2" align="center">
								${dto.subject}
							</td>
						</tr>
					</thead>
					
					<tbody>
						<tr>
							<td width="50%">
								이름 : ${dto.name}
							</td>
							<td align="right">
								${dto.reg_date} | 조회 ${dto.hitcount}
							</td>
						</tr>
						
						<tr>
							<td colspan="2" style="border-bottom: :none">
								<img name="img" src="${pageContext.request.contextPath}/uploads/fanArt/${dto.img}"
								class="w-100 h-auto img-fluid img-thumbnail">
							</td>
						</tr>
						
						<tr>
							<td colspan="2">
								${dto.content}
							</td>
						</tr>
						
					</tbody>
				</table>
				
				<table class="table table-borderless">
					<tr>
						<td width="50%">
							<c:choose>
								<c:when test="${sessionScope.member.userId == dto.member_id}"> 
									<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/fanArt_board/update?num=${dto.num}&page=${page}';">수정</button>
								</c:when>
								<c:otherwise>
									<button type="button" class="btn btn-light" disabled>수정</button>
								</c:otherwise>
							</c:choose>
							
							<c:choose>
								<c:when test="${sessionScope.member.userId==dto.member_id || sessionScope.member.userRole==0}">
									<button type="button" class="btn btn-light" onclick="deleteBoard();">삭제</button>
								</c:when>
								<c:otherwise>
									<button type="button" class="btn btn-light" disabled>삭제</button>
								</c:otherwise>
							</c:choose>
							
							
						</td>
						<td class="text-end">
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/fanArt_board/list?page=${page}';">리스트</button>
						</td>
					</tr>
					
				</table>
				
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