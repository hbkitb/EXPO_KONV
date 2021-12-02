xmlport 70045 "Multi C5 VendorOrderAddress"
{
    
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(KreditorBestillingsadresser)
        {
            tableelement("Order Address"; "Order Address")
            {
                XmlName = 'VendorOrderAddress';
                fieldelement(VendorAccount; "Order Address"."Vendor No.")
                {
                }
                fieldelement(Code; "Order Address".Code)
                {
                }
                fieldelement(Name; "Order Address".Name)
                {
                }
                fieldelement(Address; "Order Address".Address)
                {
                }
                fieldelement(Address2; "Order Address"."Address 2")
                {
                }
                fieldelement(PostCode; "Order Address"."Post Code")
                {
                }
                fieldelement(City; "Order Address".City)
                {
                }
                fieldelement(Contact; "Order Address".Contact)
                {
                }
                fieldelement(Phone; "Order Address"."Phone No.")
                {
                }
                fieldelement(FaxNo; "Order Address"."Fax No.")
                {
                }
                textelement(Country)
                {
                }
                fieldelement(CountryRegionCode; "Order Address"."Country/Region Code")
                {
                }

                trigger OnAfterInsertRecord()
                begin
                    "Order Address".Name := OrderName;
                    "Order Address".Modify;
                    OrderName := '';
                end;

                trigger OnBeforeInsertRecord()
                begin
                    OrderName := "Order Address".Name;
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
        "Order Address".DeleteAll;
    end;

    var
        OrderName: Text[50];
}

