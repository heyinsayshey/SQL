package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/*
 * select 구문 : ResultSet executeQuery() : select 구문만 디비에서 내용을 가져올 수 있다.
 * 그 외의 sql 구문 : int executeUpdate()
 */
public class JdbcEx3_0329 {

	public static void main(String[] args) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bigdb","scott","tiger");
		Statement stmt = conn.createStatement();
		String sql = "create table temp1 (no int, text varchar(30))";
		int result = stmt.executeUpdate(sql);
		System.out.println("temp1 테이블 생성 : " + result);
		sql = "insert into temp1 values(1,'홍길동')";//insert 되면 변경된 레코드의 갯수를 리턴함
		result = stmt.executeUpdate(sql);//1개의 레코드가 추가되었기 때문에 1이 리턴된다.
		System.out.println("temp1 레코드 insert 1: " + result);
		sql = "insert into temp1 values(2,'김삿갓')";
		result = stmt.executeUpdate(sql);
		System.out.println("temp1 레코드 insert 2: " + result);
		result = stmt.executeUpdate("update temp1 set text='임시파일'");
		System.out.println("temp1 레코드 update : " + result);//where 가 없기 때문에 2개의 레코드가 모두 변경되므로 2가 리턴된다.
		sql = "select * from temp1";
		ResultSet rs = stmt.executeQuery(sql);
		while(rs.next()) {
			System.out.print("no = "+rs.getString(1));
			System.out.println(", text = "+rs.getString(2));
		}
		sql = "drop table temp1";
		result = stmt.executeUpdate(sql);
		System.out.println("temp1 테이블 drop :" + result);//테이블이 삭제되었기 때문에 0 리턴
	}

}
