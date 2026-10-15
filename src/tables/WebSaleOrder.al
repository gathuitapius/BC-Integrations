table 50120 "Web Sale Order"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Order No."; Code[20]) { }
        field(2; "Customer No."; Code[20]) { TableRelation = Customer; }
        field(3; "Item No."; Code[20]) { TableRelation = Item; }
        field(4; Quantity; Decimal) { }
        field(5; "Order Date"; Date) { }
        field(6; Status; Option) { OptionMembers = Received,Processed,Error; }
    }

    keys
    {
        key(PK; "Order No.") { Clustered = true; }   // the same order can't arrive twice
    }

    trigger OnInsert()
    var
        WebOrderSetup: Record "Web Order Setup";
        NoSeries: Codeunit "No. Series";
    begin
        if "Order No." = '' then begin
            WebOrderSetup.Get();
            WebOrderSetup.TestField("Order Nos.");
            "Order No." := NoSeries.GetNextNo(WebOrderSetup."Order Nos.", WorkDate(), true);
        end;
    end;
}