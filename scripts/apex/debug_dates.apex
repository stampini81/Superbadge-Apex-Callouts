
        Date today = Date.today();
        
        Integer currentYear = today.year();
        Integer currentMonth = today.month();
        
        Integer previousQuarterStartMonth = ((currentMonth - 1) / 3) * 3 + 1 - 3;
        
        if (previousQuarterStartMonth <= 0) {
            previousQuarterStartMonth += 12;
            currentYear--;
        }
        
        Date previousQuarterStartDate = Date.newInstance(currentYear, previousQuarterStartMonth, 1);
        Date previousQuarterEndDate = previousQuarterStartDate.addMonths(3).addDays(-1);

        System.debug('Today: ' + today);
        System.debug('Start Date: ' + previousQuarterStartDate);
        System.debug('End Date: ' + previousQuarterEndDate);

        // Check if Oct 15, 2025 is inside
        Date testDate = Date.newInstance(2025, 10, 15);
        if (testDate >= previousQuarterStartDate && testDate <= previousQuarterEndDate) {
            System.debug('Test Date IS inside range');
        } else {
            System.debug('Test Date IS OUTSIDE range');
        }
