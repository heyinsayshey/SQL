package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

/*
 * �л��� �й�, �̸�, Ű, ������, �ڱ� �г��� �ִ� Ű, ���Ű, �ִ� ������, ��ո����Ը� ����ϱ�.
 */
public class JdbcEx6_0329 {

	public static void main(String[] args) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bigdb","scott","tiger");
		String sql = "select s.studno �й�, s.grade �г�, s.name �л��̸�, s.height Ű, s.weight ������, a.max_h '�г��� �ִ� Ű', a.avg_h '�г��� ��� Ű', a.max_w '�г��� �ִ� ������', a.avg_w '�г��� ��� ������'  "
				+" from student s, (select grade, max(height) max_h, avg(height) avg_h, max(weight) max_w, avg(weight) avg_w from student group by grade) a "
				+ " where s.grade=a.grade"
				+ " order by s.grade ";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		ResultSetMetaData rsmd = rs.getMetaData();
		for(int i=1;i<=rsmd.getColumnCount();i++) {
			System.out.printf("%s%4s",rsmd.getColumnLabel(i)," ");
		}
		System.out.println("\n======================================================================");
		while(rs.next()) {
			for(int i=1;i<=rsmd.getColumnCount();i++) {
				System.out.print(rs.getString(i)+"\t");
			}
			System.out.println();
		}
		
	}

}
