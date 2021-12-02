xmlport 70051 "Multi C5 InvenPost SetUp"
{
    
    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(InvenOPostSetUp)
        {
            tableelement("Inventory Posting Setup"; "Inventory Posting Setup")
            {
                XmlName = 'InvenPostSetup';
                fieldelement(LocationCode; "Inventory Posting Setup"."Location Code")
                {
                }
                fieldelement(InvenPostGRoupCode; "Inventory Posting Setup"."Invt. Posting Group Code")
                {
                }
                fieldelement(InventoryAccount; "Inventory Posting Setup"."Inventory Account")
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
        InventoryPostingSetup.DeleteAll;
    end;

    var
        InventoryPostingSetup: Record "Inventory Posting Setup";
}

