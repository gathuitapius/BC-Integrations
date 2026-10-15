page 50120 "Web Order API"
{
    PageType = API;

    // These five lines build the URL:
    APIPublisher = 'pius';          // your company or name
    APIGroup = 'shop';              // a group for related APIs
    APIVersion = 'v1.0';            // change it when you make breaking changes
    EntityName = 'webOrder';        // name for one record
    EntitySetName = 'webOrders';    // name for the list, used in the URL

    SourceTable = "Web Sale Order";
    ODataKeyFields = SystemId;      // every BC record has a hidden unique ID; APIs use it
    DelayedInsert = true;           // wait until all fields arrive, then insert (required)

    layout
    {
        area(Content)
        {
            repeater(Records)
            {
                // Left side = name in the JSON; right side = field in BC
                field(id; Rec.SystemId) { Editable = false; }
                field(orderNo; Rec."Order No.") { Editable = false; }   // assigned from the No. Series on insert
                field(customerNo; Rec."Customer No.") { }
                field(itemNo; Rec."Item No.") { }
                field(quantity; Rec.Quantity) { }
                field(orderDate; Rec."Order Date") { }
                field(status; Rec.Status) { Editable = false; }   // outsiders can read it, not set it
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        WebOrder: Record "Web Sale Order";
    begin
        Rec.Status := Rec.Status::Received;
        Rec.Insert(true);   // assigns the Order No. from the No. Series
        Commit();           // keep the received order even if sales processing fails

        WebOrder := Rec;
        if not Codeunit.Run(Codeunit::"Process Web Order", WebOrder) then begin
            WebOrder.Get(Rec."Order No.");
            WebOrder.Status := WebOrder.Status::Error;
            WebOrder.Modify();
            Commit();
        end else begin
            Commit();       // close the posting transaction before the outbound HTTP call
            SendCustomerToCRM(WebOrder."Customer No.");
        end;
        Rec.Get(Rec."Order No.");   // refresh so the response shows the final status

        exit(false);        // already inserted above
    end;

    local procedure SendCustomerToCRM(CustomerNo: Code[20])
    var
        Customer: Record Customer;
        CRMSender: Codeunit "Send Customer To CRM system";
    begin
        // Runs after Commit(): HTTP calls are not allowed inside an open write transaction.
        // A CRM failure must not undo or fail the order, so the result is ignored.
        if Customer.Get(CustomerNo) then
            if CRMSender.TrySendCustomerToCRM(Customer) then;
    end;
}