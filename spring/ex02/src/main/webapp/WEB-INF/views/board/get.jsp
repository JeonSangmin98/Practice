<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Read Page</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Read</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<div class="form-group">
					<label>BNO</label> <input class="form-control" name="bno"
						value="${board.bno}" readonly>
				</div>
				<div class="form-group">
					<label>Title</label> <input class="form-control" name="title"
						value="${board.title}" readonly>
				</div>
				<div class="form-group">
					<label>Content</label>
					<textarea class="form-control" rows="3" name="content" readonly>${board.content}</textarea>
				</div>
				<div class="form-group">
					<label>Writer</label> <input class="form-control" name="writer"
						value="${board.writer}" readonly>
				</div>
				<button class="btn btn-default listBtn">List</button>
				<button class="btn btn-info modBtn">Modify</button>
				<form id='actionForm' action='/board/list' method='get'>
					<input type='hidden' name="bno" value="${board.bno}"> <input
						type='hidden' name="pageNum" value='${cri.pageNum}'> <input
						type='hidden' name="amount" value='${cri.amount}'> <input
						type="hidden" name="keyword" value='${cri.keyword}'> <input
						type="hidden" name="type" value='${cri.type}'>
				</form>
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> Reply
				<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New
					Reply</button>
				
			</div><!-- /.panel-heading -->
			<div class="panel-body">
				<ul class="chat">
				</ul>
			</div><!-- /.panel-body -->
			<div class="panel-footer">
			</div><!-- /.panel-footer -->
		</div>
	</div>
</div>

<div class="modal fade in" id="myModal" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">×</button>
				<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label> <input class="form-control" name="reply"
						value="New Reply!!" >
				</div>			
				<div class="form-group">
					<label>Replyer</label> <input class="form-control" name="replyer"
						value="replyer" >
				</div>		
				<div class="form-group">
					<label>Reply Date</label> <input class="form-control" name="replyDate"
						value="2022-11-04" >
				</div>							
			</div>
			<div class="modal-footer">
				<button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
				<button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
				<button id="modalRegisterBtn" type="button" class="btn btn-primary">Register</button>
				<button id="modalCloseBtn" type="button" class="btn btn-default">Close</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<script src="/resources/js/reply.js"></script>
<script>
	$(function() {
		//console.log(replyService);
		//console.log("JS TEST");
		var bnoValue = '${board.bno}';

		var replyUL = $(".chat");
		
		showList(1);
		
		function showList(page){
			replyService.getList({bno:bnoValue, page:page}, function(replyCnt, list){
				//console.log(list);
				if(page == -1){
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
				var str ="";
				if(list == null || list.length == 0){
					replyUL.html("");
					return;
				}
				for(var i=0, len=list.length||0; i<len;i++){
					//console.log(list[i]);
					str += '<li class="left clearfix" data-rno="' + list[i].rno + '">';
					str += '<div>';
					str += '<div class="header">';
					str += '<strong class="primary-font">' + list[i].replyer + '</strong>'; 
					str += '<small class="pull-right text-muted">'+replyService.displayTime(list[i].replyDate) +'</small>';
					str += '</div>';
					str += '<p>'+list[i].reply+'</p>';
					str += '</div>';
					str += '</li>';
				}//end for
				replyUL.html(str);
				showReplyPage(replyCnt);
			});
		}//end showList()
		
		var pageNum = 1;
		var replyPageFooter = $(".panel-footer");
		function showReplyPage(replyCnt){
			var endNum = Math.ceil(pageNum / 10.0) * 10; 
			var startNum = endNum - 9; 
			var prev = startNum != 1;
			var next = false;
			if(endNum * 10 >= replyCnt){endNum = Math.ceil(replyCnt/10.0);}
			if(endNum * 10 < replyCnt){next = true;}
			
			var str ='<ul class="pagination pull-right">';
			if(prev){
				str += '<li class="paginate_button previous"><a href="'+(startNum-1)+'">Previous</a></li>';
			}
			for(var i=startNum;i<=endNum;i++){
				var active = (pageNum==i)?'active':'';
				str +='<li class="paginate_button '+active+'"><a href="'+i+'">'+i+'</a></li>';
			}
			if(next){
				str += '<li class="paginate_button next"><a href="'+(endNum+1)+'">Next</a></li>';
			}
			str+='</ul>';
			replyPageFooter.html(str);
		}//showReplyPage
		
		replyPageFooter.on("click", "li a", function(e){
			e.preventDefault();
			console.log("page click");
			var targetPageNum = $(this).attr("href");
			console.log("targetPageNum:" + targetPageNum);
			pageNum = targetPageNum;
			showList(pageNum);
		});
		
		var modal = $(".modal");
		
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");

		$("#modalCloseBtn").click(function(){
			modal.modal("hide");
		});
		
		$("#addReplyBtn").click(function(){
			modal.find("input").val("");
			modalInputReplyDate.closest("div").hide();
			modal.find('button[id!="modalCloseBtn"]').hide();
			modalRegisterBtn.show();
			modal.modal("show");
		});
		
		modalRegisterBtn.on("click", function(){
			var reply = {
					reply:modalInputReply.val(), 
					replyer:modalInputReplyer.val(), 
					bno:bnoValue};
			replyService.add(reply,	function(result){
						alert(result);
						modal.find("input").val("");
						modal.modal("hide");
						showList(-1);
					});
		});//modalRegisterBtn.on("click"
		
		replyUL.on("click", "li", function(){
			var rno = $(this).data("rno");
			//console.log(rno);
			replyService.get(rno, function(data){
				console.log(data);
				modalInputReply.val(data.reply);
				modalInputReplyer.val(data.replyer);
				modalInputReplyDate.val(replyService.displayTime(data.replyDate))
					.attr("readonly","readonly");
				modalRegisterBtn.hide();
				modal.data("rno", data.rno);
				modal.modal("show");
			});
			
		});
		
		modalModBtn.on("click", function(){
			var reply = {
					rno:modal.data("rno"), 
					reply:modalInputReply.val(), 
					bno:bnoValue};
			replyService.update(reply,function(result){
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});
		});
		
		modalRemoveBtn.on("click", function(){
			var rno = modal.data("rno");
			replyService.remove(rno, function(result){
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});
		});
	})
</script>


<script>
	var actionForm = $('#actionForm');
	$(".listBtn").click(function(e) {
		e.preventDefault();
		actionForm.find('input[name="bno"]').remove();
		actionForm.submit();
	});
	$(".modBtn").click(function(e) {
		e.preventDefault();
		actionForm.attr("action", "/board/modify");
		actionForm.submit();
	});
</script>
<%@ include file="../includes/footer.jsp"%>
