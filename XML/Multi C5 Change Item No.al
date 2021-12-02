xmlport 70067 "Multi C5 Change Item No."
{
    Caption = 'Import and Change G/L Accounts';
    Direction = Import;
    Format = VariableText;
    Permissions = TableData Item = rimd;
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
                        ChangeItemNo;
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
        Message('%1 vare numre ændret', Format(Counter));
    end;

    trigger OnPreXmlPort()
    begin
        currXMLport.FieldDelimiter := '';
        currXMLport.FieldSeparator := ';';
    end;

    var
        Item: Record Item;
        Counter: Integer;
        "//extra": Integer;
        OrderFilename: Text[50];

    local procedure ChangeItemNo()
    begin
        //// Change Item No.
        if Item.Get(COL01) then begin

            // Rename
            Item.Rename(COL02);

            // update new description
            if COL03 <> '' then begin
                Item.Get(COL02);
                Item.Description := COL03;
                Item.Modify;
            end;

        end;
    end;
}

