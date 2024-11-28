$Workingdirectory = 'C:\users\hanso\Downloads'
$completeddirectory = 'C:\Temp\Completed'
$ArtistDirectory = @()
$Artist = @()
$ArtistAlbum = @()
$ArtistAlbums = @()
$ArtistNameString = @()

#Set Music Directory
$MusicDirectories = Get-ChildItem -Path $Workingdirectory -Recurse -Directory -Force -ErrorAction SilentlyContinue | Select-Object Name,FullName

Foreach ($Artist in $MusicDirectories)
{
#List Artist Name and Directory
$Artist.Name
$Artist.FullName

#Convert Artist Name to String
$ArtistNameString = $Artist.Name.ToString()

#Set Artist Directory for Expanding Archive
$ArtistDirectory = "C:\Temp\Completed\$ArtistNameString"

#For each album unzip, rename, move
$ArtistAlbums = Get-ChildItem -Path $Artist.FullName | Select-Object Name,FullName
Foreach ($ArtistAlbum in $ArtistAlbums)
{
#Set Album Directory
$AlbumDirectoryString = $ArtistAlbum.Name.ToString()
$AlbumDirectoryStringNoZip = 
$AlbumDirectory = "C:\Temp\Completed\$ArtistNameString\$AlbumDirectoryString"
Expand-Archive -LiteralPath $ArtistAlbum.FullName -DestinationPath $AlbumDirectory
}
}
