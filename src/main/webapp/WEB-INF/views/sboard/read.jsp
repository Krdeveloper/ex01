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
						
						<ul class="mailbox-attachments clearfix uploadedList"></ul>
					</div>
					<div class="box-footer">
						<button class="btn btn-warning" id="btnModify">수정하기</button>
						<button class="btn btn-danger" id="btnDelete">삭제하기</button>
						<button class="btn btn-primary" id="btnBack">돌아가기</button>
					</div>
					<form role="form" method="post" id="f1">
						<input type="hidden" name="bno" value="${board.bno }">
						<input type="hidden" name="page" value="${cri.page }">
						<input type="hidden" name="searchType" value="${cri.searchType }">
						<input type="hidden" name="keyword" value="${cri.keyword }">
					</form>
					
				</div>
			</div>
		</div>
	</section>
	<script type="text/javascript"> 
	$(function(){
		$("#btnDelete").click(function(){
			$("#f1").attr("action","delete");//post 형식의 delete 커맨드 호출됨.
			$("#f1").attr("method","post"); 
			var arr=[];
			$(".uploadedList li").each(function(index){
				arr.push($(this).attr("data-src"));
			})
			
			if(arr.length>0){
				$.post("deleteAllFiles",{files:arr},function(){
					
				});
			}
			
			$("#f1").submit();
		});
		$("#btnModify").click(function(){
			$("#f1").attr("action","modify");
			$("#f1").attr("method","get");
			$("#f1").submit();
		});
		$("#btnBack").click(function(){
			//location.href="listPage";
			$("#f1").attr("action","listPage");
			$("#f1").attr("method","get");
			$("#f1").submit();
			
		});
	});
