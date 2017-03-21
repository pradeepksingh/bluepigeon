package org.bluepigeon.admin;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Emailer {
    private String to;
    private String from;
    private String host;
    private String subject;
    private String body;
    
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	public String getHost() {
		return host;
	}
	public void setHost(String host) {
		this.host = host;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
    
	public boolean sendEmail() {
	      Properties properties = System.getProperties();

	      Authenticator auth = new SMTPAuthenticator();
	      
	      properties.put("mail.smtp.host", "smtp.gmail.com");
	      properties.put("mail.smtp.auth", "true");
	      properties.put("mail.smtp.starttls.enable", "true");

	      Session session = Session.getInstance(properties, auth);
	      session.setDebug(false);
	      
	      try{
	         MimeMessage message = new MimeMessage(session);
	         message.setFrom(new InternetAddress("housing.edbuddy@gmail.com"));
	         message.addRecipient(Message.RecipientType.TO, new InternetAddress(this.to));
	         message.setSubject(this.subject);
	         message.setText(this.body);
	         Transport.send(message);
	         System.out.println("Sent message successfully....");
	      } catch (MessagingException mex) {
	         mex.printStackTrace();
	      }
		return true;
	}
}
