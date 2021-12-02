xmlport 70060 "Multi C5 G/L Budget"
{
    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Budget)
        {
            tableelement("G/L Budget Entry"; "G/L Budget Entry")
            {
                XmlName = 'GLBudget';
                fieldelement(GLBudgetName; "G/L Budget Entry"."Budget Name")
                {
                }
                fieldelement(GLAccount; "G/L Budget Entry"."G/L Account No.")
                {
                }
                fieldelement(GLBudPostingDate; "G/L Budget Entry".Date)
                {
                }
                fieldelement(GLBudDescription; "G/L Budget Entry".Description)
                {
                }
                fieldelement(GLBudAmount; "G/L Budget Entry".Amount)
                {
                }
                textelement(Department)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        if Department <> '' then begin
                            "G/L Budget Entry"."Budget Dimension 1 Code" := Department;
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
                            "G/L Budget Entry"."Budget Dimension 1 Code" := Centre;
                            DB.Init;
                            DB."Table ID" := 17;
                            DB."Entry No." := 1;
                            DB."Dimension Code" := 'BÆRER';
                            DB."Dimension Value Code" := Department;
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
                            "G/L Budget Entry"."Budget Dimension 1 Code" := Purpose;
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

                trigger OnAfterGetRecord()
                begin
                    BudgetName.Get("G/L Budget Entry"."Budget Name");
                    if BudgetName.Name = '' then begin
                        BudgetName.Init;
                        BudgetName.Name := "G/L Budget Entry"."Budget Name";
                        BudgetName.Insert;
                    end;
                end;

                trigger OnBeforeInsertRecord()
                begin
                    if DS.FindSet then begin
                        "G/L Budget Entry"."Dimension Set ID" := DS.GetDimensionSetID(DS);
                        DS.DeleteAll;
                    end;

                    if "G/L Budget Entry"."Dimension Set ID" = 0 then begin
                        DB.SetFilter(DB."Table ID", '17');
                        DB.SetFilter(DB."Entry No.", '1');
                        if DB.FindSet then
                            "G/L Budget Entry"."Dimension Set ID" := DM.CreateDimSetIDFromDimBuf(DB);
                    end;


                    DB.SetFilter(DB."Table ID", '17');
                    DB.SetFilter(DB."Entry No.", '1');
                    if DB.FindSet then
                        DB.DeleteAll;

                    "G/L Budget Entry".Validate("Dimension Set ID");
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
        DV: Record "Dimension Value";
        DB: Record "Dimension Buffer";
        DM: Codeunit DimensionManagement;
        DS: Record "Dimension Set Entry" temporary;
        BudgetName: Record "G/L Budget Name";
}

