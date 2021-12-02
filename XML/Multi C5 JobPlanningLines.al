xmlport 70056 "Multi C5 Job Planning Lines"
{
    
    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(JobPlanningLine)
        {
            tableelement("Job Planning Line"; "Job Planning Line")
            {
                XmlName = 'JobPlanningLine';
                fieldelement(JobNo; "Job Planning Line"."Job No.")
                {
                }
                fieldelement(JobTaskNo; "Job Planning Line"."Job Task No.")
                {
                }
                fieldelement(JobLineNo; "Job Planning Line"."Line No.")
                {
                }
                fieldelement(JobItemType; "Job Planning Line".Type)
                {
                }
                fieldelement(JobLineItemNo; "Job Planning Line"."No.")
                {
                }
                fieldelement(JobLineTekst; "Job Planning Line".Description)
                {
                }
                fieldelement(JobLineQty; "Job Planning Line".Quantity)
                {
                }
                textelement(JobLineTransfer)
                {
                }
                textelement(JobLineTransferred)
                {
                }
                fieldelement(JobLinePlanningDate; "Job Planning Line"."Planning Date")
                {
                }
                fieldelement(JobLineDeliveryDate; "Job Planning Line"."Planned Delivery Date")
                {
                }
                fieldelement(JobLineType; "Job Planning Line"."Line Type")
                {
                }
                fieldelement(JobLineDirectUnitPrice; "Job Planning Line"."Unit Cost")
                {
                }
                fieldelement(JobLineUnitCost; "Job Planning Line"."Unit Price")
                {
                }
                fieldelement(JobLineCostAmount; "Job Planning Line"."Total Cost")
                {
                }
                fieldelement(JobLineTotalPrice; "Job Planning Line"."Total Price (LCY)")
                {
                }
                fieldelement(JobLineDisc; "Job Planning Line"."Line Discount %")
                {
                }

                trigger OnAfterInsertRecord()
                begin
                    //DS_HL Sættes til 0 vi ved ike hvad der er faktureret/bogført her.
                    "Job Planning Line"."Qty. Transferred to Invoice" := 0;
                    "Job Planning Line"."Qty. Transferred to Invoice" := 0;
                    "Job Planning Line"."Qty. to Transfer to Journal" := 0;
                    "Job Planning Line"."Qty. to Transfer to Invoice" := 0;
                    "Job Planning Line".Modify;
                end;

                trigger OnBeforeInsertRecord()
                begin
                    Lbn := Lbn + 10000;
                    "Job Planning Line"."Line No." := Lbn;

                    //IF "Job Planning Line"."Job Task No." = '0510' THEN BEGIN
                    "Job Planning Line"."Remaining Qty." := 0;
                    "Job Planning Line"."Remaining Qty. (Base)" := 0;
                    "Job Planning Line"."Remaining Total Cost" := 0;
                    "Job Planning Line"."Remaining Total Cost (LCY)" := 0;
                    "Job Planning Line"."Remaining Line Amount" := 0;
                    "Job Planning Line"."Remaining Line Amount (LCY)" := 0;
                    //END;
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
    begin
        "Job Planning Line".DeleteAll;
        Commit;
        //Lbn := 10000;
    end;

    var
        Lbn: Integer;
}

