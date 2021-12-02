xmlport 70020 "Multi C5 Resource Notes"
{
    Format = VariableText;
    FormatEvaluate = Legacy;
    Direction = Import;
    TextEncoding = WINDOWS;
    FieldSeparator = ';';
    FieldDelimiter = '¤';
    schema
    {
        textelement(Import_ResourceNotat)
        {
            tableelement(ResourceComment; "Comment Line")
            {
                fieldelement(ResourceNo; ResourceComment."No.")
                {
                    trigger OnAfterAssignField()
                    var

                    begin
                        Evaluate(ResourceComment."Table Name", 'Resource');
                        ResourceComment.Validate("No.");
                    end;
                }

                fieldelement(LineNumber; ResourceComment."Line No.")
                {

                }

                textelement(Text)
                {
                    trigger OnAfterAssignVariable()
                    var

                    begin
                        ResourceComment.Comment := CopyStr(Text, 1, 80);
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

    trigger OnInitXmlPort()
    var
        Rec: Record "Comment Line";

    begin
        Rec.SetFilter("Table Name", 'Resource');
        Rec.DeleteAll();
    end;

    var

}