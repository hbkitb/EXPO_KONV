xmlport 70040 "Multi C5 ItemVendorPrice"
{
    //* hbk
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement("VareLeverandørPris")
        {
            tableelement("Purchase Price"; "Purchase Price")
            {
                XmlName = 'PurchasePrice';
                fieldelement(ItemNumber; "Purchase Price"."Item No.")
                {
                }
                fieldelement(VendorNumber; "Purchase Price"."Vendor No.")
                {
                }
                fieldelement(Currency; "Purchase Price"."Currency Code")
                {
                }
                fieldelement(DirectCost; "Purchase Price"."Direct Unit Cost")
                {
                }
                fieldelement(UnitCode; "Purchase Price"."Unit of Measure Code")
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
        "Purchase Price".DeleteAll
    end;

    //hbk */
}

