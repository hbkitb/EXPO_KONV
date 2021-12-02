codeunit 70001 "C5 Account Indent"
{
    trigger OnRun()
    begin
        Indent; //
    end;

    var
        GLAcc: Record "G/L Account";
        Window: Dialog;
        AccNo: array[10] of Code[20];
        i: Integer;
        Text000: Label 'This function updates the indentation of all the G/L accounts in the chart of account.';
        Text001: Label 'All accounts between a Begin-Total and the matching End-Total are indented one level.';
        Text002: Label 'The Totaling for each End-total is also updated.';
        Text003: Label '\\Do you want to indent the chart of accounts?';
        Text004: Label 'Indenting the Chart of Accounts #1##########';
        Text005: Label 'End-Total %1 is missing a matching Begin-Total.';

    local procedure Indent()
    var

    begin
        Window.Open(text004);

        //With GLacc do
        //
        IF GLAcc.Find('-') then
            repeat
                Window.Update(1, GLAcc."No.");

                if GLAcc."Account Type" = GLAcc."Account Type"::"End-Total" then begin
                    if i < 1 then
                        ERROR(
                        Text005,
                        GLAcc."No.");
                    GLAcc.Totaling := AccNo[i] + '..' + GLAcc."No.";
                    i := i - 1;
                end;

                GLAcc.Indentation := i;
                GLAcc.Modify();

                if GLAcc."Account Type" = GLAcc."Account Type"::"Begin-Total" then begin
                    i := i + 1;
                    AccNo[i] := GLAcc."No.";
                end;
            until GLAcc.NEXT = 0;

        Window.close;
    end;

    local procedure RunICAccountIndent()
    var

    begin
        IndentICAccount;
    end;

    local procedure IndentICAccount()
    var
        ICGLAcc: Record "IC G/L Account";
    begin
        Window.Open(Text004);
        //with ICGLAcc do
        if ICGLAcc.Find('-') then
            repeat
                Window.Update(1, ICGLAcc."No.");

                IF ICGLAcc."Account Type" = ICGLAcc."Account Type"::"End-Total" then begin
                    if i < 1 then
                        Error(Text005, ICGLAcc."No.");
                    i := i - 1;
                end;

                ICGLAcc.Indentation := i;
                ICGLAcc.Modify();

                if ICGLAcc."Account Type" = ICGLAcc."Account Type"::"Begin-Total" then begin
                    i := i + 1;
                    AccNo[i] := ICGLAcc."No.";
                end;
            Until ICGLAcc.Next = 0;
        Window.Close();


    end;

}