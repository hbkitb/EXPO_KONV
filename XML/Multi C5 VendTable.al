xmlport 70009 "Multi C5 VendTable"
{
    Format = VariableText;
    FormatEvaluate = Legacy;
    Direction = Import;
    TextEncoding = WINDOWS;
    FieldSeparator = ';';
    FieldDelimiter = '¤';

    schema
    {
        textelement(Import_VendTable)
        {
            tableelement(VendTable; Vendor)
            {
                fieldelement(Account; VendTable."No.")
                {

                }
                fieldelement(Name; VendTable.Name)
                {

                }
                fieldelement(Adresse1; VendTable.Address)
                {

                }
                fieldelement(Adresse2; VendTable."Address 2")
                {

                }
                fieldelement(ZipCode; VendTable."Post Code")
                {

                }
                fieldelement(City; Vendtable.City)
                {

                }
                fieldelement(Country; VendTable."Country/Region Code")
                {
                    trigger OnAfterAssignField()
                    var
                        Land: Record "Country/Region";

                    begin
                        if not Land.Get(VendRec."Country/Region Code") THEN begin
                            Land.Init();
                            Land.Validate(Code, VendRec."Country/Region Code");
                            Land.Insert;
                        end;
                    end;

                }
                fieldelement(Att; VendTable.Contact)
                {

                }
                //HBK I stedet for fieldelement(Phone; VendTable."Phone No.")//
                textelement(PhoneTxt)
                {
                    trigger OnAfterAssignVariable()

                    var

                    begin
                        VendTable."Phone No." := DelChr(PhoneTxt, '=', 'abcdefprivnqtsuvxyz');
                    End;

                }
                fieldelement(Fax; VendTable."Fax No.")
                {

                }
                /*hbk
                fieldelement(InvoiceAccount; VendTable."Pay-to Vendor No.")
                {
                    
                }
                */

                textelement(InvAcc)
                {


                }
                textelement(Group)
                {
                    trigger OnAfterAssignVariable()
                    var

                    begin

                        if not vendorPostingGroup.Get(Group) then begin
                            VendorPostingGroup.Init();
                            VendorPostingGroup.Code := Group;
                            VendorPostingGroup.Insert;
                        end;
                        VendTable."Gen. Bus. Posting Group" := Group;
                        VendTable."VAT Bus. Posting Group" := 'Danmark';

                        VendTable."Vendor Posting Group" := Group
                    end;
                }
                textelement(FixedDisc)
                {
                    trigger OnAfterAssignVariable()

                    var
                        FB: Record "Vendor Invoice Disc.";

                    begin
                        if not fb.get(VendTable."No.") then begin
                            FB.Init();
                            FB.Code := VendTable."No.";
                            Evaluate(FB."Discount %", FixedDisc);
                            FB.Insert();  //HBK
                        end;

                    end;
                }
                textelement(Approved)
                {

                }
                fieldelement(Currency; VendTable."Currency Code")
                {

                }
                textelement(Language)
                {
                    trigger OnAfterAssignVariable()

                    var

                    begin
                        case Language of
                            '0':
                                VendTable."Language Code" := 'DAN';
                            '1':
                                VendTable."Language Code" := 'DAN';
                            '2':
                                VendTable."Language Code" := 'ENU';
                            '3':
                                VendTable."Language Code" := 'DEU';
                            '4':
                                VendTable."Language Code" := 'FRA';
                            '5':
                                VendTable."Language Code" := 'ITA';
                            '6':
                                VendTable."Language Code" := 'NLD';
                            '7':
                                VendTable."Language Code" := 'ISL';
                        end;
                    end;
                }
                fieldelement(Payment; VendTable."Payment Terms Code")
                {
                    trigger OnAfterAssignField()

                    var

                    begin
                        if VendTable."Payment Terms Code" = '' then
                            VendTable."Payment Terms Code" := 'BLANK';
                    end;
                }
                fieldelement(Delivery; VendTable."Shipment Method Code")
                {

                }
                //fieldelement(Blocked; VendTable.Blocked)
                textelement(BlockedVend)
                {
                    //trigger OnAfterAssignField()
                    trigger OnAfterAssignVariable()
                    var
                    begin
                        //case VendTable.Blocked of
                        case BlockedVend of
                            '0':
                                VendTable.Blocked := VendTable.Blocked::" ";
                            '1':
                                VendTable.Blocked := VendTable.Blocked::Payment;
                            '2':
                                VendTable.Blocked := VendTable.Blocked::All;
                            '3':
                                VendTable.Blocked := VendTable.Blocked::Payment;
                        end;
                    end;
                }

                //HBK i stedet for fieldelement(Purchaser; VendTable."Purchaser Code")
                fieldelement(PurchPerson; VendTable."Purchaser Code")
                {
                    //HBK i stedet for custtable.invoiceaccount

                    trigger OnAfterAssignField()

                    var
                        PurchCheck: Record "Salesperson/Purchaser";

                    begin
                        IF NOT PurchCheck.Get(VendTable."Purchaser Code") then
                            VendTable."Purchaser Code" := '';
                    End;


                }
                textelement(Vat)
                {

                }
                textelement(Giro)
                {

                }
                //HBK i stedet for fieldelement(VatNumber; VendTable."VAT Registration No.")
                textelement(VatNoTxt)
                {
                    trigger OnAfterAssignVariable()

                    var

                    begin
                        VendTable."VAT Registration No." := DelChr(VatNoTxt, '=', 'abcdefprivtsuvxyz');
                    End;

                }
                textelement(Interest)
                {

                }
                textelement(Department)
                {
                    trigger OnAfterAssignVariable()
                    var
                    begin
                        If (Department <> '') then
                            DefaultDimensionSet.InsertDefaultDimension('AFDELING', Department, '1', VendTable."No.", 23);
                    end;
                }
                textelement(Centre)
                {
                    trigger OnAfterAssignVariable()
                    var
                    begin
                        If (Centre <> '') then
                            DefaultDimensionSet.InsertDefaultDimension('BÆRER', Centre, '1', VendTable."No.", 23);
                    end;
                }
                textelement(Purpose)
                {
                    trigger OnAfterAssignVariable()
                    var
                    begin
                        If (Purpose <> '') then
                            DefaultDimensionSet.InsertDefaultDimension('FORMÅL', Purpose, '1', VendTable."No.", 23);
                    end;
                }
                textelement(EDIAdr)
                {

                }
                textelement(BalanceMax)
                {

                }
                fieldelement(SearchName; VendTable."Search Name")
                {

                }
                fieldelement(Email; VendTable."E-Mail")
                {

                }
                fieldelement(URL; Vendtable."Home Page")
                {

                }
                textelement(EANNumber)
                {

                }
                textelement(LandeType)
                {

                }

                trigger OnBeforeInsertRecord()

                var
                    Bem: Record "Comment Line";
                    ConfigTemplateLine: Record "Config. Template Line";
                    FieldRef: FieldRef;
                    RecRef: RecordRef;
                    TemplateVal: Codeunit "Config. Validate Management";
                    TemplateMgt: Codeunit "Config. Template Management";

                begin
                    ConfigTemplateLine.SetRange("Data Template Code", 'Kreditor');
                    ConfigTemplateLine.SetRange("Table ID", 23);
                    RecRef.GetTable(VendTable);
                    if ConfigTemplateLine.FindSet(false, false) then begin
                        repeat
                            if ConfigTemplateLine."Field ID" <> 0 then begin
                                FieldRef := RecRef.Field(ConfigTemplateLine."Field ID");
                                TemplateVal.ValidateFieldValue(RecRef, FieldRef, ConfigTemplateLine."Default Value", true, 0);
                            end;
                        until ConfigTemplateLine.Next = 0;
                    end;

                    RecRef.SetTable(VendTable);

                    //Get template info based on Contry Type
                    ConfigTemplateLine.SetRange("Data Template Code", 'KL-' + LandeType);
                    ConfigTemplateLine.SetRange("Table ID", 23);
                    RecRef.GetTable(VendTable);
                    if ConfigTemplateLine.FindSet(false, false) then begin
                        repeat
                            if ConfigTemplateLine."Field ID" <> 0 then begin
                                FieldRef := RecRef.Field(ConfigTemplateLine."Field ID");
                                TemplateVal.ValidateFieldValue(RecRef, FieldRef, ConfigTemplateLine."Default Value", true, 0);
                            end;
                        until ConfigTemplateLine.Next = 0;
                    end;

                    RecRef.SetTable(VendTable);

                    //Get template info based on group
                    ConfigTemplateLine.SetRange("Data Template Code", 'K-' + CopyStr(Group, 1, 8));
                    ConfigTemplateLine.SetRange("Table ID", 23);
                    RecRef.GetTable(VendTable);
                    if ConfigTemplateLine.FindSet(false, false) then begin
                        repeat
                            if ConfigTemplateLine."Field ID" <> 0 then begin
                                FieldRef := RecRef.Field(ConfigTemplateLine."Field ID");
                                TemplateVal.ValidateFieldValue(RecRef, FieldRef, ConfigTemplateLine."Default Value", true, 0);
                            end;
                        until ConfigTemplateLine.Next = 0;
                    end;

                    RecRef.SetTable(VendTable);

                    if not VendorPostingGroup.Get(Group) then begin
                        VendorPostingGroup.Init();
                        VendorPostingGroup.Code := Group;
                        VendorPostingGroup.Description := 'Kre.postgruppe fra C5';
                        VendorPostingGroup.Insert;
                    end;
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

    var
        VendRec: Record Vendor;
        "Dimension Value": Record "Dimension Value";
        "Default Dimension": Record "Default Dimension";
        VendorPostingGroup: Record "Vendor Posting Group";
        Contact: Record Contact;
        ContBusRel: Record "Contact Business Relation";
        DefaultDimensionSet: Codeunit "Multi C5 Dimension";

    trigger OnInitXmlPort()
    var
        Bem: Record "Comment Line";

    begin
        Clear(ContBusRel);
        Clear(Contact);
        ContBusRel.SetRange(ContBusRel."Link to Table", ContBusRel."Link to Table"::Vendor);
        if ContBusRel.FindSet() then
            repeat
                Contact.SetRange(Contact."No.", ContBusRel."Contact No.");
                if Contact.FindSet() then
                    repeat
                        Contact.Delete();
                    until Contact.Next() = 0;
                ContBusRel.Delete();
            until ContBusRel.Next() = 0;
        Commit();

        VendRec.DeleteAll();
        "Default Dimension".SetFilter("Table ID", '23');
        "Default Dimension".DeleteAll();
        Bem.SetFilter("Table Name", 'Vendor');
        Bem.DeleteAll();

    end;
}