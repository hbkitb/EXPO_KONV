xmlport 70057 "Multi C5 LedJournalName"
{
    
    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(FinansKladder)
        {
            tableelement("Gen. Journal Batch"; "Gen. Journal Batch")
            {
                XmlName = 'LedJournal';
                fieldelement(JournalBatchName; "Gen. Journal Batch"."Journal Template Name")
                {

                    trigger OnAfterAssignField()
                    begin
                        //"Gen. Journal Batch".GET;
                        //"Gen. Journal Batch".SETRANGE("Gen. Journal Batch"."Journal Template Name","Gen. Journal Batch"."Journal Template Name");
                        //"Gen. Journal Batch".SETRANGE("Gen. Journal Batch".Name,"Gen. Journal Batch".Name);
                        //"Gen. Journal Batch".DELETE;
                    end;
                }
                fieldelement(JournalName; "Gen. Journal Batch".Name)
                {
                }
                fieldelement(JournalDescription; "Gen. Journal Batch".Description)
                {
                }
                fieldelement(JournalNoSerie; "Gen. Journal Batch"."No. Series")
                {
                }
                fieldelement(JounalBalanceAccount; "Gen. Journal Batch"."Bal. Account No.")
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    "Gen. Journal Batch"."Copy VAT Setup to Jnl. Lines" := true;
                    "Gen. Journal Batch"."Allow Payment Export" := true;
                    if "Gen. Journal Batch"."Bal. Account No." <> '' then
                        "Gen. Journal Batch"."Suggest Balancing Amount" := true;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    var
        NoSer: Record "No. Series";
}

