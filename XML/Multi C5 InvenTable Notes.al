xmlport 70015 "Multi C5 InvenTable Notes"
{
    Format = VariableText;
    FormatEvaluate = Legacy;
    Direction = Import;
    TextEncoding = WINDOWS;
    FieldSeparator = ';';
    FieldDelimiter = '¤';
    schema
    {
        textelement(Import_ItemNotes)
        {
            tableelement(ItemNotes; "Comment Line")
            {
                fieldelement(ItemNo; ItemNotes."No.")
                {
                    trigger OnAfterAssignField()
                    var

                    begin
                        Evaluate(ItemNotes."Table Name", 'Item');
                        ItemNotes.Validate("No.");
                    end;
                }
                fieldelement(LineNumber; ItemNotes."Line No.")
                {

                }
                textelement(Text)
                {
                    trigger OnAfterAssignVariable()
                    var

                    Begin
                        ItemNotes.Comment := CopyStr(Text, 1, 80);
                    End;

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

    trigger OnInitXmlPort()
    var
        Rec: Record "Comment Line";
    begin
        Rec.SetFilter("Table Name", 'Item');
        Rec.DeleteAll();
    end;

    var

}