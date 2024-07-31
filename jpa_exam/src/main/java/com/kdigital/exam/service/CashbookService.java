package com.kdigital.exam.service;

import java.util.List;

import com.kdigital.exam.entity.Cashbook;

public interface CashbookService {
	public boolean insert(Cashbook cashbook);
	public Cashbook selectOne(int id);
	public boolean update(Cashbook cashbook);
	public boolean delete(int id);
	public List<Cashbook> selectAll();
}
