package com.graduate.controller;

import javax.json.JsonObject;
import javax.servlet.http.HttpServletRequest;

import com.graduate.model.User;
import com.graduate.service.IUserService;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @author xiyouquedongxing
 * @date 2018-04-14
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Resource
    private IUserService userService;

    //登录
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();
        List<User> list = userService.login(username, password);
        if (list != null && list.size() > 0) {
            session.setAttribute("username", username);
            session.setAttribute("password", password);
            String userName = list.get(0).getUserName();
            request.setAttribute("userName", userName);
            return "index";
        } else {
//            JSONObject jsonObject = new JSONObject();
//            jsonObject.put("code", 0);
//            jsonObject.put("msg", "登录失败，密码或者账号错误");
//            response.getWriter().write(jsonObject.toString());
//            response.getWriter().flush();
//            response.getWriter().close();
            return "login";
        }
    }

    //跳转到注册页面
    @GetMapping("/toRegister")
    public String toRegister(HttpServletRequest request, HttpServletResponse response) {
        return "register";
    }

    //注册
    @PostMapping("/register")
//    @RequestMapping(value = "/register",method = RequestMethod.POST)
    public String register(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        System.out.println("-----------------------------");
        String username = request.getParameter("username");
        String account = request.getParameter("account");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        User user = new User(System.currentTimeMillis(), username, account, password, Byte.parseByte("1"), Byte.parseByte("1"), phone, email, Long.parseLong("1"), new Date(), new Date());
        userService.addUser(user);
        return "login";

    }

    //重新登录
    @RequestMapping("/newLogin")
    public String newLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        return "login";
    }

    //获取用户名字密码信息
    @RequestMapping("/getUser")
    public void getUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String loginAccount = (String) session.getAttribute("username");
        String password = (String) session.getAttribute("password");
        JSONObject result = new JSONObject();
        result.put("code", "1");
        result.put("loginAccount", loginAccount);
        result.put("password", password);
        response.getWriter().write(result.toString());
        response.getWriter().flush();
        response.getWriter().close();

    }

    //跳转到用户信息页面
    @RequestMapping("/showUser")
    public String selectUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        return "/info/basicInfo";
    }

    //    跳转到重置密码页面
    @RequestMapping("/resetPassword")
    public String resetPassword(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        return "/info/resetPassword";
    }

    //更新密码
    @RequestMapping("/updatePassword")
    public void updatePassword(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String loginAccount = request.getParameter("loginAccount");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        JSONObject result = userService.updatePassword(loginAccount, oldPassword, newPassword, "1");
        response.getWriter().write(result.toString());
        response.getWriter().flush();
        response.getWriter().close();
    }

    //更新用户信息
    @RequestMapping("/updateUserInfo")
    public void updateUserInfo(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String userName = request.getParameter("userName");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String id = request.getParameter("id");
        JSONObject result = userService.updateUserInfo(userName, phone, email, id);
        response.getWriter().write(result.toString());
        response.getWriter().flush();
        response.getWriter().close();
    }

    //获取用户信息
    @RequestMapping("/getUserInfo")
    public void getUserInfo(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String password = (String) session.getAttribute("password");

        JSONObject result = userService.getUserInfo(username, password);
        response.getWriter().write(result.toString());
        response.getWriter().flush();
        response.getWriter().close();

    }

    @RequestMapping("/getExternalOrderId")
    public void getExternalOrderId(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //跳转到顾客管理界面
    @GetMapping("/buyer")
    public String buyer(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        return "/buyer/buyer";
    }

    //查询所有顾客
    @PostMapping("/getAllBuyer")
    public void getAllBuyer(HttpServletRequest request, HttpServletResponse response) throws IOException {
        System.out.println("=====================");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String account = request.getParameter("account");
        String pageNo = request.getParameter("pageNo");
        String pageSize = request.getParameter("pageSize");
        try {
            JSONObject result = userService.findAllBuyer(name, account, pageNo, pageSize);
            response.getWriter().write(result.toString());
            response.getWriter().flush();
            response.getWriter().close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //通过id查询顾客信息
    @RequestMapping(value = "/getBuyer", method = {RequestMethod.POST})
    public void getBuyer(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");
        JSONObject result = userService.getBuyerById(id);
        response.getWriter().write(result.toString());
        response.getWriter().flush();
        response.getWriter().close();
    }

    //通过id更新顾客信息
    @RequestMapping(value = "/updateBuyer", method = {RequestMethod.POST})
    public void editVendor(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String account = request.getParameter("account");
        String status = request.getParameter("status");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        JSONObject result = userService.editById(id, name, account, phone, email, status);
        response.getWriter().write(result.toString());
        response.getWriter().flush();
        response.getWriter().close();
    }

    //通过id删除顾客
    @RequestMapping(value = "/DeleteBuyer", method = {RequestMethod.POST})
    public void deleteVendor(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");
        JSONObject result = userService.delById(id);
        response.getWriter().write(result.toString());
        response.getWriter().flush();
        response.getWriter().close();
    }

    //跳转到订单管理界面
    @GetMapping("/order")
    public String order(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        return "/buyer/order";
    }


}
