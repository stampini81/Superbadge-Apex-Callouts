@isTest
private class TestVerifyDate {
    
    @isTest static void testDateWithin30Days() {
        Date d1 = Date.today();
        Date d2 = d1.addDays(10);
        Date result = VerifyDate.CheckDates(d1, d2);
        System.assertEquals(d2, result);
    }
    
    @isTest static void testDateMoreThan30Days() {
        Date d1 = Date.newInstance(2025, 1, 1);
        Date d2 = Date.newInstance(2025, 2, 5); // Mais de 30 dias
        Date result = VerifyDate.CheckDates(d1, d2);
        // O esperado é o último dia de Janeiro (2025-01-31)
        System.assertEquals(Date.newInstance(2025, 1, 31), result);
    }
}