table 50121 "Web Order Setup"
{
    DataClassification = CustomerContent;
    Caption = 'Web Order Setup';

    fields
    {
        field(1; "Primary Key"; Code[10]) { Caption = 'Primary Key'; }
        field(2; "Order Nos."; Code[20])
        {
            Caption = 'Order Nos.';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "Primary Key") { Clustered = true; }
    }
}
