xmlport 70033 "Multi C5 PurchLineNotes"
{

    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Import_PurchLineNotes)
        {
            tableelement("Purch. Comment Line"; "Purch. Comment Line")
            {
                XmlName = 'PurchLineNotes';
                fieldelement(OrderNumber; "Purch. Comment Line"."No.")
                {
                }
                fieldelement(OrderLine; "Purch. Comment Line"."Document Line No.")
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
        Bem.SetFilter("Document Line No.", '> 1');
        Bem.DeleteAll;
    end;
}

