package com.tanf;

import com.tanf.system.admin.beans.Privilege;

public class Demo
{
	public static void main(String[] args)
	{
		Privilege p = new Privilege();
		
		System.out.println(p.getClass().getSimpleName().toString().toLowerCase());
	}
}
