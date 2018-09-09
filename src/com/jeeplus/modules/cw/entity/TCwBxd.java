package com.jeeplus.modules.cw.entity;

import javax.validation.constraints.NotNull;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.jeeplus.common.persistence.DataEntity;
import com.jeeplus.common.utils.excel.annotation.ExcelField;

/**
 * 报销单管理Entity
 * @author wanqh
 * @date 2018-09-08
 */
public class TCwBxd extends DataEntity<TCwBxd> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 姓名
	private Double money;		// 金额
	private String detail;		// 明细
	private Date bxTime;		// 报销时间
	private String zmCl;		// 证明材料

	private Date bxStartDate;  //开始时间，查询
	private Date bxEndDate;  //开始时间，查询

	private String strMoney;

	public TCwBxd() {
		super();
	}

	public TCwBxd(String id){
		super(id);
	}

	@ExcelField(title="姓名", align=2, sort=7)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@NotNull(message="金额不能为空")
	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
		this.strMoney  = money.toString();
	}

	@ExcelField(title="金额", align=2, sort=8)
	public String getStrMoney() {
		return strMoney;
	}

	public void setStrMoney(String strMoney) {
		this.money = Double.valueOf(strMoney);
		this.strMoney = strMoney;
	}

	@ExcelField(title="明细", align=2, sort=9)
	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="报销时间不能为空")
	@ExcelField(title="报销时间", align=2, sort=10)
	public Date getBxTime() {
		return bxTime;
	}

	public void setBxTime(Date bxTime) {
		this.bxTime = bxTime;
	}
	
	public String getZmCl() {
		return zmCl;
	}

	public void setZmCl(String zmCl) {
		this.zmCl = zmCl;
	}


	public Date getBxStartDate() {
		return bxStartDate;
	}

	public void setBxStartDate(Date bxStartDate) {
		this.bxStartDate = bxStartDate;
	}

	public Date getBxEndDate() {
		return bxEndDate;
	}

	public void setBxEndDate(Date bxEndDate) {
		this.bxEndDate = bxEndDate;
	}

	@Override
	@ExcelField(title="备注", align=2, sort=100)
	public String getRemarks() {
		return super.getRemarks();
	}

	@Override
	public void setRemarks(String remarks) {
		super.setRemarks(remarks);
	}
}