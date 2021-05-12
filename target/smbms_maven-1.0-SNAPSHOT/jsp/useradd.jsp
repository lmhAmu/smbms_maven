<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/head.jsp"%>

<div class="right">
        <div class="location">
            <strong>你现在所在的位置是:</strong>
            <span>用户管理页面 >> 用户添加页面</span>

        </div>
        <div class="providerAdd">
            <form id="userForm" name="userForm" method="post" action="" enctype="multipart/form-data">
				<input type="hidden" name="method" value="add">
                <!--div的class 为error是验证错误，ok是验证成功-->
                <div>
                    <label for="userCode">用户编码：</label>
                    <input type="text" name="userCode" id="userCode" value=""> 
					<!-- 放置提示信息 -->
					<font color="red"></font>
                </div>
                <div>
                    <label for="userName">用户名称：</label>
                    <input type="text" name="userName" id="userName" value=""> 
					<font color="red"></font>
                </div>
                <div>
                    <label for="userPassword">用户密码：</label>
                    <input type="password" name="userPassword" id="userPassword" value=""> 
					<font color="red"></font>
                </div>
                <div>
                    <label for="ruserPassword">确认密码：</label>
                    <input type="password" name="ruserPassword" id="ruserPassword" value=""> 
					<font color="red"></font>
                </div>
                <div>
                    <label >用户性别：</label>
					<select name="gender" id="gender">
					    <option value="1" selected="selected">男</option>
					    <option value="2">女</option>
					 </select>
                </div>
                <div>
                    <label for="birthday">出生日期：</label>
                    <input type="text" Class="Wdate" id="birthday" name="birthday"
					readonly="readonly" onclick="WdatePicker();">
					<font color="red"></font>
                </div>
                <div>
                    <label for="phone">用户电话：</label>
                    <input type="text" name="phone" id="phone" value="">
					<font color="red"></font>
                </div>
                <div>
                    <label for="address">用户地址：</label>
                   <input name="address" id="address"  value="">
                </div>
                <div>
                    <label >用户角色：</label>
                    <!-- 列出所有的角色分类 -->
					<select name="userRole" id="userRole"></select>
	        		<font color="red"></font>
                </div>
                <div>
                    <label >上传图片：</label>
                    <!-- 列出所有的角色分类 -->
                    <input id="idPicPath_1" name="idPicPath_1" type="file" class="opt_input" />
                    <img id="uploadImg" >
                </div>
                <div class="providerAddBtn">
                    <input type="submit" name="add" id="add" value="保存" >
					<input type="button" id="back" name="back" value="返回" >
                </div>
            </form>
        </div>
