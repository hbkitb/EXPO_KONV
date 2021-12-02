codeunit 70006 "C5 Gen Journal Line Delete"
{
    trigger OnRun()
    begin
        Line.SetFilter(Line."Journal Template Name", 'MULTIC5');
        Line.SetFilter(Line."Journal Batch Name", 'C5Finans*');
        Line.DeleteAll;

        Batch.SetFilter(Batch."Journal Template Name", 'MULTIC5');
        Batch.SetFilter(Batch.Name, 'C5Finans*');
        Batch.DeleteAll;
    end;

    var
        Line: Record "Gen. Journal Line";
        Batch: Record "Gen. Journal Batch";
}

