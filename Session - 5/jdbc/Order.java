package jdbc;


/**
 * POJO for Orders query
 * POJO = Plain Old Java Object
 * @author yash.porwal_metacube
 *
 */
public class Order {

	private int orderId,orderTotal;
	private String orderDate;
	
	
	/**
	 * Parameterized constructor
	 * @param orderId: int
	 * @param orderTotal: int
	 * @param orderDate: String
	 */
	Order(int orderId,int orderTotal,String orderDate){
		this.orderDate = orderDate;
		this.orderId = orderId;
		this.orderTotal = orderTotal;
	}
	
	
	
	/**
	 * return the total amount of order
	 * @return
	 */
	int getTotal(){
		return this.orderTotal;
	}
	
	
	/**
	 * return orderId
	 * @return
	 */
	int getOrderId(){
		return this.orderId;
	}
	
	
	/**
	 * return the order date
	 * @return 
	 */
	String getOrderDate(){
		return this.orderDate;
	}
	
}
