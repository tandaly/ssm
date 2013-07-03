package com.tandaly.core.spring;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.BeanFactoryAware;
/**
 * 实现BeanFactoryAware接口，把该接口配置到spring中，然后把getbean方法写成静态的，就可以动态获取
 * @author Tandaly
 * @date 2013-3-6 上午11:27:42
 */
public class SpringFactory implements BeanFactoryAware {

	private static BeanFactory beanFactory;

	// private static ApplicationContext context;

	@SuppressWarnings("static-access")
	public void setBeanFactory(BeanFactory factory) throws BeansException {
		this.beanFactory = factory;
	}

	/**
	 * 根据beanName名字取得bean
	 * 
	 * @param beanName
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static <T> T getBean(String beanName) {
		if (null != beanFactory) {
			return (T) beanFactory.getBean(beanName);
		}
		return null;
	}
	
	/**
	 * 根据类取得bean
	 * @param klass
	 * @return
	 */
	public static <T> T getBean(Class<T> klass) {
		if (null != beanFactory) {
			return (T) beanFactory.getBean(klass);
		}
		return null;
	}

}
