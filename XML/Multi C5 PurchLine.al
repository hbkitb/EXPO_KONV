xmlport 70031 "Multi C5 PurchLine"
{

    DefaultFieldsValidation = false;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Import_PurchLine)
        {
            tableelement("Purchase Line"; "Purchase Line")
            {
                XmlName = 'PurchLine';
                fieldelement(DokuType; "Purchase Line"."Document Type")
                {
                }
                fieldelement(Number; "Purchase Line"."Document No.")
                {
                }
                fieldelement(LineNumber; "Purchase Line"."Line No.")
                {
                }
                fieldelement(Type; "Purchase Line".Type)
                {
                }
                textelement(ItemNumber)
                {
                }
                fieldelement(Location; "Purchase Line"."Location Code")
                {
                }
                fieldelement(Qty; "Purchase Line".Quantity)
                {

                    trigger OnAfterAssignField()
                    begin
                        if ("Purchase Line"."Document Type" = "Purchase Line"."Document Type"::Order) or ("Purchase Line"."Document Type" = "Purchase Line"."Document Type"::"Return Order") then  //order var 3 hbk ret var 5
                            "Purchase Line".Quantity := -"Purchase Line".Quantity;
                    end;
                }
                fieldelement(Price; "Purchase Line"."Direct Unit Cost")
                {
                }
                fieldelement(Discount; "Purchase Line"."Line Discount %")
                {
                }
                fieldelement(Amount; "Purchase Line".Amount)
                {

                    trigger OnAfterAssignField()
                    begin
                        if ("Purchase Line"."Document Type" = "Purchase Line"."Document Type"::Order) or ("Purchase Line"."Document Type" = "Purchase Line"."Document Type"::"Return Order") then
                            "Purchase Line".Amount := -"Purchase Line".Amount;
                    end;
                }
                fieldelement(Txt; "Purchase Line".Description)
                {
                }
                fieldelement(UnitCode; "Purchase Line"."Unit of Measure")
                {
                }
                textelement(DeliverNow)
                {

                    trigger OnAfterAssignVariable()
                    var
                        Qty: Decimal;
                    begin
                        "Purchase Line"."Qty. to Receive" := "Purchase Line".Quantity;
                        "Purchase Line"."Qty. to Invoice" := "Purchase Line".Quantity;
                    end;
                }
                textelement(Delivery)
                {

                    trigger OnAfterAssignVariable()
                    var
                        Dato: Date;
                    begin
                        Evaluate(Dato, Delivery);
                        if Dato < Today then
                            Dato := Today;

                        if ("Purchase Line"."Document Type" = "Purchase Line"."Document Type"::"Return Order") then
                            Dato := Today;

                        "Purchase Line".Validate("Expected Receipt Date", Dato);
                    end;
                }
                textelement(Department)
                {
                }
                textelement(Centre)
                {
                }
                textelement(Purpose)
                {
                }
                textelement(Employee)
                {
                }
                textelement(Account)
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    Item: Record Item;
                    Res: Record Resource;
                    Fin: Record "G/L Account";
                    Price: Decimal;
                begin

                    if ItemNumber <> '' then begin
                        if Item.Get(ItemNumber) then
                            "Purchase Line".Type := "Purchase Line".Type::"Fixed Asset";
                        if Res.Get(ItemNumber) then
                            "Purchase Line".Type := "Purchase Line".Type::"G/L Account";
                    end else
                        if (ItemNumber = '') and (Account <> '') then begin
                            ItemNumber := Account;
                            if Fin.Get(ItemNumber) then
                                "Purchase Line".Type := "Purchase Line".Type::"Charge (Item)";
                        end else begin
                            "Purchase Line".Type := "Purchase Line".Type::" ";
                            ItemNumber := '';
                            "Purchase Line".Quantity := 0;
                        end;

                    Price := "Purchase Line"."Direct Unit Cost";

                    if "Purchase Line".Type = "Purchase Line".Type::Item then begin
                        "Purchase Line".Validate("No.", ItemNumber);

                        if "Purchase Line".Quantity <> 0 then
                            "Purchase Line".Validate("Direct Unit Cost", Price);

                        if ("Purchase Line"."No." <> '') and ("Purchase Line".Quantity <> 0) then begin
                            //  "Purchase Line".VALIDATE(Quantity);
                            //  "Purchase Line".VALIDATE("Unit Price");
                            "Purchase Line".Validate("Line Discount %");
                        end;
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
        sl: Record "Purchase Line";
    begin
        sl.DeleteAll;
    end;
}

