xmlport 70030 "Multi C5 PurchTable"
{

    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Import_PurchTable)
        {
            tableelement("Purchase Header"; "Purchase Header")
            {
                XmlName = 'PurchTable';
                fieldelement(Number; "Purchase Header"."No.")
                {
                }
                fieldelement(Status; "Purchase Header"."Document Type")
                {
                }
                textelement(SearchName)
                {
                }
                fieldelement(Created; "Purchase Header"."Order Date")
                {

                    trigger OnAfterAssignField()
                    begin
                        "Purchase Header"."Document Date" := "Purchase Header"."Order Date";
                    end;
                }
                fieldelement(DeliveryDate; "Purchase Header"."Expected Receipt Date")
                {
                }
                fieldelement(Account; "Purchase Header"."Buy-from Vendor No.")
                {

                    trigger OnAfterAssignField()
                    var
                        Vend: Record Vendor;
                    begin
                        if Vend.Get("Purchase Header"."Buy-from Vendor No.") then begin
                            if Vend.Blocked <> Vend.Blocked::" " then begin
                                Vend.Blocked := Vend.Blocked::" ";  //0;
                                Vend.Modify;
                            end;
                        end;
                    end;
                }
                fieldelement(Name; "Purchase Header"."Buy-from Vendor Name")
                {
                }
                fieldelement(Address1; "Purchase Header"."Buy-from Address")
                {
                }
                fieldelement(Address2; "Purchase Header"."Buy-from Address 2")
                {
                }
                fieldelement(ZipCode; "Purchase Header"."Buy-from Post Code")
                {
                }
                fieldelement(City; "Purchase Header"."Buy-from City")
                {
                }
                fieldelement(Country; "Purchase Header"."Buy-from Country/Region Code")
                {
                    FieldValidate = no;
                }
                fieldelement(Attention; "Purchase Header"."Buy-from Contact")
                {
                }
                textelement(Phone)
                {
                }
                textelement(Fax)
                {
                }
                fieldelement(InvoiceAccount; "Purchase Header"."Pay-to Vendor No.")
                {
                }
                textelement(Group)
                {
                }
                textelement(FixedDiscPct)
                {
                }
                textelement(CashDisc)
                {
                }
                fieldelement(Currency; "Purchase Header"."Currency Code")
                {
                }
                textelement(Language)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        case Language of
                            '0':
                                "Purchase Header"."Language Code" := 'DAN';
                            '1':
                                "Purchase Header"."Language Code" := 'DAN';
                            '2':
                                "Purchase Header"."Language Code" := 'ENU';
                            '3':
                                "Purchase Header"."Language Code" := 'DEU';
                            '4':
                                "Purchase Header"."Language Code" := 'FRA';
                            '5':
                                "Purchase Header"."Language Code" := 'ITA';
                            '6':
                                "Purchase Header"."Language Code" := 'NLD';
                            '7':
                                "Purchase Header"."Language Code" := 'ISL';
                        end;
                    end;
                }
                fieldelement(Payment; "Purchase Header"."Payment Terms Code")
                {

                    trigger OnAfterAssignField()
                    begin
                        if "Purchase Header"."Payment Terms Code" = '' then
                            "Purchase Header"."Payment Terms Code" := 'BLANK';
                    end;
                }
                fieldelement(Delivery; "Purchase Header"."Shipment Method Code")
                {
                }
                textelement(Blocked)
                {
                }
                fieldelement(SalesRep; "Purchase Header"."Purchaser Code")
                {
                }
                textelement(Department)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        if Department <> '' then begin
                            DefaultDimensionSet.InsertDefaultDimension('AFDELING', Department, '1', "Purchase Header"."No.", 38);
                        end;
                    end;
                }
                textelement(Centre)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        if Centre <> '' then begin
                            DefaultDimensionSet.InsertDefaultDimension('BÆRER', Centre, '1', "Purchase Header"."No.", 38);
                        end;
                    end;
                }
                textelement(Purpose)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        if Purpose <> '' then begin
                            DefaultDimensionSet.InsertDefaultDimension('FORMÅL', Purpose, '1', "Purchase Header"."No.", 38);
                        end;
                    end;
                }
                fieldelement(VatNumber; "Purchase Header"."VAT Registration No.")
                {
                }
                fieldelement(DlvAddress1; "Purchase Header"."Ship-to Name")
                {
                }
                fieldelement(DlvAddress2; "Purchase Header"."Ship-to Address")
                {
                }
                fieldelement(DlvAddress3; "Purchase Header"."Ship-to Address 2")
                {
                }
                fieldelement(DlvZip; "Purchase Header"."Ship-to Post Code")
                {
                }
                fieldelement(DlvCity; "Purchase Header"."Ship-to City")
                {
                }
                fieldelement(DlvCountry; "Purchase Header"."Ship-to Country/Region Code")
                {
                }
                fieldelement(YourRef; "Purchase Header"."Your Reference")
                {
                }
                textelement(OurRef)
                {
                }
                fieldelement(ReferenceNumber; "Purchase Header".Comment)
                {
                }
                textelement(Email)
                {
                }
                textelement(DlvEmail)
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
        Header: Record "Purchase Header";
        Line: Record "Purchase Line";
        Bem: Record "Comment Line";
    begin
        Line.DeleteAll;
        Header.DeleteAll;
        "Default Dimension".SetFilter("Table ID", '38');
        "Default Dimension".DeleteAll;
        "Default Dimension".SetFilter("Table ID", '39');
        "Default Dimension".DeleteAll;
    end;

    var
        "Default Dimension": Record "Default Dimension";
        DefaultDimensionSet: Codeunit "Multi C5 Dimension";
}

