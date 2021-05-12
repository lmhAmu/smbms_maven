<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="/jsp/common/head.jsp"%>

<div class="right">
    <div class="location">
        <strong>你现在所在的位置是:</strong>
        <span>订单管理页面 >> 订单添加页面</span>
    </div>
    <div class="providerAdd">
        <form id="billForm" name="billForm" method="post" action="">
            <!--div的class 为error是验证错误，ok是验证成功-->
            <input type="hidden" name="method" value="add">
            <div class="">
                <label for="billCode">订单编码：</label>
                <input type="text" name="billCode" class="text" id="billCode" value="">
                <!-- 放置提示信息 -->
                <font color="red"></font>
            </div>
            <div>
                <label for="productName">商品名称：</label>
                <input type="text" name="productName" id="productName" value="">
                <font color="red"></font>
            </div>
            <div>
                <label for="productUnit">商品单位：</label>
                <input type="text" name="productUnit" id="productUnit" value="">
                <font color="red"></font>
            </div>
            <div>
                <label for="productCount">商品数量：</label>
                <input type="text" name="productCount" id="productCount" value="">
                <font color="red"></font>
            </div>
            <div>
                <label for="totalPrice">总金额：</label>
                <input type="text" name="totalPrice" id="totalPrice" value="">
                <font color="red"></font>
            </div>
            <div>
                <label >供应商：</label>
                <select name="providerId" id="providerId">
                </select>
                <font color="red"></font>
            </div>
            <div>
                <label >是否付款：</label>
                <input type="radio" name="isPayment" value="1" checked="checked">未付款
                <input type="radio" name="isPayment" value="2" >已付款
            </div>
            <div class="providerAddBtn">
                <input type="submit" name="add" id="add" value="保存">
                <input type="button" id="back" name="back" value="返回" >
            </div>
        </form>
    </div>
</div>
</section>
<%@include file="/jsp/common/foot.jsp" %>
<%--<script type="text/javascript" src="${pageContext.request.contextPath }/js/billadd.js"></script>--%>
<script type="text/javascript">
    $(document).ready(function (){
        $.ajax({
            url:"${pageContext.request.contextPath }/providerList.do",//请求的url
            type: "post",
            //data:"providerId="+providerId,//请求参数
            dataType:"json",//ajax接口（请求url）返回的数据类型
            success:function(data){//data：返回数据（json对象）

                if(data != null){
                    $("select").html("");//通过标签选择器，得到select标签，适用于页面里只有一个select
                    var options = "<option value=\"0\">请选择</option>";
                    for(var i = 0; i < data.length; i++){
                        // alert(data[i].id);
                        // alert(data[i].proName);
                        options += "<option value=\""+data[i].id+"\">"+data[i].proName+"</option>";
                    }
                    $("select").html(options);
                }
            },
            error:function(){//当访问时候，404，500 等非200的错误状态码
                // validateTip(providerId.next(),{"color":"red"},imgNo+" 获取供应商列表error",false);
                $("#providerId").next().html("获取供应商列表error")
            }
        });

        $("#billCode").focus(function (){
            validateTip($("#billCode").next(),{"color":"#666666"},"* 请输入订单编码");
        }).blur(function (){
            var billCode=$("#billCode").val();
            if(billCode==""){
                validateTip($("#billCode").next(),{"color":"red"},imgNo+"<a>编码不能为空，请重新输入</a>");
            }else{
                validateTip($("#billCode").next(),{"color":"green"},imgYes+"<a></a>");
            }
        })
        $("#productName").focus(function (){
            validateTip($("#productName").next(),{"color":"#666666"},"* 请输入商品名称");
        }).blur(function (){
            var productName=$("#productName").val();
            if(productName==""){
                validateTip($("#productName").next(),{"color":"red"},imgNo+"<a>商品名称不能为空，请重新输入</a>");
            }else{
                validateTip($("#productName").next(),{"color":"green"},imgYes+"<a></a>");
            }
        })
        $("#productUnit").focus(function (){
            validateTip($("#productUnit").next(),{"color":"#666666"},"* 请输入商品单位");
        }).blur(function (){
            var productUnit=$("#productUnit").val();
            if(productUnit==""){
                validateTip($("#productUnit").next(),{"color":"red"},imgNo+"<a>单位不能为空，请重新输入</a>");
            }else{
                validateTip($("#productUnit").next(),{"color":"green"},imgYes+"<a></a>");
            }
        })
        $("#productCount").focus(function (){
            validateTip($("#productCount").next(),{"color":"#666666"},"* 请输入大于0的正自然数，小数点后保留2位");
        }).blur(function (){
            validateTip($("#productCount").next(),{"color":"green"},"<a></a>");
        })
        $("#totalPrice").focus(function (){
            validateTip($("#totalPrice").next(),{"color":"#666666"},"* 请输入大于0的正自然数，小数点后保留2位");
        }).blur(function (){
            validateTip($("#totalPrice").next(),{"color":"green"},"<a></a>");
        })
        $("#providerId").focus(function (){
            validateTip($("#providerId").next(),{"color":"#666666"},"* 请选择供应商");
        }).blur(function (){
            var providerId = $("#providerId").val();
            if(providerId != null && providerId != "" && providerId == 0) {
                validateTip($("#providerId").next(),{"color":"red"},imgNo+"<a>供应商不能为空，请选择</a>");
            }else {
                validateTip($("#providerId").next(),{"color":"green"},imgYes+"<a></a>");
            }
        })

        $("#billForm").submit(function (){
            $("#billCode").blur();
            $("#productName").blur();
            $("#productUnit").blur();
            $("#providerId").blur();
            var fal=true;
            $("font").each(function (index,item){
                if($(item).find("a").html()!=""){
                    fal=false;
                }
            })
            //alert(fal);
            if(fal==true){
                var serialize = $("#billForm").serialize();
                $.ajax({
                    "url":"${pageContext.servletContext.contextPath}/billadd.do",
                    "type":"post",
                    "data":serialize,
                    "dataType":"text",
                    "async":true,//线程同步
                    "success":function (result) {
                        if(result=true){
                            alert("添加成功");
                            location.href="${pageContext.servletContext.contextPath}/billList.do";
                        }
                    },
                    "error":function () {
                        alert("添加失败！");
                    }
                })
            }
            return fal;
        })
        $("#back").click(function (){
            location.href="${pageContext.servletContext.contextPath}/billList.do";
        })
    })
</script>