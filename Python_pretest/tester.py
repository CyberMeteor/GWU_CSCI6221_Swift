from songs import *

# 创建Song实例
song1 = Song(name="Rolling in the Deep", path="Music_Library\Karaoke_Vocals\Adele - Rolling in the Deep (Explicit)-vocals-C minor-105bpm-440hz.mp3", authors=["Author1"], year=2020, genre="Pop")
song2 = Song(name="Song 2", path="path/to/song2.mp3", authors=["Author2"], year=2021, genre="Rock")

# 创建Playlist实例并添加歌曲
playlist = Playlist(name="My Favorite Playlist")
playlist.add_song(song1)
playlist.add_song(song2)

# 显示播放列表中的歌曲名称
playlist.display_songs()

# 播放播放列表
playlist.play()

song1.lyric_path = "Music_Library\Lrc\Adele_rolling_in_the_deep_english_only.lrc"
song1.display_lyrics()