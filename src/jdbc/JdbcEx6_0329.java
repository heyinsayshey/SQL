package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

/*
 * 학생의 학번, 이름, 키, 몸무게, 자기 학년의 최대 키, 평균키, 최대 몸무게, 평균몸무게를 출력하기.
 */
public class JdbcEx6_0329 {

	public static void main(String[] args) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bigdb","scott","tiger");
		String sql = "select s.studno 학번, s.grade 학년, s.name 학생이름, s.height 키, s.weight 몸무게, a.max_h '학년의 최대 키', a.avg_h '학년의 평균 키', a.max_w '학년의 최대 몸무게', a.avg_w '학년의 평균 몸무게'  "
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
