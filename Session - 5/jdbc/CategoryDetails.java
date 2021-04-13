package jdbc;

/**
 * this class is for fetching category details from database storefront  
 * it shows category name & the count of child category 
 * @author yash.porwal_metacube
 *
 */
public class CategoryDetails {
	private String categoryName;
	private int childCategory;
	
	
	/**
	 * Parameterized constructor
	 * @param categoryName: string - title of category
	 * @param childCategory:int - count of child category
	 */
	public CategoryDetails(String categoryName , int childCategory) {
		this.categoryName = categoryName;
		this.childCategory = childCategory;
	}
	
	
	/**
	 * return the name of parentCategory
	 * @return string
	 */
	String getCategory(){
		return this.categoryName;
	}
	
	
	/**
	 * return the count of the child
	 * @return: int
	 */
	int getChildCategoryCount(){
		return this.childCategory;
	}
}
