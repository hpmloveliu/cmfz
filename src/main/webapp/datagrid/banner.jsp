<%@page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<script type="text/javascript">

    $(function () {
        //初始化对话框--添加
        $("#addBanner").dialog({
            title: "添加对话框",
            width: 400,
            height: 200,
            closed: true,
            cache: false,
            href: "${pageContext.request.contextPath}/datagrid/addBanner.jsp"
        });

        //使用数组的方式初始化数据表格的工具栏
        var tb = [{
            text: "添加",
            iconCls: 'icon-add',
            handler: function () {
                $("#addBanner").dialog("open");
            }
        }, '-', {
            text: "修改",
            iconCls: 'icon-edit',
            handler: function () {
                //获取被选中的行
                var row = $("#dg").edatagrid("getSelected");
                if (row != null) {
                    //或取选中行的下标
                    var index = $("#dg").edatagrid("getRowIndex", row);
                    $("#dg").edatagrid("editRow", index);
                } else {
                    $.messager.alert('警告', '请先选中行');
                }

            }
        }, '-', {
            text: "取消编辑",
            iconCls: 'icon-back',
            handler: function () {
                //获取被选中的行
                var row = $("#dg").edatagrid("getSelected");
                if (row != null) {
                    //或取选中行的下标
                    var index = $("#dg").edatagrid("getRowIndex", row);
                    $("#dg").edatagrid("cancelEdit", index);
                    $("#dg").edatagrid("unselectRow", index);
                } else {
                    $.messager.alert('警告', '请先选中行');
                }
            }
        }, '-', {
            text: "删除",
            iconCls: 'icon-remove',
            handler: function () {
                //获取被选中的行
                var row = $("#dg").edatagrid("getSelected");
                if (row != null) {
                    // console.log(row.id);
                    //或取要删除的行row的id
                    var id = row.id;
                    //发送异步请求，在数据库中删除响应数据
                    $.post("${pageContext.request.contextPath}/banner/delete?id=" + id,
                        function (data) {
                            console.log(data);
                            $.messager.show({
                                title: '系统提示',
                                msg: '删除成功',
                                showType: 'slide'
                            });
                            $("#dg").edatagrid("reload");
                        }
                    )
                } else {
                    $.messager.alert('警告', '请先选中行');
                }
            }
        }, '-', {
            text: "保存",
            iconCls: 'icon-save',
            handler: function () {
                //获取被选中的行
                var row = $("#dg").edatagrid("getSelected");
                if (row != null) {
                    $("#dg").edatagrid("saveRow");
                    $.messager.show({
                        title: '系统提示',
                        msg: '更新成功',
                        showType: 'slide'
                    });
                    $("#dg").edatagrid("reload");
                } else {
                    $.messager.alert("警告", "请选中一行并修改")
                }

            }
        }]


        //初始化数据表格
        $('#dg').edatagrid({
            url: '${pageContext.request.contextPath}/banner/queryByStatusBanner',
            updateUrl: "${pageContext.request.contextPath}/banner/updateStatusBanner",
            columns: [[
                {field: 'id', title: 'ID', width: 100},
                {field: 'title', title: '标题', width: 100},
                {field: 'img_path', title: '图片路径', width: 100},
                {
                    field: 'status', title: '状态', width: 100, align: 'right', editor: {
                        type: "text",
                        options: {required: true}
                    }
                },
                {field: 'pub_date', title: '上传时间', width: 100, align: 'right'},
                {field: 'description', title: '描述', width: 100, align: 'right'}
            ]],
            fitColumns: true,
            fit: true,
            pagination: true,
            pageSize: 5,
            pageList: [3, 5, 7, 9, 11],
            toolbar: tb,
            view: detailview,
            detailFormatter: function (rowIndex, rowData) {
                return '<table><tr>' +
                    '<td rowspan=2 style="border:0"><img src="${pageContext.request.contextPath}' + rowData.img_path + '" style="height:50px;"></td>' +
                    '<td style="border:0">' +
                    '<p>描述: ' + rowData.description + '</p>' +
                    '<p>日期: ' + rowData.pub_date + '</p>' +
                    '</td>' +
                    '</tr></table>';
            },

        });


    });

</script>

<!-- 数据表格 -->
<table id="dg"></table>

<!-- 添加对话框 -->
<div id="addBanner"></div>
