xmlport 50156 "50156_Imp_KundeVare"
{
    //Import af ekstra felter fra C5 Lagerkart

    Caption = 'KundevareImport';
    DefaultFieldsValidation = false;
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    FileName = 'F:\PBS\DEB\*.DK';
    Format = VariableText;
    Permissions =;
    TextEncoding = WINDOWS;
    UseRequestPage = false;

    schema
    {

        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                XmlName = 'KundeVare';
                UseTemporary = true;
                textelement(Felt01)
                {
                }
                textelement(Felt02)
                {
                }
                textelement(Felt03)
                {
                    MinOccurs = Zero;
                }


                trigger OnBeforeInsertRecord()
                var
                //counter: Integer;

                begin

                    Counter := Counter + 1;   // pga fejl i indsæt på temp. tabel integer.
                    Integer.Number := Counter;


                    IF Felt01 <> '' THEN begin

                        GenPostSetupImp;  //bogopsæt


                    end;


                end;
            }
        }
    }

    requestpage
    {

    }

    trigger OnInitXmlPort()
    begin
        CrossItem.DeleteAll;
    end;

    trigger OnPostXmlPort()
    begin
        MESSAGE('Import er færdig !');  //
    end;

    var
        Item: Record Item;
        //h 
        //SalesPrice: Record "Sales Price";
        SalesPrice: Record "Price List Line";
        Counter: Integer;
        NoInd: Integer;
        COOPSign: Integer;
        OrdKart: Record "Sales Header";
        OrdLinie: Record "Sales Line";
        DebKart: Record Customer;
        FakKart: Record Customer;
        LagKart: Record Item;
        OrdNum: Text[20];
        Dag: Integer;
        "Måned": Integer;
        "År": Integer;
        DebKonto: Text[20];
        FakKonto: Text[20];
        PgBestil: Text[20];
        CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
        ItemCheckAvail: Codeunit "Item-Check Avail.";
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
        PrepmtMgt: Codeunit "Prepayment Mgt.";
        HideValidationDialog: Boolean;
        SalesSetup: Record "Sales & Receivables Setup";
        ArchiveManagement: Codeunit ArchiveManagement;
        LinieNo: Decimal;
        LagKonto: Text[20];
        //h
        //SalesPriceFind: Codeunit "Sales Price Calc. Mgt.";
        SalesPriceFind: Codeunit "Price Calculation Mgt.";  //081020
        PostNr: Integer;
        SagsPost: Record "Job Ledger Entry";
        "Løbenummer": Integer;
        Dato: Date;
        KostPris: Decimal;
        KostPrisRV: Decimal;
        "KostBeløb": Decimal;
        "KostBeløbRV": Decimal;
        GenPostSetup: Record "General Posting Setup";
        GenVareSetup: Record "Inventory Posting Setup";
        VendPost: Record "Vendor Posting Group";
        CustPost: Record "Customer Posting Group";
        Employee: Record Employee;
        ComLine: Record "Comment Line";
        LineNo: Decimal;
        LineNoOld: Decimal;
        ItemPostGrp: Record "Inventory Posting Group";
        VirkBog: Record "Gen. Business Posting Group";
        ProdBog: Record "Gen. Product Posting Group";
        CrossItem: Record "Item Reference";    //"Item Cross Reference";


    /*
    EVALUATE(Dag,COPYSTR(Felt02,1,2));
    EVALUATE(Måned,COPYSTR(Felt02,4,2));
    EVALUATE(År,COPYSTR(Felt02,7,4));
    Dato := DMY2DATE(Dag,Måned,År);  //Dato oprettet

    EVALUATE(Løbenummer,Felt01);
    */


    local procedure GenPostSetupImp()
    begin

        //ItemPostGrp.RESET;
        //ItemPostGrp.SetRange(Code, Felt01);
        //250718 GenPostSetup.SETRANGE("Gen. Bus. Posting Group",Felt01);

        CrossItem.Reset;
        CrossItem.SetRange("Item No.", Felt01);
        //CrossItem.SetRange("Cross-Reference Type No.", Felt02);
        CrossItem.SetRange("Reference No.", Felt02);

        if NOT CrossItem.FindSet then begin

            CrossItem.Reset;
            CrossItem.Init;


            //VirkBog.Code := Felt01;
            if Item.Get(Felt01) then begin
                CrossItem."Item No." := Felt01;
                //CrossItem."Cross-Reference Type" := CrossItem."Cross-Reference Type"::Customer;
                CrossItem."Reference Type" := CrossItem."Reference Type"::Customer;
                //CrossItem."Cross-Reference Type No." := Felt02;
                CrossItem."Reference Type No." := Felt02;
                //CrossItem."Cross-Reference No." := Felt03;
                CrossItem."Reference No." := Felt03;
                CrossItem.Validate("Unit of Measure", Item."Base Unit of Measure");
                CrossItem.Insert;
            end;
        end;

        //IF ItemPostGrp.FINDSET then
        //    repeat
        //ItemPostGrp.ToldPos := Felt02;
        //ItemPostGrp.ToldPosTxt := Felt03;

        //        ItemPostGrp.MODIFY;
        //    until ItemPostGrp.NEXT = 0;
    end;


}
