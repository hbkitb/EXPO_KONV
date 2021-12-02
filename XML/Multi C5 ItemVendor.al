xmlport 70039 "Multi C5 ItemVendor"
{

    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement("VareLeverandør")
        {
            tableelement("Item Vendor"; "Item Vendor")
            {
                XmlName = 'ItemVendor';
                fieldelement(ItemNumber; "Item Vendor"."Item No.")
                {
                }
                fieldelement(Vendor; "Item Vendor"."Vendor No.")
                {
                }
                fieldelement(VendorItemNumber; "Item Vendor"."Vendor Item No.")
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
        ItemVendor.DeleteAll
    end;

    var
        ItemVendor: Record "Item Vendor";
}

