xmlport 70041 "Multi C5 Currency Exch Rate"
{
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(ValutaKurs)
        {
            tableelement("Currency Exchange Rate"; "Currency Exchange Rate")
            {
                XmlName = 'CurrencyExchRate';
                fieldelement(Currency; "Currency Exchange Rate"."Currency Code")
                {
                }
                fieldelement(StartDate; "Currency Exchange Rate"."Starting Date")
                {
                }
                fieldelement(ExchRateAmount; "Currency Exchange Rate"."Exchange Rate Amount")
                {
                }
                fieldelement(AdjustExchRateAmount; "Currency Exchange Rate"."Adjustment Exch. Rate Amount")
                {
                }
                fieldelement(RelationalExchRateAmount; "Currency Exchange Rate"."Relational Exch. Rate Amount")
                {
                }
                fieldelement(AdjustRelationalExchRateAmount; "Currency Exchange Rate"."Relational Adjmt Exch Rate Amt")
                {
                }
            }

            trigger OnAfterAssignVariable()
            begin
                if "Currency Exchange Rate"."Currency Code" <> '' then begin
                    ;
                    if not Currency.Get("Currency Exchange Rate"."Currency Code") then begin
                        Currency.Init;
                        Currency.Code := "Currency Exchange Rate"."Currency Code";
                        Currency.Insert;
                    end;
                end;
            end;
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
        "Currency Exchange Rate".SetFilter("Currency Exchange Rate"."Currency Code", "Currency Exchange Rate"."Currency Code");
        "Currency Exchange Rate".DeleteAll;
    end;

    var
        Currency: Record Currency;
}

