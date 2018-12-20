<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>error</title>
</head>

<body>
<h1 style="color:red">异常页面 <br>
    <h3>异常信息：</h3>${sessionScope.errMsg}
    <br/>
    <a href="${pageContext.request.contextPath}/login.jsp">点击返回登录页面</a>
</body>
</html>
