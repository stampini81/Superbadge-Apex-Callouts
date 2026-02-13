
try {
    // Initial query requires Tooling API access?
    // In standard Apex execution (Execute Anonymous), we might not see Tooling objects directly if they are shadowed?
    // But TraceFlag is standard object in SOAP API but often treated as Tooling.
    
    // Let's try raw SOQL in Apex
    DebugLevel dl = [SELECT Id FROM DebugLevel LIMIT 1];
    System.debug('Found DebugLevel: ' + dl.Id);

    TraceFlag tf = new TraceFlag();
    tf.DebugLevelId = dl.Id;
    tf.StartDate = DateTime.now();
    tf.ExpirationDate = DateTime.now().addMinutes(30);
    tf.LogType = 'USER_DEBUG';
    tf.TracedEntityId = UserInfo.getUserId();
    
    insert tf;
    System.debug('Created TraceFlag: ' + tf.Id);
} catch (Exception e) {
    System.debug('Error: ' + e.getMessage());
}
