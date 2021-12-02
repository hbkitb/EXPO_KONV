xmlport 70050 "Multi C5 InvenGroup"
{
    // DSDK.01 HL 2019-03-25 Felt adskiller ændret til ¤

    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(InvnetoryPostGroup)
        {
            tableelement("Inventory Posting Group"; "Inventory Posting Group")
            {
                XmlName = 'InventoryPostGroup';
                fieldelement(Code; "Inventory Posting Group".Code)
                {
                }
                fieldelement(Description; "Inventory Posting Group".Description)
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
        InvenPostGroup.DeleteAll;
    end;

    var
        InvenPostGroup: Record "Inventory Posting Group";
}

