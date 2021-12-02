xmlport 70012 "Multi C5 Dimensions"
{
    Format = VariableText;
    FormatEvaluate = Legacy;
    Direction = Import;
    TextEncoding = WINDOWS;
    FieldSeparator = ';';
    FieldDelimiter = '<¤>';
    schema
    {
        textelement(Import_Dimensions)
        {
            tableelement(Dimensions; "Dimension Value")
            {
                fieldelement(Dimension; Dimensions."Dimension Code")
                {

                }
                fieldelement(Value; Dimensions.Code)
                {

                }
                fieldelement(Description; Dimensions.Name)
                {

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


    begin
        CreateDimension('AFDELING', 'Afdeling', 'Afdelings kode', 'Afdelingsfilter');
        CreateDimension('BÆRER', 'Bærer', 'Bærer kode', 'Bærerfilter');
        CreateDimension('FORMÅL', 'Formål', 'Formål kode', 'Formålfilter');
    end;

    local procedure CreateDimension(DimensionCode: Code[20]; DimensionName: Text; DimensionCodeCaption: Text; DimensionFilterCaption: Text)
    var
        CreateDimension: Record Dimension;
    begin
        CreateDimension.SetFilter(Code, DimensionCode);
        if not CreateDimension.FindSet() then begin
            CreateDimension.Init();
            CreateDimension.Code := DimensionCode;
            CreateDimension.Name := DimensionName;
            CreateDimension."Code Caption" := DimensionCodeCaption;
            CreateDimension."Filter Caption" := DimensionFilterCaption;
            CreateDimension.Insert;
        end;
    end;

    var
        myInt: Integer;
}