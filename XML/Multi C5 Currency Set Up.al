xmlport 70052 "Multi C5 Currency SetUp"
{
    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(CurrencySetUp)
        {
            tableelement(Currency; Currency)
            {
                AutoReplace = true;
                AutoSave = false;
                XmlName = 'CurrencySetUp';
                fieldelement(Code; Currency.Code)
                {
                }
                fieldelement(RealizedGainsAcc; Currency."Realized Gains Acc.")
                {
                }
                fieldelement(RealizedLossesAcc; Currency."Realized Losses Acc.")
                {
                }
                fieldelement(UnrealizedGainsAcc; Currency."Unrealized Gains Acc.")
                {
                }
                fieldelement(UnrealizedLossesAcc; Currency."Unrealized Losses Acc.")
                {
                }

                trigger OnBeforeModifyRecord()
                begin
                    Currency.Modify;
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
}

