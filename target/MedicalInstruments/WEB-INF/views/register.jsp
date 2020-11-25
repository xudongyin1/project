<%
    //String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+
            request.getServerPort()+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8">
<title>管理员用户注册</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="<%=basePath%>/layui/css/layui.css">
<link rel="stylesheet" href="<%=basePath%>/js/jquery/pager/pager.css" />
</head>
<body>
<div style="height: 30px"></div>
<form  method="post" class="layui-form"  action="/user/register">
    <div class="layui-col-md6 layui-col-xs12">
        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-block">
                <input type="text"   class="layui-input" name="username">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">登陆账号</label>
            <div class="layui-input-block">
                <input type="text"   class="layui-input" name="account">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">密码框</label>
            <div class="layui-input-inline">
                <input type="password" name="password" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">随您喜欢</div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">手机号码</label>
            <div class="layui-input-block">
                <input type="tel" value="" placeholder="请输入手机号码" lay-verify="phone" class="layui-input userPhone" name="phone">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">邮箱</label>
            <div class="layui-input-block">
                <input type="text" value="" placeholder="请输入邮箱" lay-verify="email" class="layui-input userEmail" name="email">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="register" type="submit">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </div>
</form>
<script src="<%=basePath%>/layui/layui.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/jquery/pager/jquery.pager.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/jquery/layer/layer.js"></script>
<script>
    layui.use('form', function(){
        var form = layui.form;

        //监听提交
        form.on('submit(register)', function(data){
            console.log(data)
            layer.msg(data,2000);
            return false;

        });
    });
</script>
</body>
</html>
