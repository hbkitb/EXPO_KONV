xmlport 70014 "Multi C5 InvenBom"
{
    Format = VariableText;
    FormatEvaluate = Legacy;
    Direction = Import;
    TextEncoding = WINDOWS;
    FieldSeparator = ';';
    FieldDelimiter = '¤';
    schema
    {
        textelement(Import_InvenBOM)
        {
            tableelement(InvenBOM; "BOM Component")
            {
                fieldelement(ParentItem; InvenBOM."Parent Item No.")
                {

                }
                fieldelement(BOMType; InvenBOM.Type)
                {

                }
                fieldelement(LineNumber; InvenBOM."Line No.")
                {

                }
                fieldelement(Item; InvenBOM."No.")
                {

                }
                fieldelement(Qty; InvenBOM."Quantity per")
                {

                }
                fieldelement(Position; InvenBOM.Position)
                {

                }

                trigger OnBeforeInsertRecord()
                var

                begin
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

    trigger OnInitXmlPort()

    var

    Begin
        InvenBOM.DeleteAll();
    End;

    var


}