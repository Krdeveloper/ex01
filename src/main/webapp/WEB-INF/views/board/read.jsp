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
						<h3 class="box-title">Read Board</h3>
					</div>
					<!-- box header -->
					<div class="box-body">
						<div class="form-group">
							<label>Title</label>
							<input readonly="readonly" type="text" name="title" class="form-control"
							value="${board.title }">
						</div>
						<div class="form-group">
							<label>Content</label>
							<textarea rows="5" cols="" class="form-control" name="content" 
							readonly="readonly">${board.content }</textarea>
							
						</div>
						<div class="form-group">
							<label>Writer</label>
							<input readonly="readonly" type="text" name="writer" class="form-control"
							value="${board.writer }">
						</div>
						
					</div>
					<div class="box-footer">
						<button class="btn btn-warning">수정하기</button>
						<button class="btn btn-danger">삭제하기</button>
						<button class="btn btn-primary">돌아가기</button>
					</div>
					<form role="form" method="post" id="f1">
						<input type="hidden" name="bno" value="${board.bno }">
						<input type="hidden" name="page" value="${cri.page }">
					</form>
					
				</div>
			</div>
		</div>
	</section>
</div>

<script type="text/javascript">
	$(function(){
		$(".btn-danger").click(function(){
			$("#f1").attr("action","delete");//post 형식의 delete 커맨드 호출됨.
			$("#f1").attr("method","post");
			$("#f1").submit();
		});
		$(".btn-warning").click(function(){
			$("#f1").attr("action","modify");
			$("#f1").attr("method","get");
			$("#f1").submit();
		});
		$(".btn-primary").click(function(){
			//location.href="listPage";
			$("#f1").attr("action","listPage");
			$("#f1").attr("method","get");
			$("#f1").submit();
			
		});
	});
</script>
<%@ include file="../include/footer.jsp" %>










