package com.kdigital.exam.ui;

import java.util.List;
import java.util.Scanner;

import com.kdigital.exam.entity.ItemType;
import com.kdigital.exam.service.CashbookService;
import com.kdigital.exam.service.CashbookServiceImpl;

public class CashbookUI {
	// Have-A 관계
	Scanner keyin = new Scanner(System.in);
	CashbookService service = new CashbookServiceImpl();

	public CashbookUI() {
		String choice;

		while(true) {
			menu();
			choice = keyin.next();

			switch(choice) {
			case "1" : create(); break;
//			case "2" : retrieve(); break;
//			case "3" : update(); break;
//			case "4" : delete(); break;
//			case "5" : retrieveAll(); break;
//			case "0" : 
//				System.out.println("프로그램을 종료합니다.");
//				return;
			}
		}
	}

	/*
	 * 회원 가입 
	 */
	private void create() {
        System.out.println("\n<< 지출 내역 입력 >>");

        int number, amount;
        String detail, note;
        ItemType type;

        System.out.print("1 (식비) / 2 (문화예술) / 3 (미용(의복)) / 4 (교통비) / 5 (경조사비) / 6 (금융 (저축 등)) / 7 (기타0)");
        
        System.out.print(" ## 항목번호 : ");
        number = keyin.nextInt();
        
        switch(number) {
        case 1 : type = ItemType.식비; break;
        case 2 : type = ItemType.문화예술; break;
        case 3 : type = ItemType.미용; break;
        case 4 : type = ItemType.교통; break;
        case 5 : type = ItemType.경조사; break;
        case 6 : type = ItemType.금융; break;
        case 7 : type = ItemType.기타; break;
        }
        
        keyin.nextLine(); // 버퍼비우기
        
        System.out.print(" ## 자세한 내역 : ");
        detail = keyin.nextLine();
        
        System.out.print(" ## 금액 : ");
        amount = keyin.nextInt();
        keyin.nextLine();
        
        System.out.print(" ## 메모할 내용 : ");
        note = keyin.nextLine();
	
	}
//	private void retrieve() {
//		System.out.println("\n<< 월별 지출 보기 >>");
//		int year = 0;
//		int month = 0;
//
//		System.out.print("## 년도를 2자리로 입력하세요 : ");
//		year = keyin.nextInt();
//		
//		System.out.print("## 월을 2자리로 입력하세요 : ");
//		month = keyin.nextInt();
//
//		Cashbook cashbook = service.selectOne(id);
//
//		if (cashbook == null) {
//			System.out.println("## 입력한 아이디의 회원 정보가 없습니다.");
//			return;
//		} 
//
//		System.out.println(fitness);
//		System.out.println();
//
//	}
//	private void update() {
//		System.out.println("\n<< 회원 정보 수정 >>");
//	
//		int id;
//		String check;
//		double height, weight;
//
//		System.out.print("> 아이디 : ");
//		id = keyin.nextInt();
//		
//		Fitness fitness = service.selectOne(id);
//
//		if(fitness == null) {
//			System.out.println("## 입력한 아이디에 해당하는 회원이 없습니다.");
//			return;
//		}
//
//		System.out.print("> 키(cm) : ");
//		height = keyin.nextInt();
//
//		System.out.print("> 몸무게(Kg) : ");
//		weight = keyin.nextInt();
//
//		System.out.print("## 정말로 수정할까요? (Y/N)");
//		check = keyin.next();
//
//		if (!(check.equals("Y") || check.equals("y"))) {
//			System.out.println("## 수정 작업이 취소되었습니다.\n");
//			return;
//		}
//
//		fitness.setHeight(height);
//		fitness.setWeight(weight);
//		
//		boolean result = service.update(fitness);
//		if (result) {
//			System.out.println("## 수정이 완료되었습니다.\n");
//		} else {
//			System.out.println("## 정보 수정 실패");
//		}
//	}
//	private void delete() {
//		int id;
//		String check;
//
//		System.out.print("# 아이디 : ");
//		id = keyin.nextInt();
//
//		Fitness fitness = service.selectOne(id);
//
//		if (fitness == null) {
//			System.out.println("## 입력한 아이디에 해당하는 회원이 없습니다.");
//			return;
//		}
//
//		System.out.print("## 정말로 탈퇴할까요? (Y/N)");
//		check = keyin.next();
//
//		if (!(check.equals("Y") || check.equals("y"))) {
//			System.out.println("## 탈퇴 작업이 취소되었습니다.\n");
//			return;
//		}
//
//		boolean result = service.delete(id);
//		
//		if (result) {
//			System.out.println("## 탈퇴가 완료되었습니다.\n");
//		} else {
//			System.out.println("## 탈퇴 실패");
//		}
//
//	}
//	
//	// 회원 전체 조회
//	private void retrieveAll() {
//		System.out.println("\n<< 전체 회원 조회 >>");
//		List<Fitness> list = service.selectAll();
//
//		if (list.size() == 0) {
//			System.out.println("## 가입한 회원이 한 명도 없습니다.");
//			return;
//		}
//		
//		System.out.println("## 전체 회원의 수 : " + list.size() + "명");
//		
//		for (int i = 0; i<list.size(); ++i) {
//			System.out.println(list.get(i));;
//		}
//	}
	/*
	 * 메뉴를 화면에 출력
	 * C(Create), R(Retrieve), U(Update), D(Delete)
	 */
	private void menu() {
		System.out.println("==== [지출 관리] ====");
		System.out.println("	1) 지출 내역 입력");
		System.out.println("	2) 지출 내역 조회");
		System.out.println("	3) 내역 삭제");
		System.out.println("	4) 삭 제");
		System.out.println("	5) 지출 통계 조회");
		System.out.println("	0) 종 료");
		System.out.print("  	# 선택 : ");
	}
}
