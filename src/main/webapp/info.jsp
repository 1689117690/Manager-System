<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		var store = Ext.create('Ext.data.Store', {
	        fields: ["userId", "username", "account","birth","address","mobile"],
	        pageSize: 10,  //页容量5条数据
	        //是否在服务端排序 （true的话，在客户端就不能排序）
	        remoteSort: false,
	        remoteFilter: true,  
	        proxy: {
	            type: 'ajax',
	            url: 'userController/getAllUsers.action',
	            extraParams:{param:''},	          
	            reader: {
	                type: 'json', //返回数据类型为json格式
	                root: 'User',  //数据
	                totalProperty: 'total' //数据总条数
	            }
	        },
	        sorters: [{
	            //排序字段。
	            property: 'userId',
	            //排序类型，默认为 ASC 
	            direction: 'asc'
	        }],
	        autoLoad: true  //即时加载数据
	    });
		
		Ext.onReady(function () {
            

            var grid = Ext.create('Ext.grid.Panel', {
            renderTo: Ext.getBody(),
            store: store,
            height: 400,
            width:800,
            selModel: { selType: 'checkboxmodel' },   //选择框
            columns: [                    
                          { text: '用户ID', dataIndex: 'userId', hidden: true},
                          { text: '姓名', dataIndex: 'username',align: 'center',maxWidth: 120 },
                          { text: '账号', dataIndex: 'account', align: 'center', minWidth: 80 },
                          { text: '出生日期', dataIndex: 'birth', align: 'center', minWidth: 80 },
                          { text: '地址', dataIndex: 'address', align: 'center', minWidth: 150 },
                          { text: '手机号码', dataIndex: 'mobile', align: 'center', minWidth: 80 }
                       ],
            bbar: [{
                xtype: 'pagingtoolbar',
                store: store,
                displayMsg: '显示 {0} - {1} 条，共计 {2} 条',
                emptyMsg: "没有数据",
                beforePageText: "当前页",
                afterPageText: "共{0}页",
                displayInfo: true                 
            }],
             listeners: { 'itemclick': function (view, record, item, index, e) {
               //Ext.MessageBox.alert("标题",record.data.userId);
            }
            },
             tbar:[
             {text:'新增',iconCls:'a_add',handler:addUser},"-",
             {text:'修改',iconCls:'a_edit2',handler: edits},"-",
             {text:'删除',iconCls:'a_lock',handler: deleteUser},"-",
             "->",{id:'condition',xtype:'textfield',name:'searchField',emptyText:'输入搜索词'},
             { iconCls:"a_search",text:"搜索",handler:search}], 
        });
            
      	/* 用户搜索 */
		function search (){
		      var searchField = Ext.getCmp("condition").getValue();
		      store.proxy.extraParams ={param:searchField};
		   /*     var par={};
		       par.param=searchField;
		       store.load({params:par}); */
		       store.getProxy().url="userController/findUser.action";
		      
		      store.load();
		      
		 }
 
		 function addUser(){
			 location.href="addUser.jsp";
		 }
 

 function  edits(){
 	var record = grid.getSelectionModel().getSelection();
 	if(record.length == 0 || record.length > 1){
 		Ext.MessageBox.show({
 			title:"提示",
 			msg:"请选择一行进行编辑！"
 		})
 		return;
 	}else{
 		var userId = record[0].get("userId");
 		var username = record[0].get("username");
 		var account = record[0].get("account");
 		var birth = record[0].get("birth");
 		var address = record[0].get("address");
 		var mobile = record[0].get("mobile");
 		editRow(userId,username, account, birth, address, mobile);
 	}
 }
 
 function editRow(userId,username, account, birth, address, mobile) {
	 	Ext.getCmp("userId").setValue(userId);
	 	Ext.getCmp("username").setValue(username);
		Ext.getCmp("account").setValue(account);
		Ext.getCmp("birth").setValue(birth);
		Ext.getCmp("address").setValue(address);
		Ext.getCmp("mobile").setValue(mobile);

		win.show();
	}
 
	function deleteUser(){
		var record = grid.getSelectionModel().getSelection();
		if(record.length==0){
			Ext.MessageBox.show({
				title:"提示",
				msg:"请选择至少一行进行删除！"
			})
			return; 
		}else{
			var userIds = "";
			for(var i=0;i<record.length;i++){
				userIds += record[i].get("userId");
				if(i<record.length-1){
					userIds = userIds + ","
				}
			}
			Ext.Ajax.request({
				url:'userController/deleteUser.action',
				type:"POST",
				dataType:'JSON',
				params:{userIds:userIds},
				success:function(){
					Ext.Msg.alert("提示", "删除成功!");
					location.href="info.jsp";
				},
				failure:function(){
					 Ext.Msg.alert("提示", "删除失败!");
				}
			});
		}
	}
 
});
	

		
		var userId = new Ext.form.Hidden({
			id:'userId',
			name:'userId'
			//value:'1'
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
			

			var win = new Ext.Window({
				title:'信息修改',
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
							url : 'userController/modifyUser.action',
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
								Ext.Msg.alert('修改成功', action.result.msg);
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
		
	</script>

</body>
</html>