package dao;

import dto.UserDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import utils.DBUtil;

public class UserDAO {

    private static final String LOGIN = "SELECT * FROM tblUsers WHERE userID = ? AND password = ?";
    private static final String CREATE_USER = "INSERT INTO tblUsers(userID, fullName, roleID, password, phone) VALUES (?, ?, ?, ?, ?)";
    private static final String SEARCH_USER = "SELECT * FROM tblUsers WHERE userID LIKE ? OR fullName LIKE ? OR roleID LIKE ?";
    private static final String UPDATE_USER = "UPDATE tblUsers SET fullName = ?, roleID = ?, password = ? , phone = ? WHERE userID = ?";
    private static final String DELETE_USER = "DELETE FROM tblUsers WHERE userID = ?";

    private UserDTO mapUser(ResultSet rs) throws SQLException {
        return new UserDTO(rs.getString("userID"), rs.getString("fullName"), rs.getString("roleID"), rs.getString("password"), rs.getString("phone"));
    }

    public UserDTO login(String userID, String password) throws SQLException {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(LOGIN);
            ps.setString(1, userID);
            ps.setString(2, password);
            rs = ps.executeQuery();
            if (rs.next()) {
                String fullName = rs.getString("fullName");
                String roleID = rs.getString("roleID");
                String phone = rs.getString("phone");
                user = new UserDTO(userID, fullName, roleID, password, phone);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (rs != null) {
                rs.close();
            }
        }
        return user;
    }

    public void createUser(UserDTO user) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(CREATE_USER);
            ps.setString(1, user.getUserID());
            ps.setString(2, user.getFullName());
            ps.setString(3, user.getRoleID());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getPhone());
            ps.executeUpdate(); // gửi đơn hàng xuống data
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
            if (ps != null) {
                ps.close();
            }
        }
    }

    public ArrayList<UserDTO> searchUser(String keyword) throws SQLException {
        Connection conn = null;
        ArrayList<UserDTO> userList = new ArrayList<UserDTO>();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(SEARCH_USER);
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ps.setString(3, "%" + keyword + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                userList.add(mapUser(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }

    public boolean updateUser(UserDTO user) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(UPDATE_USER);
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getRoleID());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getUserID());
            System.out.println(ps.executeUpdate() > 0);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }

    public boolean deleteUser(String userID) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(DELETE_USER);
            ps.setString(1, userID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public UserDTO getUserById(String id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM tblUsers WHERE userID = ?";
        try ( Connection conn = DBUtil.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<UserDTO> getAllUsers() throws Exception {
        ArrayList<UserDTO> userList = new ArrayList<UserDTO>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection(); // chỗ này tuỳ theo project bạn lấy connection sao
            String sql = "select * from tblUsers";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                userList.add(mapUser(rs));
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return userList;
    }

    public boolean updateUserRoleID(String userID, String newRoleID) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        String sql = "UPDATE tblUsers SET roleID = ? WHERE userID = ?";
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, newRoleID);
            ps.setString(2, userID);
            System.out.println(userID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    public UserDTO checkUserIDAndPhone(String userID, String phone) throws Exception {
        String sql = "SELECT fullName, roleID  FROM tblUsers WHERE userID = ? AND phone = ?";
        try ( Connection conn = DBUtil.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userID);
            ps.setString(2, phone);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new UserDTO(userID, rs.getString("fullName"), rs.getString("roleID"), "", phone);
            }
        }
        return null;
    }

    public boolean updatePassword(String userID, String newPassword) throws SQLException {
        String sql = "UPDATE tblUsers SET password = ? WHERE userID = ?";
        try ( Connection conn = DBUtil.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword); // Có thể mã hoá bằng BCrypt nếu muốn
            ps.setString(2, userID);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean checkUserExists(String userID) {
    boolean exists = false;
    String sql = "SELECT userID FROM tblUsers WHERE userID = ?";
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, userID);
        try (ResultSet rs = ps.executeQuery()) {
            exists = rs.next(); // nếu có dòng => tồn tại
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return exists;
}


}
