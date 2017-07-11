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
						<h3 class="box-title">modify Board</h3>
					</div>
					<!-- box header -->
					<form role="form" method="post" action="modify">
					<div class="box-body">
						<div class="form-group">
							<label>Title</label>
							<input  type="text" name="title" class="form-control"
							value="${board.title }">
						</div>
						<div class="form-group">
							<label>Content</label>
							<textarea rows="5" cols="" class="form-control" name="content" 
							>${board.content }</textarea>
							
						</div>
						<div class="form-group">
							<label>Writer</label>
							<input  type="text" name="writer" class="form-control"
							value="${board.writer }">
						</div>
						
					</div>
					<div class="box-footer">
						<button type="submit" class="btn btn-warning">
						수정하기</button>
						
					</div>
					
						<input type="hidden" name="bno" value="${board.bno }">
						<input type="hidden" name="page" value="${cri.page }">
					</form>
					
				</div>
			</div>
		</div>
	</section>
</div>

<%@ include file="../include/footer.jsp" %>