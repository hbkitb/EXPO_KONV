codeunit 70005 "Multi C5 Create Currency"
{
    trigger OnRun()
    begin

    end;

    var



    procedure CreateCurrency(CurrencyCode: Code[20]; AmountLCY: Decimal; Amount: Decimal)

    var
        Currency: Record Currency;

    begin
        if not Currency.Get(CurrencyCode) then begin
            Currency.Init;
            Currency.Code := CurrencyCode;
            Currency."Invoice Rounding Precision" := 0.01;
            Currency."Amount Rounding Precision" := 0.00001;
            Currency."Unit-Amount Rounding Precision" := 0.01;
            Currency."Amount Decimal Places" := '2:5';
            if (AmountLCY <> 0) and (Amount <> 0) then
                Currency."Currency Factor" := Amount / AmountLCY;
            Currency.Insert();
            CreateExchRate(CurrencyCode, AmountLCY, Amount);

        end;
    end;

    procedure CreateExchRate(CurrencyCode: Code[20]; AmountLCY: Decimal; Amount: Decimal)

    var
        CurrrencyExchRate: Record "Currency Exchange Rate";
    begin
        CurrrencyExchRate.SetFilter(CurrrencyExchRate."Currency Code", CurrencyCode);
        if not CurrrencyExchRate.FindFirst() then begin
            CurrrencyExchRate.Init();
            Evaluate(CurrrencyExchRate."Starting Date", '01-01-1900');
            CurrrencyExchRate."Currency Code" := CurrencyCode;
            CurrrencyExchRate."Exchange Rate Amount" := 1;
            if (AmountLCY <> 0) and (Amount <> 0) then begin
                CurrrencyExchRate."Adjustment Exch. Rate Amount" := AmountLCY / Amount;
                CurrrencyExchRate."Relational Exch. Rate Amount" := CurrrencyExchRate."Adjustment Exch. Rate Amount";
            end;
            CurrrencyExchRate."Relational Adjmt Exch Rate Amt" := 1;
            CurrrencyExchRate.Insert;
        end;
    end;



}