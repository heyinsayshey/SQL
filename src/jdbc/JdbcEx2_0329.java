package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/*
 * �������̺��� �о ������ȣ, �����̸�, �а��ڵ�, �޿�, ���ʽ��� ����ϱ�
 */
public class JdbcEx2_0329 {

	public static void main(String[] args) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bigdb","scott","tiger");
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("select*from professor order by 1");
		while(rs.next()) {//�ҷ��� ���̺��� ù��° ��(���ڵ�)�� rs �� �����ϰ� �ִ�.
			System.out.print("������ȣ : " + rs.getInt(1));
			System.out.print(", �����̸� : " + rs.getString("name"));
			System.out.print(", �а��ڵ� : " + rs.getString("deptno"));
			System.out.print(", �޿� : " + rs.getInt("salary"));
			System.out.print(", ���ʽ� : " + rs.getInt("bonus"));
			System.out.println(", �Ի��� : " + rs.getTimestamp("hiredate"));//��Ʈ���� ������
		}
	}

}
