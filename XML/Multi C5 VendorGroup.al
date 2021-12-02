xmlport 70049 "Multi C5 VendorGroup"
{
    
    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(VendorPostingGroup)
        {
            tableelement("Vendor Posting Group"; "Vendor Posting Group")
            {
                XmlName = 'VendorPostingGroup';
                fieldelement(Code; "Vendor Posting Group".Code)
                {
                }
                textelement(description)
                {
                    XmlName = 'Description';
                }
                fieldelement(PayablesAccount; "Vendor Posting Group"."Payables Account")
                {
                }
                fieldelement(DebitRoundingAccount; "Vendor Posting Group"."Debit Rounding Account")
                {
                }
                fieldelement(CreditRoundingAccount; "Vendor Posting Group"."Credit Rounding Account")
                {
                }
                fieldelement(PaymentToleranceDebitAcc; "Vendor Posting Group"."Payment Tolerance Debit Acc.")
                {
                }
                fieldelement(PaymentToleranceCreditAcc; "Vendor Posting Group"."Payment Tolerance Credit Acc.")
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
        VendPostGroup.DeleteAll;
    end;

    var
        VendPostGroup: Record "Vendor Posting Group";
}

