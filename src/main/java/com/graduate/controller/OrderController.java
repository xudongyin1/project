package com.graduate.controller;

import com.graduate.model.User;
import com.graduate.service.IUserService;
import com.graduate.service.OrderService;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.xmlbeans.impl.jam.mutable.MPackage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;


@Controller
@RequestMapping("/order")
public class OrderController {

    @Resource
    private IUserService userService;

    @Resource
    private OrderService orderService;

    //订单查询,包含条件查询
//    @PostMapping("/findAllOrder")
    @RequestMapping(value = "/findAllOrder", method = {RequestMethod.POST})
    public void findAllOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        System.out.println("++++*+++++++++");
        HashMap<String, Object> map = new HashMap<>();
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String bName = request.getParameter("bName");
        String bAccount = request.getParameter("bAccount");
        String sName = request.getParameter("sName");
        String pageNo = request.getParameter("pageNo");
        String pageSize = request.getParameter("pageSize");
        if (StringUtils.isNotBlank(startDate)) {
            map.put("startDate", startDate);
        }
        if (StringUtils.isNotBlank(endDate)) {
            map.put("endDate", endDate);
        }
        if (StringUtils.isNotBlank(bName)) {
            map.put("bName", bName);
        }
        if (StringUtils.isNotBlank(bAccount)) {
            map.put("bAccount", bAccount);
        }
        if (StringUtils.isNotBlank(sName)) {
            map.put("sName", sName);
        }
        if (StringUtils.isNotBlank(pageNo) && StringUtils.isNotBlank(pageSize)) {
            int startIndex = Integer.parseInt(pageSize) * (Integer.parseInt(pageNo) - 1);
            map.put("startIndex", startIndex);
            map.put("pageSize", Integer.parseInt(pageSize));
        }
        JSONObject result = orderService.findAllOrder(map);
        response.getWriter().write(result.toString());
        response.getWriter().flush();
        response.getWriter().close();
    }


    //通过id删除订单
    @PostMapping("/deleteOrder")
    public void deleteOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");
        JSONObject result = orderService.deleteOrder(id);
        response.getWriter().write(result.toString());
        response.getWriter().flush();
        response.getWriter().close();
    }
}
