codeunit 50100 "Send Customer To CRM system"
{
    trigger OnRun()
    begin

    end;

    procedure SendCustomerToCRM(Customer: Record Customer)
    begin
        PostCustomer(Customer);
        Message('Customer %1 sent successfully.', Customer."No.");
    end;

    /// <summary>Silent variant for background processes: no message, returns false instead of raising an error.</summary>
    [TryFunction]
    procedure TrySendCustomerToCRM(Customer: Record Customer)
    begin
        PostCustomer(Customer);
    end;

    local procedure PostCustomer(Customer: Record Customer)
    var
        RequestBody: Text;
        ResponseBody: Text;
        client: HttpClient;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        Json: JsonObject;
        Url: Text;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        Body: Text;
    begin

        Url := 'https://webhook.site/899cd5fe-0709-471a-88c2-c8fa82a9d1ac';


        Json.Add('customerNo.', Customer."No.");
        Json.Add('customerName', Customer.Name);
        Json.Add('customerEmail', Customer."E-Mail");
        Json.Add('customerPhone', Customer."Phone No.");

        Json.WriteTo(Body);

        Content.writeFrom(Body);
        Content.GetHeaders(ContentHeaders);
        ContentHeaders.remove('Content-type');
        ContentHeaders.Add('Content-Type', 'application/json');

        //client.DefaultRequestHeaders.Add('x-api-key', 'your-api-key-here');

        client.Timeout(10000);
        if not client.post(Url, Content, Response) then
            Error('Could not reach the external system.');

        Response.Content().ReadAs(ResponseBody);
        if not Response.IsSuccessStatusCode() then
            Error('Error sending customer data to CRM: %1', ResponseBody);
    end;
}