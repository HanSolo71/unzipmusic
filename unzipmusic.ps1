#Add 7zip for powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201
Set-PSRepository -Name 'PSGallery' -SourceLocation "https://www.powershellgallery.com/api/v2" -InstallationPolicy Trusted
Install-Module -Name 7Zip4PowerShell

$Workingdirectory = 'C:\users\hanso\Downloads'
$ArtistDirectory = @()
$Artist = @()
$ArtistAlbum = @()
$ArtistAlbums = @()
$ArtistNameString = @()
$ArtistAlbums = @()
$AlbumDirectoryString = @()
$AlbumDirectory = @()


#Set Music Directory
$MusicDirectories = Get-ChildItem -Path $Workingdirectory -Recurse -Directory -Force -ErrorAction SilentlyContinue | Select-Object Name,FullName

#For each artist in the music directory do the following work
Foreach ($Artist in $MusicDirectories)
{
#List Artist Name and Directory
$Artist.Name
$Artist.FullName

#Convert Artist Name to String
$ArtistNameString = $Artist.Name.ToString()

#Set Artist Directory for Expanding Archive
$ArtistDirectory = "E:\TempMusic\Completed\$ArtistNameString"

#For each album of the artist unzip, rename, move
$ArtistAlbums = Get-ChildItem -Path $Artist.FullName | Select-Object Name,FullName
Foreach ($ArtistAlbum in $ArtistAlbums)
{

#Convert Album Directoy to string and replace bad characters for folder name and add artist name to folder
$AlbumDirectoryString = $ArtistAlbum.Name.ToString() -replace '.zip' -replace '_SpotifyDown_com' -replace '^', "$ArtistNameString - "

#Set Album Directory
$AlbumDirectory = "E:\TempMusic\Completed\$ArtistNameString\$AlbumDirectoryString"

#Extract Dat
#Expand-Archive -LiteralPath $ArtistAlbum.FullName -DestinationPath $AlbumDirectory -Force
Expand-7Zip -ArchiveFileName $ArtistAlbum.FullName -TargetPath $AlbumDirectory
}
}
