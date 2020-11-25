package com.graduate.dao;

import com.graduate.model.Order;
import org.apache.ibatis.annotations.Param;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface OrderMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Order record);

    int insertSelective(Order record);

    Order selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Order record);

    int updateByPrimaryKey(Order record);

    //查询所有订单，包括加查询条件的
    List<Order> selectAll(@Param("map") Map<String,Object> map);

    int countByMap(@Param("map") Map<String, Object> map);
}
