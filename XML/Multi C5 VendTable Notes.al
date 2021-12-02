xmlport 70010 "Multi C5 Vendtable Notes"
{
    Format = VariableText;
    FormatEvaluate = Legacy;
    Direction = Import;
    TextEncoding = WINDOWS;
    FieldSeparator = ';';
    FieldDelimiter = '¤';
    schema
    {
        textelement(Import_VendTableNotes)
        {
            tableelement(VendTableNotes; "Comment Line")
            {
                fieldelement(Account; VendTableNotes."No.")
                {
                    trigger OnAfterAssignField()

                    var

                    begin
                        Evaluate(VendTableNotes."Table Name", 'Vendor');
                        VendTableNotes.Validate("No.");
                    end;
                }
                fieldelement(LineNumber; VendTableNotes."Line No.")
                {

                }
                textelement(Txt)
                {
                    trigger OnAfterAssignVariable()
                    var

                    begin
                        VendTableNotes.Comment := CopyStr(txt, 1, 80);
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
        Rec.SetFilter("Table Name", 'Vendor');
        rec.DeleteAll();
    end;
}