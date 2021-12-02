xmlport 70068 "Multi C5 Change Cust Account"
{
    Caption = 'Change Custormor Accounts';
    Direction = Import;
    Format = VariableText;
    Permissions = TableData Customer = rimd;
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
                        ChangeCustomerAccount;
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
        Customer: Record Customer;
        Counter: Integer;
        "//extra": Integer;
        OrderFilename: Text[50];

    local procedure ChangeCustomerAccount()
    begin
        //// Change Customer Account
        if Customer.Get(COL01) then begin

            // rename
            Customer.Rename(COL02);

            // update new description
            if COL03 <> '' then begin
                Customer.Get(COL02);
                Customer.Name := COL03;
                Customer.Modify;
            end;

        end;
    end;
}

