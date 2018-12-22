<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<script type="text/javascript">
    $(function () {
        // 初始化按钮--提交
        $("#addAlbumBtn").linkbutton({
            onClick: function () {
                //单击按钮，执行form表单的 提交 方式
                //$.messager.progress();	// 显示进度条
                $("#addAlbumForm").form("submit", {
                    url: "${pageContext.request.contextPath}/album/insertAlbum",
                    onSubmit: function () {
                        return true;
                    },
                    onSubmit: function () {
                        var h = $("#addAlbumForm").form("validate");
                        if (!h) {
                            $.messager.progress('close');	// 如果验证不成功则隐藏进度条
                        }
                        return $("#addAlbumForm").form("validate");
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
                        $("#addAlbumDialog").dialog("close");
                    }
                });
            }
        });

        // 初始化按钮--重置按钮
        $("#resetAlbumBtn").linkbutton({
            onClick: function () {
                $("#addAlbumForm").form("reset");
            }
        });

        //初始化，表单控件--title
        $("#albumTitle").textbox({
            required: true,
            prompt: "请输入专辑名称..."
        });
        //章节
        $("#albumCount").textbox({
            required: true,
            prompt: "请输入章节数..."
        });
        //文件框--图片
        $("#albumCoverImg").filebox({
            buttonText: "选择封面",
            required: true,
            prompt: "请选择专辑封面..."
        });
        //作者
        $("#albumAuthor").textbox({
            required: true,
            prompt: "请输入作者..."
        });
        //播音员
        $("#albumBroadcast").textbox({
            required: true,
            prompt: "请输入播音员姓名..."
        });
        //简介
        $("#albumBrief").textbox({
            required: true,
            multiline: true,
            width: 180,
            height: 50,
            prompt: "请输入简介..."
        });
        //评分
        $("#albumScore").numberbox({
            required: true,
            prompt: "请输入评分..."
        });

    });

</script>
<h3>请输入以下内容：</h3>
<form method="post" id="addAlbumForm" enctype="multipart/form-data">
    <table>
        <tr>
            <td valign="middle" align="right">
                标题:
            </td>
            <td valign="middle" align="left">
                <input id="albumTitle" name="title"/>
            </td>
        </tr>
        <tr>
            <td valign="middle" align="right">
                章节数:
            </td>
            <td valign="middle" align="left">
                <input id="albumCount" name="count"/>
            </td>
        </tr>
        <tr>
            <td valign="middle" align="right">
                图片:
            </td>
            <td valign="middle" align="left"><!-- 文件类型 -->
                <input id="albumCoverImg" name="imgFile"/>
            </td>
        </tr>
        <tr>
            <td valign="middle" align="right">
                作者:
            </td>
            <td valign="middle" align="left">
                <input id="albumAuthor" name="author"/>
            </td>
        </tr>
        <tr>
            <td valign="middle" align="right">
                播音:
            </td>
            <td valign="middle" align="left">
                <input id="albumBroadcast" name="broadcast"/>
            </td>
        </tr>
        <tr>
            <td valign="middle" align="right">
                评分:
            </td>
            <td valign="middle" align="left">
                <input id="albumScore" name="score"/>
            </td>
        </tr>
        <tr>
            <td valign="middle" align="right">
                简介:
            </td>
            <td valign="middle" align="left">
                <input id="albumBrief" name="brief"/>
            </td>
        </tr>

    </table>
</form>

<!-- 提交按钮 -->
<a id="addAlbumBtn">提交</a>
<a id="resetAlbumBtn">重置</a>