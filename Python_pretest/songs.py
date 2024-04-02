class Song:
    def __init__(self, name, path="", authors=None, lyric_path="", karaoke_path="", year=0000, genre="Unknown", played_times=0, album="Unknown", rating=0):
        self.name = name  # 新添加的歌曲名称属性
        self.path = path
        self.authors = authors if authors is not None else []
        self.lyric_path = lyric_path
        self.karaoke_path = karaoke_path
        self.year = year
        self.genre = genre
        self.played_times = played_times
        self.album = album
        self.rating = rating

    def get_song_name(self):
        """返回歌曲的名称"""
        return self.name

    def display_info(self):
        print(f"Name: {self.name}")  # 显示歌曲名称
        print(f"Song Path: {self.path}")
        print(f"Authors: {', '.join(self.authors)}")
        print(f"Lyric Path: {self.lyric_path}")
        print(f"Karaoke Path: {self.karaoke_path}")
        print(f"Year: {self.year}")
        print(f"Genre: {self.genre}")
        print(f"Played Times: {self.played_times}")
        print(f"Album: {self.album}")
        print(f"Rating: {self.rating}")

    def play_song(self):
        self.played_times += 1
        print(f"Playing {self.name}...")



class Playlist:
    def __init__(self, name, songs=[]):
        self.name = name
        self.songs = songs  # 初始化时可以包含一组歌曲

    def add_song(self, song):
        self.songs.append(song)

    def remove_song(self, song):
        self.songs.remove(song)

    def display_songs(self):
        print(f"Playlist: {self.name}")
        for song in self.songs:
            print(song.get_song_name())
            

    def play(self):
        print(f"Playing Playlist: {self.name}")
        for song in self.songs:
            song.play_song()

    def generate_playlist_by_genre(self, genre):
        filtered_songs = [song for song in self.songs if song.genre == genre]
        return Playlist(f"{self.name} - {genre}", filtered_songs)


    def generate_playlist_by_year(self, year):
        filtered_songs = [song for song in self.songs if song.year == year]
        return Playlist(f"{self.name} - {year}", filtered_songs)


    def generate_playlist_by_attribute(self, attribute, value):
        filtered_songs = [song for song in self.songs if getattr(song, attribute, None) == value]
        return Playlist(f"{self.name} - {value}", filtered_songs)
