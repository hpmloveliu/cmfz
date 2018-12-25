<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>

<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<div id="statistics_bar" style="width: 600px;height: 400px;margin-top: 30px;margin-left: 30px">

</div>

<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart2 = echarts.init(document.getElementById('statistics_bar'));

    var option = {
        title: {
            text: '持名法州APP活跃用户',
            left: 'center'
        },
        tooltip: {
            trigger: 'item'
        },
        // 说明
        legend: {
            orient: 'vertical',
            left: 'left',
            data: ['统计分析']
        },
        xAxis: {
            type: 'category',
            data: ['一周', '两周', '三周']
        },
        yAxis: {
            type: 'value'
        },
        series: [{
            name: "统计分析",
            data: [],
            type: 'bar'
        }]
    };

    myChart2.setOption(option);

    $(function () {
        $.post("${pageContext.request.contextPath}/user/queryByDate", function (data) {
            console.log(data);
            myChart2.setOption({
                series: [{
                    // 根据名字对应到相应的系列
                    name: '统计分析',
                    data: data.data
                }]
            });
        }, "json")
    });


</script>












