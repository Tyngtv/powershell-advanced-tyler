Configuration TylerBaseline
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node localhost
    {
        WindowsFeature WebServer
        {
            Name = 'Web-Server'
            Ensure = 'Present'
        }
    }
}
