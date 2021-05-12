<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/head.jsp"%>
<div class="right">
            <div class="location">
                <strong>你现在所在的位置是:</strong>
                <span>密码修改页面</span>
            </div>
            <div class="providerAdd">
                <form id="userForm" name="userForm" method="post" action="a">
                    <input type="hidden" name="method" value="savepwd">
                    <!--div的class 为error是验证错误，ok是验证成功-->
<%--                    <div class="info">${message}</div>--%>
                    <div class="">
                        <label for="oldPassword">旧密码：</label>
                        <input type="password" name="oldpassword" id="oldpassword" value=""> 
						<font color="red"></font>
                    </div>
                    <div>
                        <label for="newPassword">新密码：</label>
                        <input type="password" name="newpassword" id="newpassword" value=""> 
						<font color="red"></font>
                    </div>
                    <div>
                        <label for="reNewPassword">确认新密码：</label>
                        <input type="password" name="rnewpassword" id="rnewpassword" value=""> 
						<font color="red"></font>
                    </div>
                    <div class="providerAddBtn">
                        <!--<a href="#">保存</a>-->
                        <input type="submit" name="save" id="save" value="保存" class="input-button">
                    </div>
                </form>
            </div>
        </div>
    </section>
<%@include file="/jsp/common/foot.jsp" %>
<%--<script type="text/javascript" src="${pageContext.request.contextPath }/js/pwdmodify.js"></script>--%>
<script type="text/javascript">
    $(document).ready(function (){
        $("#oldpassword").focus(function (){
            validateTip($("#oldpassword").next(),{"color":"#666666"},"* 请输入原密码");
        }).blur(function (){
            var oldpassword=$("#oldpassword").val();
            if(oldpassword==""){
                validateTip($("#oldpassword").next(),{"color":"red"},imgNo+"<a>请输入旧密码</a>");
            }else{
                var oldpassword=$("#oldpassword").val();
                $.ajax({
                    "url":"${pageContext.servletContext.contextPath}/usermodifyverify.do",
                    "type": "post",
                    "data": "oldpassword="+oldpassword,
                    "async":false,//线程同步
                    "dataType":"json",
                    "success":function (js) {
                        if(js.login=="false"){
                            alert("请登录!!");
                            location.href="login.jsp";
                        }else if (js.result !="true"){
                            validateTip($("#oldpassword").next(),{"color":"red"},imgNo+"<a>原密码输入不正确</a>");
                        }else{
                            validateTip($("#oldpassword").next(),{"color":"green"},imgYes+"<a></a>");
                        }
                    },
                    error:function (result) {
                        alert("服务器繁忙，请稍后重试！")
                    }
                })
            }
        })

        $("#newpassword").focus(function (){
            validateTip($("#newpassword").next(),{"color":"#666666"},"* 密码长度必须是大于6小于20");
        }).blur(function (){
            var newpassword=$("#newpassword").val();
            if(newpassword==""){
                validateTip($("#newpassword").next(),{"color":"red"},imgNo+"<a>密码输入不符合规范，请重新输入</a>");
            }else{
                validateTip($("#newpassword").next(),{"color":"green"},imgYes+"<a></a>");
            }
        })

        $("#rnewpassword").focus(function (){
            validateTip($("#rnewpassword").next(),{"color":"#666666"},"* 请输入与上面一致的密码");
        }).blur(function (){
            var rnewpassword=$("#rnewpassword").val();
            var newpassword=$("#newpassword").val();
            if(rnewpassword==newpassword&&rnewpassword!=""){
                validateTip($("#rnewpassword").next(),{"color":"green"},imgYes+"<a></a>");
            }else{
                validateTip($("#rnewpassword").next(),{"color":"red"},imgNo+"<a>两次密码输入不一致，请重新输入</a>");
            }
        })

        $("#userForm").submit(function (){
            $("#oldpassword").blur();
            $("#newpassword").blur();
            $("#rnewpassword").blur();
            var fal=true;
            $("font").each(function (index,item){
                console.log($(item).find("a").html())
                if($(item).find("a").html()!=""){
                    fal=false;
                }
            })
            if(fal==true){
                var newpassword=$("#newpassword").val();
                $.ajax({
                    "url":"${pageContext.servletContext.contextPath}/userupdate.do",
                    "type":"post",
                    "data":"newpassword="+newpassword,
                    "dataType":"text",
                    "async":true,//线程同步
                    "success":function (result) {
                        if(result=true){
                            alert("修改成功");
                            location.href="${pageContext.servletContext.contextPath}/userlist.do";
                        }
                    },
                    "error":function () {
                        alert("修改失败！");
                    }
                })
            }
            return fal;
        })
    })
</script>