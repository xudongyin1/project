package com.graduate.service;

import com.graduate.model.User;
import net.sf.json.JSONObject;

import java.util.List;

/**
 * @author xiyouquedongxing
 * @date 2018-04-14
 */
public interface IUserService {


    /**
     * 用户登陆
     * @param username 用户名
     * @param password 密码
     * @return boolean 查询结果
     * */
    List<User> login(String username, String password);

    /**
     * 获取用户信息
     * @param username 用户名
     * @param password 密码
     * @return boolean 查询结果
     * */
    JSONObject getUserInfo(String username, String password);

    /**
     * 更新密码
     * @param loginAccount
     * @param oldPassword
     * @param newPassword
     * @return boolean 查询结果
     * */
    JSONObject updatePassword(String loginAccount, String oldPassword, String newPassword, String id);

    /**
     * 更新用户信息
     * @param userName
     * @param phone
     * @param email
     * @return boolean 查询结果
     * */
    JSONObject updateUserInfo(String userName, String phone, String email, String id);

    /**
     * 添加管理员用户
     * @param user
     * @return
     */
    JSONObject addUser(User user);


    //查询所有顾客信息
    JSONObject findAllBuyer(String name, String account, String pageNo, String pageSize);
    //通过id查询顾客信息
    JSONObject getBuyerById(String id);

    //通过id更新顾客信息
    JSONObject editById(String id, String name, String account, String phone, String email, String status);

    //通过id删除顾客
    JSONObject delById(String id);
}
