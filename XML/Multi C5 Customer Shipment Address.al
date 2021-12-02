xmlport 70044 "Multi C5 Cust. Ship. Address"
{
    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(DebitorLeveringsadresser)
        {
            tableelement("Ship-to Address"; "Ship-to Address")
            {
                XmlName = 'ShipToAddress';
                fieldelement(CustomerAccount; "Ship-to Address"."Customer No.")
                {
                }
                fieldelement(Code; "Ship-to Address".Code)
                {
                }
                fieldelement(Name; "Ship-to Address".Name)
                {
                }
                fieldelement(Address; "Ship-to Address".Address)
                {
                }
                fieldelement(Address2; "Ship-to Address"."Address 2")
                {
                }
                fieldelement(PostCode; "Ship-to Address"."Post Code")
                {
                }
                fieldelement(City; "Ship-to Address".City)
                {
                }
                fieldelement(Contact; "Ship-to Address".Contact)
                {
                }
                fieldelement(Phone; "Ship-to Address"."Phone No.")
                {
                }
                fieldelement(FaxNo; "Ship-to Address"."Fax No.")
                {
                }
                textelement(Country)
                {
                }
                fieldelement(CountryRegionCode; "Ship-to Address"."Country/Region Code")
                {
                }
                fieldelement(ShipmentMetod; "Ship-to Address"."Shipment Method Code")
                {
                }
                fieldelement(GLNNo; "Ship-to Address".GLN)
                {
                }

                trigger OnAfterInsertRecord()
                begin
                    "Ship-to Address".Name := ShipmentName;
                    "Ship-to Address".Modify;
                    ShipmentName := '';
                end;

                trigger OnBeforeInsertRecord()
                begin
                    ShipmentName := "Ship-to Address".Name;
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
        "Ship-to Address".DeleteAll;
    end;

    var
        ShipmentName: Text[50];
}

