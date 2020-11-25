package com.graduate.service.impl;

import com.google.gson.JsonObject;
import com.graduate.dao.UserMapper;
import com.graduate.model.User;
import com.graduate.service.IUserService;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONFunction;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * User Class
 *
 * @author xiyouquedongxing
 * @date 2018-04-14
 * */
@Service("userService")
public class UserServiceImpl extends BaseImpl implements IUserService {

    @Resource
    private UserMapper userMapper;

    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    @Override
    public List<User> login(String username, String password) {
        Map<String,String> map = new HashMap<String,String>(2);
        if (StringUtils.isNotBlank(username)) {
            map.put("username",username);
            map.put("type", "1");
        }
        if (StringUtils.isNotBlank(password)) {
            map.put("password",password);
        }
        List<User> list = userMapper.getUser(map);
        System.out.println("查询结果："+list);
        return list;
    }

    @Override
    public JSONObject getUserInfo(String username, String password) {
        Map<String,String> map = new HashMap<String,String>(2);
        if (StringUtils.isNotBlank(username)) {
            map.put("username",username);
        }
        if (StringUtils.isNotBlank(password)) {
            map.put("password",password);
        }
        List<User> list = userMapper.getUser(map);
        if (list.size() < 1) {
            JSONObject obj = new JSONObject();
            obj.put("code","0");
            obj.put("msg","未查询到用户信息");
            return obj;
        }
        String str = getListGson().toJson(list);
        JSONArray data = JSONArray.fromObject(str);
        JSONObject obj = data.getJSONObject(0);
        return getByIdResult(obj);
    }

    @Override
    public JSONObject updatePassword(String loginAccount, String oldPassword, String newPassword, String id) {
        Map<String,Object> map = new HashMap<>(6);
        if (StringUtils.isNotBlank(id)) {
            map.put("id",Long.parseLong(id));
        }
        if (StringUtils.isNotBlank(loginAccount)) {
            map.put("loginAccount",loginAccount);
        }
        if (StringUtils.isNotBlank(oldPassword)) {
            map.put("oldPassword",oldPassword);
        }
        if (StringUtils.isNotBlank(newPassword)) {
            map.put("newPassword",newPassword);
        }
        map.put("modifiedTime",format.format(new Date()));
        int i = userMapper.updateByMap(map);
        return aiAndSi(i, 1);
    }

    @Override
    public JSONObject updateUserInfo(String userName, String phone, String email, String id) {
        Map<String,Object> map = new HashMap<>(6);
        if (StringUtils.isNotBlank(id)) {
            map.put("id",Long.parseLong(id));
        }
        if (StringUtils.isNotBlank(userName)) {
            map.put("userName",userName);
        }
        if (StringUtils.isNotBlank(phone)) {
            map.put("phone",phone);
        }
        if (StringUtils.isNotBlank(email)) {
            map.put("email",email);
        }
        map.put("modifiedTime",format.format(new Date()));
        int i = userMapper.updateInfoByMap(map);
        return aiAndSi(i, 1);
    }

    @Override
    public JSONObject addUser(User user) {
        int i = userMapper.insert(user);
        return aiAndSi(i, 1);
    }

    //查询所有顾客信息
    @Override
    public JSONObject findAllBuyer(String name, String account, String pageNo, String pageSize) {
        HashMap<String, Object> map = new HashMap<>(4);
        if (StringUtils.isNotBlank(name)) {
            map.put("name",name);
        }
        if (StringUtils.isNotBlank(account)) {
            map.put("account",account);
        }
        if (StringUtils.isNotBlank(pageNo) && StringUtils.isNotBlank(pageSize)) {
            int startIndex = (Integer.parseInt(pageNo) - 1) * Integer.parseInt(pageSize);
            map.put("startIndex", startIndex);
            map.put("pageSize", Integer.parseInt(pageSize));
        }
//        System.out.println(map.toString());
        List<User> list = userMapper.selectByMap(map);
//        for (int i = 0; i < list.size(); i++) {
//            User user = list.get(i);
//            System.out.println(user.toString());
//        }

        String str = getListGson().toJson(list);
        JSONArray data = JSONArray.fromObject(str);
        //查询数据条数
//        int count = list.size();  这样数量就是每一个每页查询的数量，不是总的符合条件的数量
        int count= userMapper.countByMap(map);
        return selectResult(count, data);
    }

    //通过id查询顾客信息
    @Override
    public JSONObject getBuyerById(String id) {
        User user = userMapper.selectByPrimaryKey(Long.parseLong(id));
        String json = getListGson().toJson(user);

        return JSONObject.fromObject(json);
    }

    //通过id更新顾客信息
    @Override
    public JSONObject editById(String id, String name, String account, String phone, String email, String status) {
        User user = new User();
        user.setId(Long.parseLong(id));
        user.setEmail(email);
        user.setLoginAccount(account);
        user.setUserName(name);
        user.setMobile(phone);
        user.setStatus(Byte.parseByte(status));
        user.setModifiedTime(new Date());
        int i = userMapper.updateByPrimaryKeySelective(user);
        return editByIdResult(i);
    }

    //通过io删除顾客
    @Override
    public JSONObject delById(String id) {
        int i = userMapper.deleteByPrimaryKey(Long.parseLong(id));
        return delByIdResult(i);
    }

}
