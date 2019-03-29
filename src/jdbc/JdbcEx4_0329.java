package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
/*
 * PreparedPreparedStatement 객체 사용하기
 * 		=> Statement 의 하위 인터페이스
 * 		   Statement : 명령 전달 객체
 * 			값 전달시 ? 파라미터를 사용하여 전달(권장사항) (자료형을 지정할 수 있으므로 틀릴 일이 없음)
 * 
 * Statement > PreparedStatement
 */
public class JdbcEx4_0329 {

	public static void main(String[] args) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bigdb","scott","tiger");
		
		String sql = "create table temp1 (no int, text varchar(30))";
		//PreparedStatement : db는 번역해놓고 값이 들어올때까지 기다림.
		PreparedStatement stmt = conn.prepareStatement(sql);
		int result = stmt.executeUpdate();//아까 내려온 쿼리문 실행함.
		System.out.println("temp1 테이블 생성 : " + result);
		
		sql = "insert into temp1 values(?,?)";
		stmt = conn.prepareStatement(sql);//실행준비
		stmt.setInt(1, 1);//(1번째 물음표, 값)
		stmt.setString(2, "홍길동");//(2번째 물음표, 값)
		result = stmt.executeUpdate();//파라미터 받은 것 실행함.
		System.out.println("temp1 레코드 insert 1: " + result);
		stmt.setInt(1, 2);
		stmt.setString(2, "김삿갓");
		result = stmt.executeUpdate();
		System.out.println("temp1 레코드 insert 2: " + result);
		
		sql = "update temp1 set text=?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "임시파일");
		result = stmt.executeUpdate();
		System.out.println("temp1 레코드 update : " + result);
		
		sql = "select * from temp1";
		stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			System.out.print("no = "+rs.getString(1));
			System.out.println(", text = "+rs.getString(2));
		}
		sql = "drop table temp1";
		stmt = conn.prepareStatement(sql);
		result = stmt.executeUpdate();
		System.out.println("temp1 테이블 drop :" + result);
	}

}
