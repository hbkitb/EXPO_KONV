xmlport 70046 "Multi C5 Company Info"
{
    Caption = 'Virksomh';
    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Virksomhedsoplysninger)
        {
            tableelement("Company Information"; "Company Information")
            {
                XmlName = 'Virksomhedsoplysninger';
                fieldelement(Name; "Company Information".Name)
                {
                }
                fieldelement(Address; "Company Information".Address)
                {
                }
                fieldelement(Address2; "Company Information"."Address 2")
                {
                }
                fieldelement(PostCode; "Company Information"."Post Code")
                {
                }
                fieldelement(City; "Company Information".City)
                {
                }
                fieldelement(Phone; "Company Information"."Phone No.")
                {
                }
                fieldelement(FaxNo; "Company Information"."Fax No.")
                {
                }
                fieldelement(BankName; "Company Information"."Bank Name")
                {
                }
                fieldelement(BankReg; "Company Information"."Bank Branch No.")
                {
                }
                fieldelement(BankAccount; "Company Information"."Bank Account No.")
                {
                }
                textelement(Country)
                {
                }
                fieldelement(CountryRegionCode; "Company Information"."Country/Region Code")
                {
                }
                fieldelement(VATRegNo; "Company Information"."VAT Registration No.")
                {
                }
                textelement(CVRNo)
                {
                }
                fieldelement(SWIFT; "Company Information"."SWIFT Code")
                {
                }
                fieldelement(IBAN; "Company Information".IBAN)
                {
                }
                textelement(CellPhone)
                {
                }
                fieldelement(GiroNo; "Company Information"."Giro No.")
                {
                }
                textelement(BankCreditorNo)
                {
                }
                fieldelement(PBSNo; "Company Information"."Payment Routing No.")
                {
                }
                fieldelement(Email; "Company Information"."E-Mail")
                {
                }
                fieldelement(URL; "Company Information"."Home Page")
                {
                }
                textelement(VATNumberType)
                {
                }
                fieldelement(GLN; "Company Information".GLN)
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
        Company.DeleteAll;
    end;

    var
        Company: Record "Company Information";
}

