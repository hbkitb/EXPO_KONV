xmlport 70035 "Multi C5 Insert G/L Entries"
{
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Import_Finansposter)
        {
            tableelement("G/L Entry"; "G/L Entry")
            {
                XmlName = 'Finansposter';
                fieldelement(Account; "G/L Entry"."G/L Account No.")
                {
                }
                fieldelement(Date; "G/L Entry"."Posting Date")
                {
                }
                fieldelement(Voucher; "G/L Entry"."Document No.")
                {
                }
                fieldelement(Txt; "G/L Entry".Description)
                {
                }
                fieldelement(AmountMST; "G/L Entry".Amount)
                {
                }
                textelement(AmountCur)
                {
                }
                textelement(Currency)
                {
                }
                textelement(Department)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        if Department <> '' then begin
                            "G/L Entry"."Global Dimension 1 Code" := Department;
                            DB.Init;
                            DB."Table ID" := 17;
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
                            "G/L Entry"."Global Dimension 2 Code" := Centre;
                            DB.Init;
                            DB."Table ID" := 17;
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
                            DB."Table ID" := 17;
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
                    "G/L Entry"."Entry No." := Lbn;
                    Lbn := Lbn + 1;

                    "G/L Entry"."Source Code" := 'Start';

                    if DS.FindSet then begin
                        "G/L Entry"."Dimension Set ID" := DS.GetDimensionSetID(DS);
                        DS.DeleteAll;
                    end;

                    if "G/L Entry"."Dimension Set ID" = 0 then begin
                        DB.SetFilter(DB."Table ID", '17');
                        DB.SetFilter(DB."Entry No.", '1');
                        if DB.FindSet then
                            "G/L Entry"."Dimension Set ID" := DM.CreateDimSetIDFromDimBuf(DB);
                    end;


                    DB.SetFilter(DB."Table ID", '17');
                    DB.SetFilter(DB."Entry No.", '1');
                    if DB.FindSet then
                        DB.DeleteAll;

                    "G/L Entry".Validate("Dimension Set ID");

                    if "G/L Entry".Amount >= 0 then
                        "G/L Entry"."Debit Amount" := "G/L Entry".Amount
                    else
                        "G/L Entry"."Credit Amount" := "G/L Entry".Amount;
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
        Lbn := 1;

        if not SourceCode.Get('Start') then begin
            SourceCode.Init;
            SourceCode.Code := 'START';
            SourceCode.Description := 'Start poster/Konverterede poster';
            SourceCode.Insert;
        end;
    end;

    var
        DV: Record "Dimension Value";
        DB: Record "Dimension Buffer";
        DM: Codeunit DimensionManagement;
        DS: Record "Dimension Set Entry" temporary;
        Lbn: Integer;
        SourceCode: Record "Source Code";
}

