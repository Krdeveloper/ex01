<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-primary">
					<div class="box-header">
						<h3 class="box-title">modify Board</h3>
					</div>
					<!-- box header -->
					<form role="form" method="post" action="modify" id="registerForm">
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
						
						<ul class="mailbox-attachments clearfix uploadedList"></ul>
						
					</div>
					<div class="box-footer">
						<button type="submit" class="btn btn-warning">
						수정하기</button>
						
					</div>
					
						<input type="hidden" name="bno" value="${board.bno }">
						<input type="hidden" name="page" value="${cri.page }">
						<input type="hidden" name="searchType" value="${cri.searchType }">
						<input type="hidden" name="keyword" value="${cri.keyword }">
					</form>
					
				</div>
			</div>
		</div>
	</section>
	
	<script id="templateAttach" type="text/x-handlebars-template">
		<li data-src='{{fullName}}'>
			<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}"
			alt="Attachment"></span>
		<div class="mailbox-attachment-info">
		<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
		<a href="{{fullName}}" class="btn btn-default btn-xs pull-right delbtn">
			<i class="fa fa-fw fa-remove"></i></a>
		</div>
		</li>
	</script>
	
	<script>
	function checkImageType(fileName){
		var pattern = /jpg|gif|png|jpeg/i;
		return fileName.match(pattern);
	}
	function getFileInfo(fullName){
		var fileName, imgsrc, getLink;
		
		var fileLink;
		
		if(checkImageType(fullName)){
			imgsrc = "displayFile?fileName="+fullName;
			fileLink = fullName.substr(14);
			
			var front = fullName.substr(0,12);
			var end = fullName.substr(14);
			
			getLink = "displayFile?fileName="+front+end;
		}else{
			imgsrc="/resources/dist/img/file.png";
			fileLink=fullName.substr(12);
			getLink="displayFile?fileName="+fullName;
		}
		fileName = fileLink.substr(fileLink.indexOf("_")+1);
		
		return {fileName:fileName, imgsrc:imgsrc,getLink:getLink, fullName:fullName};
	}
	
	var bno = ${board.bno };
	var template = Handlebars.compile($("#templateAttach").html());
	
	
	$.getJSON("${pageContext.request.contextPath}/sboard/getAttach/" + bno, function(list){
		$(list).each(function(){
			var fileInfo = getFileInfo(this);
			
			var html = template(fileInfo);
			
			$(".uploadedList").append(html);
		})
	})
	
	$("#registerForm").submit(function(event){
		event.preventDefault();
		
		var that = $(this);
		
		var str = "";
		
		$(".uploadedList .delbtn").each(function(index){
			str += "<input type='hidden' name='files["+index+"]' value='"+$(this).attr("href") +"'> ";
			
		});
		
		that.append(str);
		
		that.get(0).submit();
	});
	</script>
</div>

<%@ include file="../include/footer.jsp" %>