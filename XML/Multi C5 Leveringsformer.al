xmlport 70058 "Multi C5 Leveringsformer"
{
    // DSDK.01 HL 2019-03-25 Felt adskiller ændret til ¤

    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Leveringsformer)
        {
            tableelement("Shipment Method"; "Shipment Method")
            {
                XmlName = 'Shipment';
                fieldelement(ShipCode; "Shipment Method".Code)
                {
                }
                fieldelement(ShipDescription; "Shipment Method".Description)
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
        "Shipment Method".DeleteAll
    end;
}

