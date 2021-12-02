xmlport 70048 "Multi C5 CustomerGroup"
{
    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(CustomerPostinggroup)
        {
            tableelement("Customer Posting Group"; "Customer Posting Group")
            {
                XmlName = 'CustPostGroup';
                fieldelement(Code; "Customer Posting Group".Code)
                {
                }
                textelement("<description>")
                {
                    XmlName = 'Description';
                }
                fieldelement(ReceivablesAccount; "Customer Posting Group"."Receivables Account")
                {
                }
                fieldelement(DebitRoundingAccount; "Customer Posting Group"."Debit Rounding Account")
                {
                }
                fieldelement(CreditRoundingAccount; "Customer Posting Group"."Credit Rounding Account")
                {
                }
                fieldelement(PaymentToleranceDebitAcc; "Customer Posting Group"."Payment Tolerance Debit Acc.")
                {
                }
                fieldelement(PaymentToleranceCreditAcc; "Customer Posting Group"."Payment Tolerance Credit Acc.")
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
        CustPostGroup.DeleteAll;
    end;

    var
        CustPostGroup: Record "Customer Posting Group";
}

