<!--
    登录页面
-->
<%
    //String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+
                        request.getServerPort()+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>医疗器械管理系统</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0,
            minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="<%=basePath%>/static/css/font.css">
    <link rel="stylesheet" href="<%=basePath%>/static/css/weadmin.css">
    <script type="text/javascript" src="<%=basePath%>/js/jquery/jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>/js/jquery/pager/jquery.pager.js"></script>
    <link rel="stylesheet" href="<%=basePath%>/layui/css/layui.css">
    <script src="<%=basePath%>/layui/layui.js"></script>
</head>
<body class="login-bg">

<div class="login">
    <div class="message">医疗器械管理登录</div>
    <div id="darkbannerwrap"></div>
    <form method="post" class="layui-form" action="/user/login">
        <input name="username" placeholder="用户名"  type="text" lay-verify="required" class="layui-input" >
        <hr class="hr15">
        <input name="password" lay-verify="required" placeholder="密码"  type="password" class="layui-input">
        <hr class="hr15">
        <input class="loginin" value="登录" lay-submit lay-filter="login" style="width:100%;" type="submit">
        <hr class="hr20" >
        <input class="loginin" value="注册"  style="width:100%;" id="rebtn" type="button">
        <hr class="hr20" >
<%--        <button class="layui-btn" onclick="register()" style="width:100% ;height: 48px ;font-size: 24px;">注册</button>--%>
<%--        <hr class="hr20" >--%>
    </form>
</div>

<script type="text/javascript">

    layui.extend({
        admin: '<%=basePath%>/static/js/admin'
    });
    layui.use(['form','admin'], function(){
        var form = layui.form
            ,admin = layui.admin;
        //监听提交
        form.on('submit(login)', function(data){
            layer.msg(data,2000);
            return false;
        });
    });
    //进行页面跳转
    $("#rebtn").click(function () {
         console.log("hello");
         // $("window").attr('href','register.jsp');
        window.location.href = "/user/toRegister";
    })
</script>
<!-- 底部结束 -->
</body>
</html>
