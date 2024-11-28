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
$ArtistDirectory = "C:\Temp\Completed\$ArtistNameString"

#For each album of the artist unzip, rename, move
$ArtistAlbums = Get-ChildItem -Path $Artist.FullName | Select-Object Name,FullName
Foreach ($ArtistAlbum in $ArtistAlbums)
{

#Convert Album Directoy to string and replace bad characters for folder name and add artist name to folder
$AlbumDirectoryString = $ArtistAlbum.Name.ToString() -replace '.zip' -replace '_SpotifyDown_com' -replace '^', "$ArtistNameString - "

#Set Album Directory
$AlbumDirectory = "E:\TempMusic\Completed\$ArtistNameString\$AlbumDirectoryString"

#Extract Dat
Expand-Archive -LiteralPath $ArtistAlbum.FullName -DestinationPath $AlbumDirectory
}
}
