xmlport 70037 "Multi C5 VendorBankAccount"
{

    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(KreditorBankoplysninger)
        {
            tableelement("Vendor Bank Account"; "Vendor Bank Account")
            {
                XmlName = 'VendorBankAccount';
                fieldelement(Code; "Vendor Bank Account".Code)
                {
                }
                fieldelement(Account; "Vendor Bank Account"."Vendor No.")
                {
                }
                textelement(VendorName)
                {
                }
                fieldelement(Currency; "Vendor Bank Account"."Currency Code")
                {
                }
                textelement(Bankaccount)
                {
                }
                fieldelement(Regno; "Vendor Bank Account"."Bank Branch No.")
                {
                }
                fieldelement(BankAccount; "Vendor Bank Account"."Bank Account No.")
                {
                }
                textelement(Giro)
                {
                }
                textelement(PaymentMode)
                {
                }
                textelement(PaymSpec)
                {
                }
                textelement(PaymentForm)
                {
                }
                fieldelement(BankNavn; "Vendor Bank Account".Name)
                {
                }
                fieldelement(BankAdresse1; "Vendor Bank Account".Address)
                {
                }
                fieldelement(BankAdresse2; "Vendor Bank Account"."Address 2")
                {
                }
                textelement(BankAdresse3)
                {
                }
                fieldelement(BankAttention; "Vendor Bank Account".Contact)
                {
                }
                fieldelement(BankPhone; "Vendor Bank Account"."Phone No.")
                {
                }
                fieldelement(BankFax; "Vendor Bank Account"."Fax No.")
                {
                }
                fieldelement(BankCountry; "Vendor Bank Account"."Country/Region Code")
                {
                }
                fieldelement(BankSwift; "Vendor Bank Account"."SWIFT Code")
                {
                }
                fieldelement(BankIBAN; "Vendor Bank Account".IBAN)
                {
                }
                fieldelement(BankEmail; "Vendor Bank Account"."E-Mail")
                {
                }

                trigger OnAfterInsertRecord()
                begin

                    Vendor.Get("Vendor Bank Account"."Vendor No.");

                    if Giro <> '' then begin
                        ;
                        //Vendor.Gir := Giro;
                        Vendor."Creditor No." := Giro;
                        Vendor."Payment Method Code" := PaymentForm;
                    end
                    else begin
                        ;
                        if "Vendor Bank Account"."Bank Account No." <> '' then begin
                            ;
                            Vendor."Preferred Bank Account Code" := '1';
                            Vendor."Payment Method Code" := PaymentForm
                        end
                        else begin
                            ;
                            "Vendor Bank Account".Delete;
                        end;
                    end;
                    Vendor.Modify;
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
        "Vendor Bank Account".DeleteAll;
        exit;
    end;

    var
        Vendor: Record Vendor;
}

