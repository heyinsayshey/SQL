package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.Scanner;

public class Exam1_0329 {

	public static void main(String[] args) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bigdb","scott","tiger");
		
		while(true) {
			System.out.println("sql 구문을 입력하세요.");
			Scanner scan = new Scanner(System.in);
			String sql = scan.nextLine();
			if(sql.equals("exit")) {
				System.out.println("종료되었습니다.");
				break;
			}
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery();
				ResultSetMetaData rsmd = rs.getMetaData();
				for(int i=1;i<=rsmd.getColumnCount();i++) {
					System.out.printf("%s%4s",rsmd.getColumnLabel(i)," ");
				}
				System.out.println("\n==========================================================");
				while(rs.next()) {
					for(int i=1;i<=rsmd.getColumnCount();i++) {
						System.out.print(rs.getString(i)+"\t");
					}
					System.out.println();
				}
			}catch(Exception e) {
				System.out.println("잘못된 sql 구문입니다.");
			}
		}
		
	}

}
