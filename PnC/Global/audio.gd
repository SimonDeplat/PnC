extends Node

var tracks
var sounds

func play_track(track: String) -> void:
	$TrackPlayer.set_stream(tracks[track])
	if not $TrackPlayer.is_playing():
		$TrackPlayer.set_playing(true)

func play_sound(sound: String) -> void:
	if not sounds[sound]["playing"]:
		sounds[sound]["playing"] = true
		var player = AudioStreamPlayer.new()
		player.set_stream(sounds[sound]["file"])
		player.set_autoplay(true)
		add_child(player)
		await player.finished
		player.queue_free()
		sounds[sound]["playing"] = false
