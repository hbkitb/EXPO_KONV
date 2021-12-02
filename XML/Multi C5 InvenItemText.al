xmlport 70034 "Multi C5 InvenItemText"
{

    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Import_InvenItemText)
        {
            tableelement("Extended Text Line"; "Extended Text Line")
            {
                XmlName = 'ExtTextLine';
                textelement(Type)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        "Extended Text Line"."Table Name" := "Extended Text Line"."Table Name"::Item;
                    end;
                }
                fieldelement(No; "Extended Text Line"."No.")
                {
                }
                fieldelement(Language; "Extended Text Line"."Language Code")
                {
                }
                fieldelement(TxtNo; "Extended Text Line"."Text No.")
                {
                }
                fieldelement(LineNo; "Extended Text Line"."Line No.")
                {
                }
                fieldelement(Txt; "Extended Text Line".Text)
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
        ExtendedTextLine.DeleteAll;
    end;

    var
        ExtendedTextLine: Record "Extended Text Line";
}

