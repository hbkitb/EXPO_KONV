xmlport 70043 MultiC5_VendorContact
{
    
    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Kreditorkontakter)
        {
            tableelement(Contact; Contact)
            {
                XmlName = 'VendContact';
                textelement(VendorQty)
                {
                }
                textelement(VendorAccount)
                {
                }
                fieldelement(Name; Contact.Name)
                {
                }
                fieldelement(Position; Contact."Job Title")
                {
                }
                fieldelement(Address; Contact.Address)
                {
                }
                fieldelement(Address2; Contact."Address 2")
                {
                }
                fieldelement(City; Contact.City)
                {
                }
                fieldelement(Phone; Contact."Phone No.")
                {
                }
                fieldelement(Language; Contact."Language Code")
                {
                }
                fieldelement(CountryRegionCode; Contact."Country/Region Code")
                {
                }
                fieldelement(FaxNo; Contact."Fax No.")
                {
                }
                fieldelement(PostCode; Contact."Post Code")
                {
                }
                fieldelement(Email; Contact."E-Mail")
                {
                }
                fieldelement(Type; Contact.Type)
                {
                }
                fieldelement(CompanyName; Contact."Company Name")
                {
                }
                fieldelement(Phone; Contact."Phone No.")
                {
                }
                fieldelement(MobilePhoneNo; Contact."Mobile Phone No.")
                {
                }

                trigger OnBeforeModifyRecord()
                begin
                    ContBusRel.Get;
                    ContBusRel.SetRange(ContBusRel."Link to Table", ContBusRel."Link to Table"::Vendor);
                    ContBusRel.SetRange(ContBusRel."No.", VendorAccount);

                    Contact."Company No." := ContBusRel."Contact No.";
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
        Clear(ContBusRel);
        Clear(Contact);
        ContBusRel.SetRange(ContBusRel."Link to Table", ContBusRel."Link to Table"::Vendor);
        if ContBusRel.FindSet then
            repeat
                Contact.SetRange(Contact."No.", ContBusRel."Contact No.");
                if Contact.FindSet then
                    repeat
                        Contact.Delete;
                    until Contact.Next = 0;
                ContBusRel.Delete;

            until ContBusRel.Next = 0;
        Commit;
    end;

    trigger OnPreXmlPort()
    begin
        REPORT.RunModal(5194, false);
    end;

    var
        VendTable: Record Vendor;
        ContBusRel: Record "Contact Business Relation";
}

