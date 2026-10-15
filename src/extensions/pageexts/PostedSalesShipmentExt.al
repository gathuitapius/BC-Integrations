pageextension 50127 "Posted Sales Shipment BC Shop" extends "Posted Sales Shipment"
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