</div>
</section>
<%@include file="/jsp/common/foot.jsp" %>
<%--<script type="text/javascript" src="${pageContext.request.contextPath }/js/useradd.js"></script>--%>
<script type="text/javascript">
    $(document).ready(function (){
        $.ajax({
            url:"${pageContext.request.contextPath }/roleList.do",//请求的url
            type: "post",
            //data:"providerId="+providerId,//请求参数
            dataType:"json",//ajax接口（请求url）返回的数据类型
            success:function(data){//data：返回数据（json对象）
                if(data != null){
                    var userRole=$("#userRole").html("");//通过标签选择器，得到select标签，适用于页面里只有一个select
                    userRole.append("<option value=\"0\">请选择</option>")
                    for(var i = 0; i < data.length; i++){
                        // alert(data[i].id);
                        // alert(data[i].proName);
                        userRole.append("<option value=\""+data[i].id+"\">"+data[i].roleName+"</option>")
                    }
                }
            },
            error:function(){//当访问时候，404，500 等非200的错误状态码
                $("#providerId").next().html("获取用户角色列表error")
            }
        });

        $("#userCode").focus(function (){
            validateTip($("#userCode").next(),{"color":"#666666"},"* 用户编码是您登录系统的账号");
        }).blur(function (){
            var userCode=$("#userCode").val();
            if(userCode==""){
                validateTip($("#userCode").next(),{"color":"red"},imgNo+"<a>用户编码不能为空，请重新输入</a>");
            }else{
                var userCode=$("#userCode").val();
                $.ajax({
                    url:"${pageContext.request.contextPath }/useraddverify.do",//请求的url
                    type: "post",
                    data:"userCode="+userCode,//请求参数
                    dataType:"json",//ajax接口（请求url）返回的数据类型
                    success:function(data){//data：返回数据（json对象）
                        if(data ==false) {
                            validateTip($("#userCode").next(),{"color":"red"},imgNo+"<a>该用户账号已存在</a>");
                        }else {
                            validateTip($("#userCode").next(),{"color":"green"},imgYes+"<a></a>");
                        }
                    }
                })
            }
        })

        $("#userName").focus(function (){
            validateTip($("#userName").next(),{"color":"#666666"},"* 用户名长度必须是大于1小于10的字符");
        }).blur(function (){
            var userName=$("#userName").val();
            if(userName!= null && userName.length > 1
                && userName.length < 10){
                validateTip($("#userName").next(),{"color":"green"},imgYes+"<a></a>");
            }else{
                validateTip($("#userName").next(),{"color":"red"},imgNo+"<a>用户名输入的不符合规范，请重新输入</a>");
            }
        })

        $("#userPassword").focus(function (){
            validateTip($("#userPassword").next(),{"color":"#666666"},"* 密码长度必须是大于6小于20");
        }).blur(function (){
            var userPassword=$("#userPassword").val();
            if(userPassword != null && userPassword.length > 6
                && userPassword.length < 20 ){
                validateTip($("#userPassword").next(),{"color":"green"},imgYes+"<a></a>");
            }else{
                validateTip($("#userPassword").next(),{"color":"red"},imgNo+"<a>密码输入不符合规范，请重新输入</a>");
            }
        })

        $("#ruserPassword").focus(function(){
            validateTip($("#ruserPassword").next(),{"color":"#666666"},"* 请输入与上面一只的密码");
        }).blur(function(){
            var userPassword=$("#userPassword").val();
            var ruserPassword=$("#ruserPassword").val();
            if(ruserPassword != null && ruserPassword.length > 6
                && ruserPassword.length < 20 && userPassword == ruserPassword){
                validateTip($("#ruserPassword").next(),{"color":"green"},imgYes+"<a></a>");
            }else{
                validateTip($("#ruserPassword").next(),{"color":"red"},imgNo + "<a>两次密码输入不一致，请重新输入</a>");
            }
        })

        $("#birthday").focus(function (){
            validateTip($("#birthday").next(),{"color":"#666666"},"* 点击输入框，选择日期");
        }).blur(function(){
            var birthday=$("#birthday").val();
            if(birthday==""){
                validateTip($("#birthday").next(),{"color":"red"},imgNo + "<a>选择的日期不正确,请重新输入</a>");
            }else {
                validateTip($("#birthday").next(),{"color":"green"},imgYes+"<a></a>");
            }
        })
        $("#phone").focus(function (){
            validateTip($("#phone").next(),{"color":"#666666"},"* 请输入手机号");
        }).blur(function (){
            var patrn=/^(13[0-9]|15[0-9]|18[0-9])\d{8}$/;
            var phone=$("#phone").val();
            if(phone.match(patrn)){
                validateTip($("#phone").next(),{"color":"green"},imgYes+"<a></a>");
            }else{
                validateTip($("#phone").next(),{"color":"red"},imgNo + "<a>您输入的手机号格式不正确</a>");
            }
        })
        $("#userRole").focus(function (){
            validateTip($("#userRole").next(),{"color":"#666666"},"* 请选择用户角色");
        }).blur(function (){
            var userRole=$("#userRole").val();
            if(userRole!= null && userRole> 0){
                validateTip($("#userRole").next(),{"color":"green"},imgYes+"<a></a>");
            }else{
                validateTip($("#userRole").next(),{"color":"red"},imgNo + "<a>请重新选择用户角色</a>");
            }
        })
        $("#userForm").submit(function (){
            $("#userCode").blur();
            $("#userName").blur();
            $("#userPassword").blur();
            $("#ruserPassword").blur();
            $("#birthday").blur();
            $("#phone").blur();
            $("#userRole").blur();
            var fal=true;
            $("font").each(function (index,item){
                if($(item).find("a").html()!=""){
                    fal=false;
                }
            })
            // alert(fal);
            if(fal==true){
                var formdata= new FormData($("#userForm")[0]);
                $.ajax({
                    "url":"${pageContext.servletContext.contextPath}/useradd.do",
                    "type":"post",
                    "data":formdata,
                    "dataType":"text",
                    "async":true,//线程同步
                    "processData": false, // 使数据不做处理
                    "contentType": false, // 不要设置Content-Type请求头
                    "success":function (result) {
                        console.log(result)
                        if(result=true){
                            alert("添加成功");
                            location.href="${pageContext.servletContext.contextPath}/userlist.do";
                        }
                    }
                })
            }
            return fal;
        })
        $("#back").click(function (){
            location.href="${pageContext.servletContext.contextPath}/userlist.do";
        })
        $("#idPicPath_1").change(function () {
            //获取file文件对象
            var file = $(this)[0].files[0];
            //等价于document.getElementById("pic").files[0];
            //获取一个指向该元素的地址
            var path = window.URL.createObjectURL(file);
            console.log(path);
            $("#uploadImg").attr('src', path);
        })
    })
</script>