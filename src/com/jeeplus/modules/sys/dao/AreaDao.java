package com.jeeplus.modules.sys.dao;

import com.jeeplus.common.persistence.TreeDao;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.sys.entity.Area;

/**
 * 区域DAO接口
 * 
 * @version 2014-05-16
 */
@MyBatisDao
public interface AreaDao extends TreeDao<Area> {
	
}
