xmlport 70024 "Multi C5 InvenLocation"
{
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Import_InvenLocation)
        {
            tableelement(Location; Location)
            {
                AutoUpdate = true;
                XmlName = 'InvenLocation';
                fieldelement(Code; Location.Code)
                {
                }
                fieldelement(Name; Location.Name)
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

