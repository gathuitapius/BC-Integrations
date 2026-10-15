tableextension 50125 "Sales Invoice Header BC Shop" extends "Sales Invoice Header"
{
    fields
    {
        // Same field number on all three tables so Sales-Post copies the value to the posted documents
        field(50100; "Created from BC Shop"; Boolean)
        {
            Caption = 'Created from BC Shop';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}
