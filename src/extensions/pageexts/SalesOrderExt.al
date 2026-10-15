pageextension 50126 "Sales Order BC Shop" extends "Sales Order"
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
