<%@page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<script type="text/javascript">
    $(function () {
        //页面加载完成后，
        // 初始化按钮--添加按钮
        $("#addBtn").linkbutton({
            onClick: function () {
                //单击按钮，执行form表单的 提交 方式
                $.messager.progress();	// 显示进度条
                $("#addform").form("submit", {
                    url: "${pageContext.request.contextPath}/banner/insertBanner",
                    onSubmit: function () {
                        var h = $("#addform").form("validate");
                        if (!h) {
                            $.messager.progress('close');	// 如果验证不成功则隐藏进度条
                        }
                        return $("#addform").form("validate");
                    },
                    success: function () {
                        $.messager.progress('close');	// 如果提交成功则隐藏进度条
                        $.messager.show({
                            title: "系统提醒",
                            msg: "添加成功"
                        });
                        //刷新数据表格中的数据
                        $("#dg").datagrid("reload");
                        //关闭对话框
                        $("#addBanner").dialog("close");
                    }
                });
            }
        });
        // 初始化按钮--重置按钮
        $("#resetBtn").linkbutton({
            onClick: function () {
                $("#addform").form("reset");
            }
        });

        //初始化，表单控件--title
        $("#tt1").textbox({
            required: true,
            validType: "isLength[8]"
        });
        //文件框
        $("#imgp").filebox({
            buttonText: "选择文件",
            required: true
        });
        //下拉列表
        $("#sta").combobox({
            data: [{text: "显示", value: 'y'}, {text: '否', value: 'n'}],
            valueField: 'value',
            textField: "text",
            panelHeight: 50,
            editable: false,
            onLoadSuccess: function (data) {
                //设置默认选中
                $("#sta").combobox("setValue", "n");
            },
            onSelect: function (item) {
                console.log(item);
            }
        });
        //文本框，描述信息
        $("#des").textbox({
            type: "text",
            multiline: true,//定义是否是多行文本框
            prompt: "请输入描述信息。。。。", //在输入框显示提示消息。
            width: 200,
            height: 50
        });
    });
</script>
这是添加对话框
<form method="post" id="addform" enctype="multipart/form-data">
    <table>
        <tr>
            <td valign="middle" align="right">
                标题:
            </td>
            <td valign="middle" align="left">
                <input id="tt1" name="title"/>
            </td>
        </tr>
        <tr>
            <td valign="middle" align="right">
                图片:
            </td>
            <td valign="middle" align="left">
                <input id="imgp" name="file1"/>
            </td>
        </tr>
        <tr>
            <td valign="middle" align="right">
                状态:
            </td>
            <td valign="middle" align="left"> <!-- 下拉列表 -->
                <input id="sta" name="status"/>
            </td>
        </tr>
        <tr>
            <td valign="middle" align="right">
                描述:
            </td>
            <td valign="middle" align="left">
                <input id="des" name="description"/>
            </td>
        </tr>
    </table>
</form>

<!-- 提交按钮 -->
<a id="addBtn">提交</a>
<a id="resetBtn">重置</a>




