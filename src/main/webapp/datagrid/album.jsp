<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<script type="text/javascript">
    var parentId; //全局变量
    $(function () {
        //初始化对话框--导入对话框
        $("#albumImportDialog").dialog({
            title: "数据导入对话框",
            closed: true,
            width: "300",
            height: "200",
            href: "${pageContext.request.contextPath}/datagrid/aImport.jsp"
        });

        //初始化对话框--专辑详细信息
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
                    var parentNode = $("#albumTreegrid").treegrid("getParent", row.id);
                    if (parentNode == null) { //如果为父节点，则parent为null
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
                //获取被选中的行
                var row = $("#albumTreegrid").treegrid("getSelected");

                if (row != null) {
                    //判断是否为父节点
                    var parentNode = $("#albumTreegrid").treegrid("getParent", row.id);
                    if (parentNode != null) {
                        var mp3Url = row.url;
                        //如果为子节点，则同步请求下载对应的音频文件,根据对应的章节Id查询
                        location.href = "${pageContext.request.contextPath}/album/downloadChapter?mp3Url=" + mp3Url;
                        //注意文件下载时不能用异步请求，因为异步请求不能使用文件流
                    } else {
                        $.messager.alert("提示", "请选则专辑中的一个章节");
                    }
                } else {
                    $.messager.alert("提示", "请先选中一个章节");
                }
            }

        }, '-', {
            text: "导入",
            iconCls: 'icon-tip',
            handler: function () {
                alert("导入窗口");
                //location.href="${pageContext.request.contextPath}/album/albumImport";
                $("#albumImportDialog").dialog("open");
            }
        }, '-', {
            text: "导出",
            iconCls: 'icon-print',
            handler: function () {
                location.href = "${pageContext.request.contextPath}/album/albumExport";
            }
        }]


        $('#albumTreegrid').treegrid({
            url: '${pageContext.request.contextPath}/album/queryAlbumByPage',
            idField: 'id',
            treeField: 'title',
            columns: [[
                {field: 'title', title: '专辑名称', width: 60},
                {field: 'url', title: '播放', align: 'right', formatter: myPlay},
                {field: 'size', title: '章节大小(MB)', width: 80},
                {field: 'duration', title: '章节时长(秒)', width: 80}
            ]],
            fit: true,
            fitColumns: true,
            toolbar: albumTb,
            onLoadSuccess: function () { //成功后的回调
                $('#albumTreegrid').treegrid("collapseAll");
            },
            onDblClickRow: function (row) {//双击事件,参数为被选中的当前行
                $("#playChapterDialog").dialog("open");
                $("#audio_url").prop("src", "${pageContext.request.contextPath}" + row.url);//为音频标签属性赋值
            },
            pagination: true,
            pageSize: 3,
            pageList: [3, 5, 10, 15]
        });



    });

    // 自定义操作列的内容
    /*
        参数1：当前列中 该行上的属性值
        参数2：该行对应的json对象
        参数3：行下标索引
    */
    function myPlay(value, row, index) {
        if (typeof row.id == "string") {
            var v = row.url;
            var a = "<audio controls><source src='${pageContext.request.contextPath}" + v + "' type='audio/mpeg'></audio>"
            return a;
        } else {
            return "";
        }
    }
</script>
<!-- 树形表格 -->
<table id="albumTreegrid" style="width:600px;height:400px"></table>

<!-- 专辑详情对话框 -->
<div id="detailDialog"></div>
<!-- 添加专辑对话框 -->
<div id="addAlbumDialog"></div>
<!-- 添加章节对话框 -->
<div id="addChapterDialog"></div>
<!-- 播放音频对话框 -->
<div id="playChapterDialog" class="easyui-dialog" title="paly Dialog"
     data-options="resizable:true,modal:true,closed:true">
    <!-- 音频标签 -->
    <audio id="audio_url" src="" controls="controls" autoplay="autoplay" loop="loop">
    </audio>
</div>
<!-- 导入对话框 -->
<div id="albumImportDialog">

</div>