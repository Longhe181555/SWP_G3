/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
//1111111111111111111111
/**
 *
 * @author sonnt
 */
public class DateTimeHelper {

    public static Date getWeekStart(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK) - calendar.getFirstDayOfWeek();
        calendar.add(Calendar.DAY_OF_MONTH, -dayOfWeek);
        return calendar.getTime();
    }

    public static java.sql.Date convertUtilDateToSqlDate(java.util.Date utilDate) {
        if (utilDate != null) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(utilDate);
            calendar.set(Calendar.HOUR_OF_DAY, 0);
            calendar.set(Calendar.MINUTE, 0);
            calendar.set(Calendar.SECOND, 0);
            calendar.set(Calendar.MILLISECOND, 0);
            return new java.sql.Date(calendar.getTimeInMillis());
        } else {
            return null;
        }
    }

    public static Date addDaysToDate(Date date, int days) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DAY_OF_YEAR, days);
        return calendar.getTime();
    }
    public static int getCurrentYear() {
        Calendar calendar = Calendar.getInstance();
        return calendar.get(Calendar.YEAR);
    }

    public static ArrayList<String> generateYearlyLabels() {
        ArrayList<String> yearlyLabels = new ArrayList<>();
        int currentYear = getCurrentYear();

        for (int i = -2; i <= 1; i++) {
            yearlyLabels.add(String.valueOf(currentYear + i));
        }

        return yearlyLabels;
    }


    public static ArrayList<java.sql.Date> getListBetween(Date from, Date to) {
        ArrayList<java.sql.Date> dates = new ArrayList<>();
        Date temp = from;
        while (!temp.after(to)) {
            dates.add(convertUtilDateToSqlDate(temp));
            temp = addDaysToDate(temp, 1);
        }
        return dates;
    }

    public static java.util.Date convertSqlDateToUtilDate(java.sql.Date sqlDate) {
        return sqlDate != null ? new java.util.Date(sqlDate.getTime()) : null;
    }

}
