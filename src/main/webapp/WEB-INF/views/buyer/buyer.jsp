<!--
材料厂商页面
-->

<%
    //String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" +
            request.getServerPort() + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8">
<title>layui</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="<%=basePath%>/layui/css/layui.css">
<link rel="stylesheet" href="<%=basePath%>/js/jquery/pager/pager.css"/>
</head>
<body>
<div style="height: 30px"></div>
<form class="layui-form" action="#">
    <div class="layui-form-item">
        <div class="layui-inline">
            <input type="text" name="name" id="name" placeholder="顾客昵称" autocomplete="off" class="layui-input">
        </div>
        <div class="layui-inline">
            <input type="text" name="account" id="account" placeholder="顾客账号" autocomplete="off" class="layui-input">
        </div>
        <%--<div class="layui-inline">
            <input type="text" name="vType" id="vType" placeholder="顾客状态" autocomplete="off" class="layui-input">
        </div>--%>

        <div class="layui-inline">
            <button class="layui-btn" onclick="getTableDate(1)" id="searchBtn">
                <i class="layui-icon">&#xe615;</i></button>
        </div>
    </div>
</form>
<table id="buyer" class="layui-table" lay-filter="test">
    <thead>
    <th>ID</th>
    <th>顾客昵称</th>
    <th>顾客账号</th>
    <th>手机</th>
    <th>邮箱</th>
    <th>状态</th>
    <th>创建时间</th>
    <%--    <th>修改时间</th>--%>
    <th>操作</th>
    </thead>
    <tbody id="dataBody"></tbody>
</table>
<div id="pager"></div>
<form id="infoForm" style="display: none;" class="layui-form" action="#">
    <div style="height: 30px"></div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">顾客昵称</label>
            <div class="layui-input-inline">
                <input type="text" id="Gname" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">顾客账号</label>
            <div class="layui-input-inline">
                <input type="text" id="Gaccount" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">手机</label>
            <div class="layui-input-inline">
                <input type="text" id="Gphone" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">邮箱</label>
            <div class="layui-input-inline">
                <input type="text" id="Gemail" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">状态</label>
            <div class="layui-input-inline">
                <select id="statusF" >
                    <option value="">请选择顾客状态</option>
                    <option value="1" >启用</option>
                    <option value="2">冻结</option>
                </select>
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
        var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功

        //解决html元素不能正常显示

        //但是，如果你的HTML是动态生成的，自动渲染就会失效
        //因此你需要在相应的地方，执行下述方法来进行渲染
        form.render();
    });

    $(function () {
        getTableDate(1);
    });
    //获取表格数据
    function getTableDate(pageNo) {
        if (!pageNo)
            pageNo = 1;   //页数
        var pageSize = 10; //每页数据量
        //请求接口获取数据
        $.post("/user/getAllBuyer", {
            name: $('#name').val(),
            account: $('#account').val(),
            pageNo: pageNo,
            pageSize: pageSize
        }, function (result) {
            $('#dataBody').empty();
            var res = JSON.parse(result);
            // console.log(res.count);
            if (res.code == 1) {
                layer.msg(res.msg);
                createRow(res.data);
            } else {
                layer.msg(res.msg);
            }
            $('#pager').pager({
                currentPageNo: pageNo,
                totalRecordCount: res.count,
                pageSize: pageSize,
                showPageNoCount: 5,
                isShowRecordCount: true,
                isShowGoto: true,
                pageFunction: getTableDate

            })
        })
    }
    //获取数据生成表格
    function createRow(data) {
        $.each(data, function (k, v) {
            var row = $('<tr></tr>');
            row.append('<td>' + v.id + '</td>');
            row.append('<td>' + v.userName + '</td>');
            row.append('<td>' + v.loginAccount + '</td>');
            row.append('<td>' + v.mobile + '</td>');
            row.append('<td>' + v.email + '</td>');
            var status = v.status;
            if ('1' == status) {
                status = '启用';
                row.append('<td><div class="layui-bg-green" style="width: fit-content" > ' + status + '</div></td>');
            } else if ('2' == status) {
                status = '冻结';
                row.append('<td><div class="layui-bg-red" style="width: fit-content" > ' + status + '</div></td>');
            }

            row.append('<td>' + v.createTime + '</td>');
            row.append('<td><a class="layui-btn layui-btn-xs" onclick="edit(' + v.id + ')">编辑</a>' +
                '<a class="layui-btn layui-btn-danger layui-btn-xs" onclick="del(' + v.id + ')">删除</a> </td>');
            $("#buyer").append(row);

        });
    }


    //通过id更新信息
    function edit(id) {
        //通过id查询数据
        $.post("/user/getBuyer", {
            id: id
        }, function (result) {
            const res = JSON.parse(result);
            console.log(res);

            $('#Gname').val(res.userName);
            $('#Gaccount').val(res.loginAccount);
            $('#Gphone').val(res.mobile);
            $('#Gemail').val(res.email);
            $('#statusF').val(res.status);
            // console.log($('#Gstatus').val());
            // console.log("hello")

        });
        var index = layer.open({
            title: "编辑顾客信息",
            type: 1, //page层
            area: ['340px', '400px'],
            shade: 0.6, //遮罩透明度
            closeBtn: 1,
            shift: 0, //0-6的动画形式，-1不开启
            content: $('#infoForm'),
            btn: ['确定', '取消'],
            yes: function () {
                $.post("/user/updateBuyer", {
                    id: id,
                    name: $('#Gname').val(),
                    account: $('#Gaccount').val(),
                    status: $('#statusF').val(),
                    email: $('#Gemail').val(),
                    phone: $('#Gphone').val()
                }, function (result) {
                    var res = JSON.parse(result);
                    layer.msg(res.msg);
                    layer.close(index);
                });
            },
            end: function () {
                //取消按钮事件
                // setTimeout(function () {
                //     getTableDate(this.pageNo);
                // }, 2000);
            }
        });
    }

    //通过id删除
    function del(id) {
        //通过id删除数据
        layer.confirm('是否确认删除此条记录？', {
            title: '确认删除',
            btn: ['确定', '取消']
            //按钮
        }, function (index) {
            layer.close(index);
            $.post("/user/DeleteBuyer", {
                id: id
            }, function (result) {
                var res = JSON.parse(result);
                layer.msg(res.msg);
                getTableDate(this.pageNo);
            });
        });
    }
</script>
</body>
</html>
