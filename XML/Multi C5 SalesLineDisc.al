xmlport 70029 "Multi C5 SalesLineDisc"
{
    //*  hbk
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Import_SalesLineDisc)
        {
            tableelement("Sales Line Discount"; "Sales Line Discount")
            {
                XmlName = 'SalesLineDisc';
                fieldelement(AccountCode; "Sales Line Discount"."Sales Type")
                {
                }
                fieldelement(AccountRelation; "Sales Line Discount"."Sales Code")
                {
                }
                fieldelement(ItemCode; "Sales Line Discount".Type)
                {
                }
                fieldelement(ItemRelation; "Sales Line Discount".Code)
                {
                }
                textelement(Type)
                {
                }
                fieldelement(Qty; "Sales Line Discount"."Minimum Quantity")
                {
                }
                fieldelement(FromDate; "Sales Line Discount"."Starting Date")
                {
                }
                fieldelement(ToDate; "Sales Line Discount"."Ending Date")
                {
                }
                fieldelement(Rate; "Sales Line Discount"."Line Discount %")
                {
                }
                textelement(Currency)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        if Currency = 'DKK' then
                            Currency := '';

                        "Sales Line Discount".Validate("Currency Code", Currency);
                    end;
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
    var
        SL: Record "Sales Line Discount";
    begin
        SL.DeleteAll;
    end;

    //hbk */
}

