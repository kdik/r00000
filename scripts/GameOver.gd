extends Spatial

func _ready():
    $Static.visible = true
    yield(get_tree().create_timer(1.5), "timeout")
    $Static.visible = false
    var text
    match Global.ending:
        Global.CAUGHT:
            #text = "YOU WERE KILLED BY\nSOMETHING WICKED"
            $VideoPlayer3.visible = true
            $VideoPlayer3.play()
        Global.ROOTS:
            $VideoPlayer4.visible = true
            $VideoPlayer4.play()
            #text = "YOU WERE KILLED BY\nTHE ROOTS IN YOUR HEAD"
        Global.BECOME_EVIL:
            #text = "YOU HAVE BECOME\nTHE EVIL PRESENCE BEYOND THE DOOR"
            $VideoPlayer1.visible = true
            $VideoPlayer1.play()
    #yield($Subtitles.show_subtitles(text, 5), "completed")
    #$Subtitles.visible = false


func _on_ending_video_finished():
    $Static.visible = true
    yield(get_tree(), "idle_frame")
    get_tree().change_scene("res://scenes/Menu.tscn")
