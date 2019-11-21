<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!-- 获取当前服务器路径 -->
  <%pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<title>SSM_CRUD</title>
</head>
<body>

<!-- 员工修改弹窗 -->
<div class="modal fade" id="employeeupdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工修改</h4>
      </div>
      <div class="modal-body">
      	<form class="form-horizontal" id="formAddemployee">
      
		  <div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">员工姓名</label>
		    <div  id="AddempName" class="col-sm-10">
		      <p class="form-control-static" id="empName_static"></p>
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div  class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">邮箱</label>
		    <div id="Addemail" class="col-sm-10">
		      <input type="text" name="email" class="form-control" id="updateemail" placeholder="邮箱，例：123456789@qq.com">
		      <span class="help-block"></span>
		    </div>
		  </div>
			<div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">性别</label>
		    <div class="col-sm-10">
		      	<label class="radio-inline">
				  	<input type="radio" name="gender" id="updategender" value="M"> 男
				</label>
				<label class="radio-inline">
				  	<input type="radio" name="gender" id="updategender" value="F"> 女
				</label>
		    </div>
		  </div>
		  	<!-- 部门提交id -->
		    <div class="form-group">
		     <label for="inputEmail3" class="col-sm-2 control-label">部门名称</label>
		     <div class="col-sm-4">
		      <select class="form-control" name="dId">
				
			  </select>
		     </div>
		  
		  </div>
		  
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="empupdate">更新</button>
      </div>
    </div>
  </div>
</div>

<!-- 员工新增弹窗 -->
<div class="modal fade" id="employeeModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工新增</h4>
      </div>
      <div class="modal-body">
      	<form class="form-horizontal" id="formAddemployee">
      
		  <div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">员工姓名</label>
		    <div  id="AddempName" class="col-sm-10">
		      <input type="text" name="empName" class="form-control" id="empName" placeholder="员工姓名">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div  class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">邮箱</label>
		    <div id="Addemail" class="col-sm-10">
		      <input type="text" name="email" class="form-control" id="email" placeholder="邮箱，例：123456789@qq.com">
		      <span class="help-block"></span>
		    </div>
		  </div>
			<div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">性别</label>
		    <div class="col-sm-10">
		      	<label class="radio-inline">
				  	<input type="radio" name="gender" id="gender" value="M" checked="checked"> 男
				</label>
				<label class="radio-inline">
				  	<input type="radio" name="gender" id="gender" value="F"> 女
				</label>
		    </div>
		  </div>
		  	<!-- 部门提交id -->
		    <div class="form-group">
		     <label for="inputEmail3" class="col-sm-2 control-label">部门名称</label>
		     <div class="col-sm-4">
		      <select class="form-control" name="dId">
				
			  </select>
		     </div>
		  
		  </div>
		  
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="empsave">保存</button>
      </div>
    </div>
  </div>
</div>

