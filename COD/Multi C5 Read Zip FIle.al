codeunit 70503 "Multi C5 Read Zip File"
{
    trigger OnRun()
    begin

    end;

    procedure ReadZip();
    var
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        ResponseText: Text;
        ResponseStream: InStream;
    begin
        if not Client.Get(URL, ResponseMessage) then
            Error(Text001_Err);

        if not ResponseMessage.IsSuccessStatusCode() then begin
            ResponseMessage.Content().ReadAs(ResponseText);
            Error(Text002_Err, ResponseMessage.HttpStatusCode(), ResponseText);
        end;

        ResponseMessage.Content().ReadAs(ResponseStream);
        UnZipResponse(ResponseStream);
    end;

    local procedure UnZipResponse(ResponseInStream: InStream);
    var
        TempNameValueBuffer: Record "Name/Value Buffer" temporary;
    //hTempBLob: Record TempBlob temporary;
    //hZipMgt: Codeunit "Zip Stream Wrapper";
    //hResponseOutStream: OutStream;
    begin
        //hbk ZipMgt.OpenZipFromStream(ResponseInStream, false);
        TempNameValueBuffer.Reset();
        TempNameValueBuffer.DeleteAll();
        //hbk ZipMgt.GetEntries(TempNameValueBuffer);
        if TempNameValueBuffer.FindFirst() then begin
            //hClear(TempBlob);
            //hTempBlob.Blob.CreateOutStream(ResponseOutStream,TextEncoding::Windows);
            //hbk ZipMgt.WriteEntryFromZipToOutStream(TempNameValueBuffer.Name,ResponseOutStream);
            //hTempBlob.Blob.CreateInStream(ResponseInStream,TextEncoding::Windows);
            ParseXml(ResponseInStream);
        end;
    end;

    local procedure ParseXml(ResponseInStream: InStream);

    var
        XmlDoc: XmlDocument;
        Node: XmlNode;
    begin
        XML := '';
        XmlDocument.ReadFrom(ResponseInStream, XmlDoc);
        if XmlDoc.SelectSingleNode('//' + Element, Node) then
            xml := Node.AsXmlElement().InnerText;
    end;

    procedure SetParameters(p_URL: Text; p_Element: Text)
    begin
        URL := p_URL;
        Element := p_Element;
    end;

    procedure GetResult(): Text
    begin
        exit(XML);
    end;

    var
        URL: Text;
        Element: Text;
        XML: Text;
        Text001_Err: Label 'The call to the web service failed.';
        Text002_Err: Label 'The web service returned an error message:\ Status code: %1\ Description: %2';
}
