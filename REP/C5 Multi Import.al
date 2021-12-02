report 70000 "Multi C5 Import"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;


    dataset
    {
        //dataitem(DataItemName; SourceTableName)
        //{
        //    column(ColumnName; SourceFieldName)
        //    {

        //    }
        //}


    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Placering af filer til import")
                {
                    field(Sti; Path)
                    {
                        ApplicationArea = All;

                    }
                }
                group(Indlæsningstrin)
                {
                    field(Trin; Trin)
                    {
                        ApplicationArea = All;
                    }
                }
                group(Opsætning)
                {
                    field(Virksomhedsoplysninger; VirksomhedsOplysninger)
                    {
                        ApplicationArea = All;
                    }
                    field("Sælgere/Indkøbere"; SælgereIndkøber)
                    {
                        ApplicationArea = All;
                    }
                    field(Rabatter; Rabatter)
                    {
                        ApplicationArea = All;
                    }
                    field(Debitorgrupper; DebitorGrupper)
                    {
                        ApplicationArea = All;
                    }
                    field(Kreditorgrupper; KreditorGrupper)
                    {
                        ApplicationArea = All;
                    }
                    field(Varegrupper; VareGrupper)
                    {
                        ApplicationArea = All;
                    }
                    field(Varebogføring; "VareBogføring")
                    {
                        ApplicationArea = All;
                    }
                    field(Prisgrupper; PrisGrupper)
                    {
                        ApplicationArea = All;
                    }
                    field(Dimensioner; Dimensioner)
                    {
                        ApplicationArea = All;
                    }
                    field(Lokationer; Lokationer)
                    {
                        ApplicationArea = All;
                    }
                    field(Betalingsbetingelser; BetalingsBetingelser)
                    {
                        ApplicationArea = All;
                    }
                    field(KontoPlan; KontoPlan)
                    {
                        ApplicationArea = All;
                    }
                    field(Valuta; Valuta)
                    {
                        ApplicationArea = All;
                    }
                    field("Valutaopsætning"; "Valutaopsætning")
                    {
                        ApplicationArea = All;
                    }
                    field(Leveringsformer; LeveringsFormer)
                    {
                        ApplicationArea = All;
                    }
                    field("Sagsbogføringsgrupper"; "SagsBogFøringsgrupper")
                    {
                        ApplicationArea = All;
                    }

                }
                group(Stamdata)
                {
                    field(Debitorer; Debitorer)
                    {
                        ApplicationArea = All;
                    }
                    field(Debitornotater; DebitorNotater)
                    {
                        ApplicationArea = All;
                    }
                    field(Debitorkontakter; DebitorKontakter)
                    {
                        ApplicationArea = All;
                    }
                    field("Debitor leveringsadresser"; DebitorLeveringsAdresser)
                    {
                        ApplicationArea = All;
                    }
                    field(Kreditor; Kreditor)
                    {
                        ApplicationArea = All;
                    }
                    field(Kreditornotater; KreditorNotater)
                    {
                        ApplicationArea = All;
                    }
                    field(Kreditorkontakter; KreditorKontakter)
                    {
                        ApplicationArea = All;
                    }
                    field("Kreditor ordreadresser"; KreditorOrdreAdresser)
                    {
                        ApplicationArea = All;
                    }
                    field(Lager; Lager)
                    {
                        ApplicationArea = All;
                    }
                    field(Lagernotater; LagerNotater)
                    {
                        ApplicationArea = All;
                    }
                    field(Lagerpriser; LagerPriser)
                    {
                        ApplicationArea = All;
                    }
                    field(Lagerrabatter; LagerRabatter)
                    {
                        ApplicationArea = All;
                    }
                    field(DebLagPriser; DebLagPriser)  //180121
                    {
                        ApplicationArea = All;
                    }
                    field(Styklister; StykLister)
                    {
                        ApplicationArea = All;
                    }
                    field(Ressourcer; Ressourcer)
                    {
                        ApplicationArea = All;
                    }
                    field(Ressourcenotater; RessourceNotater)
                    {
                        ApplicationArea = All;
                    }
                    field(Ressourcepriser; RessourcePriser)
                    {
                        ApplicationArea = All;
                    }
                }
                //Trin 3
                group("Poster/Ordrer")
                {
                    field("Finans åbningstal"; "FinansÅbning")
                    {
                        ApplicationArea = All;
                    }
                    field(Finansposter; FinansPoster)
                    {
                        ApplicationArea = All;
                    }
                    field("Indlæs finansposter til tabel"; "IndlæsFinansPosterTilTabel")
                    {
                        ApplicationArea = All;
                    }
                    field(Finansbudgetposter; FinansBudgetPoster)
                    {
                        ApplicationArea = All;
                    }
                    field(Debitorposter; DebitorPoster)
                    {
                        ApplicationArea = All;
                    }
                    field(Kreditorposter; KreditorPoster)
                    {
                        ApplicationArea = All;
                    }
                    field(Lagerposter; LagerPoster)
                    {
                        ApplicationArea = All;
                    }
                    field(Salgsordre; SalgsOrdre)
                    {
                        ApplicationArea = All;
                    }
                    field(Indkøbsordre; "IndkøbsOrdre")
                    {
                        ApplicationArea = All;
                    }
                    field(Sager; Sager)
                    {
                        ApplicationArea = All;
                    }
                    Field(Sagslinjer; SagsLinjer)
                    {
                        ApplicationArea = All;
                    }
                    field("SagsplanLægningslinjer"; "SagsPlanLægningsLinjer")
                    {
                        ApplicationArea = All;
                    }
                    field(Sagsposter; SagsPoster)
                    {
                        ApplicationArea = All; //
                    }
                }
            }


        }
        actions
        {
            area(processing)
            {
                //action(ActionName)
                //{
                //    ApplicationArea = All;

                //}
            }
        }


        trigger OnInit();

        begin
            //Path := OpenFolder('C:\EXP2NAV\');
        end;

        trigger OnOpenPage();

        begin

        end;

        trigger OnClosePage();

        var
            MyInFile: File;
            MyOutFile: File;
            StreamIn: InStream;
            StreamOut: OutStream;
            Buffer: Text;
            Items: Record Item;
            //h
            //171120 PriceGroup: Record "Sales Price";
            Cur: Record Currency;
            ImPortToGLEntryBuffer: CodeUnit "C5 Import To G/L Entry Mgt.";

        begin
            //DS_HL Sagerkan ikke læses ind - der sal rettes i eksportkørslerne - noget valutahejs.
            //Trin 1
            if VirksomhedsOplysninger = true then begin
                //if File.Exists(Path + 'VirksomhedsOplysninger.csv') = true and not DebRabat.Get() then begin
                //VarXmlFile.Open(Path + 'VirksomhedsOplysninger.csv');
                //VarXmlFile.CreateInStream(VarInStream);
                //Xmlport.Import(Xmlport::MultiC5_CompanyInformation, VarInStream);
                //VarXmlFile.Close();
                //Commit();
                //end;
                //Xmlport.Run(70003);
                FileName := 'Virksomhedsoplysninger.csv';
                UploadIntoStream('Import Virksomhed', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 Company Info", FileInStream);
            end;

            if "SælgereIndkøber" = true then begin
                //if File.Exists(Path + 'Medarbejdere.csv') = true and not DebRabat.Get() then begin
                //    VarXmlFile.Open(Path + 'Medarbejdere.csv');
                //    VarXmlFile.CreateInStream(VarInStream);
                //    Xmlport.Import(Xmlport::MultiC5_SalesPurchaserCode, VarInStream);
                //    VarXmlFile.Close();
                //    Commit();
                //end;
                FileName := 'Medarbejdere.csv';
                UploadIntoStream('Import Medarbejder', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 SalesPurchaserCode", FileInStream);
            end;

            if Rabatter = true then begin
                //if File.Exists(Path + 'DebRabat.csv') = true and not DebRabat.Get() then begin
                //    VarXmlFile.Open(Path + 'DebRabat.csv');
                //    VarXmlFile.CreateInStream(VarInStream);
                //    Xmlport.Import(Xmlport::MultiC5_CustDiscGroup, VarInStream);
                //    VarXmlFile.Close();
                //    Commit();
                //end;
                FileName := 'DebRabat.csv';
                UploadIntoStream('Import Deb-Rabat', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 CustDisc Group", FileInStream);

                //if File.Exists(Path + 'LagRabat.csv') = true and not LagRabat.Get() then begin
                //    VarXmlFile.Open(Path + 'LagerRabat.csv');
                //    VarXmlFile.CreateInStream(VarInStream);
                //    Xmlport.Import(Xmlport::MultiC5_InvenDiscGroup, VarInStream);
                //    VarXmlFile.Close();
                //    Commit();
                //end;
                FileName := 'LagRabat.csv';
                UploadIntoStream('Import LagRabat', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 InvenDiscGroup", FileInStream);
            end;

            if KontoPlan = true then begin
                //if File.Exists(Path + 'KontoPlan.csv') = true and not DebRabat.Get() then begin
                //    VarXmlFile.Open(Path + 'KontoPlan.csv');
                //    VarXmlFile.CreateInStream(VarInStream);
                //    Xmlport.Import(Xmlport::MultiC5_Ledtable, VarInStream);
                //    VarXmlFile.Close();
                //    Commit();
                FileName := 'KontoPlan.csv';
                UploadIntoStream('Import kontoplan', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 GLChart", FileInStream);
                Commit();

                FileName := 'KontoPlanNotat.csv';
                UploadIntoStream('Import kontop.notat', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 GLChartComments", FileInStream);
                Commit();
                //if File.Exists(Path + 'KontoPlanNotat.csv') = true and not DebRabat.Get() then begin
                //    VarXmlFile.Open(Path + 'KontoPlanNotat.csv');
                //    VarXmlFile.CreateInStream(VarInStream);
                //    Xmlport.Import(Xmlport::MultiC5_LedtableNotes, VarInStream);
                //    VarXmlFile.Close();
                //    Commit();
                //end;
                //end;
            end;

            if DebitorGrupper = true then begin
                //1. Debitorgrupper
                //if File.Exists(Path + 'DebitorGrupper.csv') = true then begin
                //    VarXmlFile.Open(Path + 'DebitorGrupperGrupper.csv');
                //    VarXmlFile.CreateInStream(VarInStream);
                //    Xmlport.Import(Xmlport::MultiC5_CustomerGroup, VarInStream);
                //    VarXmlFile.Close();
                //    Commit();
                //end;
                FileName := 'DebitorGrupper.csv';
                UploadIntoStream('Import Debgrupper', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 CustomerGroup", FileInStream);
            end;

            if KreditorGrupper = true then begin
                //1. Kreditorgrupper
                //if File.Exists(Path + 'KreditorGrupper.csv') = true then begin
                //    VarXmlFile.Open(Path + 'KreditorGrupper.csv');
                //    VarXmlFile.CreateInStream(VarInStream);
                //    Xmlport.Import(Xmlport::MultiC5_VendorGroup, VarInStream);
                //    VarXmlFile.Close();
                //    Commit();
                //end;
                FileName := 'KreditorGrupper.csv';
                UploadIntoStream('Import kregrupper', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 VendorGroup", FileInStream);
            end;

            if VareGrupper = true then begin
                //1. Varegrupper
                //if File.Exists(Path + 'LagerGrupper.csv') = true then begin
                //    VarXmlFile.Open(Path + 'LagerGrupper.csv');
                //    VarXmlFile.CreateInStream(VarInStream);
                //    Xmlport.Import(Xmlport::MultiC5_InvenGroup, VarInStream);
                //    VarXmlFile.Close();
                //    Commit();
                //end;
                FileName := 'LagerGrupper.csv';
                UploadIntoStream('Import LagGrupper', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 InvenGroup", FileInStream);
            end;

            if Lokationer = true then begin
                //1. Lokationer
                //if File.Exists(Path + 'Lokationer.csv') = true then begin
                //    VarXmlFile.Open(Path + 'Lokationer.csv');
                //    VarXmlFile.CreateInStream(VarInStream);
                //    Xmlport.Import(Xmlport::MultiC5_InvenLocation, VarInStream);
                //    VarXmlFile.Close();
                //    Commit();
                //

                FileName := 'Lokationer.csv';
                UploadIntoStream('Import Lokationer', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 InvenLocation", FileInStream);
            end;

            if "VareBogføring" = true then begin
                //1. Varebogføring
                //if File.Exists(Path + 'Varebogforing.csv') = true then begin
                //    VarXmlFile.Open(Path + 'Varebogforing.csv');
                //    VarXmlFile.CreateInStream(VarInStream);
                //    Xmlport.Import(Xmlport::MultiC5_InvenPostSetUp, VarInStream);
                //    VarXmlFile.Close();
                //    Commit();
                //end;
                FileName := 'Varebogforing.csv';
                UploadIntoStream('Import Varebogføring', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 InvenPost SetUp", FileInStream);
            end;

            if PrisGrupper = true then begin
                //1. Prisgrupper
                //if File.Exists(Path + 'PrisGrupper.csv') = true then begin
                //    VarXmlFile.Open(Path + 'PrisGrupper.csv');
                //    VarXmlFile.CreateInStream(VarInStream);
                //    Xmlport.Import(Xmlport::MultiC5_InvenPriceGroup, VarInStream);
                //    VarXmlFile.Close();
                //    Commit();
                //end;
                FileName := 'PrisGrupper.csv';
                UploadIntoStream('Import Prisgrupper', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 InvenPriceGroup", FileInStream);
            end;

            if Dimensioner = true then begin
                //1. Dimensioner
                //if File.Exists(Path + 'Dimensioner.csv') = true then begin
                //    VarXmlFile.Open(Path + 'Dimensioner.csv');
                //    VarXmlFile.CreateInStream(VarInStream);
                //    Xmlport.Import(Xmlport::MultiC5_Dimensions, VarInStream);
                //    VarXmlFile.Close();
                FileName := 'Dimensioner.csv';
                UploadIntoStream('Import Dimensionar', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 Dimensions", FileInStream);
                //    Commit();
                //end;
            end;

            if BetalingsBetingelser = true then begin
                //1. Betalingsbetingelser
                //if File.Exists(Path + 'Betalingsbetingelser.csv') = true then begin
                //    VarXmlFile.Open(Path + 'Betalingsbetingelser.csv');
                //    VarXmlFile.CreateInStream(VarInStream);
                //    Xmlport.Import(Xmlport::MultiC5_Payment, VarInStream);
                //    VarXmlFile.Close();
                //    Commit();
                //end;
                FileName := 'Betalingsbetingelser.csv';
                UploadIntoStream('Import BetalingsBet', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 Payment", FileInStream);
            end;

            if "Valutaopsætning" = true then begin
                //1. Valutaopsætning
                //if File.Exists(Path + 'ValutaOpsætning.csv') = true then begin
                //    VarXmlFile.Open(Path + 'ValutaOpsætning.csv');
                //    VarXmlFile.CreateInStream(VarInStream);
                //    Xmlport.Import(Xmlport::MultiC5_CurrencySetUp, VarInStream);
                //    VarXmlFile.Close();
                //    Commit();
                //end;
                FileName := 'ValutaOpsætning.csv';
                UploadIntoStream('Import Valutaops.', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 Currency SetUp", FileInStream);
            end;

            if Valuta = true then begin
                //1. Valuta
                //if File.Exists(Path + 'Valuta.csv') = true then begin
                //    VarXmlFile.Open(Path + 'Valuta.csv');
                //    VarXmlFile.CreateInStream(VarInStream);
                //    Xmlport.Import(Xmlport::MultiC5_CurrencyExchRate, VarInStream);
                //    VarXmlFile.Close();
                //    Commit();
                //end;
                FileName := 'ValutaKurser.csv';
                UploadIntoStream('Import Val-Kurser', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 Currency Exch Rate", FileInStream);
            end;

            if LeveringsFormer = true then begin
                //1. Leveringsformer
                //if File.Exists(Path + 'LeveringsFormer.csv') = true then begin
                //    VarXmlFile.Open(Path + 'LeveringsFormer.csv');
                //    VarXmlFile.CreateInStream(VarInStream);
                //    Xmlport.Import(Xmlport::MultiC5_LeveringsFormer, VarInStream);
                //    VarXmlFile.Close();
                //    Commit();
                //end;
                FileName := 'Leveringsformer.csv';
                UploadIntoStream('Import Lev-Former', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 Leveringsformer", FileInStream);

                //1. Leveringsformerprog
                //if File.Exists(Path + 'LeveringsFormerSprog.csv') = true then begin
                //    VarXmlFile.Open(Path + 'LeveringsFormerSprog.csv');
                //    VarXmlFile.CreateInStream(VarInStream);
                //    Xmlport.Import(Xmlport::MultiC5_LeveringsFormerSprog, VarInStream);
                //    VarXmlFile.Close();
                //    Commit();
                //end;

                FileName := 'LeveringsFormerSprog.csv';
                UploadIntoStream('Import Levform-SPROG', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 Lev. form Sprog", FileInStream);

            end;

            if "SagsBogFøringsgrupper" = true then begin
                //1. Sagsbogføringsgrupper
                //if File.Exists(Path + 'SagsbogføringsGrupper.csv') = true then begin
                //    VarXmlFile.Open(Path + 'SagsBogføringsGrupper.csv');
                //    VarXmlFile.CreateInStream(VarInStream);
                //    Xmlport.Import(Xmlport::MultiC5_JobPostGroup, VarInStream);
                //    VarXmlFile.Close();
                //    Commit();
                //end;
                FileName := 'SagsBogføringsgrupper.csv';
                UploadIntoStream('Import Sagbogf-GRP', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 JobPostGroup", FileInStream);
            end;

            //Trin 2

            //her kommer fra NAV2017

            /////// TRIN 2
            IF Debitorer = TRUE THEN BEGIN
                // 2.DEBITORER
                //IF FILE.EXISTS(Path+'Debitor.csv') = TRUE THEN BEGIN
                //  VarXmlFile.OPEN(Path+'Debitor.csv');
                //  VarXmlFile.CREATEINSTREAM(VarInStream);
                FileName := 'Debitor.csv';
                UploadIntoStream('Import Debitor', Path, '', FileName, FileInStream);
                XMLPORT.IMPORT(XMLPORT::"Multi C5 CustTable", FileInStream);
                //  VarXmlFile.CLOSE;
                //  COMMIT;
                //END;
            END;
            IF DebitorNotater = TRUE THEN BEGIN
                // 2.DEBITOR-NOTATER
                //IF FILE.EXISTS(Path+'DebitorNotat.csv') = TRUE THEN BEGIN
                FileName := 'DebitorNotat.csv';
                UploadIntoStream('Import DebitorNotat', Path, '', FileName, FileInStream);
                XMLPORT.IMPORT(XMLPORT::"Multi C5 Custtable Notes", FileInStream);
                //VarXmlFile.OPEN(Path+'DebitorNotat.csv');
                //VarXmlFile.CREATEINSTREAM(VarInStream);
                //XMLPORT.IMPORT(XMLPORT::MultiC5_CustTableNotes, VarInStream);
                //VarXmlFile.CLOSE;
                //COMMIT;
                //END;
            END;

            IF DebitorKontakter = TRUE THEN BEGIN
                // 2.DEBITOR-KONTAKTER
                FileName := 'DebitorKontakt.csv';
                UploadIntoStream('Import DebitorKontakt', Path, '', FileName, FileInStream);
                XMLPORT.IMPORT(XMLPORT::"Multi C5 CustomerContact", FileInStream);
                //IF FILE.EXISTS(Path+'DebitorKontakt.csv') = TRUE THEN BEGIN
                //  VarXmlFile.OPEN(Path+'DebitorKontakt.csv');
                //  VarXmlFile.CREATEINSTREAM(VarInStream);
                //  XMLPORT.IMPORT(XMLPORT::MultiC5_CustomerContact, VarInStream);
                //  VarXmlFile.CLOSE;
                //  COMMIT;
                //END;
            END;
            /*hbk
            IF DebitorLeveringsAdresser = TRUE THEN BEGIN
              // 2.DEBITOR-LEVERINGSADRESSER
              IF FILE.EXISTS(Path+'DebitorLevering.csv') = TRUE THEN BEGIN
                VarXmlFile.OPEN(Path+'DebitorLevering.csv');
                VarXmlFile.CREATEINSTREAM(VarInStream);
                XMLPORT.IMPORT(XMLPORT::MultC5_CustomerShipmentAddress, VarInStream);
                VarXmlFile.CLOSE;
                COMMIT;
              END;
            END;
           hbk */
            IF Kreditor = TRUE THEN BEGIN
                // 2.KREDITORER
                FileName := 'Kreditor.csv';
                UploadIntoStream('Import kreditor', Path, '', FileName, FileInStream);
                XMLPORT.IMPORT(XMLPORT::"Multi C5 VendTable", FileInStream);
                /*
                IF FILE.EXISTS(Path+'Kreditor.csv') = TRUE THEN BEGIN
                  VarXmlFile.OPEN(Path+'Kreditor.csv');
                  VarXmlFile.CREATEINSTREAM(VarInStream);
                  XMLPORT.IMPORT(XMLPORT::MultiC5_VendTable, VarInStream);
                  VarXmlFile.CLOSE;
                  COMMIT;
                END;
                */
                // 2.Kreditor Bankoplysninger
                //DSDK.02-->
                /*
                IF FILE.EXISTS(Path + 'KreditorBank.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'KreditorBank.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_VendorBankAccount, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                */
                //DSDK.02 <--
            END;

            IF KreditorNotater = TRUE THEN BEGIN

                FileName := 'KreditorNotat.csv';
                UploadIntoStream('Import KreditorNotat', Path, '', FileName, FileInStream);
                XMLPORT.IMPORT(XMLPORT::"Multi C5 Vendtable Notes", FileInStream);



            END;

            /*
            IF KreditorKontakter = TRUE THEN BEGIN
                FileName := 'DebitorKontakt.csv';
                UploadIntoStream('Import DebitorKontakt', Path, '', FileName, FileInStream);
                XMLPORT.IMPORT(XMLPORT::"Multi C5 CustomerContact", FileInStream);


                // 2.KREDITOR-KONTAKTER
                IF FILE.EXISTS(Path + 'KreditorKontakt.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'KreditorKontakt.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_VendorContact, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
            END;
            IF KreditorOrdreAdresser = TRUE THEN BEGIN
                // 2.KREDITOR_ORDREADRESSER
                IF FILE.EXISTS(Path + 'KreditorLevering.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'KreditorLevering.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_VendorOrderAddress, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
            END;
            */
            IF Lager = TRUE THEN BEGIN
                // 2.LAGER
                FileName := 'Lager.csv';
                UploadIntoStream('Import Lager', Path, '', FileName, FileInStream);
                Message('777700');
                XMLPORT.IMPORT(XMLPORT::"Multi C5 InvenTable", FileInStream);
                //*
                FileName := 'Vareoversattelser.csv';
                UploadIntoStream('Import Vareoversættelser', Path, '', FileName, FileInStream);
                XMLPORT.IMPORT(XMLPORT::"Multi C5 Itemtranslation", FileInStream);

                FileName := 'HovedUdvVaretekster.csv';
                UploadIntoStream('Import Hovedudvvaretxt', Path, '', FileName, FileInStream);
                XMLPORT.IMPORT(XMLPORT::"Multi C5 Ext. ItemTextHeader", FileInStream);

                FileName := 'UdvVaretekster.csv';
                UploadIntoStream('Import udvvaretekster', Path, '', FileName, FileInStream);
                XMLPORT.IMPORT(XMLPORT::"Multi C5 InvenItemText", FileInStream);


                //*/

                /*
                IF FILE.EXISTS(Path + 'Lager.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'Lager.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_InvenTable, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                IF FILE.EXISTS(Path + 'VareOversattelser.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'VareOversattelser.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_ItemTranslation, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                IF FILE.EXISTS(Path + 'HoveddUdvVaretekster.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'HoveddUdvVaretekster.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_ExtendedItemTextHeader, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                IF FILE.EXISTS(Path + 'UdvVaretekster.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'UdvVaretekster.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_InvenItemText, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                IF FILE.EXISTS(Path + 'LagerVareLeverandor.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'LagerVareLeverandor.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_ItemVendor, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                */
            END;
            IF LagerNotater = TRUE THEN BEGIN
                // 2.LAGER-NOTATER
                FileName := 'LagerNotat.csv';
                UploadIntoStream('Import LagerNotat', Path, '', FileName, FileInStream);
                XMLPORT.IMPORT(XMLPORT::"Multi C5 InvenTable Notes", FileInStream);
                /*
                IF FILE.EXISTS(Path + 'LagerNotat.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'LagerNotat.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_InvenTableNotes, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                */
            END;
            IF LagerPriser = TRUE THEN BEGIN
                // 2.LAGER-PRISER
                FileName := 'LagerPriser.csv';
                UploadIntoStream('Import LagerPriser', Path, '', FileName, FileInStream);
                XMLPORT.IMPORT(XMLPORT::"Multi C5 InvenPrice", FileInStream);
                /*
                IF FILE.EXISTS(Path + 'LagerPriser.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'LagerPriser.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_InvenPrice, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                */

                /*
                IF FILE.EXISTS(Path + 'LagerVareLeverandorPris.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'LagerVareLeverandorPris.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_ItemVendorPrice, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                */
            END;
            IF LagerRabatter = TRUE THEN BEGIN
                FileName := 'SalgRabat.csv';
                UploadIntoStream('Import SalgRabat', Path, '', FileName, FileInStream);
                XMLPORT.IMPORT(XMLPORT::"Multi C5 SalesLineDisc", FileInStream);
                /*
                IF FILE.EXISTS(Path + 'SalgRabat.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'SalgRabat.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_SalesLineDisc, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                */
            END;
            //180121
            IF DebLagPriser = TRUE THEN BEGIN
                FileName := 'SalgPris.csv';
                UploadIntoStream('Import SalgPris', Path, '', FileName, FileInStream);
                XMLPORT.IMPORT(XMLPORT::"Multi C5 CustSalesPrice", FileInStream);
                /*
                IF FILE.EXISTS(Path + 'SalgRabat.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'SalgRabat.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_SalesLineDisc, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                */
            END;
            //180121            
            IF Styklister = TRUE THEN BEGIN
                // 2.STYKLISTER
                FileName := 'Stykliste.csv';
                UploadIntoStream('Import Stykliste', Path, '', FileName, FileInStream);
                XMLPORT.IMPORT(XMLPORT::"Multi C5 InvenBom", FileInStream);
                /*
                IF FILE.EXISTS(Path + 'Stykliste.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'Stykliste.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_InvenBOM, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                */
            END;

            IF Ressourcer = TRUE THEN BEGIN
                // 2.RESSOURCER
                FileName := 'ResLager.csv';
                UploadIntoStream('Import ResLager', Path, '', FileName, FileInStream);
                XMLPORT.IMPORT(XMLPORT::"Multi C5 Resource", FileInStream);
                /*
                IF FILE.EXISTS(Path + 'ResLager.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'ResLager.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_Resource, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                */
            END;
            IF RessourceNotater = TRUE THEN BEGIN
                // 2.RESSOURCE-NOTATER
                FileName := 'ResLagNotat.csv';
                UploadIntoStream('Import ResLagNotat', Path, '', FileName, FileInStream);
                XMLPORT.IMPORT(XMLPORT::"Multi C5 Resource Notes", FileInStream);
                /*
                IF FILE.EXISTS(Path + 'ResLagerNotat.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'ResLagerNotat.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_ResourceNotes, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                */
            END;
            IF RessourcePriser = TRUE THEN BEGIN
                // 2.RESSOURCE-PRISER
                FileName := 'ResLagerPriser.csv';
                UploadIntoStream('Import ResLagerPriser', Path, '', FileName, FileInStream);
                XMLPORT.IMPORT(XMLPORT::"Multi C5 ResourcePrice", FileInStream);
                /*
                IF FILE.EXISTS(Path + 'ResLagerPriser.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'ResLagerPriser.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_ResourcePrice, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                */
            END;

            // Slut 2.trin


            /////// TRIN 3
            IF FinansÅbning = TRUE THEN BEGIN
                //RequestOptionsPage := 
                // 3.FINANSÅBNINGER
                FileName := 'FinansÅbning.csv';
                UploadIntoStream('Import FinÅbning', Path, '', FileName, FileInStream);
                //Message('før_25');
                //Message('111111111111');
                //Message(format(RequestOptionsPage));
                Xmlport.Import(Xmlport::"Multi C5 GLEntryOpening", FileInStream);
                //Xmlport.Run(70003);  //250221
                //Xmlport.Run(70003);
                //Xmlport.Run(70058, false);  //250221
                //Message('efter_25');

                /*
                IF FILE.EXISTS(Path + 'FinansÅbning.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'FinansÅbning.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_LedTransOpening, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                */
            END;
            IF FinansPoster = TRUE THEN BEGIN
                //3.FINANSPOSTER
                //  IF FILE.EXISTS(Path+'FinansPoster.csv') = TRUE THEN BEGIN
                //    VarXmlFile.OPEN(Path+'FinansPoster.csv');
                //   VarXmlFile.CREATEINSTREAM(VarInStream);
                //   XMLPORT.IMPORT(XMLPORT::MultiC5_InsertFinansposter, VarInStream);
                //   VarXmlFile.CLOSE;
                //  COMMIT;
                // END;

                //IF FinansPoster = TRUE THEN BEGIN
                // 3.FINANSPOSTER
                FileName := 'FinansPoster.csv';
                UploadIntoStream('Import Fin-Poster', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 G/L Entries", FileInStream);
                /*
                IF FILE.EXISTS(Path + 'FinansPoster.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'FinansPoster.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    //XMLPORT.IMPORT(XMLPORT::MultiC5_InsertFinansposter, VarInStream);
                    ImportToGLEntryBuffer.Import(VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                    PAGE.RUN(PAGE::"G/L Entry Buffer");
                END;
                */
                //END;

            END;

            IF FinansBudgetPoster = TRUE THEN BEGIN
                //3.FINANSBUDGETPOSTER

                FileName := 'BudgetPoster.csv';
                UploadIntoStream('Import Budgetposter', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 G/L Budget", FileInStream);
                /*
                IF FILE.EXISTS(Path + 'FinansPoster.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'FinansPoster.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_GLBudget, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                */
            END;

            IF DebitorPoster = TRUE THEN BEGIN
                // 3.DEBITORPOSTER
                FileName := 'DebitorPoster.csv';
                UploadIntoStream('Import Debitorposter', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 CustTrans", FileInStream);
                /*
                IF FILE.EXISTS(Path + 'Debitorposter.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'Debitorposter.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_CustTrans, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                */
            END;

            IF KreditorPoster = TRUE THEN BEGIN
                // 3.KREDITORPOSTER
                FileName := 'KreditorPoster.csv';
                UploadIntoStream('Import Kreditorposter', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 VendTrans", FileInStream);
                /*
                IF FILE.EXISTS(Path + 'Kreditorposter.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'Kreditorposter.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_VendTrans, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                */
            END;

            IF LagerPoster = TRUE THEN BEGIN
                // 3.LAGERPOSTER
                FileName := 'LagerPoster.csv';
                UploadIntoStream('Import Lagerposter', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 InvenTrans", FileInStream);
                /*
                IF FILE.EXISTS(Path + 'Lagerposter.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'Lagerposter.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_InvenTrans, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                */
            END;

            IF Salgsordre = TRUE THEN BEGIN
                // 3.SALGSORDRE - HEADER
                FileName := 'SalgsOrdrer.csv';
                UploadIntoStream('Import Salgsordrer', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 SalesTable", FileInStream);
                /*
                IF FILE.EXISTS(Path + 'SalgsOrdre.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'SalgsOrdre.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_SalesTable, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                */
                // 3.SALGSORDRE - LINJER
                FileName := 'Salgslinjer.csv';
                UploadIntoStream('Import Salgslinjer', Path, '', FileName, FileInStream);
                Xmlport.Import(Xmlport::"Multi C5 SalesLine", FileInStream);
                /*
                IF FILE.EXISTS(Path + 'Salgslinjer.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'Salgslinjer.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_SalesLine, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                */

                // 3.SALGSORDRE - HEADER - NOTATER
                /*
                IF FILE.EXISTS(Path + 'SalgsOrdreNotat.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'SalgsOrdreNotat.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_SalesTableNotes, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                // 3.SALGSORDRE - LINJER - NOTATER
                IF FILE.EXISTS(Path + 'SalgsLinjeNotat.csv') = TRUE THEN BEGIN
                    VarXmlFile.OPEN(Path + 'SalgsLinjeNotat.csv');
                    VarXmlFile.CREATEINSTREAM(VarInStream);
                    XMLPORT.IMPORT(XMLPORT::MultiC5_SalesLineNotes, VarInStream);
                    VarXmlFile.CLOSE;
                    COMMIT;
                END;
                */
            END;

            /*
                        IF Indkøbsordre = TRUE THEN BEGIN
                            // 3.INDKØBSORDRE - HEADER
                            IF FILE.EXISTS(Path + 'IndkøbsOrdre.csv') = TRUE THEN BEGIN
                                VarXmlFile.OPEN(Path + 'IndkøbsOrdre.csv');
                                VarXmlFile.CREATEINSTREAM(VarInStream);
                                XMLPORT.IMPORT(XMLPORT::MultiC5_PurchTable, VarInStream);
                                VarXmlFile.CLOSE;
                                COMMIT;
                            END;
                            // 3.INDKØBSORDRE - LINJER
                            IF FILE.EXISTS(Path + 'Indkøbslinjer.csv') = TRUE THEN BEGIN
                                VarXmlFile.OPEN(Path + 'Indkøbslinjer.csv');
                                VarXmlFile.CREATEINSTREAM(VarInStream);
                                XMLPORT.IMPORT(XMLPORT::MultiC5_PurchLine, VarInStream);
                                VarXmlFile.CLOSE;
                                COMMIT;
                            END;
                            // 3.INDKØBSORDRE - HEADER - NOTATER
                            IF FILE.EXISTS(Path + 'KøbsOrdreNotat.csv') = TRUE THEN BEGIN
                                VarXmlFile.OPEN(Path + 'IndkøbsOrdreNotat.csv');
                                VarXmlFile.CREATEINSTREAM(VarInStream);
                                XMLPORT.IMPORT(XMLPORT::MultiC5_PurchTableNotes, VarInStream);
                                VarXmlFile.CLOSE;
                                COMMIT;
                            END;
                            // 3.INDKØBSORDRE - LINJER - NOTATER
                            IF FILE.EXISTS(Path + 'KøbsLinjeNotat.csv') = TRUE THEN BEGIN
                                VarXmlFile.OPEN(Path + 'KøbsLinjeNotat.csv');
                                VarXmlFile.CREATEINSTREAM(VarInStream);
                                XMLPORT.IMPORT(XMLPORT::MultiC5_PurchLineNotes, VarInStream);
                                VarXmlFile.CLOSE;
                                COMMIT;
                            END;
                        END;

                        IF Sager = TRUE THEN BEGIN
                            // 3. SAGER
                            //MESSAGE('Det er ikke muligt at importere sager - der skal rettes i eksport og/eller import så priser bliver i korrekt valuta på poster');

                            IF FILE.EXISTS(Path + 'Projekter.csv') = TRUE THEN BEGIN
                                VarXmlFile.OPEN(Path + 'Projekter.csv');
                                VarXmlFile.CREATEINSTREAM(VarInStream);
                                XMLPORT.IMPORT(XMLPORT::MultiC5_Job, VarInStream);
                                VarXmlFile.CLOSE;
                                COMMIT;
                            END;
                        END;
                        IF Sagslinjer = TRUE THEN BEGIN
                            // 3.Sagslinjer
                            IF FILE.EXISTS(Path + 'Projektart2Sagsopgave.csv') = TRUE THEN BEGIN
                                VarXmlFile.OPEN(Path + 'Projektart2Sagsopgave.csv');
                                VarXmlFile.CREATEINSTREAM(VarInStream);
                                XMLPORT.IMPORT(XMLPORT::MultiC5_JobLines, VarInStream);
                                VarXmlFile.CLOSE;
                                COMMIT;
                            END;
                        END;

                        IF SagsPlanlægningslinjer = TRUE THEN BEGIN
                            // 3.Sagsplanlægningslinjer
                            IF FILE.EXISTS(Path + 'ProjektLinje2Sagsplanlægning.csv') = TRUE THEN BEGIN
                                VarXmlFile.OPEN(Path + 'ProjektLinje2Sagsplanlægning.csv');
                                VarXmlFile.CREATEINSTREAM(VarInStream);
                                XMLPORT.IMPORT(XMLPORT::MultiC5_JobPlanningLines, VarInStream);
                                VarXmlFile.CLOSE;
                                COMMIT;
                            END;
                        END;
                        IF SagsPoster = TRUE THEN BEGIN
                            // 3.Sagsposter
                            IF FILE.EXISTS(Path + 'ProjektPost2SagsPost.csv') = TRUE THEN BEGIN
                                VarXmlFile.OPEN(Path + 'ProjektPost2SagsPost.csv');
                                VarXmlFile.CREATEINSTREAM(VarInStream);
                                XMLPORT.IMPORT(XMLPORT::MultiC5_JobEntry, VarInStream);
                                VarXmlFile.CLOSE;
                                COMMIT;
                            END;

                        END;
                        // Slut 3.trin
            */

            //her over fra NAV2017

            /*hbk
                        //Trin 3
                        if "FinansÅbning" = true then begin
                            //1. Sagsbogføringsgrupper
                            //if File.Exists(Path + 'SagsbogføringsGrupper.csv') = true then begin
                            //    VarXmlFile.Open(Path + 'SagsBogføringsGrupper.csv');
                            //    VarXmlFile.CreateInStream(VarInStream);
                            //    Xmlport.Import(Xmlport::MultiC5_JobPostGroup, VarInStream);
                            //    VarXmlFile.Close();
                            FileName := 'FinansÅbning.csv';
                            UploadIntoStream('Import FinÅbning', Path, '', FileName, FileInStream);
                            Xmlport.Import(Xmlport::"Multi C5 GLEntryOpening", FileInStream);
                            //    Commit();
                            //end;
                        end;

                        if "SletIndlæsteFinansposter" = true then
                            //Sletter finansposter indlæst i kladder
                            C5GenJournalLineDelete.Run();

                        if "FinansPoster" = true then begin
                            //3. Finansposter
                            if not "IndlæsFinansPosterTilTabel" then begin
                                FileName := 'FinansPoster.csv';
                                UploadIntoStream('Import Fin-Poster', Path, '', FileName, FileInStream);
                                Xmlport.Import(Xmlport::"Multi C5 G/L Entries", FileInStream);
                                //    Commit();
                            end;
                        end;

                        if "FinansBudgetPoster" = true then begin
                            //3. Finansbudgetposter
                            FileName := 'BudgetPoster.csv';
                            UploadIntoStream('Import Budgetposter', Path, '', FileName, FileInStream);
                            Xmlport.Import(Xmlport::"Multi C5 G/L Budget", FileInStream);
                            //    Commit();
                        end;
            hbk */

            Message('Kørslen er færdig')
        end;

        var
            FileName: Text;
            FileInStream: Instream;
            Path: Text[254];
            VarXmlFile: File;
            InStream: File;
            DebRabat: Record "Customer Discount Group";
            LagRabat: Record "Item Discount Group";
            LedTable: Record "G/L Account";
            Trin: Option "0. Ingen","1. Opsætning","2. Stamdata","3. Poster","4. Alt";

            //Trin 1

            VirksomhedsOplysninger: Boolean;
            SælgereIndkøber: Boolean;
            Rabatter: Boolean;
            DebitorGrupper: Boolean;
            KreditorGrupper: Boolean;
            VareGrupper: Boolean;
            VareBogføring: Boolean;
            PrisGrupper: Boolean;
            Dimensioner: Boolean;
            Lokationer: Boolean;
            BetalingsBetingelser: Boolean;
            KontoPlan: Boolean;
            Valuta: Boolean;
            Valutaopsætning: Boolean;
            LeveringsFormer: Boolean;
            SagsBogFøringsgrupper: Boolean;
            //Trin 2
            Debitorer: Boolean;
            DebitorNotater: Boolean;
            DebitorKontakter: Boolean;
            DebitorLeveringsAdresser: Boolean;
            Kreditor: Boolean;
            KreditorNotater: Boolean;
            KreditorKontakter: Boolean;
            KreditorOrdreAdresser: Boolean;
            Lager: Boolean;
            LagerNotater: Boolean;
            LagerPriser: Boolean;
            LagerRabatter: Boolean;
            StykLister: Boolean;
            Ressourcer: Boolean;
            RessourceNotater: Boolean;
            RessourcePriser: Boolean;
            //Trin 3
            FinansÅbning: Boolean;
            FinansPoster: Boolean;
            SletIndlæsteFinansposter: Boolean;
            C5GenJournalLineDelete: Codeunit "C5 Gen Journal Line Delete";
            IndlæsFinansPosterTilTabel: Boolean;
            FinansBudgetPoster: Boolean;
            DebitorPoster: Boolean;
            KreditorPoster: Boolean;
            LagerPoster: Boolean;
            SalgsOrdre: Boolean;
            IndkøbsOrdre: Boolean;
            Sager: Boolean;
            SagsLinjer: Boolean;
            SagsPlanLægningsLinjer: Boolean;
            SagsPoster: Boolean;
            DebLagPriser: Boolean;

        Local procedure OpenFolder(DefaultFolderName: Text[100]): Text

        Var
        //OpenFolderDialog: DotNet System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089;
        //DialogResult: DotNet System.Windows.Forms.DialogResult.System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089;
        begin

        end;


    }
}