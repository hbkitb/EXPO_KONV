xmlport 70021 "Multi C5 CustDisc Group"
{
    
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Import_DebRabatGruppe)
        {
            tableelement("Customer Discount Group"; "Customer Discount Group")
            {
                AutoUpdate = true;
                XmlName = 'DebRabatGruppe';
                fieldelement(Gruppe; "Customer Discount Group".Code)
                {
                }
                fieldelement(Beskrivelse; "Customer Discount Group".Description)
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

