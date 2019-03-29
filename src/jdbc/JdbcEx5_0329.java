package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

public class JdbcEx5_0329 {

	public static void main(String[] args) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bigdb","scott","tiger");
		PreparedStatement pstmt = conn.prepareStatement("select * from dept");
		ResultSet rs = pstmt.executeQuery();
		//ResultSetMetaData : ��ȸ�� ���̺��� (�÷��� ����) ���� ����
		ResultSetMetaData rsmd = rs.getMetaData();
		for(int i=1;i<=rsmd.getColumnCount();i++) {//1���� �����ϴ� �� ����.
			System.out.print(rsmd.getColumnName(i)+"\t");
		}
		System.out.println("\n==========================");
		while(rs.next()) {
			for(int i=1;i<=rsmd.getColumnCount();i++) {
				System.out.print(rs.getString(i)+"\t");
			}
			System.out.println();
		}
	}

}
