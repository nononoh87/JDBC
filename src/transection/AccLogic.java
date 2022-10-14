package transection;

//#################################################################

//	테이블명 : account
//	account_num		계좌번호		varchar2(20)
//	customer		고객명			varchar2(20)
//	amount			계좌금액		number <---int

import java.sql.*;

public class AccLogic {
	// 연결 객체 생성시 필요한 변수 선언
	String driver;
	String url;
	String user;
	String pass;

	// ===============================================
	// 드라이버를 드라이버매니저에 등록
	public AccLogic() throws Exception {
		/////////////////////////////////////////////////////////
		// 1. 드라이버를 드라이버 매니저에 등록
		Class.forName("oracle.jdbc.driver.OracleDriver");
		url = "jdbc:oracle:thin:@192.168.0.12:1521:xe";
		user = "scott";
		pass = "tiger";
	}// AccLogic

	// ====================================================
	// 보내는 계좌번호와 받는 계좌번호와 계좌금액을 넘겨받아
	// 보내는계좌에서 계좌금액을 빼고 받는계좌에서 계좌금액을 더한다
	public int moveAccount(String sendAcc, String recvAcc, int amount) {
		Connection con = null;
		PreparedStatement ps = null;
		///////////////////////////////////////////////////////////
		// 1. Connection 객체 생성
		// (연결문자열, USER, PASS) 으로 Connection 객체를 생성합니다.
		try {
			con = DriverManager.getConnection(url, user, pass);

			con.setAutoCommit(false);

			// 3. 출금계좌에서 이체금액을 뺀다
			String sqlSend = "UPDATE account SET amount = amount-? WHERE account_num=?";
			PreparedStatement psSend = con.prepareStatement(sqlSend);
			psSend.setInt(1, amount);
			psSend.setString(2, sendAcc);
			psSend.executeUpdate();
			int reSend = psSend.executeUpdate();
			if (reSend == 0) {
				return -1;
			}
			// 4. 입금계좌에 이체금액을 더한다
			String sqlRecv = "UPDATE account SET amount = amount+? WHERE account_num=?";
			PreparedStatement psRecv = con.prepareStatement(sqlSend);
			psRecv.setInt(1, amount);
			psRecv.setString(2, recvAcc);
			psRecv.executeUpdate();
			if (reSend == 0) {
				con.rollback();
				return -1;
			}
			con.commit();

		} catch (Exception ex) {
			System.out.println("이체 실패 :" + ex.getMessage());
			return -1;
		} finally {
			// 6. 닫기 (필수) : Connection 의 갯수는 사용하는 사용자의 수보다
			try {
				con.close();
			} catch (Exception ex) {
			}
		}
		// - 만일 정상적인 경우는 0 을 리턴하고 도중에 잘못되엇으면 0-1을 리턴
		return 0;
	}// moveAccount
		
	// =======================================================
	// 보내는계좌번호와 받는계좌번호를 넘겨받아
	// 필요한 정보 검색
	public void confirmAccount(String sendAcc) throws Exception {

	}

}
