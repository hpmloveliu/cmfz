<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<script type="text/javascript">
    $(function () {
        $("#importBtn").linkbutton({
            text: "导入",
            onClick: function () {
                $("#importForm").form("submit", {
                    url: "${pageContext.request.contextPath}/album/albumImport",

                });
            }
        });
    });

</script>
<div>
    <form id="importForm" method="post" enctype="multipart/form-data">
        <input id="albumImport" class="easyui-filebox" name="importFile"/>
    </form>
</div>
<!-- 导入按钮 -->
<a id="importBtn"></a>