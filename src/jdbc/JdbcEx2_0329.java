package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/*
 * 교수테이블을 읽어서 교수번호, 교수이름, 학과코드, 급여, 보너스를 출력하기
 */
public class JdbcEx2_0329 {

	public static void main(String[] args) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bigdb","scott","tiger");
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("select*from professor order by 1");
		while(rs.next()) {//불러온 테이블에서 첫번째 행(레코드)을 rs 가 참조하고 있다.
			System.out.print("교수번호 : " + rs.getInt(1));
			System.out.print(", 교수이름 : " + rs.getString("name"));
			System.out.print(", 학과코드 : " + rs.getString("deptno"));
			System.out.print(", 급여 : " + rs.getInt("salary"));
			System.out.print(", 보너스 : " + rs.getInt("bonus"));
			System.out.println(", 입사일 : " + rs.getTimestamp("hiredate"));//스트링도 가능함
		}
	}

}
