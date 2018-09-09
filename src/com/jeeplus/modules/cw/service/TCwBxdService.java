package com.jeeplus.modules.cw.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.cw.entity.TCwBxd;
import com.jeeplus.modules.cw.dao.TCwBxdDao;

/**
 * 报销单管理Service
 * @author wanqh
 * @date 2018-09-08
 */
@Service
@Transactional(readOnly = true)
public class TCwBxdService extends CrudService<TCwBxdDao, TCwBxd> {

	public TCwBxd get(String id) {
		return super.get(id);
	}
	
	public List<TCwBxd> findList(TCwBxd tCwBxd) {
		return super.findList(tCwBxd);
	}
	
	public Page<TCwBxd> findPage(Page<TCwBxd> page, TCwBxd tCwBxd) {
		return super.findPage(page, tCwBxd);
	}
	
	@Transactional(readOnly = false)
	public void save(TCwBxd tCwBxd) {
		super.save(tCwBxd);
	}
	
	@Transactional(readOnly = false)
	public void delete(TCwBxd tCwBxd) {
		super.delete(tCwBxd);
	}
	
	
	
	
}