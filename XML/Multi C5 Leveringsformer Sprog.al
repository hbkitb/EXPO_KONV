xmlport 70059 "Multi C5 Lev. form Sprog"
{

    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(LeverinsformerSprog)
        {
            tableelement("Shipment Method Translation"; "Shipment Method Translation")
            {
                XmlName = 'ShipmentTranslation';
                fieldelement(ShipmentCode; "Shipment Method Translation"."Shipment Method")
                {
                }
                fieldelement(ShipmentDecription; "Shipment Method Translation".Description)
                {
                }
                fieldelement(ShipmentLanguage; "Shipment Method Translation"."Language Code")
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
        "Shipment Method Translation".DeleteAll;
    end;
}

