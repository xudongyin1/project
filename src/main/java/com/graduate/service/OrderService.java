package com.graduate.service;

import net.sf.json.JSONObject;

import java.util.HashMap;

/**
 *@Author: win10
 *@param: null
 *@Description:
 *@Date: 20:31 2020/11/24
 */

public interface OrderService {
    //查询所有订单
    JSONObject findAllOrder(HashMap<String, Object> map);

    //通过id删除订单
    JSONObject deleteOrder(String id);
}
