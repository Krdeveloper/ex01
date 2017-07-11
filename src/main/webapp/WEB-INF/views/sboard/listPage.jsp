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
						<h3 class="box-title">BOARD LIST ALL (${login })</h3><!-- session영역안의 login키값 찍어봄 -->
					</div>
					<!-- box header -->
					<div class="box-body">
						<select name="searchType">
							<option value="n">----------</option>
							<option value="t" ${cri.searchType=='t' ? 'selected':'' }>Title</option>
							<option value="c" ${cri.searchType=='c' ? 'selected':'' }>Content</option>
							<option value="w" ${cri.searchType=='w' ? 'selected':'' }>Writer</option>							
							<option value="tc" ${cri.searchType=='tc' ? 'selected':'' }>Title OR Content</option>
							<option value="cw" ${cri.searchType=='cw' ? 'selected':'' }>Content OR Writer</option>
							<option value="tcw" ${cri.searchType=='tcw' ? 'selected':'' }>Title OR Content OR Writer</option>
						</select>
						<input type="text" value="${cri.keyword }" name="keyword">
						<button id="searchBtn">Search</button>
					</div>
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
									<td><a href="read${pageMaker.makeSearch(pageMaker.cri.page) }&bno=${board.bno }">${board.title }<strong>[${board.replycnt }]</strong></a></td>
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
									<li><a href="listPage${pageMaker.makeSearch(pageMaker.startPage-1) }">&laquo;</a></li>
								</c:if>
								<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
									<li ${pageMaker.cri.page==idx? 'class=active' : '' }><a href="listPage${pageMaker.makeSearch(idx) }">${idx }</a></li>
								</c:forEach>
								<c:if test="${pageMaker.next }">
									<li><a href="listPage${pageMaker.makeSearch(pageMaker.endPage+1)} ">&raquo;</a></li>
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
$(function(){
	var result = '${msg}';
	if(result=='SUCCESS'){
		alert("처리 완료");
	}
	$("#searchBtn").click(function(){
		var keyword = $("input[name='keyword']").val();
		var searchType=$("select").val();
		location.href="listPage?keyword=" + keyword + "&searchType=" + searchType;
	})
})
	function btnNew(){
		location.href="register";
	}
</script>
<%@ include file="../include/footer.jsp" %>