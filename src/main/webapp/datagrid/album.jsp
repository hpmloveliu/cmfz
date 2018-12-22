<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<script type="text/javascript">
    var parentId; //全局变量
    $(function () {
        //初始化对话框--添加章节
        $("#detailDialog").dialog({
            title: "添加对话框",
            width: 400,
            height: 270,
            closed: true,
            cache: false,
            href: "${pageContext.request.contextPath}/datagrid/albumDetail.jsp"
        });
        //初始化对话框--添加章节
        $("#addChapterDialog").dialog({
            title: "添加对话框",
            width: 400,
            height: 270,
            closed: true,
            cache: false,
            href: "${pageContext.request.contextPath}/datagrid/addChapter.jsp"
        });
        //初始化对话框--添加专辑
        $("#addAlbumDialog").dialog({
            title: "添加对话框",
            width: 400,
            height: 270,
            closed: true,
            cache: false,
            href: "${pageContext.request.contextPath}/datagrid/addAlbum.jsp"
        });

        //使用数组的方式初始化数据表格的工具栏
        var albumTb = [{
            text: "专辑详情",
            iconCls: 'icon-redo',
            handler: function () {
                //获取被选中的行
                var row = $("#albumTreegrid").treegrid("getSelected");
                parentId = row.id;  //获取父节点的id值
                if (row != null) {
                    //判断是否为父节点
                    var parent = $("#albumTreegrid").treegrid("getParent", row.id);
                    if (parent == null) { //如果为父节点，则parent为null
                        $("#detailDialog").dialog("open");
                    } else {
                        $.messager.alert("提示", "请选中一个专辑标题");
                    }
                } else {
                    $.messager.alert("提示", "请先选中一个专辑");
                }

            }
        }, '-', {
            text: "添加专辑",
            iconCls: 'icon-save',
            handler: function () {
                //调用添加专辑对话框
                $("#addAlbumDialog").dialog("open");
            }
        }, '-', {
            text: "添加章节",
            iconCls: 'icon-save',
            handler: function () {
                //调用添加章节对话框
                $("#addChapterDialog").dialog("open");
            }
        }, '-', {
            text: "下载音频",
            iconCls: 'icon-undo',
            handler: function () {
                alert('帮助按钮')
            }
        }]


        $('#albumTreegrid').treegrid({
            url: '${pageContext.request.contextPath}/album/queryAlbum',
            idField: 'id',
            treeField: 'title',
            columns: [[
                {field: 'title', title: '专辑名称', width: 180},
                {field: 'url', title: '下载路径', width: 60, align: 'right'},
                {field: 'size', title: '章节大小(MB)', width: 80},
                {field: 'duration', title: '章节时长(秒)', width: 80}
            ]],
            fit: true,
            fitColumns: true,
            toolbar: albumTb,
            state: closed
        });


    });

</script>
<!-- 树形表格 -->
<table id="albumTreegrid" style="width:600px;height:400px"></table>

<!-- 专辑详情对话框 -->
<div id="detailDialog"></div>
<!-- 添加专辑对话框 -->
<div id="addAlbumDialog"></div>
<!-- 添加章节对话框 -->
<div id="addChapterDialog"></div>
<!-- 下载音频对话框 -->
<div id="downloadDialog"></div>