xmlport 70019 "Multi C5 ResourcePrice"
{
    //* hbk
    Format = VariableText;
    FormatEvaluate = Legacy;
    Direction = Import;
    TextEncoding = WINDOWS;
    FieldSeparator = ';';
    FieldDelimiter = '¤';
    schema
    {
        textelement(Import_ResourcePrice)
        {
            tableelement(ResourcePrice; "Resource Price")
            {
                fieldelement(ItemNumber; ResourcePrice.Code)
                {

                }

                fieldelement(Price; ResourcePrice."Unit Price")
                {

                }

                textelement(PriceUnit)
                {

                }

                fieldelement(Currency; ResourcePrice."Currency Code")
                {

                }
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                //action(ActionName)
                //{

                //}
            }
        }
    }

    trigger OnInitXmlPort()
    var
        ResourcePrice: Record "Resource Price";
    begin
        ResourcePrice.DeleteAll();
    end;

    var
    //hbk */
}