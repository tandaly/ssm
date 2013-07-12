package com.tandaly.core.db;

import java.io.IOException;

public class MysqlBak
{

	public static void main(String[] args)
	{
		try {
            String cmd ="mysqldump -h localhost -P3307 -uroot -proot share > E:/tools/eclipse/project/ssm/code/ssm/src/main/resources/db/share.sql"; //一定要加 -h localhost(或是服务器IP地址)
			
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
