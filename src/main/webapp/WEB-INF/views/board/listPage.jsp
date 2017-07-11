<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-primary">
					<div class="box-header">
						<h3 class="box-title">BOARD LIST ALL</h3>
					</div>
					<!-- box header -->
					<div class="box-body">
						<table class="table table-boarded">
							<tr>
								<th style="width:10px">BNO</th>
								<th>TITLE</th>
								<th>WRITER</th>
								<th>REGDATE</th>
								<th style="width:10px">VIEWCNT</th>
							</tr>
							<c:forEach var="board" items="${list }">
								<tr>
									<td>${board.bno }</td>
									<td><a href="read?bno=${board.bno }&page=${pageMaker.cri.page}">${board.title }</a></td>
									<td>${board.writer }</td>
									<td><fmt:formatDate value="${board.regdate }" pattern="yyyy-MM-dd HH:mm"/></td>
									<td><span class="badge bg-red">${board.viewcnt }</span></td>
								</tr>
							</c:forEach>
						
						</table>
						
					</div>
					<div class="box-footer">
						<div class="text-center">
							<ul class="pagination">
								<c:if test="${pageMaker.prev }">
									<li><a href="listPage?page=${pageMaker.startPage-1 }">&laquo;</a></li>
								</c:if>
								<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
									<li ${pageMaker.cri.page==idx? 'class=active' : '' }><a href="listPage?page=${idx }">${idx }</a></li>
								</c:forEach>
								<c:if test="${pageMaker.next }">
									<li><a href="listPage?page=${pageMaker.endPage+1 }">&raquo;</a></li>
								</c:if>
							</ul>
						</div>
						
						<button class="btn btn-primary" onclick="btnNew()">글등록</button>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<script>
	function btnNew(){
		location.href="register";
	}
</script>
<%@ include file="../include/footer.jsp" %>