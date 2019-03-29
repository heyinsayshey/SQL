package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/*
 * jdbc
 * 1. java.sql 패키지
 * 2. mariadb 드라이버 선택하기
 * 		class.forName("org.mariadb.jdbc.Driver")
 * 3. 연결을 위한 url 설정 
 * 4. Statement 객체를 통해 명령어 전달
 * 5. ResultSet 객체를 통해 결과 받기
 */
public class JdbcEx1_0329 {

	public static void main(String[] args) throws Exception {
		//드라이버 설정하기 : 드라이버 클래스를 클래스영역에 로드함.
		Class.forName("org.mariadb.jdbc.Driver");//이름을 가진 클래스를 찾아서 메모리에 올려놓아라. 
		//Connection 객체 생성하기 : 
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bigdb","scott","tiger");
		//Statement : sql 명령 전달 객체 
		Statement stmt = conn.createStatement();
		//ResultSet : select 구문을 실행한 결과 저장
		//executeQuery : sql 명령 실행
		ResultSet rs = stmt.executeQuery("select * from student");
		while(rs.next()) {//읽어낸 레코드 1개를 리턴
			System.out.print("학번 : " + rs.getString("studno"));
			System.out.print(", 이름 : " + rs.getString("name"));
			System.out.print(", 학년 : " + rs.getString("grade"));
			System.out.print(", 전공코드 : " + rs.getString("major1"));
			System.out.println(", 지도교수 : " + rs.getString("profno"));
		}
	}

}
