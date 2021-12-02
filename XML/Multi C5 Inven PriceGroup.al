xmlport 70016 "Multi C5 InvenPriceGroup"
{
    Format = VariableText;
    FormatEvaluate = Legacy;
    Direction = Import;
    TextEncoding = WINDOWS;
    FieldSeparator = ';';
    FieldDelimiter = '¤';
    schema
    {
        textelement(Import_InvenPriceGroup)
        {
            tableelement(CustPriceGroup; "Customer Price Group")
            {
                fieldelement(Group; CustPriceGroup.Code)
                {

                }

                fieldelement(GroupName; CustPriceGroup.Description)
                {

                }

                fieldelement(InclVAT; CustPriceGroup."Price Includes VAT")
                {

                }
                trigger OnBeforeInsertRecord()
                var

                begin
                    CustPriceGroup."Allow Invoice Disc." := true;
                    CustPriceGroup."Allow Line Disc." := true;
                end;
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

    begin
        CustPriceGroup.DeleteAll();
    end;

    var

}