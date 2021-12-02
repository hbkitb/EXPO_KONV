xmlport 70002 "Multi C5 GLChartComments"
{
    Format = VariableText;
    FormatEvaluate = Legacy;
    Direction = Import;
    TextEncoding = WINDOWS;
    FieldSeparator = ';';
    FieldDelimiter = '<¤>';
    schema
    {
        textelement(Import_GLChartComments)
        {
            XmlName = 'GLChartNotes';

            tableelement(GLChartComments; "Comment Line")
            {
                fieldelement(Account; GLChartComments."No.")
                {

                }
                fieldelement(LineNumber; GLChartComments."Line No.")
                {

                }
                textelement(Txt)
                {
                    trigger OnAfterAssignVariable()
                    var

                    begin
                        GLChartComments.Comment := CopyStr(Txt, 1, 80)
                    end;
                }
                trigger OnBeforeInsertRecord()
                var

                begin
                    Evaluate(GLChartComments."Table Name", 'G/L Account')
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                //action(ActionName)
                //{

                //}
            }
        }
    }

    var

    trigger OnInitXmlPort()

    var
        Rec: Record "Comment Line";

    begin
        Rec.SetFilter("Table Name", 'G/L Account');
        Rec.DeleteAll();
    end;

}