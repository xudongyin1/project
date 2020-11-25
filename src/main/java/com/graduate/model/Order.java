package com.graduate.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * order
 * @author 
 */
public class Order implements Serializable {
    /**
     * 订单流水号
     */
    private Long id;

    /**
     * 顾客账号
     */
    private String buyerAccount;

    /**
     * 顾客名称
     */
    private String buyerName;

    /**
     * 顾客手机号
     */
    private String buyerPhone;

    /**
     * 物品名字
     */
    private String sName;

    /**
     *  物品数量
     */
    private Integer sCount;

    /**
     * 1为已经付款，2为未付款
     */
    private Integer status;

    /**
     * 订单总价格
     */
    private BigDecimal price;

    /**
     * 订单创建时间
     */
    private Date createTime;

    /**
     * 订单修改时间
     */
    private Date updateTime;

    private static final long serialVersionUID = 1L;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getBuyerAccount() {
        return buyerAccount;
    }

    public void setBuyerAccount(String buyerAccount) {
        this.buyerAccount = buyerAccount;
    }

    public String getBuyerName() {
        return buyerName;
    }

    public void setBuyerName(String buyerName) {
        this.buyerName = buyerName;
    }

    public String getBuyerPhone() {
        return buyerPhone;
    }

    public void setBuyerPhone(String buyerPhone) {
        this.buyerPhone = buyerPhone;
    }

    public String getsName() {
        return sName;
    }

    public void setsName(String sName) {
        this.sName = sName;
    }

    public Integer getsCount() {
        return sCount;
    }

    public void setsCount(Integer sCount) {
        this.sCount = sCount;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}