<!-- 搭建显示页面 -->
	<div class="container">
		<div class="row">
  			<div class="col-md-12"><h1>SSM_CRUD</h1></div>
		</div>
		<div class="row">
			 <div class="col-md-4 col-md-offset-8">
			 <button class="btn btn-primary" id="addEmployee">新增</button>
			 <button class="btn btn-danger" id="deletemore">删除</button>
			 </div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps"> 
				<thead>
					<tr>
						<th><input type="checkbox" id="checkALL">全选</th>
						<th>编号</th>
						<th>姓名</th>
						<th>性别</th>
						<th>邮箱</th>
						<th>部门名称</th>
						<th>操作</th>	
					</tr>
				</thead>
				
				<tbody>
					
				</tbody>				
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6" id="pageinfo">
				
			</div>
			<div class="col-md-6" id="pagenav">
				
			</div>
		</div>
	</div>
	<script type="text/javascript">
	
	$(function(){
		toPage(1);
	});
	
	/* 页面加载时，直接发送请求ajax */
	var pagesreCords;
	var pagelocal;
	function toPage(pn){
			$.ajax({
				type:"GET",
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
				/* 执行成功之后的回调函数 */
				success:function(result){
					//保存总记录数
					pagesreCords = result.extend.pageInfo.total; 
					console.log(result);
					//解析并显示员工数据
					buileTable(result);
					buildPageinfo(result);
					buildNv(result);
					//解析并显示分页数据
				}
			});	
	};

		function buileTable(result){
			//清空数据，防止重复
			$("#emps tbody").empty();
			//获取员工数据
			var emps = result.extend.pageInfo.list;
			$.each(emps,function(index,item){
				var checkEmp = $("<td><input type='checkbox' class='checkemp'/></td>")
				var empId = $("<td></td>").append(item.empId);
				var empName = $("<td></td>").append(item.empName);
				var gender = $("<td></td>").append(item.gender=="M"?"男":"女");
				var email = $("<td></td>").append(item.email);
				var deptNameId = $("<td></td>").append(item.department.deptName);
				/* <button class=" btn btn-primary btn-sm">
				<span class="glyphicon glyphicon-pencil" aria-hidden="true">编辑</span>
				</button>
				<button class="btn btn-danger btn-sm" onclick="">
				<span class="glyphicon glyphicon-remove" aria-hidden="true">删除</span>
				</button> */
				/* 添加按钮 */
				var editbtn = $("<button></button>").addClass("btn btn-primary btn-sm editbtn").append("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑");
				editbtn.attr("edit-id",item.empId);
				var deletebtn = $("<button></button>").addClass("btn btn-danger btn-sm deletebtn").append("<span></span>").addClass("glyphicon glyphicon-remove").append("删除");
				deletebtn.attr("delete-id",item.empId);
				var btn = $("<td></td>").append(editbtn).append(" ").append(deletebtn);
				/* 链式操作 */
				$("<tr></tr>").append(checkEmp)
								.append(empId)
								.append(empName)
								.append(gender)
								.append(email)
								.append(deptNameId)
								.append(btn)
								/* 添加到标签区域必须用appendTo */
								.appendTo("#emps tbody");
			});
		};
		function buildPageinfo(result){
			$("#pageinfo").empty();
			$("#pageinfo").append("当前第"+result.extend.pageInfo.pageNum+"页,总共"+result.extend.pageInfo.pages+"页,总共"+result.extend.pageInfo.total+"记录数");
			pagelocal = result.extend.pageInfo.pageNum;
		};
		function buildNv(result){
			$("#pagenav").empty();
			var url = $("<url></url>").addClass("pagination");
			 var firstPage = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			 //给分页按钮添加点击事件
			
			 var previousPage = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
			
			 if (result.extend.pageInfo.pageNum == 1) {
				 firstPage.addClass("disabled");
				 previousPage.addClass("disabled");
				}else {
					 firstPage.click(function(){
							toPage(1);
						});
					 previousPage.click(function(){
							toPage(result.extend.pageInfo.pageNum-1);
						});
				}
			 //依次添加元素
				url.append(firstPage).append(previousPage);
			 /* 相当于for循环遍历 */
			 $.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				 var elemet = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
				 if (result.extend.pageInfo.pageNum == item) {
					elemet.addClass("active");
				}
				 elemet.click(function(){
						 toPage(item);
				 });
				 url.append(elemet);
			 })
			 
			 var nextPage = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
			 
			 var lastPage = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			 
			 if (result.extend.pageInfo.pages == result.extend.pageInfo.pageNum) {
				 nextPage.addClass("disabled");
				 lastPage.addClass("disabled");
				}else {
					nextPage.click(function(){
						toPage(result.extend.pageInfo.pageNum+1);
					});
					lastPage.click(function(){
						toPage(result.extend.pageInfo.pages);
					});
				}
			 url.append(nextPage).append(lastPage);
			 var nav = $("<nav></nav>");
			 nav.append(url);
			 nav.appendTo("#pagenav");
		};
		function reset(elm){
			$(elm)[0].reset();
			$(elm).find("*").removeClass("has-success has-error");
			$(elm).find(".help-block").text(""); 
			
		};
		//新增数据
		$("#addEmployee").click(function(){
			//清空form表单数据,重置表单,是对于form表单内容的清除
		 	reset("#employeeModel form"); 
			//发出ajax请求，显示数据
			getDepts("#employeeModel select");
			//设置点击按钮时弹出弹框
			$("#employeeModel").modal(
					{backdrop:"static"}
			);
			
		});
		
		function getDepts(ele){
			//清空下拉列表
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					$.each(result.extend.depts,function(index,item){
						var option = $("<option></option>").append(item.deptName).attr("value",item.deptId);
						option.appendTo(ele);
					})
					console.log(result);	
				}
			});
		};
		//保存员工
		$("#empsave").click(function(){
			
			//前端校验用户名和邮箱
		 	if(validate_data() == false)
			{
				return false;
				}; 
				//判断是都需要保存数据
			 if ($(this).attr("ajax-judge") == "error") {
					return false;
				} 
				//ajax传输数据
				 $.ajax({
						type:"POST",
						url:"${APP_PATH}/emp",
						/* 将获得数据序列化方便存储 */
						data:$("#employeeModel form").serialize(),
						success:function(result){
							//后端校验是否符合要求
							if (result.code1 == 100) {
								//当后端校验成功执行插入数据
								//关闭窗口
								 $("#employeeModel").modal('hide');
								 //发送ajax请求进行刷新
								 toPage(pagesreCords);
							}else {		
								if (undefined != result.extend.errorFieds.email) {
									showMsg("#email","error",result.extend.errorFieds.email);
								}
								if (undefined != result.extend.errorFieds.empName) {
									showMsg("#empName","error",result.extend.errorFieds.empName);
								} 
								if(undefined != result.extend.errorFieds.email && undefined != result.extend.errorFieds.empName){
									showMsg("#email","error",result.extend.errorFieds.email);
									showMsg("#empName","error",result.extend.errorFieds.empName);
								}
							
								console.log(result);
							}
							
							
						}
				
					}); 
		
		});
		
		//前端校验格式
		function validate_data(){
			 var empName = $("#empName").val();
			 var validateEmpname = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
			 if (!validateEmpname.test(empName)) {
				/*  alert("用户名应为3-16位英文或者2-5位中文"); */
			/* 	$("#empName").parent().addClass("form-group has-error");
				$("#empName").next("span").text("用户名应为3-16位英文或者2-5位中文"); */
				showMsg("#empName","error","用户名应为3-16位英文或者2-5位中文");
				return false;
			}else {
				/* $("#empName").parent().addClass("form-group has-success");
				$("#empName").next("span").text("验证正确"); */
				showMsg("#empName","sucess","");
			}
			 
			 var email = $("#email").val();
			 var validataEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!validataEmail.test(email)) {
				/* alert("邮箱格式不正确"); */
				/* $("#email").parent().addClass("form-group has-error");
				$("#email").next("span").text("邮箱格式不正确"); */
				showMsg("#email","error","邮箱格式不正确");
				return false;
			}else {
				/* $("#email").parent().addClass("form-group has-success");
				$("#email").next("span").text("验证正确"); */
				showMsg("#email","sucess","");
			}
		};
		
		//显示校验提示信息
		function showMsg(elm,status,msg){
			//清除状态信息
			$(elm).parent().removeClass("has-success has-error");
			$(elm).next("span").text("");
			if (status == "sucess") {
				$(elm).parent().addClass("has-success");
				$(elm).next("span").text(msg);
			}else {
				$(elm).parent().addClass("has-error");
				$(elm).next("span").text(msg);
			}
		};
		
		$("#empName").change(function(){
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkUser",
				type:"POST",
				data:"empName="+empName,
				success:function(result){
					if (result.code1 == 100) {
						showMsg("#empName","sucess","用户名可用");
						 $("#empsave").prop("disabled",false);
						  $("#empsave").attr("ajax-judge" ,"success"); 
					}else {
						showMsg("#empName","error",result.extend.val_msg);
						//禁用按钮并且禁用事件
						 $("#empsave").prop("disabled",true); 
						$("#empsave").attr("ajax-judge" ,"error");
					}
				}
			});
		});
		
		//编辑按钮事件
		$(document).on("click",".editbtn",function(){
			
			//显示弹出框
			$("#employeeupdateModel").modal({
				backdrop : "static"
			});
			//显示下拉列表数据
			getDepts("#employeeupdateModel select");
			//显示需要更新的员工信息数据
			getEmps($(this).attr("edit-id"));
			$("#empupdate").attr("editid",$(this).attr("edit-id"));
		})
		//获取员工数据，显示当弹框上
		function getEmps(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					console.log(result);
					$("#empName_static").text(result.extend.emp.empName);
					//val给input类型赋值
					$("#updateemail").val(result.extend.emp.email);
					//设置单选框对于的值
					$("#employeeupdateModel input[type=radio]").val([result.extend.emp.gender]);
					//设置下拉列表值
					$("#employeeupdateModel select").val(result.extend.emp.dId);
					
				}
			});
		}
		//点击更新员工，绑定事件
		$("#empupdate").click(function(){
			//验证邮箱格式
			 var email = $("#updateemail").val();
			 var validataEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!validataEmail.test(email)) {
				/* alert("邮箱格式不正确"); */
				/* $("#email").parent().addClass("form-group has-error");
				$("#email").next("span").text("邮箱格式不正确"); */
				showMsg("#updateemail","error","邮箱格式不正确");
				return false;
			}else {
				/* $("#email").parent().addClass("form-group has-success");
				$("#email").next("span").text("验证正确"); */
				showMsg("#updateemail","sucess","");
			}
			//发送ajax请求，保存员工数据
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("editid"),
				type:"POST",
				data:$("#employeeupdateModel form").serialize()+"&_method=PUT",
				success:function(result){
					console.log(result);
					 $("#employeeupdateModel").modal('hide');
					 toPage(pagelocal);
				}
			})
		});
		
		//删除单条数据
		$(document).on("click",".deletebtn",function(){
				//弹出确认框，包含名字,parents代表标签的父节点的tr元素的第二个td的元素值，eq正数是从0开始
				 var idData = $(this).parents("tr").find("td:eq(2)").text();
				if(confirm("确认要删除"+idData+"数据吗？")){
					$.ajax({
						url:"${APP_PATH}/emp/"+$(this).attr("delete-id"),
						type:"DELETE",
						success:function(){
							toPage(pagelocal);
						}
					});
				}
		});
		
		//完成全选，全不选
		$("#checkALL").click(function(){
			$(".checkemp").prop("checked",$(this).prop("checked"));
		});
		//此单击事件是对于非直接生成的标签添加点击事件
		$(document).on("click",".checkemp",function(){
			//判断是都都选中
			 var flag = $(".checkemp:checked").length ==$(".checkemp").length;
			$("#checkALL").prop("checked",flag);
			
		});
		$("#deletemore").click(function(){
			if($(".checkemp:checked").length == 0){
				alert("请选择一行需要删除的数据");
				return false;
			}
			var deleteEmpname = "";
			var deleteIds = "";
			$.each($(".checkemp:checked"),function(){
				deleteEmpname+= $(this).parents("tr").find("td:eq(2)").text()+",";
				deleteIds+=$(this).parents("tr").find("td:eq(1)").text()+"-";
			});
			//去除多余的“，”
			deleteEmpname = deleteEmpname.substring(0,deleteEmpname.length-1);
			//去除多余的“-”
			deleteIds = deleteIds.substring(0,deleteIds.length-1);
			if(confirm("确认要删除"+deleteEmpname+"数据吗?")){
				$.ajax({
					url:"${APP_PATH}/emp/"+deleteIds,
					type:"DELETE",
					success:function(result){
						toPage(pagelocal);
					}
				});
			}
			
		});
	</script>
	
</body>
</html>