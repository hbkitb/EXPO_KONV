
xmlport 70100 "Multi C5 InvenITB"
{
    Format = VariableText;
    FormatEvaluate = Legacy;
    Direction = Import;
    TextEncoding = WINDOWS;
    FieldSeparator = ';';
    FieldDelimiter = '¤';
    schema
    {
        textelement(Import_InvenTable)
        {
            tableelement(InvenTable; Item)
            {
                fieldelement(ItemNumber; InvenTable."No.")
                //textelement(nummer)
                {
                    /*
                    //trigger OnAfterAssignField()gger 
                    trigger OnBeforePassField()

                    var

                    begin

                        Message(InvenTable."No.");

                    end;
                    */
                }
                fieldelement(ItemName1; InvenTable.Description)
                {

                }
                fieldelement(ItemName2; InvenTable."Description 2")
                {

                }
                textelement(ItemName3)
                {

                }
                textelement(ItemType)
                {
                    trigger OnAfterAssignVariable()
                    var

                    begin
                        if (ItemType = '2') OR (ItemType = '0') then
                            ItemType := '0'
                        else
                            if ItemType = '4' then
                                ItemType := '2';

                        Evaluate(InvenTable.Type, ItemType);

                    end;
                }

                fieldelement(DiscGroup; InvenTable."Item Disc. Group")
                {
                    trigger OnAfterAssignField()
                    var

                    begin
                        if not ItemDiscountGroup.Get(InvenTable."Item Disc. Group") then
                            InvenTable."Item Disc. Group" := '';
                    end;
                }
                /*
                textelement(Itemdisc)
                {

                }*/

                fieldelement(CostPrice; InvenTable."Unit Cost")
                {
                    trigger OnAfterAssignField()
                    var

                    begin
                        InvenTable."Standard Cost" := InvenTable."Unit Cost";
                        InvenTable."Last Direct Cost" := InvenTable."Unit Cost" / ((InvenTable."Indirect Cost %" + 100)) * 100;

                    end;
                }
                textelement(iGroup)   //igroup hbk
                {
                    trigger OnAfterAssignVariable()
                    var
                        IPG: Record "Inventory Posting Group";
                    begin
                        if not IPG.Get(iGroup) then begin
                            IPG.Init();
                            IPG.Code := iGroup;
                            IPG.Insert();
                        end;
                        InvenTable."Inventory Posting Group" := iGroup;
                    end;
                }
                textelement(SalesGroup)
                {

                }
                textelement(CostingMethod)
                {

                    trigger OnAfterAssignVariable()
                    var

                    begin
                        if CostingMethod = '2' then
                            InvenTable."Costing Method" := InvenTable."Costing Method"::Standard  //'4'
                        else
                            if CostingMethod = '4' then
                                CostingMethod := '2';

                        Evaluate(InvenTable."Costing Method", CostingMethod);

                    end;

                }
                textelement(PurchSeriesSize)
                {

                }
                fieldelement(PrimaryVendor; InvenTable."Vendor No.")
                //textelement(invvendno)
                {

                }
                fieldelement(VendItemNumber; InvenTable."Vendor No.")
                //textelement(vendino)
                {

                }
                fieldelement(Blocked; InvenTable.Blocked)
                {

                }
                textelement(Alternative)
                {

                }
                textelement(AltItemNumber)
                {
                    trigger OnAfterAssignVariable()
                    var
                        ALT: Record "Item Substitution";

                    begin
                        if AltItemNumber <> '' then begin
                            ALT.Init();
                            ALT.Type := ALT.Type::Item;  //0;
                            ALT."No." := InvenTable."No.";
                            ALT."Substitute Type" := ALT."Substitute Type"::Item; //0;
                            ALT."Substitute No." := AltItemNumber;
                            ALT.Insert();
                        end;
                    end;
                }
                textelement(Commission)
                {

                }
                fieldelement(NetWeight; InvenTable."Net Weight")
                {

                }
                fieldelement(Volume; InvenTable."Unit Volume")
                {

                }
                textelement(TariffNumber)
                {
                    trigger OnAfterAssignVariable()
                    var
                        Tariff: Record "Tariff Number";

                    begin
                        if not Tariff.Get(TariffNumber) then begin
                            //Tariff.Insert();
                            Tariff."No." := TariffNumber;
                            Tariff.Insert();
                        end;

                        InvenTable."Tariff No." := TariffNumber;
                    end;
                }
                textelement(UnitCode)
                {
                    trigger OnAfterAssignVariable()

                    var
                        Units: Record "Unit of Measure";
                        ItemUnit: Record "Item Unit of Measure";

                    begin
                        if UnitCode = '' then
                            UnitCode := 'STK';

                        if not Units.Get(UnitCode) then begin
                            Units.Init();
                            Units.Code := UnitCode;
                            Units.Description := 'Styk';
                            Units.Insert();
                        end;

                        InvenTable."Base Unit of Measure" := UnitCode;
                        IF not ItemUnit.Get(inventable."No.", UnitCode) then begin
                            ItemUnit.Init();
                            ItemUnit."Item No." := InvenTable."No.";  //nummer
                            ItemUnit.Code := UnitCode;
                            ItemUnit."Qty. per Unit of Measure" := 1;
                            ItemUnit.Weight := InvenTable."Net Weight";
                            ItemUnit.Cubage := InvenTable."Unit Volume";
                            ItemUnit.Insert();
                        end;

                        InvenTable."Sales Unit of Measure" := UnitCode;
                        InvenTable."Purch. Unit of Measure" := UnitCode;


                    end;
                }
                textelement(CostType)
                {

                }
                fieldelement(ExtraCost; InvenTable."Indirect Cost %")
                {

                }
                textelement(PurchCostModel)
                {

                }
                textelement(MainLocation)
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
                            DefaultDimensionSet.InsertDefaultDimensionBase('AFDELING', Department, InvenTable."No.", 27);
                    end;
                }
                textelement(Centre)
                {
                    trigger OnAfterAssignVariable()
                    var

                    begin
                        if Centre <> '' then
                            DefaultDimensionSet.InsertDefaultDimensionBase('BÆRER', Centre, InvenTable."No.", 27);
                    end;
                }
                textelement(Purpose)
                {
                    trigger OnAfterAssignVariable()
                    var

                    begin
                        if Purpose <> '' then
                            DefaultDimensionSet.InsertDefaultDimensionBase('Formål', Purpose, InvenTable."No.", 27);
                    end;
                }

                textelement(CostPriceUnit)
                {

                }
                fieldelement(SalesPrice; InvenTable."Unit Price")
                {

                }
                textelement(CostModel)
                {

                }


                trigger OnBeforeInsertRecord()
                /*var

                begin
                    Message(nummer);

                    inventable."No." := nummer;
                    Message(InvenTable."No.");
                end;*/

                //123
                var
                    ConfigTemplateLine: Record "Config. Template Line";
                    FieldRef: FieldRef;
                    RecRef: RecordRef;
                    TemplateVal: Codeunit "Config. Validate Management";
                    TemplateMgt: Codeunit "Config. Template Management";

                begin
                    //inventable."No." := nummer;   //hbk
                    ConfigTemplateLine.SetRange("Data Template Code", 'Vare');
                    ConfigTemplateLine.SetRange("Table ID", 27);
                    RecRef.GetTable(InvenTable);
                    if ConfigTemplateLine.FindSet(false, false) then begin
                        repeat
                            if ConfigTemplateLine."Field ID" <> 0 then begin
                                FieldRef := RecRef.Field(ConfigTemplateLine."Field ID");
                                TemplateVal.ValidateFieldValue(RecRef, FieldRef, ConfigTemplateLine."Default Value", true, 0);
                            end;
                        until ConfigTemplateLine.Next = 0;
                    end;

                    RecRef.SetTable(InvenTable);

                    //Get template info based on Contry Type
                    ConfigTemplateLine.SetRange("Data Template Code", 'I-' + COPYSTR(iGroup, 1, 8));  //hbk
                    ConfigTemplateLine.SetRange("Table ID", 27);
                    RecRef.GetTable(InvenTable);
                    if ConfigTemplateLine.FindSet(false, false) then begin
                        repeat
                            if ConfigTemplateLine."Field ID" <> 0 then begin
                                FieldRef := RecRef.Field(ConfigTemplateLine."Field ID");
                                TemplateVal.ValidateFieldValue(RecRef, FieldRef, ConfigTemplateLine."Default Value", true, 0);
                            end;
                        until ConfigTemplateLine.Next = 0;
                    end;

                    RecRef.SetTable(InvenTable);

                    if InvenTable.Type = Inventable.Type::Inventory then begin
                        //Get template info based on Type
                        ConfigTemplateLine.SetRange("Data Template Code", 'V-' + CopyStr(iGroup, 1, 8));  //hbk
                        ConfigTemplateLine.SetRange("Table ID", 27);
                        RecRef.GetTable(InvenTable);
                        if ConfigTemplateLine.FindSet(false, false) then begin
                            repeat
                                if ConfigTemplateLine."Field ID" <> 0 then begin
                                    FieldRef := RecRef.Field(ConfigTemplateLine."Field ID");
                                    TemplateVal.ValidateFieldValue(RecRef, FieldRef, ConfigTemplateLine."Default Value", true, 0);
                                end;
                            until ConfigTemplateLine.Next = 0;
                        end;

                        RecRef.SetTable(InvenTable);
                    end else
                        if InvenTable.Type = InvenTable.Type::Service then begin
                            //Get template info based on Type
                            ConfigTemplateLine.SetRange("Data Template Code", 'S-' + CopyStr(iGroup, 1, 8));  //hbk
                            ConfigTemplateLine.SetRange("Table ID", 27);
                            RecRef.GetTable(InvenTable);
                            if ConfigTemplateLine.FindSet(false, false) then begin
                                repeat
                                    if ConfigTemplateLine."Field ID" <> 0 then begin
                                        FieldRef := RecRef.Field(ConfigTemplateLine."Field ID");
                                        TemplateVal.ValidateFieldValue(RecRef, FieldRef, ConfigTemplateLine."Default Value", true, 0);
                                    end;
                                until ConfigTemplateLine.Next = 0;
                            end;

                            RecRef.SetTable(InvenTable);
                        end else
                            if InvenTable.Type = InvenTable.Type::Service then begin
                                //Get template info based on Type
                                ConfigTemplateLine.SetRange("Data Template Code", 'L-' + CopyStr(iGroup, 1, 8));  //hbk
                                ConfigTemplateLine.SetRange("Table ID", 27);
                                RecRef.GetTable(InvenTable);
                                if ConfigTemplateLine.FindSet(false, false) then begin
                                    repeat
                                        if ConfigTemplateLine."Field ID" <> 0 then begin
                                            FieldRef := RecRef.Field(ConfigTemplateLine."Field ID");
                                            TemplateVal.ValidateFieldValue(RecRef, FieldRef, ConfigTemplateLine."Default Value", true, 0);
                                        end;
                                    until ConfigTemplateLine.Next = 0;
                                end;

                                RecRef.SetTable(InvenTable);
                            end;
                end;  //123

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
        Comment: Record "Comment Line";
        ItemRec: Record Item;
        AltItem: Record "Item Substitution";
        BOMComponent: Record "BOM Component";
        CustPriceGroup: Record "Customer Price Group";
        DefaultDimension: Record "Default Dimension";

    begin
        Message('før11');
        ItemRec.Delete();  //hbk
        ItemUnit.DeleteAll();
        AltItem.DeleteAll();
        BOMComponent.DeleteAll();
        DefaultDimension.SetFilter("Table ID", '27');
        DefaultDimension.DeleteAll();
        Comment.SetFilter("Table Name", 'Item');
        Comment.DeleteAll();
        Message('efter');
    end;

    var

        ItemDiscountGroup: Record "Item Discount Group";

        DefaultDimensionSet: Codeunit "Multi C5 Dimension";

        ItemUnit: Record "Item Unit of Measure";

}

