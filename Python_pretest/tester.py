from songs import *

# 创建Song实例
song1 = Song(name="Song 1", path="path/to/song1.mp3", authors=["Author1"], year=2020, genre="Pop")
song2 = Song(name="Song 2", path="path/to/song2.mp3", authors=["Author2"], year=2021, genre="Rock")

# 创建Playlist实例并添加歌曲
playlist = Playlist(name="My Favorite Playlist")
playlist.add_song(song1)
playlist.add_song(song2)

# 显示播放列表中的歌曲名称
playlist.display_songs()

# 播放播放列表
playlist.play()
