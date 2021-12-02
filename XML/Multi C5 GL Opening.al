xmlport 70003 "Multi C5 GLEntryOpening"
{
    Format = VariableText;
    FormatEvaluate = Legacy;
    Direction = Import;
    TextEncoding = WINDOWS;
    FieldSeparator = ';';
    FieldDelimiter = '¤';
    //UseRequestPage = false;


    schema
    {
        textelement(Import_GLOpening)
        {
            XmlName = 'GLOpening';


            tableelement(GenJournalLine; "Gen. Journal Line")
            {
                fieldelement(Account; GenJournalLine."Account No.")
                {

                }

                fieldelement(Txt; GenJournalLine.Description)
                {

                }
                fieldelement(PostDate; GenJournalLine."Posting Date")
                {

                }
                textelement(Department)
                {
                    trigger OnAfterAssignVariable()

                    var

                    begin
                        if Department <> '' then begin
                            GenJournalLine."Shortcut Dimension 1 Code" := Department;
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
                            GenJournalLine."Shortcut Dimension 2 Code" := Centre;
                            SetDimension.InsertDimensionEntrySetId('BÆRER', Centre, 81);
                        end;
                    end;
                }
                textelement(PurPose)
                {
                    trigger OnAfterAssignVariable()

                    var

                    begin
                        if PurPose <> '' then begin
                            SetDimension.InsertDimensionEntrySetId('FORMÅL', PurPose, 81);
                        end;
                    end;
                }
                fieldelement(AmountMST; GenJournalLine."Amount (LCY)")
                {
                    FieldValidate = no;
                }
                fieldelement(AmountCur; GenJournalLine.Amount)
                {
                    FieldValidate = no;
                }
                fieldelement(Currency; GenJournalLine."Currency Code")
                {
                    FieldValidate = no;

                    trigger OnAfterAssignField()
                    var
                        CreateCurrency: Codeunit "Multi C5 Create Currency";
                    begin
                        if GenJournalLine."Currency Code" <> '' then
                            CreateCurrency.CreateCurrency(GenJournalLine."Currency Code", GenJournalLine."Amount (LCY)", GenJournalLine.Amount);

                        if (GenJournalLine."Amount (LCY)" <> 0) and (GenJournalLine.Amount <> 0) then
                            GenJournalLine."Currency Factor" := GenJournalLine.Amount / GenJournalLine."Amount (LCY)";

                    end;
                }
                fieldelement(Voucher; GenJournalLine."Document No.")
                {

                }

                trigger OnBeforeInsertRecord()

                var

                begin
                    //Message('0');
                    GenJournalLine."Line No." := LineNumber;
                    LineNumber := LineNumber + 10000;
                    GenJournalLine."Journal Template Name" := 'MULTIC5';
                    GenJournalLine."Journal Batch Name" := 'GL_ÅBNING';
                    GenJournalLine."Source Code" := 'Start';
                    IF (GenJournalLine."Amount (LCY)" <> 0) AND (GenJournalLine.Amount <> 0) then
                        GenJournalLine."Currency Factor" := GenJournalLine.Amount / GenJournalLine."Amount (LCY)";

                    GenJournalLine."Gen. Posting Type" := GenJournalLine."Gen. Posting Type"::" ";
                    GenJournalLine."Gen. Bus. Posting Group" := '';
                    GenJournalLine.Validate(GenJournalLine."Gen. Prod. Posting Group", '');

                    if DS.FindSet() then begin
                        GenJournalLine."Dimension Set ID" := DS.GetDimensionSetID(DS);
                        DS.DeleteAll();
                    end;

                    if GenJournalLine."Dimension Set ID" = 0 then begin
                        DB.SetFilter(DB."Table ID", '81');
                        DB.SetFilter(DB."Entry No.", '1');
                        if DB.FindSet() then
                            GenJournalLine."Dimension Set ID" := DM.CreateDimSetIDFromDimBuf(DB);

                    end;

                    DB.SetFilter(DB."Table ID", '81');
                    DB.SetFilter(DB."Entry No.", '1');
                    if DB.FindSet() then
                        DB.DeleteAll();

                    GenJournalLine.Validate("Dimension Set ID");
                    //Message('1');
                end;

                trigger OnAfterInsertRecord()
                var

                begin
                    //Message('efter indsat');
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
        //Message('3');
        //Message(Format(RequestOptionsPage));
        CreateJournal.CreateJournalTemplate();
        CreateJournal.CreateJournalBatch('GL_ÅBNING', 'Åbningsposter fra C5');

        Line.SetFilter(Line."Journal Template Name", 'MULTIC5');
        Line.SetFilter(Line."Journal Batch Name", 'GL_ÅBNING');
        Line.DeleteAll();

        LineNumber := 10000;
        //Message('4');
    end;

    var
        LineNumber: Integer;
        DV: Record "Dimension Value";
        DB: Record "Dimension Buffer";
        DM: Codeunit DimensionManagement;
        DS: Record "Dimension Set Entry" temporary;
        SourceCode: Record "Source Code";
        SetDimension: Codeunit "Multi C5 Dimension";


}