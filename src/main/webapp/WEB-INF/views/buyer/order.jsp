<!--
    器材出入库明细页面
-->

<%
    //String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+
            request.getServerPort()+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="utf-8">
<title>layui</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="<%=basePath%>/layui/css/layui.css">
<link rel="stylesheet" href="<%=basePath%>/js/jquery/pager/pager.css" />
<style>
    .layui-form-label{
        width: auto;
    }
</style>
</head>
<body>
<div style="height: 30px"></div>
<div class="layui-form-item">

    <div class="layui-inline">
        <label class="layui-form-label">日期</label>
        <div class="layui-input-inline">
            <input type="text" class="layui-input" id="startDate" placeholder="yyyy-MM-dd">
        </div>
        <label class="layui-form-label">至</label>
        <div class="layui-input-inline">
            <input type="text" class="layui-input" id="endDate" placeholder="yyyy-MM-dd">
        </div>
    </div>
    <div class="layui-inline">
        <input type="text"  id="bName" placeholder="顾客昵称" autocomplete="off" class="layui-input">
    </div>
    <div class="layui-inline">
        <input type="text"  id="bAccount" placeholder="顾客账号" autocomplete="off" class="layui-input">
    </div>
    <div class="layui-inline">
        <input type="text" id="sName" placeholder="物品名称" autocomplete="off" class="layui-input">
    </div>
    <div class="layui-inline">
        <button class="layui-btn" onclick="getTableDate(1)" id="searchBtn">
            <i class="layui-icon">&#xe615;</i></button>
    </div>
</div>
<table id="accessStock" class="layui-table" lay-filter="test" >
    <thead>
    <th>单号</th>
    <th>顾客账号</th>
    <th>顾客昵称</th>
    <th>顾客手机号</th>
    <th>耗材名称</th>
    <th>数量</th>
    <th>状态</th>
    <th>金额</th>
    <th>日期</th>
    <th>操作</th>
    </thead>
    <tbody id="dataBody"></tbody>
</table>
<div id="pager"></div>
<script src="<%=basePath%>/layui/layui.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/jquery/pager/jquery.pager.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/jquery/layer/layer.js"></script>
<script>

    $(function () {
        getTableDate(1);
    });
    //获取表格数据
    function getTableDate(pageNo) {
          if (!pageNo){
              pageNo=1;
          }
        var pageSize = 10;
          $.post("/order/findAllOrder",{
              startDate: $('#startDate').val(),
              endDate: $('#endDate').val(),
              bName: $('#bName').val(),
              bAccount: $('#bAccount').val(),
              sName: $('#sName').val(),
              pageNo : pageNo,
              pageSize : pageSize
          },function (result) {
             $('#dataBody').empty();
             var res = JSON.parse(result);
             console.log(res);
             if (res.code== 1){
                 layer.msg(res.msg);
                 createRow(res.data);
             }else {
                 layer.msg(res.msg);
             }
              $("#pager").pager({
                  currentPageNo: pageNo,
                  totalRecordCount: res.count,
                  pageSize: pageSize,
                  showPageNoCount: 5,
                  isShowRecordCount: true,
                  isShowGoto: true,
                  pageFunction: getTableDate
              });
          });
    }
    //获取数据生成表格
    function createRow(data) {
        $.each(data,function (k,v) {
            var row = $('<tr></tr>');
            row.append('<td>'+v.id+'</td>');
            row.append('<td>'+v.buyerAccount+'</td>');
            row.append('<td>'+v.buyerName+'</td>');
            row.append('<td>'+v.buyerPhone+'</td>');
            row.append('<td>'+v.sName+'</td>');
            row.append('<td>'+v.sCount+'</td>');
            var status = v.status;
            if (1 == status) {
                status = '已付款';
                row.append('<td><div class="layui-bg-green" style="width: fit-content"> '+status+'</div></td>');
            } else {
                status = '未付款';
                row.append('<td><div class="layui-bg-red" style="width: fit-content">'+status+'</div></td>');
            }

            row.append('<td>'+v.price+'</td>');
            row.append('<td>'+v.createTime+'</td>');
            row.append('<td><a class="layui-btn layui-btn-danger layui-btn-xs" onclick="del(' +v.id+ ')">删除</a></td>');
            $('#accessStock').append(row);
        })
    }
    //通过id删除订单
    function del(id){
        layer.confirm('是否确认删除这条记录？',
            {
                title:"确认删除",
                btn:['确定','取消']
            },
            function (index) {
              layer.close(index);
              $.post("/order/deleteOrder",
                  {
                      id:id
                  },
                  function (result) {
                      var res = JSON.parse(result);
                      layer.msg(res.msg);
                      getTableDate(this.pageNo);
              });
        });
    }

    layui.use(['form','laydate'], function(){
        var form = layui.form
            ,laydate = layui.laydate;
        //常规用法
        laydate.render({
            elem: '#startDate'
        });
        laydate.render({
            elem: '#endDate'
        });
        // form.render();
        //……

        //但是，如果你的HTML是动态生成的，自动渲染就会失效
        //因此你需要在相应的地方，执行下述方法来手动渲染，跟这类似的还有 element.init();
        //form.render();
    });
</script>
</body>
</html>
