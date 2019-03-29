<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title></title>


    <script type="text/javascript" charset="UTF-8" src="./Ext/ext-all.js"></script>
    <link href="./Extjs/resources/css/ext-all.css" rel="stylesheet" /> 
	<script src="./Extjs/ext-all.js"></script>
	<script src="./Extjs/locale/ext-lang-zh_CN.js"></script>
	<link href="./Extjs/resources/ext-theme-classic/ext-theme-classic-all.css" rel="stylesheet" />    
</head>
<body>
<script type="text/javascript">

var userId = new Ext.form.Hidden({
	name:'userId',
	value:'1'
});

var username = new Ext.form.TextField( {
	id :'username',
	fieldLabel : '用户名',
	name : 'username',//元素名称
	//anchor:'95%',//也可用此定义自适应宽度
	allowBlank : false,//不允许为空
	blankText : '用户名不能为空',//错误提示内容
	maxLength : 16,
	maxLengthText : '姓名长度不能超过16个字符'
});

var account = new Ext.form.TextField({
	id:'account',
	name:'account',
	fieldLabel:'账号',
	allowBlank:false,
	blankText:'账号不能为空',
	maxLength:16,
	maxLengthText:'账号长度不能超过16个字符'
});

var birth = new Ext.form.field.Date({
	id:'birth',
	name:'birth',
	fieldLabel:'生日',
	format:'Y-m-d'
});

var address = new Ext.form.TextField({
	id:'address',
	name:'address',
	fieldLabel:'地址',
	allowBlank:true
});

var mobile = new Ext.form.TextField({
	id:'mobile',
	name:'mobile',
	fieldLabel:'手机号码',
	allowBlank:true,
	vtype:'mobile'
});

Ext.apply(Ext.form.field.VTypes, {
	mobile : function(v) {
		return /^\d{11}$/.test(v);
	},
	mobileText : '无效的手机号码',
	mobileMask : /[\d]/i
});

var form = new Ext.form.FormPanel({
		name:'form',
		bodyStyle:{background:'#ffffff'},
		items : [ userId,username, account,birth,address,mobile ]
	});

var formEle = Ext.create('Ext.form.FieldSet', {
				layout : "column",
				title : "基本信息",
				margin : '5 0 0 0',
				items : [form]
			});
function next(){
	location.href="info.jsp";
};
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';
	

	var win = new Ext.Window({
		title:'添加',
		width:500,
		height:400,
		items:[formEle],
		closeable:false,
		buttonAlign: 'center',
		buttons: [{
			text: '保存',
			handler: function() {
			//Ext.Msg.alert('保存', '表单提交');
			//form.getForm().reset();
			/* var username = username.getValue();
			var account = account.getValue();
			var birth = birth.getValue();
			var address = address.getValue();
			var mobile = mobile.getValue(); */
			if(form.form.isValid()){
				form.form.submit({
					waitMsg : '正在保存,请稍后...',
					url : 'userController/addUser.action',
					method : 'post',
					params : {
					userId : userId,
					username : username,
					account : account,
					birth : birth,
					address : address,
					mobile : mobile
					},
					//提交成功的回调函数
					success : function(form, action) {
						Ext.Msg.alert('保存成功', action.result.msg,next());
						//location.href="info.jsp";
					},
					//提交失败的回调函数
					failure : function(form, action) {
						Ext.Msg.alert('保存失败', action.result.msg); 
		            	}
					
				});
				
				}
			}

		},
			{
			text: '重置',
			handler: function() {
			//mainWin.hide();
			form.getForm().reset();
			//Ext.Msg.alert('取消', '取消按钮');

		}

		}]
	
	});
	win.show();
	
});
	
</script>
</body>
</html>