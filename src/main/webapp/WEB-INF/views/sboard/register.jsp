<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>


	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-primary">
					<div class="box-header">
						<h3 class="box-title">REGISTER BOARD</h3>
					</div>
					<!-- box header -->
					
					<form role="form" method="post" action="register" enctype="multipart/form-data">
						<div class="box-body">
							<div class="form-group">
								<label>Title</label>
								<input type="text" name="title" class="form-control" placeholder="Enter Title">
							</div>
							<div class="form-group">
								<label>Content</label>
								<textarea rows="5" cols="" name="content"  
								class="form-control" placeholder="Enter Content"></textarea>
								
							</div>
							<div class="form-group">
								<label>Writer</label>
								<input type="text" name="writer" class="form-control" placeholder="Enter Writer">
							</div>
							
							<div class="form-group">
								<label>Files</label>
								<input type="file" name="imgFiles" class="form-control" multiple="multiple">
								
							</div>
						</div>
						<div class="box-footer">
							<!-- <div>
								<hr>
							</div>
							<ul class="mailbox-attachments clearfix uploadedList">
							</ul> -->
							<button type="submit" class="btn btn-primary">새 게시글 등록</button>
						</div>
						
					</form>
				</div>
			</div>
		</div>
	</section>

</div>

<%@ include file="../include/footer.jsp" %>





