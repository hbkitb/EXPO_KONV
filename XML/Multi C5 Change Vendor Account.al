xmlport 70069 "Multi C5 Change Vendor Account"
{
    Caption = 'Change Custormor Accounts';
    Direction = Import;
    Format = VariableText;
    Permissions = TableData Vendor = rimd;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                AutoReplace = true;
                XmlName = 'Import';
                UseTemporary = true;
                textelement(COL01)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(COL02)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(COL03)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }

                trigger OnBeforeInsertRecord()
                begin
                    Counter += 1;
                    Integer.Number := Counter;    //Styring mht flere records

                    if (COL01 <> '') and (COL02 <> '') then begin
                        ChangeVendorAccount;
                    end;
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

    trigger OnPostXmlPort()
    begin
        Message('%1 Konti ændret', Format(Counter));
    end;

    trigger OnPreXmlPort()
    begin
        currXMLport.FieldDelimiter := '';
        currXMLport.FieldSeparator := ';';
    end;

    var
        Vendor: Record Customer;
        Counter: Integer;
        "//extra": Integer;
        OrderFilename: Text[50];

    local procedure ChangeVendorAccount()
    begin
        //// Change Vendor Account
        if Vendor.Get(COL01) then begin

            // rename
            Vendor.Rename(COL02);

            // update new description
            if COL03 <> '' then begin
                Vendor.Get(COL02);
                Vendor.Name := COL03;
                Vendor.Modify;
            end;

        end;
    end;
}

