package com.kdigital.exam.service; // 현재 클래스가 패키지 안에 포함되어 있는지 정보

import java.util.List;

import com.kdigital.exam.entity.Cashbook;
import com.kdigital.exam.util.MyEntityManager;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

public class CashbookServiceImpl implements CashbookService{

	@Override
	public boolean insert(Cashbook cashbook) {
		EntityManager manager = MyEntityManager.getManager();
		EntityTransaction tx = manager.getTransaction();
		
		try {
			tx.begin();
			
			manager.persist(cashbook);
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return false;
		} finally {
			manager.close();
		}
		return true;
	}

	@Override
	public Cashbook selectOne(int id) {
		EntityManager manager = MyEntityManager.getManager();
		EntityTransaction tx = manager.getTransaction();
		
		Cashbook cashbook = null;
		
		try {
			tx.begin();
			
			cashbook = manager.find(Cashbook.class, id);
			
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
		} 
		return cashbook;
	}

	@Override
	public boolean update(Cashbook cashbook) {
		return false;
	}

	@Override
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<Cashbook> selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

}
