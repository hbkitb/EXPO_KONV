xmlport 70022 "Multi C5 InvenDiscGroup"
{
    
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Import_LagRabatGruppe)
        {
            tableelement("Item Discount Group"; "Item Discount Group")
            {
                AutoUpdate = true;
                XmlName = 'LagRabatGruppe';
                fieldelement(Gruppe; "Item Discount Group".Code)
                {
                }
                fieldelement(Beskrivelse; "Item Discount Group".Description)
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
}

