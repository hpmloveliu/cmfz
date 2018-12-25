<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>持名法州主页</title>
    <link rel="stylesheet" type="text/css" href="../themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../themes/icon.css">
    <link rel="stylesheet" type="text/css" href="../themes/IconExtension.css">
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/datagrid-detailview.js"></script>
    <script type="text/javascript" src="../js/jquery.edatagrid.js"></script>
    <script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/echarts.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/china.js"></script>
    <script type="text/javascript">
        $(function () {
            <!-- tabs处理 -->
            $("tt").tabs({
                fit: true,

            });


            <!--菜单处理,手风琴中嵌套tree-->
            $.ajax({
                type: 'POST',
                async: false,
                dataType: "json",
                url: '${pageContext.request.contextPath}/category/queryParentCategory?parent_id=0',//获取菜单
                success: function (result) {
                    $.each(result, function (i, n) {//i为当前遍历元素的下标，n为result中取出来的一个元素
                        var vid = n.id;
                        // console.log(id)
                        //添加面板，父标签标题,手风琴
                        $('#aa').accordion('add', {
                            title: result[i].title,
                            content: '<div style="padding:10px 0px"><ul id="tree' + vid + '" class="easyui-tree"></ul></div>',
                            selected: false
                        });

                        //再次发送ajax请求，加载二级标签的数据
                        $.ajax({
                            type: 'POST',
                            async: false,
                            url: "${pageContext.request.contextPath}/category/queryParentCategory?parent_id=" + vid,
                            dataType: "json",
                            success: function (data) {
                                //根据返回结果，将返回值赋值给二级标签,二级菜单为tree
                                // console.log(data);
                                $("#tree" + vid).tree({
                                    data: data,
                                    formatter: function (value) {
                                        //自定义列内容
                                        /*
                                        参数1：当前列中 该行上的属性值
                                        */
                                        //console.log(value);
                                        return value.title;
                                    },
                                    onClick: function (node) {//为菜单项添加事件,有一个参数 node代表当前节点的json对象
                                        //在单击叶子节点时自动跳到对应的选项卡，并加载数据，
                                        //当点击某个菜单项时，调用此方法
                                        //1先判断是否为叶子节点  ，调用tree的isLeaf方法，是叶子节点返回true 有一个target参数是一个节点DOM对象
                                        //console.log("vid="+vid+"::"+node);
                                        var bn = $("#tree" + vid).tree("isLeaf", node.target);
                                        if (bn) {//如果时叶子节点，则调用方法
                                            // console.log(node);
                                            addTabs(node);
                                        }
                                    }
                                });
                            }

                        });
                    });
                }

            });

            //自定义方法,添加选项卡
            function addTabs(node) {
                var text = node.title;
                //3 调用tabs的exists方法判断页面是否存在,存在返回true
                if ($("#tt").tabs("exists", text)) {
                    //如果页面存在，则选中   调用tabs的select方法
                    $("#tt").tabs("select", text);
                } else {
                    //不存在，则打开一个新的页面
                    $("#tt").tabs('add', {
                        title: text,
                        selected: true,
                        closable: true,//显示选项卡面板将显示一个关闭按钮
                        href: "${pageContext.request.contextPath}" + node.url
                    });

                }

            }


        });


    </script>

</head>
<body class="easyui-layout">
<div data-options="region:'north',split:true" style="height:60px;background-color:  #5C160C">
    <div style="font-size: 24px;color: #FAF7F7;font-family: 楷体;font-weight: 900;width: 500px;float:left;padding-left: 20px;padding-top: 10px">
        持名法州后台管理系统
    </div>
    <div style="font-size: 16px;color: #FAF7F7;font-family: 楷体;width: 300px;float:right;padding-top:15px">欢迎您:xxxxx
        &nbsp;<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改密码</a>&nbsp;&nbsp;<a href="#"
                                                                                                              class="easyui-linkbutton"
                                                                                                              data-options="iconCls:'icon-01'">退出系统</a>
    </div>
</div>
<div data-options="region:'south',split:true" style="height: 40px;background: #5C160C">
    <div style="text-align: center;font-size:15px; color: #FAF7F7;font-family: 楷体">&copy;百知教育 htf@zparkhr.com.cn</div>
</div>

<div data-options="region:'west',title:'导航菜单',split:true" style="width:220px;">
    <div id="aa" class="easyui-accordion" data-options="fit:true">

    </div>


</div>
<div data-options="region:'center'">
    <div id="tt" class="easyui-tabs" data-options="fit:true,narrow:true,pill:true">
        <div title="主页" data-options="iconCls:'icon-neighbourhood',"
             style="background-image:url(image/shouye.jpg);background-repeat: no-repeat;background-size:100% 100%;"></div>
    </div>
</div>
</body>
</html>