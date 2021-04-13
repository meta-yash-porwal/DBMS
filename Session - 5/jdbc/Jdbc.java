package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * this class handle all the CRUD operations & 
 * Insert, Select, Delete operations
 * @author yash.porwal_metacube
 *
 */
public class Jdbc  {
	private Connection connection;
	private Statement stmt;
	
	
	/**
	 * constructor
	 * initializing the connection to the database
	 * @throws SQLException
	 */
	Jdbc() throws SQLException{
		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/storefront", "root", "123");
		stmt = connection.createStatement();
	}
	
	

	/**
	 * return the list of POJOs of orders which contains the order details of the give userID
	 * POJO - Plain old java object 
	 * @param userId: int
	 * @return
	 * @throws SQLException
	 */
	public ArrayList<Order> getOrders(int userId) throws SQLException {
		ArrayList<Order> orders = new ArrayList<Order>();
		ResultSet rs =stmt.executeQuery(
				"select Id, TotalCost, OrderDate from orders where Id=" + userId);
		while(rs.next()){
			Order newOrder = new Order(rs.getInt(1), rs.getInt(2), rs.getTimestamp(3).toString());
			orders.add(newOrder);
		}
	return orders;
	}
	
	
	/**
	 * Insert the given images with product id using the batch insertion technique
	 * @param imagePaths:productId(Map)
	 * @throws SQLException
	 */
	public void insertImages(HashMap<String, Integer> imagePaths) throws SQLException {
		connection.setAutoCommit(false);
		System.out.println("Inserting images....");
		for(String path:imagePaths.keySet()){
			System.out.println(path+"   "+imagePaths.get(path));
			stmt.addBatch(
			"Insert Into images values("+
					imagePaths.get(path)+",LOAD_FILE('"+path+"'));");
//					imagePaths.get(path)+","+ path +";");
		}
		stmt.executeBatch();
		connection.commit();
		connection.setAutoCommit(true);
	}
	
	
	
	/**
	 * return the no of deleted unordered product from the last 1 year
	 * @return: int
	 * @throws SQLException
	 */
	public int deleteUnorderdProduct() throws SQLException {
		int deletedRows = stmt.executeUpdate(
				"delete from Product "
				+ "Where Id "
				+ "NOT IN "
				+ "(select I.ProductId from item I inner join orders O "
				+ "on I.OrderId = O.Id "
				+ "where O.OrderDate > (DATE_SUB(CURDATE(), INTERVAL 1 YEAR)));"
				);
		return deletedRows;
	}

	
	/**
	 * return the list of the POJOs of Category Details contains 
	 * the name of the parent category name 
	 * and count of its child
	 * @return: ArrayList of type CategoryDetails (CategoryName & count of child category)
	 * @throws SQLException
	 */
	public ArrayList<CategoryDetails> getChildCategoryCount() throws SQLException{
		ArrayList<CategoryDetails> catDetails = new ArrayList<>();
		ResultSet rs = stmt.executeQuery("Select c.title as Parent, "
				+ "count(ca.title) as Count_Child_Category "
				+ "from category c, category ca "
				+ "where c.id = ca.parentcategoryid "
				+ "group by parent "
				+ "order by parent;");
		
		while(rs.next()){
			CategoryDetails catDetail = new CategoryDetails(rs.getString(1), rs.getInt(2));
			catDetails.add(catDetail);
		}
		return catDetails;
	}
	
}
