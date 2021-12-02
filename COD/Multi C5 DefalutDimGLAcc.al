codeunit 70003 "Multi C5 Defalut Dim GL Acc"
{

    trigger OnRun()
    begin
        DefaultDimension.SetFilter("Table ID", '%1', 15);
        if DefaultDimension.FindSet then begin
            repeat
                if DefaultDimension."Value Posting" = DefaultDimension."Value Posting"::"Code Mandatory" then
                    DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::" "
                else
                    if DefaultDimension."Value Posting" = DefaultDimension."Value Posting"::" " then
                        DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::"Code Mandatory";
                DefaultDimension.Modify;
            until DefaultDimension.Next = 0;
        end;
    end;

    var
        DefaultDimension: Record "Default Dimension";
}

