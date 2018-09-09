package com.jeeplus.modules.cw.web;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.jeeplus.common.utils.DateUtils;
import com.jeeplus.common.utils.MyBeanUtils;
import com.jeeplus.common.config.Global;
import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.web.BaseController;
import com.jeeplus.common.utils.StringUtils;
import com.jeeplus.common.utils.excel.ExportExcel;
import com.jeeplus.common.utils.excel.ImportExcel;
import com.jeeplus.modules.cw.entity.TCwBxd;
import com.jeeplus.modules.cw.service.TCwBxdService;

/**
 * 报销单管理Controller
 * @author wanqh
 * @date 2018-09-08
 */
@Controller
@RequestMapping(value = "${adminPath}/cw/CwBxd")
public class TCwBxdController extends BaseController {

	@Autowired
	private TCwBxdService CwBxdService;
	
	@ModelAttribute
	public TCwBxd get(@RequestParam(required=false) String id) {
		TCwBxd entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = CwBxdService.get(id);
		}
		if (entity == null){
			entity = new TCwBxd();
		}
		return entity;
	}
	
	/**
	 * 报销单列表页面
	 */
	@RequiresPermissions("cw:CwBxd:list")
	@RequestMapping(value = {"list", ""})
	public String list(TCwBxd CwBxd, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TCwBxd> page = CwBxdService.findPage(new Page<TCwBxd>(request, response), CwBxd); 
		model.addAttribute("page", page);
		return "modules/cw/cwBxdList";
	}

	/**
	 * 查看，增加，编辑报销单表单页面
	 */
	@RequiresPermissions(value={"cw:CwBxd:view","cw:CwBxd:add","cw:CwBxd:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(TCwBxd CwBxd, Model model) {
		model.addAttribute("CwBxd", CwBxd);
		return "modules/cw/cwBxdForm";
	}

	/**
	 * 保存报销单
	 */
	@RequiresPermissions(value={"cw:CwBxd:add","cw:CwBxd:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(TCwBxd CwBxd, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, CwBxd)){
			return form(CwBxd, model);
		}
		if(!CwBxd.getIsNewRecord()){//编辑表单保存
			TCwBxd t = CwBxdService.get(CwBxd.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(CwBxd, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			CwBxdService.save(t);//保存
		}else{//新增表单保存
			CwBxdService.save(CwBxd);//保存
		}
		addMessage(redirectAttributes, "保存报销单成功");
		return "redirect:"+Global.getAdminPath()+"/cw/CwBxd/?repage";
	}
	
	/**
	 * 删除报销单
	 */
	@RequiresPermissions("cw:CwBxd:del")
	@RequestMapping(value = "delete")
	public String delete(TCwBxd CwBxd, RedirectAttributes redirectAttributes) {
		CwBxdService.delete(CwBxd);
		addMessage(redirectAttributes, "删除报销单成功");
		return "redirect:"+Global.getAdminPath()+"/cw/CwBxd/?repage";
	}
	
	/**
	 * 批量删除报销单
	 */
	@RequiresPermissions("cw:CwBxd:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			CwBxdService.delete(CwBxdService.get(id));
		}
		addMessage(redirectAttributes, "删除报销单成功");
		return "redirect:"+Global.getAdminPath()+"/cw/CwBxd/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("cw:CwBxd:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(TCwBxd CwBxd, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "报销单"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<TCwBxd> page = CwBxdService.findPage(new Page<TCwBxd>(request, response, -1), CwBxd);
    		new ExportExcel("报销单", TCwBxd.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出报销单记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/cw/CwBxd/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("cw:CwBxd:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<TCwBxd> list = ei.getDataList(TCwBxd.class);
			for (TCwBxd CwBxd : list){
				try{
					CwBxdService.save(CwBxd);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条报销单记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条报销单记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入报销单失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/cw/CwBxd/?repage";
    }
	
	/**
	 * 下载导入报销单数据模板
	 */
	@RequiresPermissions("cw:CwBxd:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "报销单数据导入模板.xlsx";
    		List<TCwBxd> list = Lists.newArrayList();
    		TCwBxd bxd = new TCwBxd();
    		bxd.setName("张三");
    		bxd.setMoney(999.99);
    		bxd.setBxTime(new Date());
    		bxd.setDetail("添加明细");
    		bxd.setRemarks("添加备注");
    		list.add(bxd);
    		new ExportExcel("报销单数据", TCwBxd.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/cw/CwBxd/?repage";
    }
	
	
	

}