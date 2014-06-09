<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String MenuNo=request.getParameter("MenuNo");

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>滞纳金收取报表</title>
    
    <link href="<%=basePath %>lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath %>lib/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath %>lib/css/common.css" rel="stylesheet" type="text/css" />  
    <script src="<%=basePath %>lib/jquery/jquery-1.5.2.min.js" type="text/javascript"></script>
    <script src="<%=basePath %>lib/ligerUI/js/ligerui.min.js" type="text/javascript"></script>  
    <script src="<%=basePath %>lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="<%=basePath %>lib/js/common.js" type="text/javascript"></script>   
    <script src="<%=basePath %>lib/js/LG.js" type="text/javascript"></script>
    <script src="<%=basePath %>lib/js/ajaxfileupload.js" type="text/javascript"></script>
    <script src="<%=basePath %>lib/js/ligerui.expand.js" type="text/javascript"></script> 
    <script src="<%=basePath %>lib/json2.js" type="text/javascript"></script>
    <script src="<%=basePath %>lib/test.js" type="text/javascript"></script>
    <script src="<%=basePath %>lib/jquery-validation/jquery.validate.min.js" type="text/javascript"></script> 
    <script src="<%=basePath %>lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="<%=basePath %>lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
  </head>
<body style="padding:10px;height:100%; text-align:center;">
<jsp:include page="../viewpage.jsp"></jsp:include>
   <ipnut type="hidden" id="MenuNo" value="<%=MenuNo  %>" />
   <div id="detail" style="display:none;"><form id="mainform" method="post"></form> </div>
 <div id="mainsearch" style=" width:98%">
    <div class="searchtitle">
        <span>搜索</span>
        
    </div>
    <div class="navline" style="margin-bottom:4px; margin-top:4px;"></div>
        <div class="searchbox">
        <form id="formsearch" class="l-form"></form>
    </div>
  </div>
  <div id="maingrid"></div>   
  <script type="text/javascript">
      //相对路径
      var rootPath = "<%=basePath %>";
      //列表结构
      var grid = $("#maingrid").ligerGrid({
          columns: 
                [
                   	{display: "所属门店", name: "shop", width: 120 },
					{display:"租赁合同号",name:"zlhtid", width: 90},
					{display:"物业合同号",name:"wyhtid", width: 90},
					{display:"供应商编码",name:"wldmbm", width: 90},
					{display:"供应商名称",name:"wldmname", width: 120},
					{display:"收款单号",name:"pid", width: 90},
					{display:"收款人",name:"entryman", width: 90},
					{display:"交纳方式",name:"paymode", width: 90},
					{display:"合同应交日期",name:"payabledate", width: 90},
					{display:"实际交纳日期",name:"paiddate", width: 90},
					{display:"物业管理费金额",name:"wymoney", width: 90},
					{display:"空调用费金额",name:"ktmoney", width: 90},
					{display:"逾期天数",name:"overdate", width: 90},
					{display:"物业滞纳金",name:"wyznjmoney", width: 90},
					{display:"减免物业滞纳金",name:"wyznjjm", width: 90},
					{display:"实收物业滞纳金",name:"wyznjsh", width: 90},
					{display:"空调滞纳金",name:"ktznjmoney", width: 90},
					{display:"减免空调滞纳金",name:"ktznjjm", width: 90},
					{display:"实收空调滞纳金",name:"ktznjsh", width: 90}
                 ], 
           dataAction: 'server',
 		   url: rootPath + 'wyrpt/rpt_getClassList.action?view=RptZnjPay',
           sortName: 'entrydate', 
           pageSize: 20, 
           //toolbar: {},
           width: '98%', height: '100%',heightDiff:-10, checkbox: false
      });
	  
      $("#formsearch").ligerForm({
		   fields:[
		   	{display:"门店名称",name:"ToShop",newline:true,labelWidth:100,width:220,space:30,type:"select",comboboxName:"shopname",options:{valueFieldID:"shop",url:'<%=basePath %>/json/json_shopBySeclect.action'},cssClass:"field",attr: { "op": "like"}},
		    {display:"收款单号",name:"pid",newline:false,labelWidth:100,width:220,space:30,type:"text",cssClass:"field",attr: { "op": "equal"}},
		    {display:"查询开始日期",name:"entrydate",newline:true,labelWidth:100,width:220,space:30,type:"date",cssClass:"field",attr: { "op": "greaterorequal"}},
		    {display:"查询结束日期",name:"endentrydate",newline:false,labelWidth:100,width:220,space:30,type:"date",cssClass:"field",attr: { "op": "lessorequal"}},
		    {display:"收款人",name:"entryuserTo",newline:true,labelWidth:100,width:220,space:30,type:"select",comboboxName:"entryuser",options:{valueFieldID:"entryuserid",url:'<%=basePath %>/json/json_wyuserBySeclect.action'},cssClass:"field",attr: { "op": "equal"}},
		    {display: "供应商编码", name:"ghdwdm",newline:false,labelWidth:100,width:220,space:30,type:"text",cssClass: "field", attr: { "op": "like"}},
		    {display: "物业合同号", name:"a.htid",newline:true,labelWidth:100,width:220,space:30,type:"text",cssClass: "field", attr: { "op": "equal"}}
		    ],
		   toJSON: JSON2.stringify
	  });
	  
	  LG.appendDownLoadButtons("#formsearch", grid);
	  
	  
	  
	  //LG.loadToolbar(grid, toolbarBtnItemClick);
	  
	  //工具条事件
      function toolbarBtnItemClick(item) {
          switch (item.id) {
          	case "exprot":
                  //top.f_addTab(null, '新增合同', '<%=basePath %>htDetail.jsp');
                  break;
          }
      }
      
      
      function f_reload() {
          grid.loadData();
      }
      
      
      function f_delete() {
          var selected = grid.getSelected();
          if (!selected) { jQuery.ligerDialog.warn('请选择行!'); return }
          if (selected) {
           LG.ajax({
                  url: rootPath+'bus/bus_delWyht.action',
                  loading: '正在删除中...',
                  data: { htid: selected.htid },
                  success: function () {
                      jQuery.ligerDialog.success('删除成功!');
                      f_reload();
                  },
                  error: function (message) {
                      jQuery.ligerDialog.error(message.Message);
                  }
              });
          }
          else {
              jQuery.ligerDialog.error('请选择行!');
          }
      }
      

   


      
  </script>
</body>
</html>