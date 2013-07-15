package canWriteText;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;

import java.awt.Graphics;
import java.util.Random;

import org.omg.CORBA.PUBLIC_MEMBER;
public class DealDraw {
	
	private int colorRed;
	private int colorBlue;
	private int colorGreen;
	 private Random random;
	private String contentString=null;
	
	
	private DealDraw()
	{
	random=new Random();
	}
	
	public static  DealDraw createDealDraw()
	{
		return new DealDraw();
	}
	
	
	
	/*
	 * 图片文字内容
	 */
	private String content;
private final int POINTNUM=50;//设置背景的点数为50
	private final int LINENUM=5;//干扰线条数为5
	private final int DEGREE=30;//设置旋转最大度数
	
	/*
	 * 验证码显示的字符串内容
	 */
private  final String []SHOWTEXT=new String []	{"0","1","2","3","4","5","6","7","8","9"
		,"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
		"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"
};


  private final  String[] CONTENTFONT = { "Verdana", "Microsoft Sans Serif", "Comic Sans MS", "Arial", "宋体", "新宋体" };

/*
 * 随机产生RBG值
 */
public int  produceColorVlaue()
{ 
//	int color=(int)Math.round(Math.random()*255);
	
	int color=random.nextInt(255);
	return color;
	
}



/*
 * 产生点的横坐标
 */


public int produceXLocation(int x)
{
	int xlocation=random.nextInt(x);
	return xlocation;
}



/*
 * 产生点的纵坐标
 */
public int produceYLocation(int y)
{
	int ylocation=random.nextInt(y);
	return ylocation;
}


/*
 * 随机产生验证码的内容
 */
public String produceContentString()
{
	String content=SHOWTEXT[random.nextInt(SHOWTEXT.length)];
	return content;
}
/*
 * 随机产生字体
 */
public String produceContentFont()
{
	String contentFont=CONTENTFONT[random.nextInt(CONTENTFONT.length)];
	return contentFont;
}

/*
 * 随机产生字体的大小
 */
public int produceFontSize(int size)
{
	size=(int) (Math.random()*(size/4)+size/2);
	return size;
	
}
 public int produceFontDegree()
 {
	 
	 int degree=random.nextInt(DEGREE);
	 return degree;
 }

	public void drawImage(Graphics g,int width,int height,int number)
	{this.contentString="";
		
		
		//画背景
		g.setColor(Color.white);
		g.fillRect(0,0 , width, height);
		//画边框
		g.setColor(Color.GREEN);
		g.drawRect(0, 0, width, height);
		
		//画背景的点点
		for(int i=0;i<POINTNUM;i++)
		{
			g.setColor(new Color(this.colorRed,this.colorBlue,this.colorGreen));
			g.drawOval(produceXLocation(width-1), produceYLocation(height-1), 0, 0);
			
		}
		
		//画线条
		for(int i=0;i<LINENUM;i++)
		{g.setColor(new Color(this.colorRed,this.colorBlue,this.colorGreen));
		g.drawLine(0, produceYLocation(height), width, produceYLocation(height));
		}
		
		
		//画图片内容
		for(int i=0;i<number;i++)
		{
			this.colorBlue=produceColorVlaue();
			this.colorGreen=produceColorVlaue();
			this.colorRed=produceColorVlaue();
			g.setColor(new Color(this.colorRed, this.colorBlue, this.colorGreen));
			g.setFont(new Font(produceContentFont(), Font.PLAIN, produceFontSize(height)));
			this.content=produceContentString();
			this.contentString+=content;
			//((Graphics2D)g).rotate(produceFontDegree()*Math.PI/180);
			g.drawString(this.content, i*20, 20);
			System.out.println(this.content);
			//System.out.println(i);
		}
		System.out.println("this.contentString="+this.contentString);
		}

	public String getContentString() {
		return contentString;
	}

	public void setContentString(String contentString) {
		this.contentString = contentString;
	}
	
	
	

}
