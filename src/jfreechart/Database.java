package jfreechart;

import java.sql.*;
import java.util.*;

public class Database {

	String URL = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
	String USER ="scott";
	String PASS = "tiger";

	public ArrayList<ArrayList> getData() {

		ArrayList<ArrayList> data = new ArrayList<ArrayList>();
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection(URL, USER , PASS);	
			
			//***************************************************************
			String sql = "SELECT nvl(job, '미정') 업무, round(avg(sal)) 평균월급  "
					+ "FROM emp  "
					+ "GROUP BY job";
			//***************************************************************
			//String sql =" SELECT ename, nvl(sal, 0)"
			//		+"FROM (SELECT ename, nvl(sal, 0) sal FROM emp ORDER BY SAL desc)"
			//		+"WHERE rownum < 11";
			
			PreparedStatement stmt = con.prepareStatement( sql );	

			ResultSet rset = stmt.executeQuery();

			
			while( rset.next() ){
				ArrayList temp = new ArrayList();
				temp.add( rset.getInt("SAL"));				//****************
				temp.add( rset.getString("ENAME"));		//****************		
				data.add(temp);
			}
			rset.close();
			stmt.close();
			con.close();
		} catch(Exception ex){
			System.out.println("에러 : " + ex.getMessage() );
		}
		return data;
	}
}
