xmlport 70065 "Multi C5 CustSalesPrice"
{
    //* h
    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Import_CustSalesPrice)
        {
            tableelement("Sales Price"; "Sales Price")
            {
                XmlName = 'InvenPrice';
                fieldelement(SalesType; "Sales Price"."Sales Type")
                {
                }
                fieldelement(SalesCode; "Sales Price"."Sales Code")
                {
                }
                textelement(ItemType)
                {
                }
                fieldelement(ItemNumber; "Sales Price"."Item No.")
                {
                }
                textelement(Type)
                {
                }
                fieldelement(MinimumQuantity; "Sales Price"."Minimum Quantity")
                {
                }
                fieldelement(StartDate; "Sales Price"."Starting Date")
                {
                }
                fieldelement(EndDate; "Sales Price"."Ending Date")
                {
                }
                fieldelement(Price; "Sales Price"."Unit Price")
                {
                }
                fieldelement(Currency; "Sales Price"."Currency Code")
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    Item: Record Item;
                begin
                    if Item.Get("Sales Price"."Item No.") then
                        "Sales Price"."Unit of Measure Code" := Item."Base Unit of Measure";
                end;
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
        //"Sales Price".SetFilter("Sales Price"."Sales Type", '%1', "Sales Price"."Sales Type"::Customer);
        //"Sales Price".DeleteAll;
    end;
    //HBK */
}

