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
</head>
<body>
<div style="height: 30px"></div>
<div class="layui-form-item">
    <div class="layui-inline">
        <input type="text" name="id" id="id" placeholder="ID" autocomplete="off" class="layui-input">
    </div>
    <div class="layui-inline">
        <input type="text" name="hcNo" id="hcNo" placeholder="耗材编号" autocomplete="off" class="layui-input">
    </div>
    <div class="layui-inline">
        <input type="text" name="hcName" id="hcName" placeholder="耗材名称" autocomplete="off" class="layui-input">
    </div>
    <div class="layui-inline">
        <input type="text" name="manafacturer" id="manafacturer" placeholder="生产厂家" autocomplete="off" class="layui-input">
    </div>
    <div class="layui-inline">
        <button class="layui-btn" onclick="getTableDate(1)" id="searchBtn">
            <i class="layui-icon">&#xe615;</i></button>
        <button class="layui-btn" onclick="addBtn()"><i class="layui-icon"></i>添加</button>
    </div>
</div>
<table id="device" class="layui-table" lay-filter="test" >
    <thead>
    <th>ID</th>
    <th>耗材编号</th>
    <th>耗材名称</th>
    <th>生产厂家</th>
    <th>规格型号</th>
    <th>单位</th>
    <th>入库价格</th>
    <th>操作</th>
    </thead>
    <tbody id="dataBody"></tbody>
</table>
<div id="pager"></div>
<form id="infoForm" style="display: none;">
    <div style="height: 30px"></div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">耗材编号</label>
            <div class="layui-input-inline">
                <input type="text" id="hcNoF" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">耗材名称</label>
            <div class="layui-input-inline">
                <input type="text" id="hcNameF" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">生产厂家</label>
            <div class="layui-input-inline">
                <input type="text" id="manafacturerF" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">单位</label>
            <div class="layui-input-inline">
                <input type="text" id="unitF" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">规格型号</label>
            <div class="layui-input-inline">
                <input type="text" id="hcTypeF" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">入库价格</label>
            <div class="layui-input-inline">
                <input type="text" id="priceF" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

</form>
<script src="<%=basePath%>/layui/layui.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/jquery/pager/jquery.pager.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/jquery/layer/layer.js"></script>
<script>
    $(function () {
        getTableDate(1);
    });

    function getTableDate(pageNo) {
        if (!pageNo)
            pageNo = 1;
        var pageSize = 10;
        $.post("/supplies/selectSupplies",{
            id: $('#id').val(),
            hcNo: $('#hcNo').val(),
            hcName: $('#hcName').val(),
            manafacturer: $('#manafacturer').val(),
            pageNo : pageNo,
            pageSize : pageSize
        },function(result){
            $("#dataBody").empty();
            var res = JSON.parse(result);
            if (res.code == 1) {
                layer.msg(res.msg);
                createRow(res.data);
            } else {
                layer.msg(res.msg);
            }
            $("#pager").pager({
                currentPageNo : pageNo,
                totalRecordCount : res.count,
                pageSize : pageSize,
                showPageNoCount : 5,
                isShowRecordCount : true,
                isShowGoto : true,
                pageFunction : getTableDate
            });
        });
    }

    function createRow(data) {
        $.each(data,function (k,v) {
            var row = $('<tr></tr>');
            row.append('<td>'+ v.id +'</td>');
            row.append('<td>'+ v.hcNo +'</td>');
            row.append('<td>'+ v.hcName +'</td>');
            row.append('<td>'+ v.manafacturer +'</td>');
            row.append('<td>'+ v.hcType +'</td>');
            row.append('<td>'+ v.unit +'</td>');
            row.append('<td>'+ v.price +'</td>');
            row.append('<td><a class="layui-btn layui-btn-xs" onclick="edit('+v.id+')">编辑</a>' +
                '<a class="layui-btn layui-btn-danger layui-btn-xs" onclick="del('+v.id+')" >删除</a></td>');
            $("#device").append(row);
        });
    }
    function addBtn() {
        var index = layer.open({
            title: "添加耗材",
            type: 1, //page层
            area: ['340px', '400px'],
            shade: 0.6, //遮罩透明度
            closeBtn: 1,
            shift: 0, //0-6的动画形式，-1不开启
            content: $('#infoForm'),
            btn: ['确定', '取消'],
            yes: function () {
                $.post("/supplies/add",{
                    hcNo : $('#hcNoF').val(),
                    hcName : $('#hcNameF').val(),
                    manafacturer : $('#manafacturerF').val(),
                    unit : $('#unitF').val(),
                    hcType : $('#hcTypeF').val(),
                    price : $('#priceF').val()
                },function (result) {
                    var res = JSON.parse(result);
                    layer.msg(res.msg);
                    layer.close(index);
                });
            }
        });
    }
    function edit(id) {
        //通过id查询数据
        $.post("/supplies/getSupplies",{
            id : id
        },function (result) {
            var res = JSON.parse(result);
            console.log(res);
            if (res.code == 1) {
                var data = res.data;
                $('#hcNoF').val(data.hcNo),
                $('#hcNameF').val(data.hcName),
                $('#manafacturerF').val(data.manafacturer),
                $('#unitF').val(data.unit),
                $('#hcTypeF').val(data.hcType),
                $('#priceF').val(data.price)
            }
        });
        var index = layer.open({
            title: "编辑耗材信息",
            type: 1, //page层
            area: ['340px', '400px'],
            shade: 0.6, //遮罩透明度
            closeBtn: 1,
            shift: 0, //0-6的动画形式，-1不开启
            content: $('#infoForm'),
            btn: ['确定', '取消'],
            yes: function () {
                $.post("/supplies/edit",{
                    id : id,
                    hcNo : $('#hcNoF').val(),
                    hcName : $('#hcNameF').val(),
                    manafacturer : $('#manafacturerF').val(),
                    unit : $('#unitF').val(),
                    hcType : $('#hcTypeF').val(),
                    price : $('#priceF').val()
                },function (result) {
                    var res = JSON.parse(result);
                    layer.msg(res.msg);
                    layer.close(index);
                });
            },
            end: function () {
                setTimeout(function () {
                    getTableDate(1);
                },2000);
            }
        });
    }
    function del(id) {
        //通过id删除数据
        layer.confirm('是否确认删除此条记录？', {
            title : '确认删除',
            btn : [ '确定', '取消' ]
            //按钮
        }, function(index) {
            layer.close(index);
            $.post("/supplies/del",{
                id : id
            },function (result) {
                var res = JSON.parse(result);
                layer.msg(res.msg);
                getTableDate(1);
            });
        });
    }
    layui.use('form', function(){
        var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功

        //……

        //但是，如果你的HTML是动态生成的，自动渲染就会失效
        //因此你需要在相应的地方，执行下述方法来手动渲染，跟这类似的还有 element.init();
        //form.render();
    });
</script>
</body>
</html>