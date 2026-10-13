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

        Service W3SVC
        {
            Name = 'W3SVC'
            StartupType = 'Automatic'
            State = 'Running'
            DependsOn = '[WindowsFeature]WebServer'
        }
    }
}
