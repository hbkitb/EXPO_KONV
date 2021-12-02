xmlport 70006 "Multi C5 Payment"
{
    Format = VariableText;
    FormatEvaluate = Legacy;
    Direction = Import;
    TextEncoding = WINDOWS;
    FieldSeparator = ';';
    FieldDelimiter = '¤';
    schema
    {
        textelement(Import_PaymentCode)
        {
            tableelement(Payment; "Payment Terms")
            {
                fieldelement(PayCode; Payment.Code)
                {

                }
                fieldelement(Txt; Payment.Description)
                {

                }
                textelement(Method)
                {

                }
                textelement(Qty)
                {

                }
                textelement(UnitCode)
                {

                }
                trigger OnBeforeInsertRecord()

                var
                    Unit: Text[1];
                    PayRec: Record "Payment Terms";

                begin
                    case UnitCode of
                        '0':
                            Unit := 'D';
                        '1':
                            Unit := 'U';
                        '2':
                            Unit := 'M';
                    end;
                    case Method of
                        '0':
                            Evaluate(Payment."Due Date Calculation", Qty + Unit);
                        '1':
                            Evaluate(Payment."Due Date Calculation", 'LM+' + Qty + Unit);
                        '2':
                            Evaluate(Payment."Due Date Calculation", 'LK+' + Qty + Unit);
                        '3':
                            Evaluate(Payment."Due Date Calculation", 'LÅ+' + Qty + Unit);
                        '4':
                            Evaluate(Payment."Due Date Calculation", 'LU+' + Qty + Unit);
                    end;
                    if PayRec.Get(Payment.Code) then
                        currXMLport.Skip();
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
        PayRec: Record "Payment Terms";

    begin
        if not PayRec.Get('BLANK') then begin
            PayRec.Init();
            PayRec.Code := 'BLANK';
            Evaluate(PayRec."Due Date Calculation", '0D');
            PayRec.Description := 'Blank kode oprettet fra C5';
            PayRec.Insert();
        end;
    end;
}