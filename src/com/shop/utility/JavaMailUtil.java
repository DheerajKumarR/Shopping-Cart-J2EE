package com.shop.utility;

import java.io.File;
import java.util.Properties;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Multipart;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;

import jakarta.activation.DataHandler;
import jakarta.activation.DataSource;
import jakarta.activation.FileDataSource;


public class JavaMailUtil {

    // ---------------- Existing Methods ----------------

    public static void sendMail(String recipientMailId) throws MessagingException {
        System.out.println("Preparing to send Mail");
        Properties properties = new Properties();
        String host = "smtp.gmail.com";
        properties.put("mail.smtp.host", host);
        properties.put("mail.transport.protocol", "smtp");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.port", "587");

        ResourceBundle rb = ResourceBundle.getBundle("application");
        String emailId = rb.getString("mailer.email");
        String passWord = rb.getString("mailer.password");

        properties.put("mail.user", emailId);
        properties.put("mail.password", passWord);

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(emailId, passWord);
            }
        });

        Message message = prepareMessage(session, emailId, recipientMailId);
        Transport.send(message);
        System.out.println("Message Sent Successfully!");
    }

    private static Message prepareMessage(Session session, String myAccountEmail, String recipientEmail) {
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(myAccountEmail));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
            message.setSubject("Welcome to Ellison Electronics");
            message.setText("Hey! " + recipientEmail + ", Thanks for Signing Up with us!");
            return message;
        } catch (Exception exception) {
            Logger.getLogger(JavaMailUtil.class.getName()).log(Level.SEVERE, null, exception);
        }
        return null;
    }

    protected static void sendMail(String recipient, String subject, String htmlTextMessage) throws MessagingException {
        System.out.println("Preparing to send Mail");
        Properties properties = new Properties();
        String host = "smtp.gmail.com";
        properties.put("mail.smtp.host", host);
        properties.put("mail.transport.protocol", "smtp");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.port", "587");

        ResourceBundle rb = ResourceBundle.getBundle("application");
        String emailId = rb.getString("mailer.email");
        String passWord = rb.getString("mailer.password");

        properties.put("mail.user", emailId);
        properties.put("mail.password", passWord);

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(emailId, passWord);
            }
        });

        Message message = prepareMessage(session, emailId, recipient, subject, htmlTextMessage);
        Transport.send(message);
        System.out.println("Message Sent Successfully!");
    }

    private static Message prepareMessage(Session session, String myAccountEmail, String recipientEmail,
            String subject, String htmlTextMessage) {
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(myAccountEmail));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
            message.setSubject(subject);
            message.setContent(htmlTextMessage, "text/html");
            return message;
        } catch (Exception exception) {
            Logger.getLogger(JavaMailUtil.class.getName()).log(Level.SEVERE, null, exception);
        }
        return null;
    }

    // ---------------- New Method for Attachment ----------------

    /**
     * Sends an email with an HTML body and a file attachment (e.g., PDF invoice).
     *
     * @param recipient       Recipient's email address
     * @param subject         Subject line
     * @param htmlTextMessage HTML formatted body
     * @param attachmentPath  Full file path to the attachment
     * @throws MessagingException if sending fails
     */
    public static void sendMailWithAttachment(String recipient, String subject,
                                              String htmlTextMessage, String attachmentPath) throws MessagingException {

        System.out.println("Preparing to send Mail with attachment...");
        Properties properties = new Properties();
        String host = "smtp.gmail.com";
        properties.put("mail.smtp.host", host);
        properties.put("mail.transport.protocol", "smtp");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.port", "587");

        ResourceBundle rb = ResourceBundle.getBundle("application");
        String emailId = rb.getString("mailer.email");
        String passWord = rb.getString("mailer.password");

        properties.put("mail.user", emailId);
        properties.put("mail.password", passWord);

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(emailId, passWord);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(emailId));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
            message.setSubject(subject);

            // Body part (HTML message)
            MimeBodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setContent(htmlTextMessage, "text/html");

         // Attachment part
            MimeBodyPart attachmentPart = new MimeBodyPart();
            File file = new File(attachmentPath);
            if (file.exists()) {
                DataSource source = new FileDataSource(file);
                attachmentPart.setDataHandler(new DataHandler(source));
                attachmentPart.setFileName(file.getName());
            } else {
                System.err.println("⚠ Attachment file not found: " + attachmentPath);
            }


            // Combine both parts
            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(messageBodyPart);
            if (file.exists()) {
                multipart.addBodyPart(attachmentPart);
            }

            message.setContent(multipart);

            Transport.send(message);
            System.out.println("✅ Mail with attachment sent successfully to " + recipient);

        } catch (Exception e) {
            Logger.getLogger(JavaMailUtil.class.getName()).log(Level.SEVERE, null, e);
            throw new MessagingException("Failed to send mail with attachment: " + e.getMessage());
        }
    }
}
