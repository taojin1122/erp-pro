/**
 * Copyright &copy; 2015-2020 <a href="http://www.pt.org/">pt</a> All rights reserved.
 */
package com.pt.modules.templan.service.templandeputy;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pt.core.persistence.Page;
import com.pt.core.service.CrudService;
import com.pt.common.utils.StringUtils;
import com.pt.modules.sys.entity.User;
import com.pt.modules.sys.mapper.UserMapper;
import com.pt.modules.sys.utils.UserUtils;
import com.pt.modules.templan.entity.templandeputy.TemplanDeputy;
import com.pt.modules.templan.mapper.templandeputy.TemplanDeputyMapper;
import com.pt.modules.templan.entity.templandeputy.TemplanDeputyist;
import com.pt.modules.templan.mapper.templandeputy.TemplanDeputyistMapper;

/**
 * 临时计划副总审核Service
 * @author cjx
 * @version 2018-09-08
 */
@Service
@Transactional(readOnly = true)
public class TemplanDeputyService extends CrudService<TemplanDeputyMapper, TemplanDeputy> {

	@Autowired
	private TemplanDeputyistMapper templanDeputyistMapper;
	@Autowired
	private TemplanDeputyMapper templanDeputyMapper;
	@Autowired
	private UserMapper userMapper;
	
	public TemplanDeputy get(String id) {
		TemplanDeputy templanDeputy = super.get(id);
		templanDeputy.setTemplanDeputyistList(templanDeputyistMapper.findTempMds(templanDeputy.getId()));
		return templanDeputy;
	}
	
	public List<TemplanDeputy> findList(TemplanDeputy templanDeputy) {
		return super.findList(templanDeputy);
	}
	
	public Page<TemplanDeputy> findPage(Page<TemplanDeputy> page, TemplanDeputy templanDeputy) {
		/*if(!StringUtils.isBlank(templanDeputy.getCreateByName()) ){
			User user = new User();
		    user.setLoginName(templanDeputy.getCreateByName());  
			User u =userMapper.getByLoginName(user);
			if(u!=null){
				templanDeputy.setDepartmentAssessing(u.getId());
			}
		}*/
		return super.findPage(page, templanDeputy);
	}
	
	@Transactional(readOnly = false)
	public void save(TemplanDeputy templanDeputy) {
		templanDeputy.setState(templanDeputy.getStatying());
		User user = UserUtils.getUser();
		templanDeputy.setDeputyAssessing(user.getId());
		templanDeputy.setDeputyAssessingDate(new Date());
		templanDeputy.preUpdate();
		mapper.update(templanDeputy);
		for (TemplanDeputyist templanDeputyist : templanDeputy.getTemplanDeputyistList()){
			if (templanDeputyist.getId() == null){
				continue;
			}
			if (TemplanDeputyist.DEL_FLAG_NORMAL.equals(templanDeputyist.getDelFlag())){
				if (StringUtils.isBlank(templanDeputyist.getId())){
					templanDeputyist.setTemporaryPlanId(templanDeputy.getId());
					templanDeputyist.preInsert();
					templanDeputyistMapper.insert(templanDeputyist);
				}else{
					templanDeputyist.preUpdate();
					templanDeputyistMapper.update(templanDeputyist);
				}
			}else{
				templanDeputyistMapper.delete(templanDeputyist);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(TemplanDeputy templanDeputy) {
		super.delete(templanDeputy);
		templanDeputyistMapper.delete(new TemplanDeputyist(templanDeputy));
	}
	
	@Transactional(readOnly = false)
	public int rejectState(String id){
		TemplanDeputy templanDeputy = new TemplanDeputy();
		User user = UserUtils.getUser();
		templanDeputy.setId(id);
		templanDeputy.setState("21");
		templanDeputy.setDeputyAssessing(user.getId());
		templanDeputy.setDeputyAssessingDate(new Date());
		return templanDeputyMapper.rejectState(templanDeputy);
	}
	public int argeeState(String id){
		TemplanDeputy templanDeputy = new TemplanDeputy();
		User user = UserUtils.getUser();
		templanDeputy.setId(id);
		templanDeputy.setState("40");
		templanDeputy.setDeputyAssessing(user.getId());
		templanDeputy.setDeputyAssessingDate(new Date());
		return templanDeputyMapper.argeeState(templanDeputy);
	}
}