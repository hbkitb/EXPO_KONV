xmlport 70032 "Multi C5 PurchTableNotes"
{

    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Import_PurchTableNotes)
        {
            tableelement("Purch. Comment Line"; "Purch. Comment Line")
            {
                XmlName = 'PurchTableNotes';
                fieldelement(OrderNumber; "Purch. Comment Line"."No.")
                {
                }
                fieldelement(LineNumber; "Purch. Comment Line"."Line No.")
                {
                }
                textelement(Txt)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        "Purch. Comment Line".Comment := CopyStr(Txt, 1, 80);
                    end;
                }

                trigger OnBeforeInsertRecord()
                begin
                    "Purch. Comment Line"."Document Type" := "Purch. Comment Line"."Document Type"::"Credit Memo";
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
    var
        Bem: Record "Purch. Comment Line";
    begin
        Bem.SetFilter("Document Type", '1');
        Bem.SetFilter("Document Line No.", '0');
        Bem.DeleteAll;
    end;
}

