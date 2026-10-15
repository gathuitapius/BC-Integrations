pageextension 50100 pageextCustomerCard extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast(Processing)
        {
            action(SendToCRM)
            {
                ApplicationArea = All;
                Caption = 'Send to CRM';
                Image = SendToCRM;
                trigger OnAction()
                var
                    Sender: Codeunit "Send Customer To CRM system";
                begin
                    Sender.SendCustomerToCRM(Rec);
                end;
            }
        }
    }
    
    var
        myInt: Integer;
}