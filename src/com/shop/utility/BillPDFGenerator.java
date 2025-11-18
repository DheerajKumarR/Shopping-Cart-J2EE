package com.shop.utility;

import java.io.FileOutputStream;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

public class BillPDFGenerator {

    public static void generateBillPDF(String filePath, String customerName, String transId, double transAmount)
            throws Exception {

        Document document = new Document();
        PdfWriter.getInstance(document, new FileOutputStream(filePath));
        document.open();

        // Header
        Font titleFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, new BaseColor(46, 139, 87));
        Paragraph title = new Paragraph("Electronics Store - Order Invoice", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setSpacingAfter(20);
        document.add(title);

        // Customer info
        Font boldFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
        document.add(new Paragraph("Customer Name: " + customerName, boldFont));
        document.add(new Paragraph("Transaction ID: " + transId, boldFont));
        document.add(new Paragraph("------------------------------------------------------------"));
        document.add(new Paragraph(" "));

        // Table
     // Base amount (transAmount passed to method)
        double gst = 0.09 * transAmount;      // 9% GST
        double sgst = 0.09 * transAmount;     // 9% SGST
        double shippingCharge = 250.00;       // Fixed shipping
        double discount = 100.00;             // Fixed discount

        // Compute total payable
        double totalPayable = transAmount + gst + sgst + shippingCharge - discount;

        // Create the table
        PdfPTable table = new PdfPTable(2);
        table.setWidthPercentage(100);

        // Header row
        table.addCell("Description");
        table.addCell("Amount (₹)");

        // Purchased items
        table.addCell("Purchased Electronics Item(s)");
        table.addCell(String.format("%.2f", transAmount));

        // GST
        table.addCell("GST (9%)");
        table.addCell(String.format("%.2f", gst));

        // SGST
        table.addCell("SGST (9%)");
        table.addCell(String.format("%.2f", sgst));

        // Shipping
        table.addCell("Shipping Charges");
        table.addCell(String.format("%.2f", shippingCharge));

        // Discount
        table.addCell("Discount");
        table.addCell(String.format("-%.2f", discount));

        // Divider (for spacing)
        table.addCell("");
        table.addCell("");

        // Total payable
        Font boldFont1 = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
        PdfPCell totalLabel = new PdfPCell(new Phrase("Total Payable Amount", boldFont1));
        PdfPCell totalValue = new PdfPCell(new Phrase("₹" + String.format("%.2f", totalPayable), boldFont1));
        totalLabel.setBorder(Rectangle.TOP);
        totalValue.setBorder(Rectangle.TOP);
        table.addCell(totalLabel);
        table.addCell(totalValue);

        document.add(table);
        document.add(new Paragraph(" "));


        // Footer note
        Paragraph note = new Paragraph(
                "\nThank you for shopping with Electronics Store!\nThis is a computer-generated invoice.",
                new Font(Font.FontFamily.HELVETICA, 11, Font.ITALIC, BaseColor.GRAY));
        note.setAlignment(Element.ALIGN_CENTER);
        document.add(note);

        document.close();
    }
}
