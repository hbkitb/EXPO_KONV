xmlport 70028 "Multi C5 SalesTableNotes"
{

    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Import_SalesTableNotes)
        {
            tableelement("Sales Comment Line"; "Sales Comment Line")
            {
                XmlName = 'SalesTableNotes';
                fieldelement(OrderNumber; "Sales Comment Line"."No.")
                {
                }
                fieldelement(LineNumber; "Sales Comment Line"."Line No.")
                {
                }
                textelement(Txt)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        "Sales Comment Line".Comment := CopyStr(Txt, 1, 80);
                    end;
                }

                trigger OnBeforeInsertRecord()
                begin
                    "Sales Comment Line"."Document Type" := "Sales Comment Line"."Document Type"::"Credit Memo";
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
        Bem: Record "Sales Comment Line";
    begin
        Bem.SetFilter("Document Type", '1');
        Bem.SetFilter("Document Line No.", '0');
        Bem.DeleteAll;
    end;
}

