xmlport 70047 "Multi C5 SalesPurchaserCode"
{
    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement("SælgereIndkøbere")
        {
            tableelement("Salesperson/Purchaser"; "Salesperson/Purchaser")
            {
                XmlName = 'SalesPersonPurchaser';
                fieldelement(Code; "Salesperson/Purchaser".Code)
                {
                }
                fieldelement(Name; "Salesperson/Purchaser".Name)
                {
                }
                textelement("<adress>")
                {
                    XmlName = 'Address';
                }
                textelement("<address2>")
                {
                    XmlName = 'Address2';
                }
                textelement("<postcode>")
                {
                    XmlName = 'PostCode';
                }
                textelement("<city>")
                {
                    XmlName = 'City';
                }
                fieldelement(Phone; "Salesperson/Purchaser"."Phone No.")
                {
                }
                textelement("<localnumber>")
                {
                    XmlName = 'LocalNumber';
                }
                textelement("<department>")
                {
                    XmlName = 'Department';
                }
                textelement("<centre>")
                {
                    XmlName = 'Centre';
                }
                textelement("<purpose>")
                {
                    XmlName = 'PurPose';
                }
                textelement("<country>")
                {
                    XmlName = 'Country';
                }
                textelement(CountryRegionCode)
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
    begin
        SalesPurchaser.DeleteAll;
    end;

    var
        SalesPurchaser: Record "Salesperson/Purchaser";
}

