public with sharing class SpanEventTimestampDateTimePopulator implements Database.Batchable<SObject>, Database.Stateful {
    private Integer recordCount = 0;
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, mantra__Timestamp__c, mantra__TimestampDateTime__c FROM mantra__SpanEvent__c WHERE mantra__TimestampDateTime__c = NULL',
            AccessLevel.SYSTEM_MODE
        );
    }

    public void execute(Database.BatchableContext bc, List<SObject> records) {
        for (mantra__SpanEvent__c ase : (List<mantra__SpanEvent__c>) records) {
            ase.mantra__TimestampDateTime__c = Datetime.newInstance((Long) ase.mantra__Timestamp__c);
        }
        Database.update(records, true, AccessLevel.SYSTEM_MODE);
        recordCount += records.size();
    }

    public void finish(Database.BatchableContext bc) {
        System.debug(
            'SpanEventTimestampDateTimePopulator: ' +
                recordCount +
                ' Span Event\'s TimestampDateTime__c were successfully updated'
        );
    }
}
