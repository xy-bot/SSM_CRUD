<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
    <%pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
     <jsp:forward page="/emps"></jsp:forward>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<body>


<!-- 搭建显示页面 -->
	<div class="container">
		<div class="row">
  			<div class="col-md-12"><h1>SSM_CRUD</h1></div>
		</div>
		<div class="row">
			 <div class="col-md-4 col-md-offset-8">
			 <input type="button" value="编辑" class="btn btn-primary">
			  <input type="button" value="删除" class="btn btn-danger"> 
			 </div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover"> 
					<tr>
						<th>编号</th>
						<th>姓名</th>
						<th>性别</th>
						<th>邮箱</th>
						<th>部门名称</th>
						<th>操作</th>	
					</tr>
					<c:forEach items="${pageInfo.list}" var="emp">
						<tr>
							<th>${emp.empId} </th>
							<th>${emp.empName} </th>
							<th>${emp.gender=="M"?"男":"女"} </th>
							<th>${emp.email} </th>
							<th>${emp.department.deptName} </th>
							<th>
								<button class=" btn btn-primary btn-sm">
								<span class="glyphicon glyphicon-pencil" aria-hidden="true">编辑</span>
								</button>
								<button class="btn btn-danger btn-sm" onclick="">
								<span class="glyphicon glyphicon-remove" aria-hidden="true">删除</span>
								</button>
							</th>
						</tr>
					</c:forEach>
						
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6">
				当前第${pageInfo.pageNum}页,总共${pageInfo.pages}页,总共${pageInfo.total} 记录数
			</div>
			<div class="col-md-6">
				<nav aria-label="Page navigation ">
  					<ul class="pagination">
  					<li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
   					
   					 <c:if test="${pageInfo.hasPreviousPage}">
   					  <li>
   					 	  <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">  
			        		<span aria-hidden="true">&laquo;</span>
			        		</a>
			        	 </li>
   					 </c:if>

			    <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
			    <c:if test="${page_Num == pageInfo.pageNum}">
			    	<li class="active"><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li>
			    </c:if>
			    <c:if test="${page_Num != pageInfo.pageNum}">
			    	<li><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li>
			    </c:if>
			    </c:forEach>
			   
			    <c:if test="${pageInfo.hasNextPage}">
			     <li>
			    	<a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			     	 </a>			    
			    </li>
			    </c:if>
			   
			     <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
			  </ul>
			</nav>
			</div>
		</div>
	</div>
</body>
</html>