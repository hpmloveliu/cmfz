<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<script type="text/javascript">
    $(function () {
        // 初始化按钮--提交
        $("#addChapterBtn").linkbutton({
            onClick: function () {
                //单击按钮，执行form表单的 提交 方式
                //$.messager.progress();	// 显示进度条
                $("#addChapterForm").form("submit", {
                    url: "${pageContext.request.contextPath}/album/insertChapter",
                    onSubmit: function () {
                        return true;
                    },
                    onSubmit: function () {
                        var h = $("#addChapterForm").form("validate");
                        if (!h) {
                            $.messager.progress('close');	// 如果验证不成功则隐藏进度条
                        }
                        return $("#addChapterForm").form("validate");
                    },
                    success: function () {
                        $.messager.progress('close');	// 如果提交成功则隐藏进度条
                        $.messager.show({
                            title: "系统提醒",
                            msg: "添加成功"
                        });
                        //刷新数据表格中的数据
                        $("#albumTreegrid").treegrid("reload");
                        //关闭对话框
                        $("#addChapterDialog").dialog("close");
                    }
                });
            }
        });

        // 初始化按钮--重置按钮
        $("#resetChapterBtn").linkbutton({
            onClick: function () {
                $("#addChapterForm").form("reset");
            }
        });

        //初始化，表单控件--title
        $("#chapterTitle").textbox({
            required: true,
            prompt: "请输入章节名称..."
        });
        //大小
        $("#chapterSize").textbox({
            required: true,
            prompt: "请输入章节大小..."
        });
        //时长
        $("#chapterDuration").textbox({
            required: true,
            prompt: "请输入章节时长..."
        });
        //资源路径
        $("#chapterURL").filebox({
            buttonText: "选择资源",
            required: true,
            accept: "audio/mpeg",//限制上传的文件只能是.mp3格式
            prompt: "请选择mp3格式音频..."
        });
        //播音员
        $("#chapterAlbumId").combobox({
            url: '${pageContext.request.contextPath}/album/queryAlbum',
            valueField: 'id',
            textField: 'title',
            required: true,
            editable: false,
            onLoadSuccess: function (data) {
                //设置默认选中
                $("#chapterAlbumId").combobox("setValue", 1);
            },
            onSelect: function (item) {
                console.log(item);
            }
        });


    });

</script>
<h3>请输入以下内容：</h3>
<form method="post" id="addChapterForm" enctype="multipart/form-data">
    <table>
        <tr>
            <td valign="middle" align="right">
                标题:
            </td>
            <td valign="middle" align="left">
                <input id="chapterTitle" name="title"/>
            </td>
        </tr>
        <tr>
            <td valign="middle" align="right"><!-- 音频mp3格式 -->
                资源:
            </td>
            <td valign="middle" align="left">
                <input id="chapterURL" name="mp3File"/>
            </td>
        </tr>
        <tr>
            <td valign="middle" align="right">
                所属专辑:
            </td>
            <td valign="middle" align="left">
                <input id="chapterAlbumId" name="album_id"/>
            </td>
        </tr>

    </table>
</form>

<!-- 提交按钮 -->
<a id="addChapterBtn">提交</a>
<a id="resetChapterBtn">重置</a>