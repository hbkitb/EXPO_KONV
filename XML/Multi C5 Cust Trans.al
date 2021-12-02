xmlport 70007 "Multi C5 CustTrans"
{
    Format = VariableText;
    FormatEvaluate = Legacy;
    Direction = Import;
    TextEncoding = WINDOWS;
    FieldSeparator = ';';
    FieldDelimiter = '¤';

    schema
    {
        textelement(Import_CustTrans)
        {
            XmlName = 'CustTrans';
            tableelement(CustTrans; "Gen. Journal Line")
            {
                fieldelement(Account; CustTrans."Account No.")
                {
                    trigger OnAfterAssignField()

                    var

                    begin
                        CustTrans."Account Type" := CustTrans."Account Type"::Customer;
                        //Message('123');
                        //Blocked := 0;
                        //Blocked := Blocked::" ";
                        if cust.Get(CustTrans."Account No.") then begin
                            //    if Cust.Blocked <> Cust.Blocked::" " then begin
                            //        Blocked := Cust.Blocked;
                            ;
                        end;
                        Cust.Blocked := Cust.Blocked::" ";
                        Cust.Modify();
                        //    end;
                        //end;
                        //Message(CustTrans."Account No.");
                        //Message('55555');
                        CustTrans.Validate("Account No.");
                        //Message(CustTrans."Account No.");
                        //Message('99999');

                    end;

                }

                fieldelement(Date; CustTrans."Posting Date")
                {

                }
                fieldelement(InvioceNumber; CustTrans."External Document No.")
                {

                }
                fieldelement(Voucher; CustTrans."Document No.")
                {

                }
                fieldelement(Txt; CustTrans.Description)
                {

                }
                textelement(TransType)
                {
                    trigger OnAfterAssignVariable()
                    begin
                        if TransType = '1' then
                            CustTrans."Document Type" := CustTrans."Document Type"::Invoice
                        else
                            if TransType = '2' then
                                CustTrans."Document Type" := CustTrans."Document Type"::"Credit Memo"
                            else
                                if TransType = '3' then
                                    CustTrans."Document Type" := CustTrans."Document Type"::Payment
                                else
                                    CustTrans."Document Type" := CustTrans."Document Type"::" ";
                    end;
                }
                fieldelement(AmountMST; CustTrans."Amount (LCY)")
                {
                    FieldValidate = no;
                }
                fieldelement(AmountCUR; CustTrans.Amount)
                {
                    FieldValidate = no;
                }
                fieldelement(Currency; CustTrans."Currency Code")
                {
                    FieldValidate = no;

                    trigger OnAfterAssignField()
                    var
                        CreateCurrency: Codeunit "Multi C5 Create Currency";

                    begin
                        if CustTrans."Currency Code" <> '' then
                            CreateCurrency.CreateCurrency(CustTrans."Currency Code", CustTrans."Amount (LCY)", CustTrans.Amount);

                        if (CustTrans."Amount (LCY)" <> 0) and (CustTrans.Amount <> 0) then
                            CustTrans."Currency Factor" := CustTrans.Amount / CustTrans."Amount (LCY)";

                    end;
                }
                Textelement(Department)
                {
                    trigger OnAfterAssignVariable()
                    var

                    begin
                        if Department <> '' then begin
                            CustTrans."Shortcut Dimension 1 Code" := Department;
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
                            CustTrans."Shortcut Dimension 2 Code" := Centre;
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
                fieldelement(BalAccountNo; CustTrans."Bal. Account No.")
                {

                }
                textelement(Open)
                {

                }
                fieldelement(DueDate; CustTrans."Due Date")
                {

                }
                fieldelement(PmtDiscountDate; CustTrans."Pmt. Discount Date")
                {

                }

                trigger OnBeforeInsertRecord()

                var
                    GJL: Record "Gen. Journal Line";

                begin
                    //Message('før bef. ins');
                    //Message(CustTrans."Account No.");
                    CustTrans."Line No." := LineNumber;
                    LineNumber := LineNumber + 10000;
                    CustTrans."Journal Template Name" := 'MULTIC5';
                    CustTrans."Journal Batch Name" := 'DEB_ÅBNING';

                    PaymentTerms.Get(CustTrans."Payment Terms Code");
                    CustTrans."Payment Discount %" := PaymentTerms."Discount %";

                    if (CustTrans."Amount (LCY)" <> 0) and (CustTrans.Amount <> 0) then
                        CustTrans."Currency Factor" := CustTrans.Amount / CustTrans."Amount (LCY)";

                    if DS.FindSet() then begin
                        CustTrans."Dimension Set ID" := DS.GetDimensionSetID(DS);
                        DS.DeleteAll();
                    end;

                    if CustTrans."Dimension Set ID" = 0 then begin
                        DB.SetFilter(DB."Table ID", '81');
                        DB.SetFilter(DB."Entry No.", '1');
                        if DB.FindSet() then
                            CustTrans."Dimension Set ID" := DM.CreateDimSetIDFromDimBuf(DB);

                    end;

                    DB.SetFilter(DB."Table ID", '81');
                    DB.SetFilter(DB."Entry No.", '1');
                    if DB.FindSet() then
                        DB.DeleteAll();

                    CustTrans.Validate("Dimension Set ID");

                    //171120 if Blocked <> Blocked::" " then begin
                    if Cust.Get(CustTrans."Account No.") then begin
                        //        Cust.Blocked := Blocked;
                        //        Cust.Modify();
                        ;
                    end;
                    //end;

                    if GL.get(CustTrans."Bal. Account No.") then begin
                        if GL."Direct Posting" = false then begin
                            GL."Direct Posting" := true;
                            GL.Modify();
                        end;
                    end;

                    if (CustTrans."Document Type" = CustTrans."Document Type"::Invoice) and (CustTrans."Amount (LCY)" < 0) then
                        CustTrans."Document Type" := CustTrans."Document Type"::"Credit Memo"
                    else
                        if (CustTrans."Document Type" = custtrans."Document Type"::"Credit Memo") and (CustTrans."Amount (LCY)" > 0) then  //cre.note var 1 HBK
                            CustTrans."Document Type" := CustTrans."Document Type"::Refund;

                    if CustTrans."Document Type" = CustTrans."Document Type"::Invoice then begin
                        GJL.SetFilter("Journal Template Name", 'MULTIC5');
                        GJL.SetFilter("Journal Batch Name", 'DEB_ÅBNING');
                        GJL.SetFilter("Document Type", Format(GJL."Document Type"::Invoice));
                        GJL.SetFilter("Document No.", CustTrans."Document No.");
                        if GJL.FindFirst() then
                            CustTrans."Document Type" := CustTrans."Document Type"::" ";
                    end;

                    if CustTrans."Amount (LCY)" = 0 then
                        currXMLport.Skip();

                    //Message('efter bef. ins');
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
        //Message('før init');
        CreateJournal.CreateJournalTemplate();
        CreateJournal.CreateJournalBatch('DEB_ÅBNING', 'Debitorposter fra C5');

        Line.SetFilter(Line."Journal Template Name", 'MULLTIC5');
        Line.SetFilter(Line."Journal Batch Name", 'DEB_ÅBNING');
        Line.DeleteAll();

        LineNumber := 10000;

        //Message('efter init');

    end;

    var
        LineNumber: Integer;
        Batch: Record "Gen. Journal Batch";
        DV: Record "Dimension Value";
        DB: Record "Dimension Buffer";
        DM: Codeunit DimensionManagement;
        DS: Record "Dimension Set Entry" temporary;
        //Blocked: Integer;
        //Blocked: Enum "Customer Blocked";  //171120
        Cust: Record Customer;
        GL: Record "G/L Account";
        PaymentTerms: Record "Payment Terms";
        SourceCode: Record "Source Code";
        SetDimension: Codeunit "Multi C5 Dimension";
}