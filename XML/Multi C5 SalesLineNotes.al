xmlport 70027 "Multi C5 SalesLineNotes"
{

    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Import_SalesLineNotes)
        {
            tableelement("Sales Comment Line"; "Sales Comment Line")
            {
                XmlName = 'SalesLineNotes';
                fieldelement(OrderNumber; "Sales Comment Line"."No.")
                {
                }
                fieldelement(OrderLine; "Sales Comment Line"."Document Line No.")
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
        Bem.SetFilter("Document Line No.", '> 1');
        Bem.DeleteAll;
    end;
}

