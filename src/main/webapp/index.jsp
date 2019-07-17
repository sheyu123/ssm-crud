<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-3.2.1.min.js"></script>
<link rel="stylesheet"
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />
<script type="text/javascript"
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>

<body>

	<!-- Modal -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">员工修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_updata_static"></p>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_update_input" placeholder="sheyu1997@163.com">
								<span id="helpBlock2" class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_update_input" value="F"> 女
								</label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<!-- 部门Id即可 -->
								<select class="form-control" name="dId" id="dept_update_select">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
				</div>
			</div>
		</div>
	</div>


	<!-- Modal -->
	<div class="modal fade" id="empAllModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control"
									id="empName_add_input" placeholder="empName"> <span
									id="helpBlock2" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_add_input" placeholder="sheyu1997@163.com"> <span
									id="helpBlock2" class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add_input" value="F"> 女
								</label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<!-- 部门Id即可 -->
								<select class="form-control" name="dId" id="dept_add_select">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>



	<!--搭建显示页面 -->
	<div class="container">
		<!--标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CURD</h1>
			</div>
		</div>
		<!--按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
		<!--显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th><input type="checkbox" id="check_all" /></th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>

					</tbody>

				</table>
			</div>

		</div>

		<!--分页消息 -->
		<div class="row">
			<!--分页文字信息 -->
			<div class="col-md-6" id="page_info_area"></div>

			<!--分页条信息 -->
			<div class="col-md-6" id="page_nav_areas"></div>

		</div>
	</div>
	<!-- 发送请求后获得分页信息 -->
	<script type="text/javascript">
		$(function() {
			//默认为1
			to_page(1);
		});

		//页面跳转的方法
		var totalRecord,currendPage;

		function to_page(pn) {
			$.ajax({
				type : "GET",
				url : "${APP_PATH}/emps",
				async : true,
				data : "pn=" + pn,

				success : function(result) {

					//console.log(result);
					//1.解析并显示员工数据
					build_emps_table(result);

					//2.解析并显示分页信息
					build_page_info(result);

					//3.解析显示分页条数据
					build_page_nav(result);
				}

			});

		};

		function build_emps_table(result) {
			//清空table表格
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;

			//构建模态框
			$.each(emps, function(index, item) {
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(
						item.gender == 'M' ? "男" : "女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>")
						.append(item.department.deptName);
				var editBtn = $("<button></button>").addClass(
						"btn btn-primary btn-sm edit_btn").append(
						"<span></span>").addClass("glyphicon glyphicon-pencil")
						.append("编辑");
				//编辑按钮添加样式(id)
				editBtn.attr("edit_empId", item.empId);
				var delBtn = $("<button></button>").addClass(
						"btn btn-danger btn-sm").append("<span></span>")
						.addClass("glyphicon glyphicon-trash delete_btn")
						.append("删除");
				//删除按钮添加样式(id)
				delBtn.attr("del_empId", item.empId);
				
				//append 执行完毕后还是返回原来的元素 
				$("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(
						genderTd).append(emailTd).append(deptNameTd).append(
						editBtn).append(delBtn).appendTo("#emps_table tbody");
			});
		}

		//解析显示分页信息
		function build_page_info(result) {
			//清空分页信息
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前页数页" + result.extend.pageInfo.pageNum + ",总共"
							+ result.extend.pageInfo.pages + "页,总共有"
							+ result.extend.pageInfo.total + "条记录");
			//最大数
			totalRecord = result.extend.pageInfo.total;
			
			currendPage = result.extend.pageInfo.pageNum;
		}

		//解析显示分页条,点击分页条，能去下一页
		function build_page_nav(result) {
			//清空分页条导航
			$("#page_nav_areas").empty();

			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"));

			//判断分页是否有上一页
			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				//首页点击
				firstPageLi.click(function() {
					to_page(1);
				});
				//上一页点击
				prePageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}

			var nexPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			var LastPageLi = $("<li></li>").append(
					$("<a></a>").append("尾页").attr("href", "#"));

			//判断分页是否有下一页
			if (result.extend.pageInfo.hasNextPage == false) {
				nexPageLi.addClass("disabled");
				LastPageLi.addClass("disabled");
			} else {
				//下一页
				nexPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});

				//末页
				LastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});
			}

			//添加首页和前一页
			ul.append(firstPageLi).append(prePageLi);

			//遍历每行页数
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				//分页信息
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				//点击事件
				numLi.click(function() {
					to_page(item);
				});

				//等于当前页是下标添加样式
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				//将li添加到ul中
				ul.append(numLi);
			});

			//添加下一页和末页
			ul.append(nexPageLi).append(LastPageLi);

			//将ul添加到分页div中
			$("#page_nav_areas").append(ul);

			//将ul添加到nav中
			var navEle = $("</nav></nav>").append(ul);

			//将nav添加到分页div中
			navEle.appendTo("#page_nav_areas");

		}

		//清空样式
		function rest_form(ele) {
			//清空form表单
			$(ele)[0].reset();
			//清空样式
			$(ele).find("*").removeClass("has-success has-error");
			//清空提示文本
			$(ele).find(".help-block").text("");

		}

		//点击新增按钮弹出模态框
		$("#emp_add_modal_btn").click(function() {
			//清空form表单
			rest_form("#empAllModal form");
			//$("#empAllModal form")[0].reset();

			//发送ajax请求
			$("#dept_add_select").empty();
			getDepts("#dept_add_select");

			//弹出模态框
			$("#empAllModal").modal({
				backdrop : "static"
			});
		});

		//显示所有部门信息并显示在下拉列表中
		function getDepts(ele) {
			//清空下拉列表 
			$(ele).empty();
			$.ajax({
				type : "GET",
				url : "${APP_PATH}/depts",
				success : function(result) {
					//console.log(result);
					//显示部门信息在下拉列表中
					//$("#dept_add_select")

					$.each(result.extend.depts, function(index, item) {
						var optionEle = $("<option></option>").append(
								item.deptName).attr("value", item.deptId);
						optionEle.appendTo(ele);
					});
				}

			});

		};

		//校验表单数据
		function validate_add_from() {
			//拿到要校验的数据进行验证
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;

			if (!regName.test(empName)) {

				show_validate_msg("#empName_add_input", "error",
						"中文2~6位，数字6~16位");

				//alert("中文2~6位，数字6~16位");
				return false;
			} else {
				show_validate_msg("#empName_add_input", "success", "");
				/* $("#empName_add_input").parent().addClass("has-success");
				$("#empName_add_input").next("span").text(""); */
			}
			;

			//验证邮箱
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				//alert("邮箱格式不正确");

				show_validate_msg("#email_add_input", "error", "邮箱格式不正确")

				/* $("#email_add_input").parent().addClass("has-error");
				$("#email_add_input").next("span").text("邮箱格式不正确"); */
				return false;
			} else {

				show_validate_msg("#email_add_input", "success", "邮箱格式不正确")

				/* $("#email_add_input").parent().addClass("has-success");
				$("#email_add_input").next("span").text(""); */
			}
			;

			return true;
		}

		//表单验证状态并显示信息
		function show_validate_msg(ele, status, msg) {
			//验证前清空状态
			$(ele).parent().removeClass("has-success has-error");

			if ("success" == status) {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text("");
			} else if ("error" == status) {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}

		//验证员工是否存在（change）
		//失去焦点
		$("#empName_add_input").focusout(
				function() {
					var empName = this.value;
					//发送ajax请求检验用户名是否可用
					$.ajax({
						url : "${APP_PATH}/checkuser",
						data : "empName=" + empName,
						type : "GET",
						success : function(result) {
							if (result.code == 100) {
								show_validate_msg("#empName_add_input",
										"success", "用户名可用");
								$("#emp_save_btn").attr("ajax-va", "success");
							} else {
								show_validate_msg("#empName_add_input",
										"error", result.extend.va_msg);
								$("#emp_save_btn").attr("ajax-va", "error");
							}
						}

					});
				});

		$("#emp_save_btn")
				.click(
						function() {
							//1.模态框中填写的表单数据提交给服务器进行保存
							//1.1 提交之前进行表单验证
							if (!validate_add_from()) {
								return false;
							}
							;

							if ($(this).attr("ajax-va") == "error") {
								return false;
							}

							//2.发送ajax请求保存员工
							$
									.ajax({
										url : "${APP_PATH}/emp",
										type : "POST",
										//序列表表格内容为字符串
										data : $("#empAllModal form")
												.serialize(),
										success : function(result) {
											if (result.code == 100) {
												//添加成功后，关闭模态框， 跳转到最后一页查看数据
												$("#empAllModal").modal("hide");
												to_page(totalRecord);
											} else {
												//console.log(result);
												//显示邮箱错误信息
												if (undefined != result.extend.errorFields.email) {
													show_validate_msg(
															"#email_add_input",
															"error", "邮箱格式不正确")
												}
												//显示用户错误信息
												if (undefined != result.extend.errorFields.empName) {
													show_validate_msg(
															"#email_add_input",
															"error", "用户不正确")
												}
											}
										}

									});

						});

		//为编辑按钮绑定事件(按钮是动态创建的)
		$(document).on("click", ".edit_btn", function() {
			//编辑是邮箱是默认的，格式正确(事前经过验证)
			show_validate_msg("#email_update_input", "success", "邮箱格式正确")

			//获取对应的部门Id(查询员工信息)
			getEmp($(this).attr("edit_empId"));
			//显示部门信息
			getDepts("#dept_update_select");
			
			//为更新按钮获得员工Id
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit_empId"));
			
			$("#empUpdateModal").modal({
				backdrop : "static"
			})
		});

		//查询员工信息
		function getEmp(id) {
			$.ajax({
				url : "${APP_PATH}/emp/" + id,
				type : "GET",
				success : function(result) {
					//console.log(result);
					var empData = result.extend.emp;
					$("#empName_updata_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val(
							[ empData.gender ]);
					$("#empUpdateModal select").val([ empData.dId ]);
				}

			})
		}

		// 为更新按钮绑定事件
		$("#emp_update_btn").click(function() {
			
			//验证邮箱
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				//alert("邮箱格式不正确");
				show_validate_msg("#email_update_input", "error", "邮箱格式不正确")

				/* $("#email_add_input").parent().addClass("has-error");
				$("#email_add_input").next("span").text("邮箱格式不正确"); */
				return false;
			} else {

				show_validate_msg("#email_update_input", "success", "邮箱格式正确")
			}

			//发送修改到控制器
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					//关闭模态框
					$("#empUpdateModal").modal("hide");
					
					//回到修改的页面
					to_page(currendPage);
				}
				
			})
			
			

		})
		
		
		
		//为删除按钮绑定事件
		$(document).on("click",".delete_btn",function(){
			//获得删除员工的姓名
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			//获得删除员工的ID
			var empId = $(this).attr("del_empId");
			//弹出是否确认删除员工
			if(confirm("确认是否删除["+empName+"]吗?")){
				//发送删除员工的ajax
				$.ajax({
					url:"${APP_PATH}/emp/"+empId,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//成功后返回本页面,回到修改的页面
						to_page(currendPage);
					}
					
				})
			
				
			} 
			
		})
		
		//复选框的选中事件
		$("#check_all").click(function(){
			//prop修改和使用原生的属性，attr修改和使用自定义的属性
			$(".check_item").prop("checked",$(this).prop("checked"));
			
		})
		
		//判断复选框是否都选上
		$(document).on("click",".check_item",function(){
			//获取页面上的复选框
			var fag = $(".check_item:checked").length == $(".check_item").length;
			$("#check_all").prop("checked",fag);
		})
		
		//批量删除
		$("#emp_delete_all_btn").click(function(){
			var empNames = "";
			var del_idstr ="";
			//alert($(".check_item:checked").parents("tr").find("td:eq(2)").text());
			//遍历出勾选的复选框
			$.each($(".check_item:checked"),function(){
				//员工姓名组装
				empNames +=$(this).parents("tr").find("td:eq(2)").text()+",";
				//员工Id组装
				del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
			})
			//去除多余的,
			empNames.substring(0,empNames.length-1);
			del_idstr.substring(0,del_idstr.length-1);
			
		
		if (confirm("确认删除【" + empNames + "】吗？")) {
			$.ajax({
				url : "${APP_PATH}/emp/" + del_idstr,
				type : "DELETE",
				success : function(result) {
				alert(result.msg);

				//成功后返回本页面,回到修改的页面
						to_page(currendPage);
					}

				})

			}

		});
		
		
		
	</script>
</body>

</html>