package canWriteText;

import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.PrintWriter;

import javax.imageio.ImageIO;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sun.net.httpserver.HttpContext;

public class Check extends HttpServlet {
private  int width;
private  int height;
private int number;

private DealDraw dealDraw=DealDraw.createDealDraw();
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session=request.getSession(true);
		
		
		BufferedImage bufferedImage=new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		Graphics g=(Graphics)bufferedImage.createGraphics();
		
		dealDraw.drawImage(g, width, height, number);
		
		session.setAttribute("CheckCode", dealDraw.getContentString());
		System.out.println("dealDraw.getContentString()"+dealDraw.getContentString());
		g.dispose();//图像生效 
		//bufferedImage.flush();
		  //禁止图像缓存 
		 /* response.setHeader("Pragma", "No-cache"); 
		  response.setHeader("Cache-Control", "no-cache"); 
		  response.setDateHeader("Expires", 0);   */
		  response.setContentType("image/jpeg"); 
		  //创建二进制的输出流 
		  ServletOutputStream sos=response.getOutputStream(); 
		        // 将图像输出到Servlet输出流中。 
		        ImageIO.write(bufferedImage, "jpeg", sos); 
		        sos.flush(); 
		        sos.close(); 
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
		this.width=Integer.parseInt(config.getInitParameter("width"));
		this.height=Integer.parseInt(config.getInitParameter("height"));
		this.number=Integer.parseInt(config.getInitParameter("number"));
		
	
	}

}
