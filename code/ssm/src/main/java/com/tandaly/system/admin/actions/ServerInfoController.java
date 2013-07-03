package com.tandaly.system.admin.actions;

import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import sun.management.ManagementFactory;

import com.sun.management.OperatingSystemMXBean;
import com.tandaly.core.util.WebUtil;

@SuppressWarnings("restriction")
@Controller
@RequestMapping("server")
public class ServerInfoController {

	Log log = LogFactory.getLog(ServerInfoController.class);
	
	private static final int CPUTIME = 500;
	private static final int PERCENT = 100;
	private static final int FAULTLENGTH = 10;
	
	/**
	 * 跳转到服务信息框架页面
	 */
	@RequestMapping("serverFrame")
	public void serverFrame()
	{
	}
	
	@RequestMapping("frame")
	public void frame()
	{
		
	}
	
	@RequestMapping("serverChart")
	public void serverChart(Model model)
	{
		String caption = "JVM内存使用情况实时监控图(";
		caption = caption + "<font color=green>可分配总内存:</font><font color=red>" + new Double(Runtime.getRuntime().maxMemory() / 1024 / 1024).intValue() + "M</font> ";
		caption = caption + "<font color=green>已分配总内存:</font><font color=red>" + new Double(Runtime.getRuntime().totalMemory() / 1024 / 1024).intValue() + "M</font>)";
//		caption = caption
//				+ "已用内存:"
//				+ new Double((Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory()) / 1024 / 1024)
//						.intValue() + "M)";
	
		//JVM可用最大内存
		model.addAttribute("jvmMaxMemory", Runtime.getRuntime().maxMemory() / 1024 / 1024 + "M");
		
		//已用内存
		Integer useMemory = new Double((Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory()) / 1024 / 1024).intValue();
		model.addAttribute("useMemory", useMemory);
		
		model.addAttribute("caption", caption);
	}
	
	/**
	 * 异步获取服务监控报表数据
	 * @param model
	 */
	@RequestMapping("ajaxServerChartData")
	public void ajaxServerChartData(HttpServletResponse response)
	{
		Integer useMemory = new Double((Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory()) / 1024 / 1024).intValue();
		WebUtil.writerHtml(response, useMemory);
	}
	
	/**
	 * 服务器信息
	 * @param request
	 * @param model
	 * @return
	 * @throws UnknownHostException 
	 */
	@RequestMapping("serverInfo")
	public Object serverInfo(@Value("#{systemProperties['java.vm.version']}")String jvmVersion,HttpServletRequest request, Model model) throws UnknownHostException
	{
		OperatingSystemMXBean osmxb = (OperatingSystemMXBean) ManagementFactory.getOperatingSystemMXBean();
		model.addAttribute("", "");
		InetAddress localhost = InetAddress.getLocalHost();
		//操作系统
		model.addAttribute("osSystem", System.getProperty("os.name") + "_" + System.getProperty("os.arch"));
		//主机IP
		model.addAttribute("serverIP", "" + localhost.getHostAddress());
		//应用服务器信息
		model.addAttribute("appServer",request.getSession().getServletContext().getServerInfo());
		//监听端口
		model.addAttribute("serverPort", request.getServerPort());
		//web根路径
		model.addAttribute("webPath", (request.getSession().getServletContext().getRealPath("/") + "").replaceAll("\\\\", "/"));
		//servlet版本
		model.addAttribute("servletVersion", request.getSession().getServletContext().getMajorVersion() + "."
				+ request.getSession().getServletContext().getMinorVersion());
		//JVM版本
		//model.addAttribute("jvmVersion", System.getProperty("java.version"));
		model.addAttribute("jvmVersion", jvmVersion);
		//JVM提供商
		model.addAttribute("jvmVendor", System.getProperty("java.vendor"));
		//JVM安装路径
		model.addAttribute("JVMHome", System.getProperty("java.home").replaceAll("\\\\", "/"));
		//主机物理内存
		model.addAttribute("serverSwapSpace", osmxb.getTotalSwapSpaceSize() / 1024 / 1024 + "M");
		//JVM可用最大内存
		model.addAttribute("jvmMaxMemory", Runtime.getRuntime().maxMemory() / 1024 / 1024 + "M");
		
		return model;
	}
	
	

	public static String getCpuRatioForWindows() {
		try {
			String procCmd = System.getenv("windir")
					+ "\\system32\\wbem\\wmic.exe process get Caption,CommandLine,KernelModeTime,ReadOperationCount,ThreadCount,UserModeTime,WriteOperationCount";
			long[] c0 = readCpu(Runtime.getRuntime().exec(procCmd));
			Thread.sleep(CPUTIME);
			long[] c1 = readCpu(Runtime.getRuntime().exec(procCmd));
			if (c0 != null && c1 != null) {
				long idletime = c1[0] - c0[0];
				long busytime = c1[1] - c0[1];
				return Double.valueOf(PERCENT * (busytime) * 1.0 / (busytime + idletime)).intValue() + "";
			} else {
				return 0 + "";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			return 0 + "";
		}
	}

	private static long[] readCpu(final Process proc) {
		long[] retn = new long[2];
		try {
			proc.getOutputStream().close();
			InputStreamReader ir = new InputStreamReader(proc.getInputStream());
			LineNumberReader input = new LineNumberReader(ir);
			String line = input.readLine();
			if (line == null || line.length() < FAULTLENGTH) {
				return null;
			}
			int capidx = line.indexOf("Caption");
			int cmdidx = line.indexOf("CommandLine");
			int rocidx = line.indexOf("ReadOperationCount");
			int umtidx = line.indexOf("UserModeTime");
			int kmtidx = line.indexOf("KernelModeTime");
			int wocidx = line.indexOf("WriteOperationCount");
			long idletime = 0;
			long kneltime = 0;
			long usertime = 0;
			while ((line = input.readLine()) != null) {
				if (line.length() < wocidx) {
					continue;
				}
				// 字段出现顺序：Caption,CommandLine,KernelModeTime,ReadOperationCount,
				// ThreadCount,UserModeTime,WriteOperation
				String caption = substring(line, capidx, cmdidx - 1).trim();
				String cmd = substring(line, cmdidx, kmtidx - 1).trim();
				if (cmd.indexOf("wmic.exe") >= 0) {
					continue;
				}
				String s1 = substring(line, kmtidx, rocidx - 1).trim();
				String s2 = substring(line, umtidx, wocidx - 1).trim();
				if (caption.equals("System Idle Process") || caption.equals("System")) {
					if (s1.length() > 0)
						idletime += Long.valueOf(s1).longValue();
					if (s2.length() > 0)
						idletime += Long.valueOf(s2).longValue();
					continue;
				}
				if (s1.length() > 0)
					kneltime += Long.valueOf(s1).longValue();
				if (s2.length() > 0)
					usertime += Long.valueOf(s2).longValue();
			}
			retn[0] = idletime;
			retn[1] = kneltime + usertime;
			return retn;
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
				proc.getInputStream().close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	private static String substring(String src, int start_idx, int end_idx) {
		byte[] b = src.getBytes();
		String tgt = "";
		for (int i = start_idx; i <= end_idx; i++) {
			tgt += (char) b[i];
		}
		return tgt;
	}
}
