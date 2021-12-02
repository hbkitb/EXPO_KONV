xmlport 70064 "Multi C5 JobPostGroup"
{

    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = WINDOWS;

    schema
    {
        textelement("Sagsbogføringsgrupper")
        {
            tableelement("Job Posting Group"; "Job Posting Group")
            {
                XmlName = 'JobPostingGroup';
                fieldelement(JobPostingGroupCode; "Job Posting Group".Code)
                {
                }
                textelement(Description)
                {
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
        "Job Posting Group".DeleteAll;
        Commit;
    end;
}

