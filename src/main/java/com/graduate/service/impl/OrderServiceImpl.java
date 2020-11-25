package com.graduate.service.impl;

import com.graduate.dao.OrderMapper;
import com.graduate.model.Order;
import com.graduate.service.OrderService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

/**
 *@Author: win10
 *@param: null
 *@Description:
 *@Date: 20:32 2020/11/24
 */
@Service("orderService")
public class OrderServiceImpl extends BaseImpl implements OrderService {

    @Resource
    OrderMapper orderMapper;

    //查询所有订单
    @Override
    public JSONObject findAllOrder(HashMap<String, Object> map) {
//        System.out.println(map.toString());
        List<Order> list = orderMapper.selectAll(map);
        String json = getListGson().toJson(list);
        JSONArray jsonArray = JSONArray.fromObject(json);
        //查询出来数据数量
//        int i = list.size();  //这样子得出的是查询的当前页的数据的数量，不是全部符合查询条件的数据数量
        int count = orderMapper.countByMap(map);
        return selectResult(count, jsonArray);
    }

    @Override
    public JSONObject deleteOrder(String id) {
        int result = orderMapper.deleteByPrimaryKey(Long.parseLong(id));
        return delByIdResult(result);
    }

}
