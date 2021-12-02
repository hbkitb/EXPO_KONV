xmlport 70026 "Multi C5 SalesLine"
{

    DefaultFieldsValidation = false;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Import_SalesLine)
        {
            tableelement("Sales Line"; "Sales Line")
            {
                XmlName = 'SalesLine';
                fieldelement(DokuType; "Sales Line"."Document Type")
                {
                }
                fieldelement(Number; "Sales Line"."Document No.")
                {
                }
                fieldelement(LineNumber; "Sales Line"."Line No.")
                {
                }
                fieldelement(Type; "Sales Line".Type)
                {
                }
                textelement(ItemNumber)
                {
                }
                fieldelement(Location; "Sales Line"."Location Code")
                {
                }
                fieldelement(Qty; "Sales Line".Quantity)
                {

                    trigger OnAfterAssignField()
                    begin
                        if ("Sales Line"."Document Type" = "Sales Line"."Document Type"::Order) or ("Sales Line"."Document Type" = "Sales Line"."Document Type"::"Return Order") then
                            "Sales Line".Quantity := -"Sales Line".Quantity;
                    end;
                }
                fieldelement(Price; "Sales Line"."Unit Price")
                {
                }
                fieldelement(Discount; "Sales Line"."Line Discount %")
                {
                }
                fieldelement(Amount; "Sales Line".Amount)
                {

                    trigger OnAfterAssignField()
                    begin
                        if ("Sales Line"."Document Type" = "Sales Line"."Document Type"::Order) or ("Sales Line"."Document Type" = "Sales Line"."Document Type"::"Return Order") then
                            "Sales Line".Amount := -"Sales Line".Amount;
                    end;
                }
                fieldelement(Txt; "Sales Line".Description)
                {
                }
                fieldelement(UnitCode; "Sales Line"."Unit of Measure")
                {
                }
                textelement(DeliverNow)
                {

                    trigger OnAfterAssignVariable()
                    var
                        Qty: Decimal;
                    begin
                        "Sales Line"."Qty. to Ship" := "Sales Line".Quantity;
                        "Sales Line"."Qty. to Invoice" := "Sales Line".Quantity;
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

                        if ("Sales Line"."Document Type" = "Sales Line"."Document Type"::"Return Order") then
                            Dato := Today;

                        "Sales Line".Validate("Shipment Date", Dato);
                    end;
                }
                fieldelement(CostPrice; "Sales Line"."Unit Cost (LCY)")
                {
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
                            "Sales Line".Type := "Sales Line".Type::"Fixed Asset";
                        if Res.Get(ItemNumber) then
                            "Sales Line".Type := "Sales Line".Type::"G/L Account";
                    end else
                        if (ItemNumber = '') and (Account <> '') then begin
                            ItemNumber := Account;
                            if Fin.Get(ItemNumber) then
                                "Sales Line".Type := "Sales Line".Type::"Fixed Asset";
                        end else begin
                            "Sales Line".Type := "Sales Line".Type::" ";
                            ItemNumber := '';
                            "Sales Line".Quantity := 0;
                        end;

                    Price := "Sales Line"."Unit Price";

                    if ("Sales Line".Type = "Sales Line".Type::Item) or ("Sales Line".Type = "Sales Line".Type::Resource) then begin
                        "Sales Line".Validate("No.", ItemNumber);

                        if "Sales Line".Quantity <> 0 then
                            "Sales Line".Validate("Unit Price", Price);

                        if ("Sales Line"."No." <> '') and ("Sales Line".Quantity <> 0) then begin
                            //  "Sales Line".VALIDATE(Quantity);
                            //  "Sales Line".VALIDATE("Unit Price");
                            "Sales Line".Validate("Line Discount %");
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
        sl: Record "Sales Line";
    begin
        sl.DeleteAll;
    end;
}

