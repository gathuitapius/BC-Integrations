pageextension 50128 "Posted Sales Invoice BC Shop" extends "Posted Sales Invoice"
{
    layout
    {
        addlast(General)
        {
            field("Created from BC Shop"; Rec."Created from BC Shop")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether this document was created from the BC Shop web order process.';
            }
        }
    }
}
