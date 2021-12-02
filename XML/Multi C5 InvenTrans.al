xmlport 70023 "Multi C5 InvenTrans"
{

    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Import_InvenTrans)
        {
            tableelement("Item Journal Line"; "Item Journal Line")
            {
                XmlName = 'InvenTrans';
                fieldelement(ItemNumber; "Item Journal Line"."Item No.")
                //textelement(ino)
                {


                    trigger OnAfterAssignField()
                    begin
                        "Item Journal Line".Validate("Item No.");
                    end;

                }
                fieldelement(Location; "Item Journal Line"."Location Code")
                {
                }
                fieldelement(Qty; "Item Journal Line".Quantity)
                {

                }
                fieldelement(Date; "Item Journal Line"."Posting Date")
                {
                }
                fieldelement(Voucher; "Item Journal Line"."Document No.")
                {
                }
                textelement("serial lot no")
                {
                    XmlName = 'SerialLotNo';
                }
                fieldelement(CostPrice; "Item Journal Line"."Unit Cost")
                {
                }

                trigger OnAfterInsertRecord()
                begin
                    if "Serial Lot No" <> '' then begin
                        ReservationEntry.Init;
                        ReservationEntry."Entry No." := ResLineNumber;
                        ResLineNumber := ResLineNumber + 1;
                        if "Item Journal Line"."Entry Type" = "Item Journal Line"."Entry Type"::"Positive Adjmt." then begin
                            ReservationEntry.Positive := true;
                            ReservationEntry.Quantity := "Item Journal Line".Quantity;
                        end else begin
                            ReservationEntry.Positive := false;
                            ReservationEntry.Quantity := "Item Journal Line".Quantity;
                        end;
                        ReservationEntry."Item No." := "Item Journal Line"."Item No.";
                        ReservationEntry."Location Code" := "Item Journal Line"."Location Code";
                        ReservationEntry."Quantity (Base)" := ReservationEntry.Quantity;
                        ReservationEntry."Quantity Invoiced (Base)" := 0;
                        ReservationEntry."Qty. to Handle (Base)" := ReservationEntry.Quantity;
                        ReservationEntry."Qty. to Invoice (Base)" := ReservationEntry.Quantity;
                        ReservationEntry."Qty. per Unit of Measure" := 1;
                        ReservationEntry."Reservation Status" := ReservationEntry."Reservation Status"::Prospect;
                        ReservationEntry."Source Type" := 83;
                        ReservationEntry."Source Subtype" := 2;
                        ReservationEntry."Source ID" := "Item Journal Line"."Journal Template Name";
                        ReservationEntry."Source Batch Name" := "Item Journal Line"."Journal Batch Name";
                        ReservationEntry."Source Ref. No." := "Item Journal Line"."Line No.";
                        Item.Get(ReservationEntry."Item No.");
                        if Item."Lot Nos." <> '' then begin
                            ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Lot No.";
                            ReservationEntry."Lot No." := "Serial Lot No";
                        end;
                        if Item."Serial Nos." <> '' then begin
                            ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Serial No.";
                            ReservationEntry."Serial No." := "Serial Lot No";
                        end;
                        ReservationEntry.Insert;
                    end;
                end;

                trigger OnBeforeInsertRecord()
                var
                    Item: Record Item;
                begin
                    "Item Journal Line"."Line No." := LineNumber;
                    LineNumber := LineNumber + 10000;
                    "Item Journal Line"."Journal Template Name" := 'MULTIC5';
                    "Item Journal Line"."Journal Batch Name" := 'LAG_POSTER';
                    "Item Journal Line"."Source Code" := 'START';
                    if "Item Journal Line".Quantity < 0 then begin
                        "Item Journal Line"."Entry Type" := "Item Journal Line"."Entry Type"::"Negative Adjmt.";  //3;
                        "Item Journal Line".Quantity := -"Item Journal Line".Quantity;
                        "Item Journal Line"."Invoiced Quantity" := "Item Journal Line".Quantity;
                        "Item Journal Line"."Quantity (Base)" := "Item Journal Line".Quantity;
                        "Item Journal Line"."Invoiced Qty. (Base)" := "Item Journal Line".Quantity;

                    end else
                        "Item Journal Line"."Entry Type" := "Item Journal Line"."Entry Type"::"Positive Adjmt.";  //2;

                    if Item.Get("Item Journal Line"."Item No.") then begin
                        //"Item Journal Line"."Unit Cost" := Item."Unit Cost";
                        "Item Journal Line"."Unit Amount" := "Item Journal Line"."Unit Cost";
                        "Item Journal Line".Amount := "Item Journal Line"."Unit Cost" * "Item Journal Line".Quantity;
                        "Item Journal Line"."Inventory Posting Group" := 'C5Migration';
                        "Item Journal Line"."Gen. Prod. Posting Group" := 'C5Migration';


                    end;

                    InventoryPostingSetup.SetFilter("Location Code", '%1', "Item Journal Line"."Location Code");
                    InventoryPostingSetup.SetFilter("Invt. Posting Group Code", '%1', "Item Journal Line"."Inventory Posting Group");
                    if not InventoryPostingSetup.FindFirst then begin
                        InventoryPostingSetup."Location Code" := "Item Journal Line"."Location Code";
                        InventoryPostingSetup."Invt. Posting Group Code" := "Item Journal Line"."Gen. Prod. Posting Group";
                        InventoryPostingSetup.Insert;
                    end;
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
    var
        Template: Record "Item Journal Template";
        Line: Record "Item Journal Line";
        Batch: Record "Item Journal Batch";
    begin
        //hbk
        item.reset;
        if item.FindSet() then begin
            repeat
                item.blocked := false;
                item.Modify()
            until item.Next() = 0;
            item.reset;
        end;
        //hbk
        if not SourceCode.Get('Start') then begin
            SourceCode.Init;
            SourceCode.Code := 'START';
            SourceCode.Description := 'Start poster/Konverterede poster';
            SourceCode.Insert;
        end;

        if not GenProductPostingGroup.Get('C5Migration') then begin
            GenProductPostingGroup.Init;
            GenProductPostingGroup.Code := 'C5Migration';
            GenProductPostingGroup.Description := 'Konvertering af åbningsbeholdning fra C5';
            GenProductPostingGroup."Def. VAT Prod. Posting Group" := 'Moms';
            GenProductPostingGroup."Auto Insert Default" := true;
        end;

        GeneralPostingSetup.SetFilter("Gen. Bus. Posting Group", '%1', '');
        GeneralPostingSetup.SetFilter("Gen. Prod. Posting Group", '%1', 'C5Migration');
        if not GeneralPostingSetup.FindFirst then begin
            GeneralPostingSetup.Init;
            GeneralPostingSetup."Gen. Bus. Posting Group" := '';
            GeneralPostingSetup."Gen. Prod. Posting Group" := 'C5Migration';
            GeneralPostingSetup.Insert;
        end;

        if not InventoryPostingGroup.Get('C5Migration') then begin
            InventoryPostingGroup.Init;
            InventoryPostingGroup.Code := 'C5Migration';
            InventoryPostingGroup.Description := 'Konvertering af åbningsbeholdning';
            InventoryPostingGroup.Insert;
        end;

        if not Template.Get('MULTIC5') then begin
            Template.Init;
            Template.Name := 'MULTIC5';
            Template.Description := 'Til import fra C5';
            Template."Test Report ID" := 702;
            Template."Page ID" := 40;
            Template."Posting Report ID" := 703;
            Template.Type := template.type::Item;  //hbk var 0 capacity
            Template."Source Code" := 'Start';
            Template.Insert;
        end;
        Batch.SetFilter(Batch.Name, 'LAG_POSTER');
        if not Batch.FindFirst then begin
            Batch.Init;
            Batch."Journal Template Name" := 'MULTIC5';
            Batch.Name := 'LAG_POSTER';
            Batch.Description := 'Lagerposter fra C5';
            Batch.Insert;
        end;
        Line.SetFilter(Line."Journal Template Name", 'MULTIC5');
        Line.SetFilter(Line."Journal Batch Name", 'LAG_POSTER');
        Line.DeleteAll;

        ReservationEntry.SetFilter("Source ID", '%1', 'MULTIC5');
        ReservationEntry.SetFilter("Source Batch Name", '%1', 'LAG_POSTER');
        ReservationEntry.DeleteAll;

        LineNumber := 10000;
        ResLineNumber := 1;
    end;

    var
        LineNumber: Integer;
        SourceCode: Record "Source Code";
        ReservationEntry: Record "Reservation Entry";
        ResLineNumber: Integer;
        Item: Record Item;
        GenProductPostingGroup: Record "Gen. Product Posting Group";
        GeneralPostingSetup: Record "General Posting Setup";
        InventoryPostingGroup: Record "Inventory Posting Group";
        InventoryPostingSetup: Record "Inventory Posting Setup";
}

