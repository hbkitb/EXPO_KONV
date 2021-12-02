xmlport 70042 "Multi C5 Ext. ItemTextHeader"
{
   
    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Import_InvenItemTextHeader)
        {
            tableelement("Extended Text Header"; "Extended Text Header")
            {
                XmlName = 'ExtTextHeader';
                fieldelement(Type; "Extended Text Header"."Table Name")
                {
                }
                fieldelement(Number; "Extended Text Header"."No.")
                {
                }
                fieldelement(Language; "Extended Text Header"."Language Code")
                {
                }
                fieldelement(TxtNo; "Extended Text Header"."Text No.")
                {
                }

                trigger OnAfterInsertRecord()
                begin
                    ExtendedTextHeader."Sales Quote" := true;
                    ExtendedTextHeader."Sales Invoice" := true;
                    ExtendedTextHeader."Sales Order" := true;
                    ExtendedTextHeader."Sales Credit Memo" := true;
                    ExtendedTextHeader."Purchase Quote" := true;
                    ExtendedTextHeader."Purchase Invoice" := true;
                    ExtendedTextHeader."Purchase Order" := true;
                    ExtendedTextHeader."Purchase Credit Memo" := true;
                    ExtendedTextHeader.Reminder := true;
                    ExtendedTextHeader."Finance Charge Memo" := true;
                    ExtendedTextHeader."Sales Blanket Order" := true;
                    ExtendedTextHeader."Purchase Blanket Order" := true;
                    ExtendedTextHeader."Prepmt. Sales Invoice" := true;
                    ExtendedTextHeader."Prepmt. Sales Credit Memo" := true;
                    ExtendedTextHeader."Prepmt. Purchase Invoice" := true;
                    ExtendedTextHeader."Prepmt. Purchase Credit Memo" := true;
                    ExtendedTextHeader."Service Order" := true;
                    ExtendedTextHeader."Service Quote" := true;
                    ExtendedTextHeader."Service Invoice" := true;
                    ExtendedTextHeader."Service Credit Memo" := true;
                    ExtendedTextHeader."Sales Return Order" := true;
                    ExtendedTextHeader."Purchase Return Order" := true;
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
        ExtendedTextHeader.DeleteAll;
    end;

    var
        ExtendedTextHeader: Record "Extended Text Header";
}

