<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="隐藏域名称（ID）"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="隐藏域值（ID）"%>
<%@ attribute name="labelName" type="java.lang.String" required="true" description="输入框名称（Name）"%>
<%@ attribute name="labelValue" type="java.lang.String" required="true" description="输入框值（Name）"%>
<%@ attribute name="fieldLabels" type="java.lang.String" required="true" description="表格Th里显示的名字"%>
<%@ attribute name="fieldKeys" type="java.lang.String" required="true" description="表格Td里显示的值"%>
<%@ attribute name="searchLabels" type="java.lang.String" required="true" description="表格Td里显示的值"%>
<%@ attribute name="searchKeys" type="java.lang.String" required="true" description="表格Td里显示的值"%>
<%@ attribute name="title" type="java.lang.String" required="true" description="选择框标题"%>
<%@ attribute name="url" type="java.lang.String" required="true" description="数据地址"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="isMultiSelected" type="java.lang.Boolean" required="false" description="css样式"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否限制选择，如果限制，设置为disabled"%>
	<input id="${id}Id" name="${name}"  type="hidden" value="${value}"/>
	<div class="input-group" style="width: 100%">
		<input id="${id}Name"  name="${labelName }" ${allowInput?'':'readonly="readonly"'}  type="text" value="${labelValue}" data-msg-required="${dataMsgRequired}"
		class="${cssClass}" style="${cssStyle}"/>
       		 <span class="input-group-btn">
	       		 <button type="button"  id="${id}Button" class="btn <c:if test="${fn:contains(cssClass, 'input-sm')}"> btn-sm </c:if><c:if test="${fn:contains(cssClass, 'input-lg')}"> btn-lg </c:if>  btn-primary ${disabled} ${hideBtn ? 'hide' : ''}"><i class="fa fa-search"></i>
	             </button> 
	               <button type="button" id="${id}DelButton" class="close" data-dismiss="alert" style="position: absolute; top: 5px; right: 53px; z-index: 999; display: block;">×</button>
       		 </span>
       		
    </div>
	 <label id="${id}Name-error" class="error" for="${id}Name" style="display:none"></label>
<script type="text/javascript">
$(document).ready(function(){
	$("#${id}Button, #${id}Name").click(function(){
		if ($("#${id}Button").hasClass("disabled")){
			return true;
		}
		
		top.layer.open({
		    type: 2,  
		    area: ['800px', '500px'],
		    title:"${title}",
		    auto:true,
		    name:'friend',
		    content: "${ctx}/tag/gridselect?url="+encodeURIComponent("${url}")+"&fieldLabels="+encodeURIComponent("${fieldLabels}")+"&fieldKeys="+encodeURIComponent("${fieldKeys}")+"&searchLabels="+encodeURIComponent("${searchLabels}")+"&searchKeys="+encodeURIComponent("${searchKeys}")+"&isMultiSelected=${isMultiSelected? true:false}",
		    btn: ['确定', '关闭'],
		    yes: function(index, layero){
		    	 var iframeWin = layero.find('iframe')[0].contentWindow; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
		    	 var item = iframeWin.getSelections();
		    	 if(item.length != 1){
				    	jp.warning("只能选择一条数据!");
				    	return;
			    	 }
			    	/*  var ids = [];
			    	 var name = [];
			    	 var code = [];
			    	 for(var i=0; i<items.length; i++){
			    		 var item = items[i];
			    		 ids.push(item.id);
			    		 code.push(item${fn:substring(labelName, fns:lastIndexOf(labelName, '.'), fn:length(labelName))});
			    		 name.push(item.itemName);
			    	 } */
			    
			    	 
			    	
		    	 $("#${id}Id").val(item[0].id);
		    	 $("#${id}Name").val(item[0].itemName);
		    	 $("#${id}specs").val(item[0].specs);
		    	 $("#${id}modelNum").val(item[0].modelNum);
		    	
				 top.layer.close(index);//关闭对话框。
			  },
			  cancel: function(index){ 
		       }
		}); 
	})
	$("#${id}DelButton").click(function(){
		// 是否限制选择，如果限制，设置为disabled
		if ($("#${id}Button").hasClass("disabled")){
			return true;
		}
		// 清除	
		$("#${id}Id").val("");
		$("#${id}Name").val("");
		$("#${id}specs").val("");
		$("#${id}modelNum").val("");
		$("#${id}Name").focus();

	});
})
</script>
