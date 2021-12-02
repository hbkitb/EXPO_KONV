xmlport 70055 "Multi C5 JobEntry"
{

    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(JobEntryImport)
        {
            tableelement("Job Ledger Entry"; "Job Ledger Entry")
            {
                XmlName = 'JobLedgerEntry';
                fieldelement(JobNo; "Job Ledger Entry"."Job No.")
                {
                }
                fieldelement(JobTaskNo; "Job Ledger Entry"."Job Task No.")
                {
                }
                fieldelement(PostingDate; "Job Ledger Entry"."Posting Date")
                {
                }
                fieldelement(JobVoucher; "Job Ledger Entry"."Document No.")
                {
                }
                fieldelement(JobItemType; "Job Ledger Entry".Type)
                {
                }
                fieldelement(JobItemNo; "Job Ledger Entry"."No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        "Job Ledger Entry".Validate("Job Ledger Entry"."No.", "Job Ledger Entry"."No.");
                    end;
                }
                fieldelement(JobDescripstion; "Job Ledger Entry".Description)
                {
                }
                fieldelement(JobQuantity; "Job Ledger Entry".Quantity)
                {
                }
                fieldelement(JobDirectUnitCost; "Job Ledger Entry"."Direct Unit Cost (LCY)")
                {
                }
                fieldelement(JobCostUnitLCY; "Job Ledger Entry"."Unit Cost (LCY)")
                {
                }
                fieldelement(JobCostUnit; "Job Ledger Entry"."Unit Cost")
                {
                }
                fieldelement(JobTotalCostLCY; "Job Ledger Entry"."Total Cost (LCY)")
                {
                }
                fieldelement(JobTotalCost; "Job Ledger Entry"."Total Cost")
                {
                }
                fieldelement(JobUnitPriceLCY; "Job Ledger Entry"."Unit Price (LCY)")
                {
                }
                fieldelement(JobUnitPrice; "Job Ledger Entry"."Unit Price")
                {
                }
                fieldelement(JobTotalPriceLCY; "Job Ledger Entry"."Total Price (LCY)")
                {
                }
                fieldelement(JobTotalPrice; "Job Ledger Entry"."Total Price")
                {
                }
                fieldelement(JobUnit; "Job Ledger Entry"."Unit of Measure Code")
                {
                }
                fieldelement(JobEntryCurrency; "Job Ledger Entry"."Currency Code")
                {
                }
                fieldelement(JobEntryCurrencyFactor; "Job Ledger Entry"."Currency Factor")
                {
                }
                fieldelement(JobLocationCode; "Job Ledger Entry"."Location Code")
                {
                }
                fieldelement(JobEntryType; "Job Ledger Entry"."Entry Type")
                {
                }
                fieldelement(JobJournalName; "Job Ledger Entry"."Journal Batch Name")
                {
                }
                textelement(Department)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        if Department <> '' then begin
                            "Job Ledger Entry"."Global Dimension 1 Code" := Department;
                            DB.Init;
                            DB."Table ID" := 169;
                            DB."Entry No." := 1;
                            DB."Dimension Code" := 'AFDELING';
                            DB."Dimension Value Code" := Department;
                            DB.Insert;
                            DS.Init;
                            DS."Dimension Code" := 'AFDELING';
                            DS."Dimension Value Code" := Department;
                            DV.SetFilter(DV."Dimension Code", 'AFDELING');
                            DV.SetFilter(DV.Code, Department);
                            if DV.FindFirst then
                                DS."Dimension Value ID" := DV."Dimension Value ID";
                            DS.Insert;
                        end;
                    end;
                }
                textelement(Centre)
                {

                    trigger OnAfterAssignVariable()
                    begin

                        if Centre <> '' then begin
                            "Job Ledger Entry"."Global Dimension 2 Code" := Centre;
                            DB.Init;
                            DB."Table ID" := 169;
                            DB."Entry No." := 1;
                            DB."Dimension Code" := 'BÆRER';
                            DB."Dimension Value Code" := Centre;
                            DB.Insert;
                            DS.Init;
                            DS."Dimension Code" := 'BÆRER';
                            DS."Dimension Value Code" := Centre;
                            DV.SetFilter(DV."Dimension Code", 'BÆRER');
                            DV.SetFilter(DV.Code, Centre);
                            if DV.FindFirst then
                                DS."Dimension Value ID" := DV."Dimension Value ID";
                            DS.Insert;
                        end;
                    end;
                }
                textelement(Purpose)
                {

                    trigger OnAfterAssignVariable()
                    begin

                        if Purpose <> '' then begin
                            DB.Init;
                            DB."Table ID" := 169;
                            DB."Entry No." := 1;
                            DB."Dimension Code" := 'FORMÅL';
                            DB."Dimension Value Code" := Purpose;
                            DB.Insert;
                            DS.Init;
                            DS."Dimension Code" := 'FORMÅL';
                            DS."Dimension Value Code" := Purpose;
                            DV.SetFilter(DV."Dimension Code", 'FORMÅL');
                            DV.SetFilter(DV.Code, Purpose);
                            if DV.FindFirst then
                                DS."Dimension Value ID" := DV."Dimension Value ID";
                            DS.Insert;
                        end;
                    end;
                }

                trigger OnBeforeInsertRecord()
                begin
                    "Job Ledger Entry"."Entry No." := Lbn;
                    Lbn := Lbn + 1;

                    if DS.FindSet then begin
                        "Job Ledger Entry"."Dimension Set ID" := DS.GetDimensionSetID(DS);
                        DS.DeleteAll;
                    end;

                    if "Job Ledger Entry"."Dimension Set ID" = 0 then begin
                        DB.SetFilter(DB."Table ID", '169');
                        DB.SetFilter(DB."Entry No.", '1');
                        if DB.FindSet then
                            "Job Ledger Entry"."Dimension Set ID" := DM.CreateDimSetIDFromDimBuf(DB);
                    end;

                    DB.SetFilter(DB."Table ID", '169');
                    DB.SetFilter(DB."Entry No.", '1');
                    if DB.FindSet then
                        DB.DeleteAll;

                    "Job Ledger Entry".Validate("Dimension Set ID");

                    "Job Ledger Entry"."Line Amount (LCY)" := "Job Ledger Entry"."Total Price (LCY)";
                    "Job Ledger Entry"."Line Amount" := "Job Ledger Entry"."Total Price";
                    "Job Ledger Entry"."Quantity (Base)" := "Job Ledger Entry".Quantity;
                    "Job Ledger Entry"."Qty. per Unit of Measure" := 1;
                    "Job Ledger Entry"."Source Code" := 'Start';
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

    trigger OnInitXmlPort()
    begin
        "Job Ledger Entry".DeleteAll;
        Lbn := 1;

        if not SourceCode.Get('Start') then begin
            SourceCode.Init;
            SourceCode.Code := 'START';
            SourceCode.Description := 'Start poster/Konverterede poster';
            SourceCode.Insert;
        end;
    end;

    var
        Lbn: Integer;
        DV: Record "Dimension Value";
        DB: Record "Dimension Buffer";
        DM: Codeunit DimensionManagement;
        DS: Record "Dimension Set Entry" temporary;
        DefaultDimension: Record "Default Dimension";
        SourceCode: Record "Source Code";
}

