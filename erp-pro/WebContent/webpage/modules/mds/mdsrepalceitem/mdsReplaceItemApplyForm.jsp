<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>代料申请管理</title>
	<meta name="decorator" content="ani"/>
	<script type="text/javascript">
		var validateForm;
		var $table; // 父页面table表格id
		var $topIndex;//弹出窗口的 index
		function doSubmit(table, index){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		  if(validateForm.form()){
			  $table = table;
			  $topIndex = index;
			  jp.loading();
			  $("#inputForm").submit();
			  return true;
		  }

		  return false;
		}

		$(document).ready(function() {
			validateForm = $("#inputForm").validate({
				submitHandler: function(form){
					jp.post("${ctx}/mds/mdsReplaceItem/save",$('#inputForm').serialize(),function(data){
						if(data.success){
	                    	$table.bootstrapTable('refresh');
	                    	jp.success(data.msg);
	                    	jp.close($topIndex);//关闭dialog

	                    }else{
            	  			jp.error(data.msg);
	                    }
					})
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			
		});
	</script>
</head>
<body class="bg-white">
		<form:form id="inputForm" modelAttribute="mdsReplaceItem" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="table table-bordered">
		   <tbody>
			<%-- 	<tr style="display:none">
				    <td class="width-10 active"><label class="pull-right">采购订单id：</label></td>
					 <td class="width-30">
						<form:input path="id" htmlEscape="false"    class="form-control "/>
					</td> 
					 <td class="width-15 active"><label class="pull-right">替换后物料id：</label></td>
					<td class="width-35">
						<form:input path="mdsItemId" htmlEscape="false"    class="form-control "/>
					</td> 
				</tr> --%>
				<tr>
				<td class="width-10 active"><label class="pull-right">替换物料编码：</label></td>
					<td class="width-30">
					<sys:itemSelectForDetailForm url="${ctx}/mdsitem/mdsItem/data?itemType=M"
										id="item" name="itemId" value="${mdsReplaceItem.itemId}"
										labelName="itemCode" labelValue="${mdsReplaceItem.itemName}"
										title="选择物料" cssClass="form-control required"
										fieldLabels="物料号|物料名|标准号|材质|规格/型号|单位"
										fieldKeys="itemCode|itemName|normalField|modelNum|specs|mdsUnitId"
										searchLabels="物料号|物料名" searchKeys="itemCode|itemName" ></sys:itemSelectForDetailForm>
						<%-- <form:input path="itemName" htmlEscape="false"    class="form-control "/> --%>
					</td>
				</tr>
				<tr>
				  <td class="width-10 active"><label class="pull-right">替换物料名称：</label></td>
				  <td class="width-30">
				   <form:input path="itemName" htmlEscape="false"    class="form-control "/>
				  </td>
				</tr>
				<tr>
				  <td class="width-10 active"><label class="pull-right">替换后采购数量：</label></td>
					<td class="width-30">
						<form:input path="afterReplacePuraseNumber" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>