package jdbc;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;



/**
 * MAIN class have all the driver function to successfully run this program
 * @author yash.porwal_metacube
 *
 */
public class Main {
	
	
	public static void main(String[] args) throws SQLException{
		Jdbc jdbc = new Jdbc();
		Scanner sc = new Scanner(System.in);
		while(true){
			System.out.println("\n\n1.Get all the orders of given userId");
			System.out.println("2.Insert multiple images");
			System.out.println("3.Delete unorderd product from last 1 year");
			System.out.println("4.get all parentCategories and the count of their child categories");
			int choice = sc.nextInt();
			
			switch (choice) {
			
			case 1:
				System.out.println("Enter user Id");
				int userId = sc.nextInt();
				ArrayList<Order> orders = jdbc.getOrders(userId);
				printOrders(orders);
				break;
				
			case 2:
				System.out.println("Insert number of images");
				int totalImages = sc.nextInt();
				HashMap<String,Integer> imagePaths = new HashMap<>();
				for(int index = 0; index < totalImages; index++){
//					System.out.println("Enter path for image "+(index+1));
//					String path = sc.next();
					System.out.println("Enter Product Id for image "+(index+1));
					int id = sc.nextInt();
					String path[] = {"C:\\Users\\yash.porwal_metacube\\workspace\\DBMS - 5\\src\\jdbc\\onePlus.png",
							"C:\\Users\\yash.porwal_metacube\\workspace\\DBMS - 5\\src\\jdbc\\Dell_logo_2016.svg",
							"C:\\Users\\yash.porwal_metacube\\workspace\\DBMS - 5\\src\\jdbc\\HP.svg",
							"C:\\Users\\yash.porwal_metacube\\workspace\\DBMS - 5\\src\\jdbc\\mi.png",
							"C:\\Users\\yash.porwal_metacube\\workspace\\DBMS - 5\\src\\jdbc\\samsung.jfif"
					};
					imagePaths.put(path[index%5], id);
					}
				jdbc.insertImages(imagePaths);
				break;
				
			case 3:
				System.out.println("Deleted "+jdbc.deleteUnorderdProduct()+" products");
				break;
				
			case 4:
				printCatDetails(jdbc.getChildCategoryCount());
				break;
				
			default:
				sc.close();
				return;
				
			}
		}
	}
	
	
	
	/**
	 * print the categoryDetails
	 * @param childCategoryCount: ArrayList - CategoryDetails
	 */
	private static void printCatDetails(
			ArrayList<CategoryDetails> childCategoryCount) {
		if(childCategoryCount.size()==0) return;
		System.out.println("parent \tchild count");
		
		for(CategoryDetails catDetail:childCategoryCount){
			System.out.println(catDetail.getCategory()+" \t"+catDetail.getChildCategoryCount());
		}
		
	}

	
	
	/**
	 * print orders details
	 * @param orders ArrayList - order
	 */
	static void printOrders(ArrayList<Order> orders){
		if(orders.size()==0) return;
		System.out.println("OrderId \t OrderTotal \t OrderDate");
		for(Order order:orders){
			System.out.println(order.getOrderId()+" \t\t "+order.getTotal()+" \t\t "+order.getOrderDate());
			
		}
	}
}
