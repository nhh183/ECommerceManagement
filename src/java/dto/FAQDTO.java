/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

/**
 *
 * @author User
 */
public class FAQDTO {
    private int faqID;
    private String question;
    private String answer;
    private String status;

    public FAQDTO() {
    }

    public FAQDTO(int faqID, String question, String answer, String status) {
        this.faqID = faqID;
        this.question = question;
        this.answer = answer;
        this.status = status;
    }

    public FAQDTO(String question, String answer, String status) {
        this.question = question;
        this.answer = answer;
        this.status = status;
    }

    public int getFaqID() {
        return faqID;
    }

    public void setFaqID(int faqID) {
        this.faqID = faqID;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}
