package com.graduate.service.impl;

import com.graduate.dao.UserMapper;
import com.graduate.model.User;
import com.graduate.service.IUserService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User Class
 *
 * @author xiyouquedongxing
 * @date 2018-04-14
 * */
@Service("userService")
public class UserServiceImpl implements IUserService {

    @Resource
    private UserMapper userMapper;


    @Override
    public List<User> login(String username, String password) {
        Map<String,String> map = new HashMap<String,String>(2);
        if (StringUtils.isNotBlank(username)) {
            map.put("username",username);
        }
        if (StringUtils.isNotBlank(password)) {
            map.put("password",password);
        }
        List<User> list = userMapper.getUser(map);
        System.out.println("查询结果："+list);
        return list;
    }

}