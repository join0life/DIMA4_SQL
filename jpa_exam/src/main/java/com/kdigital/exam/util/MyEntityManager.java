package com.kdigital.exam.util;

// Singleton Pattern
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class MyEntityManager {
	private static EntityManagerFactory factory;
	
	private MyEntityManager() {} // 외부에서 이 클래스를 생성하지 못하도록 막기 위한 용도
	// 스태틱블록 : private인 static 변수를 초기화
	static {
		factory = Persistence.createEntityManagerFactory("jpastudy");
	}
	public static EntityManager getManager() {
		return factory.createEntityManager();
	}
	public static void close() {
		factory.close();
	}

}
