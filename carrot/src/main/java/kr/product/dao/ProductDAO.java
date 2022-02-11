package kr.product.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.product.vo.CategoryVO;
import kr.product.vo.ProductVO;
import kr.util.DBUtil;

public class ProductDAO {
	//싱글턴 패턴
	private static ProductDAO instance = new ProductDAO();
	public static ProductDAO getInstance() {
		return instance;
	}
	private ProductDAO() {}

	//상품등록
	public void registerProduct(ProductVO product)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "INSERT INTO aproduct (Aproduct_num,Amember_num,photo1,photo2,photo3,photo4,photo5,"
					+ "title,price,content,category,nickname,reg_date) VALUES(aproduct_seq.nextval,?,?,?,?,?,?,?,?,?,?,?,SYSDATE)";			    
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, product.getAproduct_num());
			pstmt.setInt(2, product.getAmember_num());
			pstmt.setString(3, product.getPhoto1());
			pstmt.setString(4, product.getPhoto2());
			pstmt.setString(5, product.getPhoto3());
			pstmt.setString(6, product.getPhoto4());
			pstmt.setString(7, product.getPhoto5());
			pstmt.setString(8, product.getTitle());
			pstmt.setInt(9, product.getPrice());
			pstmt.setString(10, product.getContent());
			pstmt.setInt(11, product.getCategory());
			pstmt.setString(12, product.getNickname());

			//SQL문 실행
			pstmt.executeUpdate();

		}catch(Exception e){
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//목록
	//상품상세정보
	//상품수정
	public void updateProduct(ProductVO product)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "UPDATE aproduct SET Photo1=?, Photo2=?, Photo3=?, Photo4=?, "
					+ "Photo5=?, Title=?, Price=?, Content=?, Category=?  WHERE Aproduct_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터를 바인딩
			pstmt.setString(1, product.getPhoto1());
			pstmt.setString(2, product.getPhoto2());
			pstmt.setString(3, product.getPhoto3());
			pstmt.setString(4, product.getPhoto4());
			pstmt.setString(5, product.getPhoto5());
			pstmt.setString(6, product.getTitle());
			pstmt.setInt(7, product.getPrice());
			pstmt.setString(8, product.getContent());
			pstmt.setInt(9, product.getCategory());
			pstmt.setInt(10, product.getAproduct_num());

			//SQL문 실행
			pstmt.executeUpdate();

		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);

		}
	}
	//상품삭제


	// 카테고리 목록
	public List<CategoryVO> getListCategory() throws Exception {
		List<CategoryVO> list = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM acategory ORDER BY category";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			list = new ArrayList<CategoryVO>();
			while(rs.next()) {
				CategoryVO vo = new CategoryVO();
				vo.setCategory(rs.getInt("category"));
				vo.setName(rs.getString("name"));
				list.add(vo);
			}
		}
		catch(Exception e) {
			throw new Exception(e);
		}
		finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;
	}
}
