param (
    [string] $sqlserverName = "",
    [string] $sqlServerUser = "",
    [string] $sqlServerPassword = "",
    [string] $sqlDBName = "",
    [string] $sqlFileName = ""  
) 
&.\ImportAzureModule.ps1

Write-Verbose "Creating firewall rule to allow sql server access to full range of ip addresses"
$rule = New-AzureSqlDatabaseServerFirewallRule -ServerName $sqlserverName -RuleName "demorule" -StartIPAddress "0.0.0.0" -EndIPAddress "255.255.255.255" -ErrorAction SilentlyContinue

Write-Verbose "Preparing the Azure SQL Database with output tables/stored procedures and types"
$sqlQuery = get-content $sqlFileName | Out-String

# Create the connection string
$sqlConnectionString ="Server=tcp:$sqlserverName.database.windows.net,1433;Database=$sqlDBName;User ID=$sqlServerUser;Password=$sqlServerPassword;Trusted_Connection=False;Encrypt=True;Connection Timeout=30"
$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = $sqlConnectionString

#Create the SQL Command object
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.Connection = $SqlConnection
#Open SQL connection
$SqlCmd.Connection.Open()

$sqlQuery -split "GO;" | ForEach-Object{
    if($_ -ne "")
    {
        $SqlCmd.CommandText = $_
        #Execute the Query
        $ReturnValue = $SqlCmd.ExecuteNonQuery()
    }
}
#Close the connection
$SqlCmd.Connection.Close()