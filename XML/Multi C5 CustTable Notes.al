xmlport 70008 "Multi C5 Custtable Notes"
{
    Format = VariableText;
    FormatEvaluate = Legacy;
    Direction = Import;
    TextEncoding = WINDOWS;
    FieldSeparator = ';';
    FieldDelimiter = '¤';
    schema
    {
        textelement(Import_CustTableNotes)
        {
            tableelement(CustTableNotes; "Comment Line")
            {
                fieldelement(Account; CustTableNotes."No.")
                {
                    trigger OnAfterAssignField()

                    var

                    begin
                        Evaluate(CustTableNotes."Table Name", 'Customer');
                        CustTableNotes.Validate("No.");
                    end;
                }
                fieldelement(LineNumber; CustTableNotes."Line No.")
                {

                }
                textelement(Txt)
                {
                    trigger OnAfterAssignVariable()
                    var

                    begin
                        CustTableNotes.Comment := CopyStr(txt, 1, 80);
                    end;
                }
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
        Rec.SetFilter("Table Name", 'Customer');
        rec.DeleteAll();
    end;
}