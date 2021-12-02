xmlport 70001 "Multi C5 GLChart"
{
    Format = VariableText;
    FormatEvaluate = Legacy;
    Direction = Import;
    TextEncoding = WINDOWS;
    FieldSeparator = ';';
    FieldDelimiter = '<¤>';

    schema
    {
        textelement(Import_GLChart)
        {
            XmlName = 'GLChart';

            tableelement(GLAccount; "G/L Account")
            {
                UseTemporary = false;
                fieldelement("No."; GLAccount."No.")
                {

                }
                fieldelement(Name; GLAccount.Name)
                {
                    trigger OnAfterAssignField()
                    var
                        pos: Integer;
                    begin
                        GLAccount."Search Name" := UpperCase(GLAccount.Name);
                    end;
                }
                textelement(AccType)
                {
                    trigger OnAfterAssignVariable()
                    begin
                        if AccType = '1' then //Status
                            GLAccount."Income/Balance" := GLAccount."Income/Balance"::"Balance Sheet"
                        else
                            if AccType = '2' then //Overskrift
                                GLAccount."Account Type" := GLAccount."Account Type"::Heading
                            else
                                if AccType = '3' then begin //Sideskift
                                    GLAccount."Account Type" := GLAccount."Account Type"::Heading;
                                    GLAccount."New Page" := true;
                                end else
                                    if AccType = '4' then //Tom
                                        GLAccount."Account Type" := GLAccount."Account Type"::Heading
                                    else
                                        if AccType = '5' then //Sumkonto
                                            GLAccount."Account Type" := GLAccount."Account Type"::"End-Total"
                                        else
                                            if AccType = '6' then //Tælleværk
                                                GLAccount."Account Type" := GLAccount."Account Type"::Total;
                    end;


                }
                textelement(DriftsStatus)
                {
                    trigger OnAfterAssignVariable()
                    begin
                        if GLAccount."Account Type" > 0 then
                            Evaluate(GLAccount."Income/Balance", DriftsStatus);
                    end;
                }
                fieldelement(DC; GLAccount."Debit/Credit")
                {
                }
                textelement(Department)
                {

                }
                textelement(DepartmentMand)
                {
                    trigger OnAfterAssignVariable()

                    var

                    begin
                        If (Department <> '') or (DepartmentMand = '1') then
                            DefaultDimensionSet.InsertDefaultDimension('AFDELING', Department, DepartmentMand, GLAccount."No.", 15);
                    end;
                }
                textelement(OffsetAccount)
                {

                }
                textelement(Access)
                {
                    trigger OnAfterAssignVariable()

                    var

                    begin
                        if Access = '0' then
                            GLAccount."Direct Posting" := true;
                        if Access = '1' then
                            GLAccount.Blocked := true;
                        if Access = '2' then
                            GLAccount."Direct Posting" := false;
                    end;
                }
                fieldelement(TotalFromAccount; GLAccount.Totaling)
                {
                    FieldValidate = no;
                }
                textelement(Centre)
                {

                }
                textelement(CentreMand)
                {
                    trigger OnAfterAssignVariable()

                    var

                    begin
                        If (Centre <> '') or (CentreMand = '1') then
                            DefaultDimensionSet.InsertDefaultDimension('BÆRER', Centre, CentreMand, GLAccount."No.", 15);
                    end;
                }
                textelement(Purpose)
                {

                }
                textelement(MandPurpose)
                {
                    trigger OnAfterAssignVariable()

                    var

                    begin
                        If (Centre <> '') or (CentreMand = '1') then
                            DefaultDimensionSet.InsertDefaultDimension('FORMÅL', Centre, CentreMand, GLAccount."No.", 15);
                    end;
                }
                fieldelement(PostingType; GLAccount."Gen. Posting Type")
                {
                }
                fieldelement(GenProdPostongGrp; GLAccount."Gen. Prod. Posting Group")
                {

                    trigger OnAfterAssignField()
                    begin
                        if GLAccount."Gen. Prod. Posting Group" <> '' then begin
                            GPG.Get(GLAccount."Gen. Prod. Posting Group");
                            GLAccount."VAT Prod. Posting Group" := GPG."Def. VAT Prod. Posting Group";
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

    begin
        GL.DeleteAll;
        dd.SetFilter("Table Id", '15');
        dd.DeleteAll;
        ComLine.Setfilter("Table Name", 'G/L Account');
        ComLine.DeleteALL;

    end;

    trigger OnPreXMLPort()

    var

    begin

    end;

    trigger OnPostXmlPort()
    var
        GL: Record "G/L Account";
        GL1: Record "G/L Account";
        AccountLen: Integer;
        PadString: Text[20];
        AddAccount: Integer;
        TmpAccount: Integer;
        AutoIndent: Codeunit "C5 Account Indent";
        DiffLen: Boolean;
        "Default Dimension": Record "Default Dimension";
        NewDim: Record "Default Dimension";

    begin
        //Ændre kontotype
        if GL.FindSet() then begin
            repeat
                if GL."Account Type" = GL."Account Type"::"End-Total" then begin
                    GL1.SetFilter("No.", '%1', GL.Totaling);
                    GL1.FindFirst();
                    if GL1."Account Type" = GL1."Account Type"::"Begin-Total" then begin
                        GL."Account Type" := GL."Account Type"::Total; //GL."Account Type"::"End-Total";
                        GL.Totaling := GL1."No." + '..' + GL."No.";
                        GL.Modify;
                    end else begin
                        GL1."Account Type" := GL1."Account Type"::"Begin-Total";
                        GL1.Modify();
                    end;
                end;
            until GL.Next() = 0;
        end;

        AutoIndent.Run();

    end;

    var
        GL: Record "G/L Account";
        dd: Record "Default Dimension";
        ComLine: Record "Comment Line";
        GPG: Record "Gen. Product Posting Group";
        DefaultDimensionSet: Codeunit "Multi C5 Dimension";
}