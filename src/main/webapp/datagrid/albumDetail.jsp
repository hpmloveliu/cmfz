<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<script type="text/javascript">
    $(function () {
        //初始化表单,远程加载数据
        $("#albumDetailInfo").form("load", "${pageContext.request.contextPath}/album/queryAlbumById?parentId=" + parentId);
        $("#albumDetailInfo").form({
            onLoadSuccess: function (data) {
                //获取图片的路径
                var cimg = "${pageContext.request.contextPath}" + data.coverImg;
                $("#imgCoverPath").prop("src", cimg); //问img标签的src属性赋值
            }
        });
    });

</script>

<form id="albumDetailInfo" method="post">
    <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td valign="middle" align="right" hidden="true">
                id:
            </td>
            <td valign="middle" align="left">
                <input class="td" value="" name="tid" hidden="true"/>
            </td>
        </tr>
        <tr>
            <td valign="middle" align="right">
                标题:
            </td>
            <td valign="middle" align="left">
                <input class="aTitle" name="title"/>
            </td>
        </tr>
        <tr>
            <td valign="middle" align="right">
                作者:
            </td>
            <td valign="middle" align="left">
                <input class="aAuthor" name="author"/>
            </td>
        </tr>
        <tr>
            <td valign="middle" align="right">
                播音员:
            </td>
            <td valign="middle" align="left">
                <input class="aBroadcast" name="broadcast"/>
            </td>
        </tr>
        <tr>
            <td valign="middle" align="right">
                章节数量:
            </td>
            <td valign="middle" align="left">
                <input class="aCount" name="count"/>
            </td>
        </tr>
        <tr>
            <td valign="middle" align="right">
                评分:
            </td>
            <td valign="middle" align="left">
                <input class="aScore" name="score"/>
            </td>
        </tr>
        <tr>
            <td valign="middle" align="right">
                上传日期:
            </td>
            <td valign="middle" align="left">
                <input class="aPubDate" name="pub_date"/>
            </td>
        </tr>
        <tr>
            <td valign="middle" align="right">
                简介:
            </td>
            <td valign="middle" align="left">
                <input class="aBrief" name="brief"/>
            </td>
        </tr>
        <tr>
            <td valign="middle" align="right">
                封面:
            </td>
            <td valign="middle" align="left">
                <img id="imgCoverPath" src="" width="200" height="150"/>
            </td>
        </tr>
    </table>
</form>

