xmlport 70005 "Multi C5 CustTable"
{
    Format = VariableText;
    FormatEvaluate = Legacy;
    Direction = Import;
    TextEncoding = WINDOWS;
    FieldSeparator = ';';
    FieldDelimiter = '¤';
    schema
    {
        textelement(Import_CustTable)
        {
            tableelement(CustTable; Customer)
            {
                fieldelement(Account; CustTable."No.")
                {

                }
                fieldelement(Name; CustTable.Name)
                {

                }
                fieldelement(Adr1; CustTable.Address)
                {

                }
                fieldelement(Adr2; CustTable."Address 2")
                {

                }
                fieldelement(PostCode; CustTable."Post Code")
                {

                }
                fieldelement(City; CustTable.City)
                {

                }
                fieldelement(Country; CustTable."Country/Region Code")
                {

                    trigger OnAfterAssignField()
                    var
                        Land: Record "Country/Region";

                    begin
                        if not Land.Get(CustRec."Country/Region Code") THEN begin
                            Land.Init();
                            Land.Validate(Code, CustRec."Country/Region Code");
                            Land.Insert;
                        end;
                    end;

                }
                fieldelement(Att; CustTable.Contact)
                {

                }
                /*
                fieldelement(Phone; Custtable."Phone No.")
                {

                }
                */

                //HBK i stedet for custtable.phone no
                textelement(PhoneTxt)
                {
                    trigger OnAfterAssignVariable()

                    var

                    begin
                        CustTable."Phone No." := DelChr(PhoneTxt, '=', 'abcdefprivnqtsuvxyz');
                    End;

                }
                fieldelement(Fax; CustTable."Fax No.")
                {

                }
                /*
                fieldelement(InvoiceAccount; CustTable."Bill-to Customer No.")
                {

                }
                */

                //HBK i stedet for custtable.invoiceaccount
                textelement(InvAcc)
                {


                }
                textelement(Group)
                {
                    trigger OnAfterAssignVariable()
                    var

                    begin
                        if not CustomerPostingGroup.Get(Group) then begin
                            CustomerPostingGroup.Init();
                            CustomerPostingGroup.Code := Group;
                            CustomerPostingGroup.Insert;
                        end;
                        CustTable."Gen. Bus. Posting Group" := Group;
                        CustTable."VAT Bus. Posting Group" := 'Danmark';

                        CustTable."Customer Posting Group" := Group;
                    end;

                }
                textelement(FixedDisc)
                {
                    trigger OnAfterAssignVariable()
                    var
                        FB: Record "Cust. Invoice Disc.";

                    begin
                        if not FB.Get(CustTable."No.") THEN begin
                            FB.Init();
                            FB.Code := CustTable."No.";
                            Evaluate(FB."Discount %", FixedDisc);
                            FB.Insert();
                        end;
                    end;
                }
                textelement(Approved)
                {

                }
                fieldelement(PriceGroup; CustTable."Customer Price Group")
                {

                }
                fieldelement(Currency; CustTable."Currency Code")
                {

                }
                textelement(Language)
                {
                    trigger OnAfterAssignVariable()

                    var

                    begin
                        case Language of
                            '0':
                                CustTable."Language Code" := 'DAN';
                            '1':
                                CustTable."Language Code" := 'DAN';
                            '2':
                                CustTable."Language Code" := 'ENU';
                            '3':
                                CustTable."Language Code" := 'DEU';
                            '4':
                                CustTable."Language Code" := 'FRA';
                            '5':
                                CustTable."Language Code" := 'ITA';
                            '6':
                                CustTable."Language Code" := 'NLD';
                            '7':
                                CustTable."Language Code" := 'ISL';
                        end;
                    end;
                }
                fieldelement(Payment; CustTable."Payment Terms Code")
                {
                    trigger OnAfterAssignField()


                    var

                    begin
                        if CustTable."Payment Terms Code" = '' then
                            CustTable."Payment Terms Code" := 'BLANK';
                    end;
                }
                fieldelement(Delivery; CustTable."Shipment Method Code")
                {

                }
                //fieldelement(Blocked; CustTable.Blocked)
                textelement(CustBlock)
                {
                    //trigger OnAfterAssignField()
                    trigger OnAfterAssignvariable()
                    var
                    begin
                        //case CustTable.Blocked of
                        case CustBlock of
                            '0':
                                CustTable.Blocked := CustTable.Blocked::" ";
                            '1':
                                CustTable.Blocked := CustTable.Blocked::Invoice;

                            '2':
                                CustTable.Blocked := CustTable.Blocked::Ship;
                            '3':
                                CustTable.Blocked := CustTable.Blocked::All;
                        end;
                    end;
                }
                fieldelement(SalesRep; CustTable."Salesperson Code")
                {
                    //HBK i stedet for custtable.invoiceaccount

                    trigger OnAfterAssignField()

                    var
                        salesCheck: Record "Salesperson/Purchaser";

                    begin
                        IF NOT salesCheck.Get(CustTable."Salesperson Code") then
                            CustTable."Salesperson Code" := '';
                    End;


                }
                textelement(VAT)
                {

                }
                textelement(Giro)
                {

                }

                /*
                fieldelement(VATNumber; Custtable."VAT Registration No.")
                {

                }
                */
                //HBK i stedet for custtable.invoiceaccount
                textelement(VatNoTxt)
                {
                    trigger OnAfterAssignVariable()

                    var

                    begin
                        CustTable."VAT Registration No." := DelChr(VatNoTxt, '=', 'abcdefprivtsuvxyz');
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
                            DefaultDimensionSet.InsertDefaultDimension('AFDELING', Department, '1', CustTable."No.", 18);
                    end;
                }
                textelement(Centre)
                {
                    trigger OnAfterAssignVariable()
                    var
                    begin
                        If (Centre <> '') then
                            DefaultDimensionSet.InsertDefaultDimension('BÆRER', Centre, '1', CustTable."No.", 18);
                    end;
                }
                textelement(Purpose)
                {

                }
                textelement(EDIAdr)
                {
                    trigger OnAfterAssignVariable()
                    var
                    begin
                        If (Purpose <> '') then
                            DefaultDimensionSet.InsertDefaultDimension('FORMÅL', Purpose, '1', CustTable."No.", 18);
                    end;
                }
                fieldelement(BalanceMax; CustTable."Credit Limit (LCY)")
                {

                }
                fieldelement(SearchName; CustTable."Search Name")
                {

                }
                fieldelement(Email; CustTable."E-Mail")
                {

                }
                fieldelement(URL; CustTable."Home Page")
                {

                }
                fieldelement(EANNumber; Custtable.GLN)
                {

                }
                textelement(LandeType)
                {

                }
                fieldelement(Rabatgruppe; CustTable."Customer Disc. Group")
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
                    ConfigTemplateLine.SetRange("Data Template Code", 'Debitor');
                    ConfigTemplateLine.SetRange("Table ID", 18);
                    RecRef.GetTable(CustTable);
                    if ConfigTemplateLine.FindSet(false, false) then begin
                        repeat
                            if ConfigTemplateLine."Field ID" <> 0 then begin
                                FieldRef := RecRef.Field(ConfigTemplateLine."Field ID");
                                TemplateVal.ValidateFieldValue(RecRef, FieldRef, ConfigTemplateLine."Default Value", true, 0);
                            end;
                        until ConfigTemplateLine.Next = 0;
                    end;

                    RecRef.SetTable(CustTable);

                    //Get template info based on Contry Type
                    ConfigTemplateLine.SetRange("Data Template Code", 'DL-' + LandeType);
                    ConfigTemplateLine.SetRange("Table ID", 18);
                    RecRef.GetTable(CustTable);
                    if ConfigTemplateLine.FindSet(false, false) then begin
                        repeat
                            if ConfigTemplateLine."Field ID" <> 0 then begin
                                FieldRef := RecRef.Field(ConfigTemplateLine."Field ID");
                                TemplateVal.ValidateFieldValue(RecRef, FieldRef, ConfigTemplateLine."Default Value", true, 0);
                            end;
                        until ConfigTemplateLine.Next = 0;
                    end;

                    RecRef.SetTable(CustTable);

                    //Get template info based on group
                    ConfigTemplateLine.SetRange("Data Template Code", 'D-' + CopyStr(Group, 1, 8));
                    ConfigTemplateLine.SetRange("Table ID", 18);
                    RecRef.GetTable(CustTable);
                    if ConfigTemplateLine.FindSet(false, false) then begin
                        repeat
                            if ConfigTemplateLine."Field ID" <> 0 then begin
                                FieldRef := RecRef.Field(ConfigTemplateLine."Field ID");
                                TemplateVal.ValidateFieldValue(RecRef, FieldRef, ConfigTemplateLine."Default Value", true, 0);
                            end;
                        until ConfigTemplateLine.Next = 0;
                    end;

                    RecRef.SetTable(CustTable);

                    if not CustomerPostingGroup.Get(Group) then begin
                        CustomerPostingGroup.Init();
                        CustomerPostingGroup.Code := Group;
                        CustomerPostingGroup.Description := 'Deb.postgruppe fra C5';
                        CustomerPostingGroup.Insert;
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
        CustRec: Record Customer;
        "Dimension Value": Record "Dimension Value";
        "Default Dimension": Record "Default Dimension";
        CustomerPostingGroup: Record "Customer Posting Group";
        Contact: Record Contact;
        ContBusRel: Record "Contact Business Relation";
        DefaultDimensionSet: Codeunit "Multi C5 Dimension";

    trigger OnInitXmlPort()
    var
        Bem: Record "Comment Line";

    begin
        Clear(ContBusRel);
        Clear(Contact);
        ContBusRel.SetRange(ContBusRel."Link to Table", ContBusRel."Link to Table"::Customer);
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

        CustRec.DeleteAll();
        "Default Dimension".SetFilter("Table ID", '18');
        "Default Dimension".DeleteAll();
        Bem.SetFilter("Table Name", 'Customer');
        Bem.DeleteAll();

    end;

}