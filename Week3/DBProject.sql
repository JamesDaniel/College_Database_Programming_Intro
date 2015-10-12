DROP TABLE FavouriteSongs;
DROP TABLE SongRatings;
DROP TABLE Playlists;
DROP TABLE FavouritePages;
DROP Table SongComments;
DROP TABLE SongsAtEvent;
DROP TABLE EventMembers;
DROP TABLE Events;
DROP TABLE FriendsWith;
DROP TABLE Friend;
DROP TABLE Members;
DROP TABLE Songs;
DROP TABLE Pages;


CREATE TABLE Members (
MemID NUMBER(6),
firstname VARCHAR(30) NOT NULL,
lastname VARCHAR(30) NOT NULL,
address VARCHAR(200) NOT NULL,
city VARCHAR(30) NOT NULL,
username VARCHAR(30) NOT NULL UNIQUE,
password VARCHAR(30) NOT NULL,
picture VARCHAR(200),
email VARCHAR(50) NOT NULL,
regDate Date,
CONSTRAINT pk_members PRIMARY KEY (MemID)
);

CREATE TABLE Friend (
FriendID NUMBER(6),
MemID NUMBER(6),
CONSTRAINT pk_Friend PRIMARY KEY (FriendID),
CONSTRAINT fk_Friend_Members FOREIGN KEY (MemID) REFERENCES Members(MemID)
);

CREATE TABLE FriendsWith (
MemID NUMBER(6),
FriendID NUMBER(6),
CONSTRAINT pk_FriendsWith PRIMARY KEY (MemID, FriendID),
CONSTRAINT fk_FriendsWith_Members FOREIGN KEY (MemID) REFERENCES Members(MemID),
CONSTRAINT fk_FriendsWith_Friend FOREIGN KEY (FriendID) REFERENCES Friend(FriendID)
);


CREATE TABLE Songs (
SongID NUMBER(6),
songName VARCHAR(30) NOT NULL,
description VARCHAR(200),
genre VARCHAR(20) NOT NULL CHECK (genre IN('ELECTRIC','DANCE','POP','JAZZ')),
numOfViews NUMBER(9),
price NUMBER(5,2) DEFAULT 0,
uploadDate Date,
CONSTRAINT pk_songs PRIMARY KEY (SongID)
);

CREATE TABLE SongRatings (
MemID NUMBER(6),
SongID NUMBER(6),
rating NUMBER(1) CHECK(rating > 0 AND rating < 6),
CONSTRAINT pk_SongRatings PRIMARY KEY (MemID, SongID),
CONSTRAINT fk_SongRatings_Members FOREIGN KEY (MemID) REFERENCES Members(MemID),
CONSTRAINT fk_SongRatings_Songs FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);


CREATE TABLE FavouriteSongs (
MemID NUMBER(6),
SongID NUMBER(6),
CONSTRAINT pk_FavouriteSongs PRIMARY KEY (MemID, SongID),
CONSTRAINT fk_FavouriteSongs_Members FOREIGN KEY (MemID) REFERENCES Members(MemID),
CONSTRAINT fk_FavouriteSongs_Songs FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);

CREATE TABLE Pages (
PageID NUMBER(6),
PageType VARCHAR2(10) CHECK (PageType IN ('BUSINESS','USER','EVENT','BAND')),
BackgroundPicture VARCHAR2(200),
CONSTRAINT pk_Pages PRIMARY KEY (PageID)
);

CREATE TABLE Playlists (
PlaylistID NUMBER(6),
MemID NUMBER(6),
SongID NUMBER(6),
CONSTRAINT pk_Playlists PRIMARY KEY (PlaylistID),
CONSTRAINT fk_Playlists_Members FOREIGN KEY (MemID) REFERENCES Members(MemID),
CONSTRAINT fk_Playlists_Songs FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);

CREATE TABLE FavouritePages (
MemID NUMBER(6),
PageID NUMBER(6),
CONSTRAINT pk_FavouritePages PRIMARY KEY (MemID, PageID)
);


CREATE TABLE SongComments (
SongCommentID NUMBER(6),
SongID NUMBER(6),
MemID NUMBER(6),
SongComment VARCHAR2(200),
CONSTRAINT pk_SongComments PRIMARY KEY (SongCommentID),
CONSTRAINT fk_SongComments_Members FOREIGN KEY (MemID) REFERENCES Members(MemID),
CONSTRAINT fk_SongComments_Songs FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);

CREATE TABLE Events (
EventID NUMBER(6),
MemID NUMBER(6),
EventLocation VARCHAR(200),
EventCity VARCHAR(30),
CONSTRAINT pk_Events PRIMARY KEY (EventID),
CONSTRAINT fk_Events_MemID FOREIGN KEY (MemID) REFERENCES Members(MemID)
);

CREATE TABLE SongsAtEvent (
SongID NUMBER(6),
EventID NUMBER(6),
CONSTRAINT pk_SongsAtEvent PRIMARY KEY (SongID, EventID),
CONSTRAINT fk_SongsAtEvent_Songs FOREIGN KEY (SongID) REFERENCES Songs(SongID),
CONSTRAINT fk_SongsAtEvent_Events FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

CREATE TABLE EventMembers (
MemID NUMBER(6),
EventID NUMBER(6),
CONSTRAINT pk_EventMembers PRIMARY KEY (MemID, EventID),
CONSTRAINT fk_EventMembers_Members FOREIGN KEY (MemID) REFERENCES Members(MemID),
CONSTRAINT fk_EventMembers_Events FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

--CREATE TABLE Merchandise (
--ItemID NUMBER(6),
--ItemPrice NUMBER(5,2) DEFAULT 0 CHECK( ItemPrice >= 0),
--ItemDescription VARCHAR2(200),








