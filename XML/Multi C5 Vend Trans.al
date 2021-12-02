xmlport 70011 "Multi C5 VendTrans"
{
    Format = VariableText;
    FormatEvaluate = Legacy;
    Direction = Import;
    TextEncoding = WINDOWS;
    FieldSeparator = ';';
    FieldDelimiter = '¤';

    schema
    {
        textelement(Import_VendTrans)
        {
            tableelement(VendTrans; "Gen. Journal Line")
            {
                fieldelement(Account; VendTrans."Account No.")
                {
                    trigger
                        OnAfterAssignField()

                    var

                    begin
                        VendTrans."Account Type" := VendTrans."Account Type"::Vendor;
                        //171120 Blocked := Blocked::" ";  //0;
                        if Vend.Get(VendTrans."Account No.") then begin
                            //    if Vend.Blocked <> Vend.Blocked::" " then begin
                            //        Blocked := Vend.Blocked;
                            ;
                        end;
                        Vend.Blocked := Vend.Blocked::" ";
                        Vend.Modify();
                        //    end;
                        //end;

                        VendTrans.Validate("Account No.");

                    end;

                }

                fieldelement(Date; VendTrans."Posting Date")
                {

                }
                fieldelement(InvioceNumber; VendTrans."External Document No.")
                {

                }
                fieldelement(Voucher; VendTrans."Document No.")
                {

                }
                fieldelement(Txt; VendTrans.Description)
                {

                }
                textelement(TransType)
                {
                    trigger OnAfterAssignVariable()
                    begin
                        if TransType = '1' then
                            VendTrans."Document Type" := VendTrans."Document Type"::Invoice
                        else
                            if TransType = '2' then
                                VendTrans."Document Type" := VendTrans."Document Type"::"Credit Memo"
                            else
                                if TransType = '3' then
                                    VendTrans."Document Type" := VendTrans."Document Type"::Payment
                                else
                                    VendTrans."Document Type" := VendTrans."Document Type"::" ";
                    end;
                }
                fieldelement(AmountMST; VendTrans."Amount (LCY)")
                {
                    FieldValidate = no;
                }
                fieldelement(AmountCUR; VendTrans.Amount)
                {
                    FieldValidate = no;
                }
                fieldelement(Currency; VendTrans."Currency Code")
                {
                    FieldValidate = no;

                    trigger OnAfterAssignField()
                    var
                        CreateCurrency: Codeunit "Multi C5 Create Currency";

                    begin
                        if VendTrans."Currency Code" <> '' then
                            CreateCurrency.CreateCurrency(VendTrans."Currency Code", VendTrans."Amount (LCY)", VendTrans.Amount);

                        if (VendTrans."Amount (LCY)" <> 0) and (VendTrans.Amount <> 0) then
                            VendTrans."Currency Factor" := VendTrans.Amount / VendTrans."Amount (LCY)";

                    end;
                }
                Textelement(Department)
                {
                    trigger OnAfterAssignVariable()
                    var

                    begin
                        if Department <> '' then begin
                            VendTrans."Shortcut Dimension 1 Code" := Department;
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
                            VendTrans."Shortcut Dimension 2 Code" := Centre;
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
                fieldelement(BalAccountNo; VendTrans."Bal. Account No.")
                {

                }
                textelement(Open)
                {

                }
                fieldelement(DueDate; VendTrans."Due Date")
                {

                }
                fieldelement(PmtDiscountDate; VendTrans."Pmt. Discount Date")
                {

                }

                trigger OnBeforeInsertRecord()

                var
                    GJL: Record "Gen. Journal Line";

                begin
                    VendTrans."Line No." := LineNumber;
                    LineNumber := LineNumber + 10000;
                    VendTrans."Journal Template Name" := 'MULTIC5';
                    VendTrans."Journal Batch Name" := 'KRE_ÅBNING';

                    PaymentTerms.Get(VendTrans."Payment Terms Code");
                    VendTrans."Payment Discount %" := PaymentTerms."Discount %";

                    if (VendTrans."Amount (LCY)" <> 0) and (VendTrans.Amount <> 0) then
                        VendTrans."Currency Factor" := VendTrans.Amount / VendTrans."Amount (LCY)";

                    if DS.FindSet() then begin
                        VendTrans."Dimension Set ID" := DS.GetDimensionSetID(DS);
                        DS.DeleteAll();
                    end;

                    if VendTrans."Dimension Set ID" = 0 then begin
                        DB.SetFilter(DB."Table ID", '81');
                        DB.SetFilter(DB."Entry No.", '1');
                        if DB.FindSet() then
                            VendTrans."Dimension Set ID" := DM.CreateDimSetIDFromDimBuf(DB);

                    end;

                    DB.SetFilter(DB."Table ID", '81');
                    DB.SetFilter(DB."Entry No.", '1');
                    if DB.FindSet() then
                        DB.DeleteAll();

                    VendTrans.Validate("Dimension Set ID");

                    //171120 if Blocked <> Blocked::" " then begin
                    if Vend.Get(VendTrans."Account No.") then begin
                        //        Vend.Blocked := Blocked;
                        //        Vend.Modify();
                        //    end;
                        ;
                    end;

                    if GL.get(VendTrans."Bal. Account No.") then begin
                        if GL."Direct Posting" = false then begin
                            GL."Direct Posting" := true;
                            GL.Modify();
                        end;
                    end;

                    if (VendTrans."Document Type" = VendTrans."Document Type"::Invoice) and (VendTrans."Amount (LCY)" > 0) then
                        VendTrans."Document Type" := VendTrans."Document Type"::"Credit Memo"
                    else
                        if (VendTrans."Document Type" = VendTrans."Document Type"::"Credit Memo") and (VendTrans."Amount (LCY)" < 0) then
                            VendTrans."Document Type" := VendTrans."Document Type"::Refund;

                    if VendTrans."Document Type" = VendTrans."Document Type"::Invoice then begin
                        GJL.SetFilter("Journal Template Name", 'MULTIC5');
                        GJL.SetFilter("Journal Batch Name", 'KRE_ÅBNING');
                        GJL.SetFilter("Document Type", Format(GJL."Document Type"::Invoice));
                        GJL.SetFilter("Document No.", VendTrans."Document No.");
                        if GJL.FindFirst() then
                            VendTrans."Document Type" := VendTrans."Document Type"::" ";
                    end;

                    if VendTrans."Amount (LCY)" = 0 then
                        currXMLport.Skip();
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
        CreateJournal.CreateJournalBatch('KRE_ÅBNING', 'KREitorposter fra C5');

        Line.SetFilter(Line."Journal Template Name", 'MULLTIC5');
        Line.SetFilter(Line."Journal Batch Name", 'KRE_ÅBNING');
        Line.DeleteAll();

        LineNumber := 10000;

    end;

    var
        LineNumber: Integer;
        Batch: Record "Gen. Journal Batch";
        DV: Record "Dimension Value";
        DB: Record "Dimension Buffer";
        DM: Codeunit DimensionManagement;
        DS: Record "Dimension Set Entry" temporary;
        //Blocked: Integer;
        //Blocked: Enum "Vendor Blocked";  //171120
        Vend: Record Vendor;
        GL: Record "G/L Account";
        PaymentTerms: Record "Payment Terms";
        SourceCode: Record "Source Code";
        SetDimension: Codeunit "Multi C5 Dimension";
}