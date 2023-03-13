<#
.SYNOPSIS
Adds the App to the SharePoint App Catalog. Script could be used for CI/CD setup in Azure DevOps
.DESCRIPTION
.EXAMPLE
.\m365-spo-login.ps1 -certificateFile "$(caCertificate.secureFilePath)" --password "" --appId "$(AppId)" --tenant "$(TenantId)"
Initiate Login in the Ci-CD Pipeline
.EXAMPLE
.\m365-spo-login.ps1 -certificateFile ".\CI-CD-Setup\onetime-aad-setup\AUM CI-CD Deployment App Certificate.pfx" -password "mypassword" -appId "myappid" -TenantId "mytenantid"
Initiate Login directly from the machine
#>
Param(

        [Parameter(Mandatory = $true)]
        [string]$certificateFile,
        [Parameter(Mandatory = $false)]
        [string]$password,
        [Parameter(Mandatory = $true)]
        [string]$appId,
        [Parameter(Mandatory=$true)]
        [string]$TenantId,
        [Parameter(Mandatory=$false)]
        [string]$SiteUrl = $SiteUrl
)

function m365loginCertificate{
        

     m365 login --authType certificate --certificateFile $certificateFile --password $password --appId $appId --tenant $TenantId
     m365 spo set --url $SiteUrl
     m365 status
}

m365loginCertificate