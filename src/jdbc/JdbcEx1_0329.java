package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/*
 * jdbc
 * 1. java.sql ��Ű��
 * 2. mariadb ����̹� �����ϱ�
 * 		class.forName("org.mariadb.jdbc.Driver")
 * 3. ������ ���� url ���� 
 * 4. Statement ��ü�� ���� ��ɾ� ����
 * 5. ResultSet ��ü�� ���� ��� �ޱ�
 */
public class JdbcEx1_0329 {

	public static void main(String[] args) throws Exception {
		//����̹� �����ϱ� : ����̹� Ŭ������ Ŭ���������� �ε���.
		Class.forName("org.mariadb.jdbc.Driver");//�̸��� ���� Ŭ������ ã�Ƽ� �޸𸮿� �÷����ƶ�. 
		//Connection ��ü �����ϱ� : 
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bigdb","scott","tiger");
		//Statement : sql ��� ���� ��ü 
		Statement stmt = conn.createStatement();
		//ResultSet : select ������ ������ ��� ����
		//executeQuery : sql ��� ����
		ResultSet rs = stmt.executeQuery("select * from student");
		while(rs.next()) {//�о ���ڵ� 1���� ����
			System.out.print("�й� : " + rs.getString("studno"));
			System.out.print(", �̸� : " + rs.getString("name"));
			System.out.print(", �г� : " + rs.getString("grade"));
			System.out.print(", �����ڵ� : " + rs.getString("major1"));
			System.out.println(", �������� : " + rs.getString("profno"));
		}
	}

}
