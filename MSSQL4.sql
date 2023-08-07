CREATE DATABASE ArtList

USE ArtList

CREATE TABLE Albums(
Id int identity primary key,
AlbumName nvarchar(30)
)

CREATE TABLE Musics(
MuscId int identity primary key,
MusicName nvarchar(30),
ListenerCount int,
TotalSecond int,
AlbumId int references Albums(Id)
)


CREATE TABLE Artists(
Id int identity primary key,
ArtistName nvarchar(30)
)

CREATE TABLE AlbumsArtists(
Id int identity primary key,
AlbumsId int references Albums(Id),
ArtistsId int references Artists(Id),
MusicId int references Musics(MuscId)
)

-----SELECT ALL INFO-----
SELECT ArtistName,AlbumName,MusicName,TotalSecond FROM AlbumsArtists
JOIN Artists
on 
AlbumsArtists.ArtistsId=Artists.Id
JOIN Albums
on
AlbumsArtists.AlbumsId=Albums.Id
JOIN Musics
on
AlbumsArtists.MusicId=Musics.MuscId


-----CREATE VIEW FIRST-----
CREATE VIEW GetPointsNamesSecond
AS
SELECT ArtistName,AlbumName,MusicName,TotalSecond FROM AlbumsArtists
JOIN Artists
on 
AlbumsArtists.ArtistsId=Artists.Id
JOIN Albums
on
AlbumsArtists.AlbumsId=Albums.Id
JOIN Musics
on
AlbumsArtists.MusicId=Musics.MuscId

SELECT *FROM GetPointsNamesSecond



----CREATE VIEW SECOND-----
CREATE VIEW GetAlbumNameMusicCount
AS
SELECT AlbumName,COUNT(MuscId)AS MusicCount FROM AlbumsArtists
JOIN Artists
on 
AlbumsArtists.ArtistsId=Artists.Id
JOIN Albums
on
AlbumsArtists.AlbumsId=Albums.Id
JOIN Musics
on
AlbumsArtists.MusicId=Musics.MuscId
Group BY AlbumName

SELECT*FROM GetAlbumNameMusicCount



-------CREATE PROCEDURE------
CREATE PROCEDURE GetListenerAlbumName @listenercount int,@NameOfAlbum nvarchar(30)
AS
SELECT AlbumName,MusicName,ListenerCount FROM AlbumsArtists
JOIN Artists
on 
AlbumsArtists.ArtistsId=Artists.Id
JOIN Albums
on
AlbumsArtists.AlbumsId=Albums.Id
JOIN Musics
on
AlbumsArtists.MusicId=Musics.MuscId
WHERE ListenerCount>@listenercount AND AlbumName=@NameOfAlbum

EXEC GetListenerAlbumName 20000000,AbbeyRoad



