package com.tandaly.core.db;

import java.io.IOException;
/**
 * mysql数据库备份程序
 * @author Tandaly
 * @date 2013-7-16 下午2:38:34
 */
public class MysqlBak
{

	public static void main(String[] args)
	{
		try {
            String cmd ="mysqldump -h localhost -P3307 -uroot -proot ssm > E:/tools/eclipse/project/ssm/code/ssm/src/main/resources/db/ssm.sql"; //一定要加 -h localhost(或是服务器IP地址)
			
            Runtime rt = Runtime.getRuntime();
            
            rt.exec("cmd /c " + cmd);
            //Process process =rt.exec("cmd /c " + cmd);
			/*InputStreamReader isr = new InputStreamReader(process.getErrorStream());
			LineNumberReader input = new LineNumberReader(isr);
			String line;
			while((line = input.readLine())!= null){
				System.out.println(line+"~~~~~~~~~~");
			}*/
			System.out.println("备份成功!");
		} catch (IOException e) {
			System.out.println("备份失败!");
			e.printStackTrace();
		}
	
	}
}