</script>
	<div class="row">
		<div class="col-md-12">
			<div class="box box-success">
				<div class="box-header">
					<h3 class="box-title">댓글추가</h3>
				</div>
				<div class="box-body">
					<label for="newReplyWriter">작성자</label>
					<input type="text" placeholder="USER ID" id="newReplyWriter" class="form-control">
					<br>
					<label for="newReplyText">댓글내용</label>
					<input type="text" placeholder="Reply Text" id="newReplyText" class="form-control">
				</div>
				<div class="footer">
					<button class="btn btn-primary" id="btnAdd">Add Reply</button>
				</div>
			</div><!-- add reply -->
			<ul class="timeline">
				<li class="time-label" id="repliesList">
					<span class="bg-green" id="btnList">Replies List
					<small id="replycntSmall">[${board.replycnt}] </small></span>
				</li>
			</ul>
			<div class="text-center">
				<ul id="pagination" class="pagination pagination-sm no-margin">
				</ul>
			</div>
		</div>
	</div>
	
	<div id="modifyModal" class="modal modal-primary fade" role="dialog">
	  <div class="modal-dialog">
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title"></h4>
	      </div>
	      <div class="modal-body" data-rno>
	        <p><input type="text" id="replytext" class="form-control"></p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
	        <button type="button" class="btn btn-danger" id="replyDelBtn">Delete</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div> 
	
	
	
	<script id="temp" type="text/x-handlebars-template">
		{{#each.}}
		<li class="replyLi" data-rno={{rno}}>
		<i class="fa fa-comments bg-blue"></i>
		<div class="timeline-item">
			<span class="time">
				<i class="fa fa-clock-o"></i>{{tempdate regdate}}
			</span>
			<h3 class="timeline-header"><strong>{{rno}}</strong>-{{replyer}}</h3>
			<div class="timeline-body">{{replytext}}</div>
			<div class="timeline-footer">
				<a class="btn btn-primary btn-xs"
						data-toggle="modal" data-target="#modifyModal">Modify</a>
			</div>
		</div>
		</li>
		{{/each}}
	</script>
	
	<script id="templateAttach" type="text/x-handlebars-template">
		<li data-src='{{fullName}}'>
			<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}"
			alt="Attachment"></span>
		<div class="mailbox-attachment-info">
		<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
		</div>
		</li>
	</script>
	
	<script>
		Handlebars.registerHelper("tempdate",function(time){
			var dateObj = new Date(time);
			var year = dateObj.getFullYear();
			var month = dateObj.getMonth()+1;
			var date = dateObj.getDate();
			
			return year + "/" + month + "/" + date;
		})
		
		var printData = function(replyArr, target, templateObject){
			var template = Handlebars.compile(templateObject.html());
			var html = template(replyArr);
			$(".replyLi").remove();
			target.after(html);
		}
		
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
		
		
		
		
		function getAllList(){
			$.ajax({//pageContext.getRequest().getContextPath()---프로젝트 이름 반환
				url:"${pageContext.request.contextPath}/replies/all/" + bno,
				type:"get",
				dataType:"json",
				success : function(data){
					console.log(data);
					var source = $("#temp").html();
					var template = Handlebars.compile(source);
					$(".replyLi").remove();
					$(".timeline").append(template(data));
				}
			});
		}
		
		var replyPage=1;
		function getPage(pageInfo){
			$.getJSON(pageInfo, function(data){
				printData(data.list, $("#repliesList"), $("#temp"));
				printPaging(data.pageMaker, $(".pagination"));
				
				$("#modifyModal").modal("hide");
			});
		}  
		
		var printPaging = function(pageMaker, target){
			var str="";
			if(pageMaker.prev){
				str += "<li><a href='"+(pageMaker.startPage-1)+"'> << </a></li>";
			}
			for(var i=pageMaker.startPage, len = pageMaker.endPage; i<=len; i++){
				var strClass = pageMaker.cri.page == i?'class=active':'';
				str += "<li "+strClass+"><a href='"+i+"'>"+i+"</a></li>";
			}
			if(pageMaker.next){
				str += "<li><a href='"+(pageMaker.endPage + 1)+"'> >> </a></li>";
			}
			target.html(str);
		}; 
		
		$(".pagination").on("click","li a", function(event){
			event.preventDefault();
			replyPage = $(this).attr("href");
			getPage("${pageContext.request.contextPath}/replies/"+bno+"/"+replyPage);
		});
		
	    //list 가져오기        body 밑에 있어서 레디 필요없음
		$("#btnList").click(function(){
			//getAllList();
			getPage("${pageContext.request.contextPath}/replies/"+bno+"/1");
		}) 
		
		/* $("#replyList").on("click",function(){
			if($(".timeline li").size()>1){
				return;
			}
			getPage("/replies/"+bno+"/1");
		}) */
		
		//댓글 추가
		$("#btnAdd").click(function(){
			var writer = $("#newReplyWriter").val();
			var text =  $("#newReplyText").val();
			var sendData = {
					bno:bno,
					replytext:text,
					replyer:writer
			};
			
			$.ajax({
				url:"${pageContext.request.contextPath}/replies/add",
				type:"post",
				dataType:"text",
				data:JSON.stringify(sendData),
				headers:{"Content-Type":"application/json"},
				success:function(data){
					console.log(data);
				}
			})
		});
		
		//modal창에 값 띄우기
		$(".timeline").on("click",".replyLi", function(event){
			var reply = $(this);
			
			$("#replytext").val(reply.find(".timeline-body").text());
			$(".modal-title").html(reply.attr("data-rno"));
		})
		
		//modify
		$("#replyModBtn").on("click",function(){
			var rno = $(".modal-title").html();
			var replytext = $("#replytext").val();
			
			$.ajax({
				type:'put',
				url:"${pageContext.request.contextPath}/replies/" + rno,
				headers : {"Content-Type":"application/json"},
				data:JSON.stringify({replytext:replytext}),
				dataType:'text',
				success:function(result){
					console.log("result: " + result);
					if(result=='SUCCESS'){
						alert("수정되었습니다.");
						
					}								
				
			}});
		}) 
		
		$("#replyDelBtn").on("click",function(){
			var rno = $(".modal-title").html();
			var replytext = $("#replytext").val();
			
			$.ajax({
				type:'delete',
				url:"${pageContext.request.contextPath}/replies/" + rno,
				headers : {"Content-Type":"application/json"},
				dataType:'text',
				success:function(result){
					console.log("result: " + result);
					if(result=='SUCCESS'){
						alert("삭제성공");
						getAllList();
					}								
				
			}});
		});
		
		
		
	</script>
</div>


<%@ include file="../include/footer.jsp" %>










