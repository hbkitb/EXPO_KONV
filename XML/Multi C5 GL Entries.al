xmlport 70004 "Multi C5 G/L Entries"
{
    Format = VariableText;
    FormatEvaluate = Legacy;
    Direction = Import;
    TextEncoding = WINDOWS;
    FieldSeparator = ';';
    FieldDelimiter = '¤';
    schema
    {
        textelement(Import_GLEntries)
        {
            tableelement(GLTrans; "Gen. Journal Line")
            {
                fieldelement(Account; GLTrans."Account No.")
                {

                }
                fieldelement(Date; GLTrans."Posting Date")
                {

                }
                fieldelement(Voucher; GLTrans."Document No.")
                {

                }
                fieldelement(Description; GLTrans.Description)
                {

                }
                fieldelement(AmountMST; GLTrans."Amount (LCY)")
                {
                    FieldValidate = no;
                }
                fieldelement(AmountCUR; GLTrans.Amount)
                {
                    FieldValidate = no;
                }
                fieldelement(Currency; GLTrans."Currency Code")
                {
                    FieldValidate = no;

                    trigger OnAfterAssignField()
                    var
                        CreateCurrency: Codeunit "Multi C5 Create Currency";

                    begin
                        if GLTrans."Currency Code" <> '' then
                            CreateCurrency.CreateCurrency(GLTrans."Currency Code", GLTrans."Amount (LCY)", GLTrans.Amount);

                        if (GLTrans."Amount (LCY)" <> 0) and (GLTrans.Amount <> 0) then
                            GLTrans."Currency Factor" := GLTrans.Amount / GLTrans."Amount (LCY)";

                    end;

                }
                textelement(Department)
                {
                    trigger OnAfterAssignVariable()
                    var

                    begin
                        if Department <> '' then begin
                            GLTrans."Shortcut Dimension 1 Code" := Department;
                            SetDimension.InsertDimensionEntrySetId('AFDELING', Department, 81);
                        end;
                    end;
                }
                textelement(Centre)
                {
                    trigger OnAfterAssignVariable()

                    var

                    begin
                        if Centre <> '' then begin
                            GLTrans."Shortcut Dimension 2 Code" := Centre;
                            SetDimension.InsertDimensionEntrySetId('BÆRER', Centre, 81);
                        end;
                    end;
                }
                textelement(Purpose)
                {
                    trigger OnAfterAssignVariable()

                    var

                    begin
                        if PurPose <> '' then begin
                            SetDimension.InsertDimensionEntrySetId('FORMÅL', PurPose, 81);
                        end;
                    end;
                }
                textelement(JournalName)
                {

                }

                trigger OnBeforeInsertRecord()

                var

                begin
                    Batch.SetFilter(Batch.Name, JournalName);
                    if not Batch.FindFirst() then begin
                        Batch.Init();
                        Batch."Journal Template Name" := 'MULTIC5';
                        Batch.Name := JournalName;
                        Batch.Description := 'Finansposter fra C5';
                        Batch.Insert();
                    end;

                    GLTrans."Line No." := Linenumber;
                    Linenumber := Linenumber + 10000;
                    GLTrans."Journal Template Name" := 'MULTIC5';
                    GLTrans."Journal Batch Name" := JournalName;
                    GLTrans."Source Code" := 'Start';
                    if (GLTrans."Amount (LCY)" <> 0) and (GLTrans.Amount <> 0) then
                        GLTrans."Currency Factor" := GLTrans.Amount / GLTrans."Amount (LCY)";

                    GLTrans."Gen. Posting Type" := GLTrans."Gen. Posting Type"::" ";
                    GLTrans."Gen. Bus. Posting Group" := '';
                    GLTrans.Validate(GLTrans."Gen. Prod. Posting Group", '');

                    if DS.FindSet() then begin
                        GLTrans."Dimension Set ID" := DS."Dimension Set ID";
                        DS.DeleteAll();
                    end;


                    if GLTrans."Dimension Set ID" = 0 then begin
                        DB.SetFilter(DB."Table ID", '81');
                        DB.SetFilter(db."Entry No.", '1');
                        if db.FindSet() then
                            GLTrans."Dimension Set ID" := DM.CreateDimSetIDFromDimBuf(DB);
                    end;

                    DB.SetFilter(DB."Table ID", '81');
                    DB.SetFilter(DB."Entry No.", '1');
                    if db.FindSet() then
                        DB.DeleteAll();

                    GLTrans.Validate("Dimension Set ID");

                    if GLTrans.Amount >= 0 then
                        GLTrans."Debit Amount" := GLTrans.Amount
                    else
                        GLTrans."Credit Amount" := -GLTrans.Amount;
                end;
            }
        }

    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                //action(ActionName)
                //{

                //}
            }
        }
    }


    trigger OnInitXmlPort()
    var
        CreateJournal: Codeunit "Multi C5 Create Journals";
        Line: Record "Gen. Journal Line";
    begin
        CreateJournal.CreateJournalTemplate();

        Line.SetFilter(Line."Journal Template Name", 'MULTIC5');
        Line.SetFilter(Line."Journal Batch Name", 'C5Finans*');
        if Line.FindLast() then
            Linenumber := Linenumber + 10000
        ELSE
            Linenumber := 10000;

    end;

    var
        Linenumber: Integer;
        Batch: Record "Gen. Journal Batch";
        DV: Record "Dimension Value";
        DB: Record "Dimension Buffer";
        DM: Codeunit DimensionManagement;
        DS: Record "Dimension Set Entry" temporary;
        SourceCode: Record "Source Code";
        SetDimension: Codeunit "Multi C5 Dimension";
}