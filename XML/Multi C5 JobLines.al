xmlport 70054 "Multi C5 JobLines"
{
   
    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement("<importjobtasklines>")
        {
            XmlName = 'ImportJobtaskLines';
            tableelement("Job Task"; "Job Task")
            {
                XmlName = 'JobLineTable';
                fieldelement(Number; "Job Task"."Job No.")
                {
                }
                fieldelement(TaskNumber; "Job Task"."Job Task No.")
                {
                }
                fieldelement(TaskDescription; "Job Task".Description)
                {
                }
                fieldelement(TaskLineType; "Job Task"."Job Task Type")
                {
                }
                fieldelement(TaskLineIdentation; "Job Task".Indentation)
                {
                }
                fieldelement(TaskPostingGroup; "Job Task"."Job Posting Group")
                {
                }
                fieldelement(TaskVIATotal; "Job Task"."WIP-Total")
                {
                }
                fieldelement(TaskTotal; "Job Task".Totaling)
                {
                }
                textelement(Department)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        if Department <> '' then begin
                            "Job Task"."Global Dimension 1 Code" := Department;
                            DB.Init;
                            DB."Table ID" := 1001;
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
                            "Job Task"."Global Dimension 2 Code" := Centre;
                            DB.Init;
                            DB."Table ID" := 1001;
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
                            DB."Table ID" := 1001;
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
        "Job Task".DeleteAll;
        DefaultDimension.SetFilter("Table ID", '1003');
        DefaultDimension.DeleteAll;
        JobTaskDimension.DeleteAll;
        Commit;
    end;

    var
        DefaultDimension: Record "Default Dimension";
        DV: Record "Dimension Value";
        DB: Record "Dimension Buffer";
        DM: Codeunit DimensionManagement;
        DS: Record "Dimension Set Entry" temporary;
        JobTaskDimension: Record "Job Task Dimension";
}

