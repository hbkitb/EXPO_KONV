xmlport 70036 "Multi C5 ItemTranslation"
{

    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Import_ItemTranslation)
        {
            tableelement("Item Translation"; "Item Translation")
            {
                XmlName = 'ItemTranslation';
                fieldelement(Number; "Item Translation"."Item No.")
                {
                }
                textelement(Blank)
                {
                }
                fieldelement(Language; "Item Translation"."Language Code")
                {
                }
                fieldelement(Txt; "Item Translation".Description)
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
        ItemTranslation.DeleteAll
    end;

    var
        ItemTranslation: Record "Item Translation";
}

