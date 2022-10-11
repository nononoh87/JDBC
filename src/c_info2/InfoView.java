package c_info2;

import java.awt.*; // awt 패키지 전부 : *
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.swing.*; // swing 패키지 전부 : *

public class InfoView {

//	1. 멤버 변수 선언
	JFrame f;
	JTextField tfName, tfId, tfTel, tfGender, tfAge, tfHome;
	JTextArea ta;
	JButton bAdd, bShow, bSearch, bDelete, bCancel, bExit;
	ImageIcon image;

	// 비지니스로직 - 모델단
	InfoModel model;

//	2. 멤버 변수 객체생성
	InfoView() {
		// 타이틀
		f = new JFrame("DBTest");

		// 동쪽 입력값
		tfName = new JTextField(20);
		tfId = new JTextField(20);
		tfTel = new JTextField(20);
		tfGender = new JTextField(20);
		tfAge = new JTextField(20);
		tfHome = new JTextField(20);

		// 남쪽 버튼창
		bAdd = new JButton("Name");

		bShow = new JButton("Show (alt+s)", new ImageIcon("src\\b_info2\\imgs\\4.PNG"));
		bShow.setHorizontalTextPosition(JButton.CENTER); // LEFT - 왼쪽 / CENTER - 가운데 / RIGHT - 오른쪽
		bShow.setVerticalTextPosition(JButton.BOTTOM); // TOP - 상 / CENTER - 가운데 / BOTTOM - 하
		bShow.setMnemonic('s');

		bSearch = new JButton("Search");

		bDelete = new JButton("Delate");
		bCancel = new JButton("Cancel");
		bExit = new JButton("수정하기 (alt+x)", new ImageIcon("src\\b_info2\\imgs\\3.PNG")); // ImageIcon => Icon의 자식 클래스 :
																							// 이미지 객체 생성 후 이미지 소스 경로 입력
		bExit.setHorizontalTextPosition(JButton.CENTER); // 텍스트 위치를 수평으로
		bExit.setVerticalTextPosition(JButton.BOTTOM); // 텍스트 위치를 수직으로
		bExit.setRolloverIcon(new ImageIcon("src\\b_info2\\imgs\\1.PNG")); // 마우스 커서 갖다댈시에 이미지 변경 효과
		bExit.setPressedIcon(new ImageIcon("src\\b_info2\\imgs\\2.PNG")); // 마우스 클릭시에 이미지 변경되는 효과
		bExit.setToolTipText("프로그램을 종료하겠습니다."); // 마우스 커서 갖다댈시 말풍선 삽입
		bExit.setMnemonic('x'); // 단축키 지정

		// center 입력창
		ta = new JTextArea(40, 20);

		// 모델객체 생성
		try {
			model = new InfoModelImpl();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

//	3. 화면 구성하고 출력
	/*
	 * 전체 프레임은 BorderLayout 지정 - West : JPanel 붙이기 (GridLayout(6,2)) - Center :
	 * 텍스트에어리어 - South : JPanel 붙이기 Button (GridLayout(1,6))
	 * 
	 */
	public void addLayout() {
		f.setLayout(new BorderLayout());

		JPanel tfWest = new JPanel();
		tfWest.setLayout(new GridLayout(6, 2));
		tfWest.add(new JLabel("Name", JLabel.CENTER));
		tfWest.add(tfName);
		tfWest.add(new JLabel("ID", JLabel.CENTER));
		tfWest.add(tfId);
		tfWest.add(new JLabel("Tel", JLabel.CENTER));
		tfWest.add(tfTel);
		tfWest.add(new JLabel("Sex", JLabel.CENTER));
		tfWest.add(tfGender);
		tfWest.add(new JLabel("Age", JLabel.CENTER));
		tfWest.add(tfAge);
		tfWest.add(new JLabel("Home", JLabel.CENTER));
		tfWest.add(tfHome);
		f.add(tfWest, BorderLayout.WEST);

		f.add(ta, BorderLayout.CENTER); // 가운데 입력값

		JPanel bSouth = new JPanel();
		bSouth.setLayout(new GridLayout(1, 2));
		bSouth.add(bAdd);
		bSouth.add(bShow);
		bSouth.add(bSearch);
		bSouth.add(bDelete);
		bSouth.add(bCancel);
		bSouth.add(bExit);
		f.add(bSouth, BorderLayout.SOUTH);

		// 화면 출력
		f.setBounds(300, 300, 900, 400); // 화면 출력 크기 (가로/세로 길이) 설정
		f.setVisible(true); // 화면에 나타나게 해줌. (출력)
		f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); // JFrame.EXIT_ON_CLOSE : X 창 클릭시 실행 종료 , 존재하지 않을시 창은 없어지나 실행은
		f.setTitle("DBTest");

	}

	void eventProc() {
		bAdd.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				insertData();
			}
		});

		bShow.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				selectAll();
			}
		});

		// bSearch 버트이 눌렸을때
		bSearch.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				selectByTel();
			}
		});
		tfTel.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				selectByTel();
			}
		});
		bDelete.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				deleteByTel();
			}
		});
		bExit.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				ModifyByTel();
				selectAll(); // 바로 수정된것이 바로 보이게끔함.
			}
		});
		
	}// eventProc()
	void ModifyByTel() {
		// (1) 사용자 입력값 얻어오기
		String name = tfName.getText();
		String id = tfId.getText();
		String tel = tfTel.getText();
		String gender = tfGender.getText();
		int age = Integer.parseInt(tfAge.getText());
		String home = tfHome.getText();
		
		
		// (2) 모델단에 ModifyByTel() 호출
		InfoVO vo = new InfoVO(name, id, tel, gender, age, home);
		vo.setName(name);
		vo.setId(id);
		vo.setTel(tel);
		vo.setGender(gender);
		vo.setAge(age);
		vo.setHome(home);
		
		try {			
			model.modify(vo);
			
		// (3) 화면을 지우고
			clearText();
		} catch (SQLException e) {
			ta.setText("수정 실패 :" + e.getMessage());
			//e.printStackTrace();
		}
	}

	void deleteByTel() {
		// (1) 입력한 전화번화값 얻어오기
		String tel = tfTel.getText();
		// (2) 모델단에 deleteByTel() 호출
		try {
			int res = model.delete(tel);
			// (3) 화면을 지우고
			ta.setText(res + "delete --");
			clearText();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	void selectByTel() {
		try {
			// (1) 입력한 전화번호 값을 얻어오기
			String tel = tfTel.getText();
			// (2) 모델단에 selectByTel() 호출
			InfoVO vo = model.selectByTel(tel);
			// (3) 받은 결과를 각각의 텍스트 필드에 지정 (출력)
			tfName.setText(vo.getName());
			
			tfId.setText(vo.getId());
			tfTel.setText(vo.getTel());
			tfGender.setText(vo.getGender());
			tfAge.setText(String.valueOf(vo.getAge()));
			tfHome.setText(vo.getHome());
		} catch (Exception ex) {
			ta.setText("전화번호를 검색 실패 :" + ex.getMessage());
			ex.printStackTrace();
		}
	}

	void selectAll() {
		try {
			ArrayList<InfoVO> data = model.selectAll();
			ta.setText("----검색결과---- \n\n");
			for (InfoVO vo : data) {
				ta.append(vo.toString());
			}
		} catch (SQLException e) {
			ta.setText("검색실패 :" + e.getMessage());
		}
	}

	void insertData() {
		// (1) 사용자입력값 얻어오기
		String name = tfName.getText();
		String id = tfId.getText();
		String tel = tfTel.getText();
		String gender = tfGender.getText();
		int age = Integer.valueOf(tfAge.getText());
		String home = tfHome.getText();
		// (2) 1번의 값들을 InfoVO에 지정 - (1) 생성자 (2) setter
		InfoVO vo = new InfoVO();

		vo.setName(name);
		vo.setId(id);
		vo.setTel(tel);
		vo.setGender(gender);
		vo.setAge(age);
		vo.setHome(home);

		// (3) 모델의 InsertInfo() 호출
		try {
			model.insertInfo(vo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// (4) 화면의 입력값을 지우기
		clearText();
	}

	void clearText() {
		tfName.setText(null);
		tfId.setText(null);
		tfTel.setText(null);
		tfGender.setText(null);
		tfAge.setText(null);
		tfHome.setText(null);
	}

	public static void main(String[] args) {
		InfoView info = new InfoView();
		info.addLayout();
		info.eventProc();
	}

}