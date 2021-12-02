xmlport 70017 "Multi C5 InvenPrice"
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
        textelement(Import_InvenPrice)
        {
            tableelement(ItemPrice; "Sales Price")
            {
                fieldelement(ItemNumber; ItemPrice."Item No.")
                {
                    trigger OnAfterAssignField()

                    var

                    begin
                        ItemPrice."Sales Type" := ItemPrice."Sales Type"::"Customer Price Group"
                    end;




                }

                fieldelement(Price; ItemPrice."Unit Price")
                {

                }

                textelement(PriceUnit)
                {

                }

                fieldelement(Currency; ItemPrice."Currency Code")
                {

                }

                fieldelement(PriceGroup; ItemPrice."Sales Code")
                {

                }
                fieldelement(Date; ItemPrice."Starting Date")
                {

                }

                trigger OnBeforeInsertRecord()
                var
                    Item: Record Item;
                begin
                    if Item.Get(ItemPrice."Item No.") then
                        ItemPrice."Unit of Measure Code" := Item."Base Unit of Measure";
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
        ItemPrice: Record "Sales Price";
    begin
        ItemPrice.DeleteAll();
    end;

    var
    //h */
}