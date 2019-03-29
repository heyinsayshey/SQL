package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
/*
 * PreparedPreparedStatement ��ü ����ϱ�
 * 		=> Statement �� ���� �������̽�
 * 		   Statement : ��� ���� ��ü
 * 			�� ���޽� ? �Ķ���͸� ����Ͽ� ����(�������) (�ڷ����� ������ �� �����Ƿ� Ʋ�� ���� ����)
 * 
 * Statement > PreparedStatement
 */
public class JdbcEx4_0329 {

	public static void main(String[] args) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bigdb","scott","tiger");
		
		String sql = "create table temp1 (no int, text varchar(30))";
		//PreparedStatement : db�� �����س��� ���� ���ö����� ��ٸ�.
		PreparedStatement stmt = conn.prepareStatement(sql);
		int result = stmt.executeUpdate();//�Ʊ� ������ ������ ������.
		System.out.println("temp1 ���̺� ���� : " + result);
		
		sql = "insert into temp1 values(?,?)";
		stmt = conn.prepareStatement(sql);//�����غ�
		stmt.setInt(1, 1);//(1��° ����ǥ, ��)
		stmt.setString(2, "ȫ�浿");//(2��° ����ǥ, ��)
		result = stmt.executeUpdate();//�Ķ���� ���� �� ������.
		System.out.println("temp1 ���ڵ� insert 1: " + result);
		stmt.setInt(1, 2);
		stmt.setString(2, "���");
		result = stmt.executeUpdate();
		System.out.println("temp1 ���ڵ� insert 2: " + result);
		
		sql = "update temp1 set text=?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "�ӽ�����");
		result = stmt.executeUpdate();
		System.out.println("temp1 ���ڵ� update : " + result);
		
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
		System.out.println("temp1 ���̺� drop :" + result);
	}

}
