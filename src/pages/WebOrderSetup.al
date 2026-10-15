page 50121 "Web Order Setup"
{
    ApplicationArea = All;
    Caption = 'Web Order Setup';
    PageType = Card;
    SourceTable = "Web Order Setup";
    UsageCategory = Administration;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                Caption = 'Numbering';
                field("Order Nos."; Rec."Order Nos.")
                {
                    ToolTip = 'Specifies the number series used to assign numbers to web orders.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
