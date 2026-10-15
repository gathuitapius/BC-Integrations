codeunit 50122 "Process Web Order"
{
    TableNo = "Web Sale Order";

    trigger OnRun()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesPost: Codeunit "Sales-Post";
    begin
        Rec.TestField("Customer No.");
        Rec.TestField("Item No.");
        Rec.TestField(Quantity);

        SalesHeader.Init();
        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.Insert(true);
        SalesHeader.Validate("Sell-to Customer No.", Rec."Customer No.");
        if Rec."Order Date" <> 0D then begin
            SalesHeader.Validate("Posting Date", Rec."Order Date");
            SalesHeader.Validate("Order Date", Rec."Order Date");
        end;
        SalesHeader."External Document No." := Rec."Order No.";
        SalesHeader."Created from BC Shop" := true;
        SalesHeader.Modify(true);

        SalesLine.Init();
        SalesLine.Validate("Document Type", SalesHeader."Document Type");
        SalesLine.Validate("Document No.", SalesHeader."No.");
        SalesLine.Validate("Line No.", 10000);
        SalesLine.Insert(true);
        SalesLine.Validate(Type, SalesLine.Type::Item);
        SalesLine.Validate("No.", Rec."Item No.");
        SalesLine.Validate(Quantity, Rec.Quantity);
        SalesLine.Modify(true);

        SalesHeader.Ship := true;
        SalesHeader.Invoice := true;
        SalesPost.Run(SalesHeader);

        Rec.Status := Rec.Status::Processed;
        Rec.Modify();
    end;
}
