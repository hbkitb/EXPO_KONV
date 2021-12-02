xmlport 70018 "Multi C5 Resource"
{
    Format = VariableText;
    FormatEvaluate = Legacy;
    Direction = Import;
    TextEncoding = WINDOWS;
    FieldSeparator = ';';
    FieldDelimiter = '¤';

    schema
    {
        textelement(Import_Resource)
        {
            tableelement(BCResource; Resource)
            {
                fieldelement(ResourceNo; BCResource."No.")
                {

                }

                fieldelement(ResourceName; BCResource.Name)
                {

                }

                fieldelement(ResourceName2; BCResource."Name 2")
                {

                }
                textelement(ResourceName3)
                {

                }

                textelement(ResourceType)
                {

                }

                textelement(DiscGroup)
                {

                }

                fieldelement(CostPrice; BCResource."Unit Cost")
                {

                }

                textelement(Group)
                {
                    trigger OnAfterAssignVariable()
                    var

                        IPG: Record "Resource Group";

                    begin
                        if not IPG.Get(Group) then begin
                            IPG.Init();
                            IPG."No." := Group;
                            IPG.Insert();
                        end;
                        BCResource."Resource Group No." := Group;

                    end;
                }

                textelement(SalesModel)
                {

                }

                textelement(CostingMethod)
                {

                }

                textelement(PurchSerieSize)
                {

                }

                textelement(PrimaryVendor)
                {

                }

                textelement(VendItemNumber)
                {

                }

                fieldelement(Blocked; BCResource.Blocked)
                {

                }

                textelement(Alternative)
                {

                }

                textelement(AltResNumber)
                {

                }

                textelement(Commission)
                {

                }
                textelement(NetWeight)
                {

                }
                textelement(Volume)
                {

                }
                textelement(TariffNumber)
                {

                }
                textelement(UnitCode)
                {
                    trigger OnAfterAssignVariable()
                    var
                        units: Record "Resource Unit of Measure";
                    begin
                        Units.INIT;
                        Units."Resource No." := BCResource."No.";
                        Units.Code := UnitCode;
                        Units."Qty. per Unit of Measure" := 1;
                        Units.INSERT;
                        BCResource."Base Unit of Measure" := UnitCode;
                    end;
                }
                textelement(CostType)
                {

                }
                fieldelement(ExtraCost; BCResource."Indirect Cost %")
                {

                }
                textelement(PurchCostModel)
                {

                }
                textelement(ManLocation)
                {

                }
                textelement(InvenLocation)
                {

                }
                textelement(Department)
                {
                    trigger OnAfterAssignVariable()
                    var

                    begin
                        if Department <> '' then
                            DefaultDimensionSet.InsertDefaultDimensionBase('AFDELING', Department, BCResource."No.", 156);
                    end;
                }
                textelement(Centre)
                {
                    trigger OnAfterAssignVariable()
                    var

                    begin
                        if Centre <> '' then
                            DefaultDimensionSet.InsertDefaultDimensionBase('BÆRER', Centre, BCResource."No.", 156);
                    end;
                }
                textelement(Purpose)
                {
                    trigger OnAfterAssignVariable()
                    var

                    begin
                        if Purpose <> '' then
                            DefaultDimensionSet.InsertDefaultDimensionBase('Formål', Purpose, BCResource."No.", 156);
                    end;
                }
                fieldelement(SalesPrice; BCResource."Unit Price")
                {

                }

                trigger OnBeforeInsertRecord()
                //Get Resource Template
                Begin
                    ConfigTemplateLine.SetRange("Data Template Code", 'RESOURCE');
                    ConfigTemplateLine.SetRange("Table ID", 156);
                    RecRef.GetTable(BCResource);
                    if ConfigTemplateLine.FindSet(false, false) then begin
                        repeat
                            if ConfigTemplateLine."Field ID" <> 0 then begin
                                FieldRef := RecRef.Field(ConfigTemplateLine."Field ID");
                                TemplateVal.ValidateFieldValue(RecRef, FieldRef, ConfigTemplateLine."Default Value", true, 0);
                            end;
                        until ConfigTemplateLine.next = 0;
                    end;
                    RecRef.SETTABLE(BCResource);

                    // Get Resource group template
                    ConfigTemplateLine.SETRANGE("Data Template Code", 'R-' + COPYSTR(Group, 1, 8));
                    ConfigTemplateLine.SETRANGE("Table ID", 156);
                    RecRef.GETTABLE(BCResource);
                    if ConfigTemplateLine.FINDSET(FALSE, FALSE) then begin
                        repeat
                            if ConfigTemplateLine."Field ID" <> 0 then begin
                                FieldRef := RecRef.FIELD(ConfigTemplateLine."Field ID");
                                TemplateVal.ValidateFieldValue(RecRef, FieldRef, ConfigTemplateLine."Default Value", TRUE, 0);
                            end;
                        Until ConfigTemplateLine.NEXT = 0;
                    end;
                    RecRef.SETTABLE(BCResource);

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
        Res: Record Resource;
        Units: Record "Resource Unit of Measure";
    begin
        Res.DeleteAll();
        Units.DeleteAll();
        "Default Dimension".SETFILTER("Default Dimension"."Table ID", '156');
        "Default Dimension".DELETEALL();
    end;

    var
        ConfigTemplateLine: Record "Config. Template Line";
        FieldRef: FieldRef;
        RecRef: RecordRef;
        TemplateVal: Codeunit "Config. Validate Management";
        "Default Dimension": Record "Default Dimension";
        DefaultDimensionSet: Codeunit "Multi C5 Dimension";
}