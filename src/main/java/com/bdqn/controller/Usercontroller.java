package com.bdqn.controller;

import com.alibaba.fastjson.JSON;


import com.bdqn.entity.Page;
import com.bdqn.entity.Role;
import com.bdqn.entity.User;
import com.bdqn.service.RoleService;
import com.bdqn.service.UserService;
import com.bdqn.util.Constains;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Controller
public class Usercontroller {

    @Autowired
    UserService userService;
    @Autowired
    RoleService roleService;
    @RequestMapping("/userlogin.do")
    public String get(@RequestParam String userCode,@RequestParam String userPassword,
                      HttpSession session, Model model){
        User user = userService.get(userCode, userPassword);
        if(user !=null){
            session.setAttribute(Constains.USER_SESSION, user);
            return "redirect:head.do";
        }else {
            model.addAttribute("error","用户名或密码错误！");
            return "login";
        }
    }
    @RequestMapping("/head.do")
    public String user(){
        return "jsp/frame";
    }

    @RequestMapping("/userlist.do")
    public String indexs(String queryname,Integer queryUserRole,Model model){
        model.addAttribute("queryname",queryname);
        model.addAttribute("queryUserRole",queryUserRole);
        List<User> list = userService.getList(queryname, queryUserRole,null);
        model.addAttribute("userList",list);
        List<Role> list1 = roleService.getList();
        model.addAttribute("roleList",list1);
        return "jsp/userlist";
    }

    @RequestMapping("/usermodifyverify.do")
    @ResponseBody
    public String usermodifyverify(String oldpassword, HttpSession session
                                   , HttpServletRequest req, HttpServletResponse res) throws IOException {
        HashMap<String,String> resultMap=new HashMap<>();
        if(session.getAttribute(Constains.USER_SESSION)==null){
            //String contextPath = req.getContextPath();
            //res.sendRedirect(contextPath+"/index.jsp");
            resultMap.put("login","false");
            resultMap.put("result","false");
        }else {
            resultMap.put("login","true");
            User user = (User) session.getAttribute(Constains.USER_SESSION);
            String userPassword = user.getUserPassword();
            if(userPassword.equals(oldpassword)){
                resultMap.put("result","true");
            }else {
                resultMap.put("result","false");
            }
        }
        return JSON.toJSONString(resultMap);
    }

    @RequestMapping("/usermodify.do")
    public String usermodify(){
        return "jsp/usermodify";
    }
    @RequestMapping("/userupdate.do")
    @ResponseBody
    public String update(String newpassword,HttpSession session){
        User user1 = (User) session.getAttribute(Constains.USER_SESSION);
        Integer id = user1.getId();
        User user=new User();
        user.setId(id);
        user.setUserPassword(newpassword);
        int i = userService.update(user);
        if(i>0){
            return "true";
        }else {
            return "false";
        }
    }
    @RequestMapping("/userview.do")
    public String userview(String userid,Model model){
        List<User> list = userService.getList(null, null, Integer.valueOf(userid));
        model.addAttribute("list",list);
        return "jsp/userview";
    }

//    @RequestMapping("/useraddlogin.do")
//    public String add(HttpServletRequest req){
//        List<Role> list = roleService.getList();
//        req.setAttribute("list",list);
//        return "jsp/useradd";
//    }
    @RequestMapping("/useraddverify.do")
    @ResponseBody
    public String useraddverify(@RequestParam String userCode){
        User user = userService.get(userCode, null);
        if(user !=null){
            return "false";
        }else {
            return "true";
        }
    }

    @RequestMapping("/useradd.do")
    @ResponseBody
    public String useradd(User user, HttpSession session,
                          @RequestParam(value = "idPicPath_1",required = false) MultipartFile file,
                         HttpServletRequest request) throws IOException {
        //获取项目实际路径
        String realPath = request.getServletContext().getRealPath("images/");
        //保存图片
        file.transferTo(new File(realPath+File.separator+file.getOriginalFilename()));
        user.setIdPicPath("images/"+file.getOriginalFilename());
        user.setCreationDate(new Date());
        int i = userService.add(user);
        return i>0?"true":"false";
    }


    //分页
    @RequestMapping("/userPage.do")
    public String userPage(Integer pageNo1, Integer pageSize1,String queryname,Integer queryUserRole,Model model) throws SQLException {
        model.addAttribute("queryname",queryname);
        model.addAttribute("queryUserRole",queryUserRole);
        List<Role> list1 = roleService.getList();
        model.addAttribute("roleList",list1);
        int pageNo = 1;
        int pageSize = 5;
        if (pageNo1 != null) {
            pageNo = Integer.valueOf(pageNo1);
        }
        if (pageSize1 != null) {
            pageSize = Integer.valueOf(pageSize1);
        }
        Page page = userService.getPageList(pageNo, pageSize, queryname, queryUserRole);
        model.addAttribute("page",page);
        return "jsp/userlist";
    }
}
