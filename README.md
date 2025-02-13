# Audicity-SpanEvent-TimestampDateTime-Populator
This project provides a batch class `SpanEventTimestampDateTimePopulator.cls` that backfills missing `mantra__SpanEvent__c` `mantra__TimestampDateTime__c` values.
This field, introduced in v1.142 of the Audicity package, provides a custom index, optimising LDV processing and filtering on  `mantra__SpanEvent__c` records. Where `mantra__SpanEvent__c` records have been generated using an Audicity version < v1.142, this batch class can be used to backfill missing `mantra__TimestampDateTime__c` data.

## How to use the batch class
1. Deploy the `SpanEventTimestampDateTimePopulator.cls` batch class (and optional test class) provided by this project
2. Execute the batch class replacing `[x]` with your preferred batch size:

`Database.executeBatch(new SpanEventTimestampDateTimePopulator(), [x]);`
