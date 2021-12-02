codeunit 70004 "Multi C5 Create Journals"
{
    trigger OnRun()
    begin

    end;

    var

    procedure CreateJournalTemplate()
    var
        Template: Record "Gen. Journal Template";

    begin
        CreateSourceCode();

        if not Template.Get('MultiC5') then begin
            Template.Init();
            Template.Name := 'MULTIC5';
            Template.Description := 'Til import fra C5';
            Template."Force Doc. Balance" := false;
            Template."Test Report ID" := 2;
            Template."Page ID" := 39;
            Template."Posting Report ID" := 3;
            Template."Source Code" := 'Start';
            Template.Insert;
        end;
    end;

    procedure CreateSourceCode()
    var
        SourceCode: Record "Source Code";
    begin
        if not SourceCode.Get('START') then begin
            SourceCode.Init();
            SourceCode.Code := 'START';
            SourceCode.Description := 'Start poster/konverterede poster';
            SourceCode.Insert();
        end;
    end;

    procedure CreateJournalBatch(BatchName: Code[20]; BatchDescription: text);

    var
        Batch: Record "Gen. Journal Batch";

    begin
        Batch.SetFilter(Batch.Name, BatchName);
        if not Batch.FindSet() then begin
            Batch.Init();
            Batch."Journal Template Name" := 'MULTIC5';
            Batch.Name := BatchName;
            Batch.Description := BatchDescription;
            Batch.Insert();
        end;
    end;
}