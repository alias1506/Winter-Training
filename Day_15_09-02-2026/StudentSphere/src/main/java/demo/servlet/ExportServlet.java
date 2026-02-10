package demo.servlet;

import demo.dal.StudentDAL;
import demo.model.Student;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/export-students")
public class ExportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        StudentDAL dal = new StudentDAL();

        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Students");

            // Create Header Row
            Row headerRow = sheet.createRow(0);
            String[] columns = { "S.No", "Name", "Roll No", "Registration No", "Email", "Phone", "Stream", "Semester" };

            CellStyle headerCellStyle = workbook.createCellStyle();
            headerCellStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
            headerCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerCellStyle.setFont(headerFont);

            for (int i = 0; i < columns.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(columns[i]);
                cell.setCellStyle(headerCellStyle);
            }

            // Fill Data Rows
            List<Student> students = dal.getAllStudents();
            int rowNum = 1;
            int serialNo = 1;
            for (Student s : students) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(serialNo++);
                row.createCell(1).setCellValue(s.getName());
                row.createCell(2).setCellValue(s.getRollNo());
                row.createCell(3).setCellValue(s.getRegistrationNo());
                row.createCell(4).setCellValue(s.getEmail());
                row.createCell(5).setCellValue(s.getPhone());
                row.createCell(6).setCellValue(s.getStream());
                row.createCell(7).setCellValue(s.getSemester());
            }

            // Auto-size columns
            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }

            // Prepare Response
            String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss"));
            String fileName = "ExportedStudentsData_" + timestamp + ".xlsx";

            resp.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            resp.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

            workbook.write(resp.getOutputStream());
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error generating Excel file: " + e.getMessage());
        }
    }
}
