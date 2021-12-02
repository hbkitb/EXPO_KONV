xmlport 70053 "Multi C5 Job"
{

    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(JobTable)
        {
            tableelement(Job; Job)
            {
                XmlName = 'JobTable';
                fieldelement(JobNumber; Job."No.")
                {
                }
                fieldelement(SearchName; Job."Search Description")
                {
                }
                fieldelement(JobName; Job.Description)
                {
                }
                fieldelement(InvoiceAccount; Job."Bill-to Customer No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        if Cust.Get(Job."Bill-to Customer No.") then begin
                            if Cust.Blocked <> Cust.Blocked::" " then begin
                                Cust.Blocked := Cust.Blocked::" "; //0;
                                Cust.Modify;
                            end;
                        end;
                    end;
                }
                fieldelement(Created; Job."Creation Date")
                {
                }
                fieldelement(Started; Job."Starting Date")
                {
                }
                fieldelement(Delivery; Job."Ending Date")
                {

                    trigger OnAfterAssignField()
                    begin
                        //EVALUATE(Dato,Job."Ending Date");
                        if Job."Ending Date" < Job."Starting Date" then
                            Job."Ending Date" := Job."Starting Date";
                    end;
                }
                fieldelement(JobStatus; Job.Status)
                {
                }
                fieldelement(JobPostingGroup; Job."Job Posting Group")
                {
                }
                textelement(Ansvarlig)
                {
                }
                fieldelement(CurrencyCode; Job."Currency Code")
                {
                }
                fieldelement(Language; Job."Language Code")
                {
                }
                textelement(OurRef)
                {
                }
                textelement(YourRef)
                {
                }
                textelement(Group)
                {
                }
                textelement(Order)
                {
                }
                textelement(ShipToName)
                {
                }
                textelement(ShipToadd1)
                {
                }
                textelement(ShipToAdd2)
                {
                }
                textelement(ShipToZIp)
                {
                }
                textelement(ShipToCity)
                {
                }
                textelement(ShipToCountry)
                {
                }
                textelement(ShipToAttention)
                {
                }
                textelement(Department)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        if Department <> '' then begin
                            DefaultDimension.Init;
                            DefaultDimension."Table ID" := DATABASE::Job;
                            DefaultDimension."No." := Job."No.";
                            DefaultDimension."Dimension Code" := 'AFDELING';
                            DefaultDimension."Dimension Value Code" := Department;
                            DefaultDimension.Insert;
                        end;
                    end;
                }
                textelement(Centre)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        if Centre <> '' then begin
                            DefaultDimension.Init;
                            DefaultDimension."Table ID" := DATABASE::Job;
                            DefaultDimension."No." := Job."No.";
                            DefaultDimension."Dimension Code" := 'BÆRER';
                            DefaultDimension."Dimension Value Code" := Centre;
                            DefaultDimension.Insert;
                        end;
                    end;
                }
                textelement(Purpose)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        if Purpose <> '' then begin
                            DefaultDimension.Init;
                            DefaultDimension."Table ID" := DATABASE::Job;
                            DefaultDimension."No." := Job."No.";
                            DefaultDimension."Dimension Code" := 'FORMÅL';
                            DefaultDimension."Dimension Value Code" := Purpose;
                            DefaultDimension.Insert;
                        end;
                    end;
                }
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
        JobEntry.DeleteAll;
        JobPlanningLine.DeleteAll;
        JobTask.DeleteAll;
        Job.DeleteAll;
        DefaultDimension.SetFilter("Table ID", '167');
        DefaultDimension.DeleteAll;
        DefaultDimension.SetFilter("Table ID", '169');
        DefaultDimension.DeleteAll;
        DefaultDimension.SetFilter("Table ID", '1003');
        DefaultDimension.DeleteAll;
        DefaultDimension.SetFilter("Table ID", '1001');
        DefaultDimension.DeleteAll;
        JobTaskDimension.DeleteAll;
        Commit;
    end;

    var
        Cust: Record Customer;
        JobTask: Record "Job Task";
        JobPlanningLine: Record "Job Planning Line";
        JobEntry: Record "Job Ledger Entry";
        JobPostingGroup: Record "Job Posting Group";
        DefaultDimension: Record "Default Dimension";
        JobTaskDimension: Record "Job Task Dimension";
}

