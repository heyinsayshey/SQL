package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/*
 * select ���� : ResultSet executeQuery() : select ������ ��񿡼� ������ ������ �� �ִ�.
 * �� ���� sql ���� : int executeUpdate()
 */
public class JdbcEx3_0329 {

	public static void main(String[] args) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bigdb","scott","tiger");
		Statement stmt = conn.createStatement();
		String sql = "create table temp1 (no int, text varchar(30))";
		int result = stmt.executeUpdate(sql);
		System.out.println("temp1 ���̺� ���� : " + result);
		sql = "insert into temp1 values(1,'ȫ�浿')";//insert �Ǹ� ����� ���ڵ��� ������ ������
		result = stmt.executeUpdate(sql);//1���� ���ڵ尡 �߰��Ǿ��� ������ 1�� ���ϵȴ�.
		System.out.println("temp1 ���ڵ� insert 1: " + result);
		sql = "insert into temp1 values(2,'���')";
		result = stmt.executeUpdate(sql);
		System.out.println("temp1 ���ڵ� insert 2: " + result);
		result = stmt.executeUpdate("update temp1 set text='�ӽ�����'");
		System.out.println("temp1 ���ڵ� update : " + result);//where �� ���� ������ 2���� ���ڵ尡 ��� ����ǹǷ� 2�� ���ϵȴ�.
		sql = "select * from temp1";
		ResultSet rs = stmt.executeQuery(sql);
		while(rs.next()) {
			System.out.print("no = "+rs.getString(1));
			System.out.println(", text = "+rs.getString(2));
		}
		sql = "drop table temp1";
		result = stmt.executeUpdate(sql);
		System.out.println("temp1 ���̺� drop :" + result);//���̺��� �����Ǿ��� ������ 0 ����
	}

}
