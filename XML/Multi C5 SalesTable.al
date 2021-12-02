xmlport 70025 "Multi C5 SalesTable"
{

    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Import_SalesTable)
        {
            tableelement("Sales Header"; "Sales Header")
            {
                XmlName = 'SalesTable';
                fieldelement(Number; "Sales Header"."No.")
                {
                }
                fieldelement(Status; "Sales Header"."Document Type")
                {
                }
                textelement(SearchName)
                {
                }
                fieldelement(Created; "Sales Header"."Order Date")
                {

                    trigger OnAfterAssignField()
                    begin
                        "Sales Header"."Document Date" := "Sales Header"."Order Date";
                    end;
                }
                textelement(DeliveryDate)
                {

                    trigger OnAfterAssignVariable()
                    var
                        Dato: Date;
                    begin
                        Evaluate(Dato, DeliveryDate);
                        if Dato < Today then
                            Dato := Today;

                        "Sales Header"."Shipment Date" := Dato;
                        "Sales Header"."Requested Delivery Date" := Dato;   //DSDK.01
                    end;
                }
                fieldelement(Account; "Sales Header"."Sell-to Customer No.")
                {

                    trigger OnAfterAssignField()
                    var
                        Cust: Record Customer;
                    begin
                        if Cust.Get("Sales Header"."Sell-to Customer No.") then begin
                            if Cust.Blocked <> Cust.Blocked::" " then begin
                                Cust.Blocked := Cust.Blocked;  //0;
                                Cust.Modify;
                            end;
                        end;
                    end;
                }
                fieldelement(Name; "Sales Header"."Sell-to Customer Name")
                {
                }
                fieldelement(Address1; "Sales Header"."Sell-to Address")
                {
                }
                fieldelement(Address2; "Sales Header"."Sell-to Address 2")
                {
                }
                fieldelement(ZipCode; "Sales Header"."Sell-to Post Code")
                {
                }
                fieldelement(City; "Sales Header"."Sell-to City")
                {
                }
                textelement(Country)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        if not CountryCode.Get(Country) then begin
                            CountryCode.Init;
                            CountryCode.Validate(Code, Country);
                            CountryCode.Insert;
                        end;
                        "Sales Header"."Sell-to Country/Region Code" := Country;
                    end;
                }
                fieldelement(Attention; "Sales Header"."Sell-to Contact")
                {
                }
                textelement(Phone)
                {
                }
                textelement(Fax)
                {
                }
                fieldelement(InvoiceAccount; "Sales Header"."Bill-to Customer No.")
                {
                }
                textelement(Group)
                {
                }
                textelement(FixedDiscPct)
                {
                }
                textelement(PriceGroup)
                {
                }
                textelement(CashDisc)
                {
                }
                fieldelement(Currency; "Sales Header"."Currency Code")
                {
                }
                textelement(Language)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        case Language of
                            '0':
                                "Sales Header"."Language Code" := 'DAN';
                            '1':
                                "Sales Header"."Language Code" := 'DAN';
                            '2':
                                "Sales Header"."Language Code" := 'ENU';
                            '3':
                                "Sales Header"."Language Code" := 'DEU';
                            '4':
                                "Sales Header"."Language Code" := 'FRA';
                            '5':
                                "Sales Header"."Language Code" := 'ITA';
                            '6':
                                "Sales Header"."Language Code" := 'NLD';
                            '7':
                                "Sales Header"."Language Code" := 'ISL';
                        end;
                    end;
                }
                fieldelement(Payment; "Sales Header"."Payment Terms Code")
                {

                    trigger OnAfterAssignField()
                    begin
                        if "Sales Header"."Payment Terms Code" = '' then
                            "Sales Header"."Payment Terms Code" := 'BLANK';
                    end;
                }
                fieldelement(Delivery; "Sales Header"."Shipment Method Code")
                {
                }
                textelement(Blocked)
                {
                }
                fieldelement(SalesRep; "Sales Header"."Salesperson Code")
                {
                    FieldValidate = no;

                    trigger OnAfterAssignField()
                    var
                        Salesperson: Record "Salesperson/Purchaser";
                    begin
                        if not Salesperson.Get("Sales Header"."Salesperson Code") then begin
                            Salesperson.Init;
                            Salesperson.Code := "Sales Header"."Salesperson Code";
                            Salesperson.Name := "Sales Header"."Salesperson Code";
                            Salesperson.Insert;
                        end;
                    end;
                }
                textelement(Department)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        if Department <> '' then begin
                            DefaultDimensionSet.InsertDefaultDimension('AFDELING', Department, '1', "Sales Header"."No.", 36);
                        end;
                    end;
                }
                textelement(Centre)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        if Centre <> '' then begin
                            DefaultDimensionSet.InsertDefaultDimension('BÆRER', Centre, '1', "Sales Header"."No.", 36);
                        end;
                    end;
                }
                textelement(Purpose)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        if Purpose <> '' then begin
                            DefaultDimensionSet.InsertDefaultDimension('FORMÅL', Purpose, '1', "Sales Header"."No.", 36);
                        end;
                    end;
                }
                fieldelement(VatNumber; "Sales Header"."VAT Registration No.")
                {
                }
                fieldelement(DlvAddress1; "Sales Header"."Ship-to Name")
                {
                }
                fieldelement(DlvAddress2; "Sales Header"."Ship-to Address")
                {
                }
                fieldelement(DlvAddress3; "Sales Header"."Ship-to Address 2")
                {
                }
                fieldelement(DlvZip; "Sales Header"."Ship-to Post Code")
                {
                }
                fieldelement(DlvCity; "Sales Header"."Ship-to City")
                {
                }
                textelement(DlvCountry)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        if not CountryCode.Get(DlvCountry) then begin
                            CountryCode.Init;
                            CountryCode.Validate(Code, DlvCountry);
                            CountryCode.Insert;
                        end;
                        "Sales Header"."Ship-to Country/Region Code" := DlvCountry;
                    end;
                }
                fieldelement(YourRef; "Sales Header"."Your Reference")
                {
                }
                fieldelement(OurRef; "Sales Header"."External Document No.")
                {
                }
                fieldelement(ReferenceNumber; "Sales Header".Comment)
                {
                }
                textelement(Email)
                {
                }
                textelement(DlvEmail)
                {
                }
                fieldelement(EANNumber; "Sales Header"."OIOUBL-GLN")
                {
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
    var
        Header: Record "Sales Header";
        Line: Record "Sales Line";
        Bem: Record "Comment Line";
    begin
        Line.DeleteAll;
        Header.DeleteAll;
        "Default Dimension".SetFilter("Table ID", '36');
        "Default Dimension".DeleteAll;
        "Default Dimension".SetFilter("Table ID", '37');
        "Default Dimension".DeleteAll;
    end;

    var
        "Default Dimension": Record "Default Dimension";
        CountryCode: Record "Country/Region";
        DefaultDimensionSet: Codeunit "Multi C5 Dimension";


}

