@IsTest
public with sharing class SpanEventTimestampDateTimePopulatorTest {
    @IsTest
    public static void batchExecutionTest() {
        //GIVEN
        Account acc = new Account(Name = 'Test');
        insert acc;
        Datetime timestamp = Datetime.newInstance(2024, 6, 30, 30, 30, 30);
        Long timestampMs = timestamp.getTime();
        mantra__SpanEvent__c ase1 = new mantra__SpanEvent__c(
            mantra__EntityId__c = acc.Id,
            mantra__Timestamp__c = timestampMs,
            mantra__User__c = UserInfo.getUserId(),
            mantra__UUID__c = System.UUID.randomUUID().toString(),
            mantra__SpanUuid__c = System.UUID.randomUUID().toString(),
            mantra__TraceUuid__c = System.UUID.randomUUID().toString(),
            mantra__TransactionUuid__c = System.UUID.randomUUID().toString(),
            mantra__Body__c = '{"recordHistories":[{"field":"Name","oldValue": "Test"}]}'
        );
        mantra__SpanEvent__c ase2 = new mantra__SpanEvent__c(
            mantra__EntityId__c = acc.Id,
            mantra__Timestamp__c = timestampMs,
            mantra__User__c = UserInfo.getUserId(),
            mantra__UUID__c = System.UUID.randomUUID().toString(),
            mantra__SpanUuid__c = System.UUID.randomUUID().toString(),
            mantra__TraceUuid__c = System.UUID.randomUUID().toString(),
            mantra__TransactionUuid__c = System.UUID.randomUUID().toString(),
            mantra__Body__c = '{"recordHistories":[{"field":"Name","oldValue": "Test"}]}'
        );
        mantra__SpanEvent__c ase3 = new mantra__SpanEvent__c(
            mantra__EntityId__c = acc.Id,
            mantra__Timestamp__c = timestampMs,
            mantra__User__c = UserInfo.getUserId(),
            mantra__UUID__c = System.UUID.randomUUID().toString(),
            mantra__SpanUuid__c = System.UUID.randomUUID().toString(),
            mantra__TraceUuid__c = System.UUID.randomUUID().toString(),
            mantra__TransactionUuid__c = System.UUID.randomUUID().toString(),
            mantra__Body__c = '{"recordHistories":[{"field":"Name","oldValue": "Test"}]}'
        );
        List<mantra__SpanEvent__c> aseList = new List<mantra__SpanEvent__c>{ ase1, ase2, ase3 };
        insert aseList;
        Set<Id> syntheticAseIds = new Set<Id>{ase1.Id,ase2.Id,ase3.Id};
        for (mantra__SpanEvent__c ase : [SELECT Id, mantra__TimestampDateTime__c FROM mantra__SpanEvent__c WHERE Id IN :syntheticAseIds]) {
            Assert.isNull(ase.mantra__TimestampDateTime__c);
        }
        

        //WHEN
        Test.startTest();
        Database.executeBatch(new SpanEventTimestampDateTimePopulator(), 2000);
        Test.stopTest();

        //THEN
        List<mantra__SpanEvent__c> updatedAse = [SELECT Id, mantra__TimestampDateTime__c FROM mantra__SpanEvent__c WHERE Id IN :syntheticAseIds];
        Assert.areEqual(3, updatedAse.size());
        for (mantra__SpanEvent__c ase : updatedAse) {
            Assert.isTrue(timestamp.equals(ase.mantra__TimestampDateTime__c));
        }
    }
}