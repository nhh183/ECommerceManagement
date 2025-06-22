package dao;

import dto.CustomerCaresDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import utils.DBUtil;

public class CustomerCaresDAO {

    private static final String CREATE_TICKET = "INSERT INTO tblCustomerCares (userID, subject, content, status) VALUES (?, ?, ?, 'new')";
    private static final String GET_TICKETS_BY_STATUS = "SELECT ticketID, userID, subject, content, status, reply FROM tblCustomerCares WHERE status = ?";
    private static final String GET_TICKETS_BY_USERID = "SELECT ticketID, userID, subject, content, status, reply FROM tblCustomerCares WHERE userID = ?";
    private static final String UPDATE_REPLY = "UPDATE tblCustomerCares SET reply = ?, status = 'answered' WHERE ticketID = ?";


    public boolean insert(CustomerCaresDTO ticket) throws Exception {
        boolean result = false;
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(CREATE_TICKET);
            ps.setString(1, ticket.getUserID());
            ps.setString(2, ticket.getSubject());
            ps.setString(3, ticket.getContent());
            result = ps.executeUpdate() > 0;
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return result;
    }

    public ArrayList<CustomerCaresDTO> getTicketsByStatus(String status) throws Exception {
        ArrayList<CustomerCaresDTO> tickets = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(GET_TICKETS_BY_STATUS);
            ps.setString(1, status);
            rs = ps.executeQuery();
            while (rs.next()) {
                tickets.add(new CustomerCaresDTO(
                    rs.getInt("ticketID"),
                    rs.getString("userID"),
                    rs.getString("subject"),
                    rs.getString("content"),
                    rs.getString("status"),
                    rs.getString("reply")
                ));
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return tickets;
    }


    public ArrayList<CustomerCaresDTO> getTicketsByUserID(String userID) throws Exception {
        ArrayList<CustomerCaresDTO> tickets = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(GET_TICKETS_BY_USERID);
            ps.setString(1, userID);
            rs = ps.executeQuery();
            while (rs.next()) {
                tickets.add(new CustomerCaresDTO(
                    rs.getInt("ticketID"),
                    rs.getString("userID"),
                    rs.getString("subject"),
                    rs.getString("content"),
                    rs.getString("status"),
                    rs.getString("reply")
                ));
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return tickets;
    }

    public boolean reply(int ticketID, String reply) throws Exception {
        boolean result = false;
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(UPDATE_REPLY);
            ps.setString(1, reply);
            ps.setInt(2, ticketID);
            result = ps.executeUpdate() > 0;
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return result;
    }
}