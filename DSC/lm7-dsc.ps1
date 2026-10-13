Configuration TylerBaseline
{
    Import-DscResource -ModuleName PSDscResources

    Node localhost
    {
        WindowsFeature WebServer
        {
            Name = 'Web-Server'
            Ensure = 'Present'
        }
    }
}
