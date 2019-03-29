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

Ext.onReady(panelLayout);  

function panelLayout() {  
                //新建tabpanel  
    var tab = Ext.create('Ext.TabPanel', {  
        region : 'center',  
        deferredRender : false,  
        activeTab : 0,  
        resizeTabs : true, // turn on tab resizing  
        minTabWidth : 115,  
        tabWidth : 135,  
        enableTabScroll : true  
    });  
    var viewPort = Ext.create('Ext.Viewport', {  
        layout : "border",  
        items : [ /*{  
            region : 'north',  
            minHeight : 100,  
            html : 'north'  
        },*/ {  
            title : 'XX管理系统',  
            region : 'west',  
            xtype : 'panel',  
            width : 200,  
            collapsible : false, // 设置可折叠  
            id : 'west-region-container',  
            layout : 'fit',  
            margins : '0 0 0 0',  
            layout : 'accordion',  
            //title : '菜单',  
            split : true,  
            collapsible : true,  
            layoutConfig : {  
                animate : true  
            },       
            items : [{  
                        title : '业务信息处理',  
                        xtype : 'treepanel',  
                        expanded : true,  
                        animate : true,  
                        enableDD : false,  
                        border : false,  
                        containerScroll : true,  
                        root : {  
                            text : '用户管理',  
                            id:'root',  
                            children : [{  
                                text : '用户信息',  
                                id : 'info.jsp',  
                                leaf : true  
                            }, {  
                                text : '用户XX',  
                                leaf : true,  
                                id :'dept_list.jsp'  
                            }]  
                        },  
            listeners:{  
    //添加节点点击事件
	itemclick: function(v,r,item){  
                    var n = tab.getComponent(r.raw.id);
                     if(r.raw.id=='root'){  
                        return;  
                     }  
                                        if (!n) { // 判断是否已经打开该面板  
                                            n = tab.add({  
                                                'id' : r.raw.id,  
                                                'title' : r.raw.text,  
                                                 closable : true, // 通过html载入目标页  
                                                 html : '<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="'+r.raw.id+'"></iframe>'  
                                            });  
                                        }  
                                    tab.setActiveTab(n);  
                             }   
            }  
                    }]  
        },tab, {  
            region : 'south',  
            minHeight : 25,  
            html:"<div align='center'>版权所有 xxxx有限公司 © 信息服务中心</div>"  
        } ]  
    })  
  
} 
		
      
</script>
    
</body>
</html>