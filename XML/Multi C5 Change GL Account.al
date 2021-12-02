xmlport 70066 "Multi C5 Change G/L Account"
{
    Caption = 'Import and Change G/L Accounts';
    Direction = Import;
    Format = VariableText;
    Permissions = TableData "G/L Account" = rimd,
                  TableData "G/L Entry" = rimd;
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
                        RenameGLAccount;
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
        Message('%1 finanskonti ændret', Format(Counter));
    end;

    trigger OnPreXmlPort()
    begin
        currXMLport.FieldDelimiter := '';
        currXMLport.FieldSeparator := ';';
    end;

    var
        GLAccount: Record "G/L Account";
        Counter: Integer;
        "//extra": Integer;
        OrderFilename: Text[50];

    local procedure RenameGLAccount()
    begin
        //// RENAME G/L ACCOUNT
        if GLAccount.Get(COL01) then begin

            // rename
            GLAccount.Rename(COL02);

            // update new description
            if (COL03) <> '' then begin
                GLAccount.Get(COL02);
                GLAccount.Name := COL03;
                GLAccount.Modify;
            end;

        end;
    end;
}

