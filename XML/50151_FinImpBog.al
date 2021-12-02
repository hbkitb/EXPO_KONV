xmlport 50151 "50151_Imp_FinKart"
{
    //Import af ekstra felter fra C5 Lagerkart

    Caption = 'FinImport';
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
                XmlName = 'FinKartImp';
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
        FinKart: Record "G/L Account";

    /*
    EVALUATE(Dag,COPYSTR(Felt02,1,2));
    EVALUATE(Måned,COPYSTR(Felt02,4,2));
    EVALUATE(År,COPYSTR(Felt02,7,4));
    Dato := DMY2DATE(Dag,Måned,År);  //Dato oprettet

    EVALUATE(Løbenummer,Felt01);
    */


    local procedure GenPostSetupImp()
    begin
        if StrLen(Felt01) < 4 then
            felt01 := '0' + Felt01;
        FinKart.RESET;
        FinKart.SetRange("No.", Felt01);
        //250718 GenPostSetup.SETRANGE("Gen. Bus. Posting Group",Felt01);

        IF FinKart.FINDSET then
            repeat
                if Felt02 <> '' then begin

                    if ((Felt02 = 'U25') OR (felt02 = 'Udg25')) then begin
                        FinKart."Gen. Posting Type" := FinKart."Gen. Posting Type"::Sale;
                        FinKart."Gen. Bus. Posting Group" := 'INDENLANDS';
                        FinKart."Gen. Prod. Posting Group" := 'DIVERSE';
                        FinKart."VAT Bus. Posting Group" := 'DANMARK'; //'INDLAND';
                        FinKart."VAT Prod. Posting Group" := 'STANDARD';
                        FinKart.Modify();
                    end;

                    if ((Felt02 = 'I25') OR (Felt02 = 'Indg25')) then begin
                        FinKart."Gen. Posting Type" := FinKart."Gen. Posting Type"::Purchase;
                        FinKart."Gen. Bus. Posting Group" := 'INDENLANDS';
                        FinKart."Gen. Prod. Posting Group" := 'DIVERSE';
                        FinKart."VAT Bus. Posting Group" := 'DANMARK';
                        FinKart."VAT Prod. Posting Group" := 'STANDARD';
                        FinKart.Modify();
                    end;

                    if (Felt02 = 'EU') OR (felt02 = 'IMPORT') then begin
                        FinKart."Gen. Posting Type" := FinKart."Gen. Posting Type"::Purchase;
                        FinKart."Gen. Bus. Posting Group" := 'EU';
                        FinKart."Gen. Prod. Posting Group" := 'DIVERSE';
                        FinKart."VAT Bus. Posting Group" := 'EU';
                        FinKart."VAT Prod. Posting Group" := 'STANDARD';
                        FinKart.Modify();
                    end;

                end;


            until FinKart.NEXT = 0;
    end;


}
