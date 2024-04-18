extends VBoxContainer
class_name Chat

const MAX_ENTRIES := 100 # TODO: Configurable

const _META_LOG_ENTRY = "logentry"

const _CHAT_TYPE_COLORS = {
	"0": Color.WHITE, # Say
	"1": Color.PURPLE, # Shout
	"2": Color.CRIMSON, # Tell
	"3": Color.DARK_CYAN, # System
	"4": Color.AQUAMARINE, # Party
	"5": Color.PURPLE, # ShoutAll, not sure about this one
	"6": Color.LIGHT_GREEN, # Group
	"7": Color.LIME_GREEN, # Clan
	"8": Color.AQUAMARINE, # Entryboard TODO
	"9": Color.DARK_CYAN, # ManagementGuideC TODO
	"10": Color.DARK_CYAN, # ManagementGuideN TODO
	"11": Color.DARK_CYAN, # ManagementAlertC TODO
	"12": Color.DARK_CYAN, # ManagementAlertN TODO
	"13": Color.DARK_GREEN, # ClanNotice TODO
}

var _rpc_client := RpcClient.new()

var _last_request_iso_date: String = ""

func _ready():
	_on_Chat_visibility_changed()
	$ChatLogPanel/ChatLogScrollContainer.scroll_vertical = 99999

#GD4 migration - get_system_time_msecs() is no more in GD4
#https://forum.godotengine.org/t/why-was-getting-milliseconds-system-time-removed-in-godot-4-0/6381
func get_system_time_msecs():
	var unix_time: float = Time.get_unix_time_from_system()
	var unix_time_int: int = int(unix_time)
	var ms: int = int((unix_time - unix_time_int) * 1000.0)
	return ms


func _on_RPCTimer_timeout():
	$RPCTimer.paused = true
	var is_at_bottom = $ChatLogPanel/ChatLogScrollContainer.get_v_scroll_bar().value+$ChatLogPanel/ChatLogScrollContainer.get_v_scroll_bar().page == $ChatLogPanel/ChatLogScrollContainer.get_v_scroll_bar().max_value
	var iso_date := _last_request_iso_date
	_last_request_iso_date = str(Time.get_datetime_string_from_system(true),".",get_system_time_msecs(),"Z") # UTC date
	#GD4 migration - get_chat() is a coroutine, so it must be called with "await"
	var chatlog := await _rpc_client.get_chat(iso_date)
	if chatlog.size() > 0:
		print(chatlog.size(), " new chat messages")
		for logentry in chatlog:
			if _is_duplicate_msg(logentry):
				printerr("Duplicate message: ",logentry)
			else:
				var datetime_dict := Time.get_datetime_dict_from_datetime_string(logentry["DateTime"], false)
				var label := Label.new()
				label.autowrap = true
				label.text = "[%02d:%02d] %s %s: %s" % [datetime_dict["hour"], datetime_dict["minute"], logentry["FirstName"], logentry["LastName"], logentry["ChatMessage"]["Message"]]
				label.set_meta(_META_LOG_ENTRY, logentry)
				var message_type := String(logentry["ChatMessage"]["Type"])
				if _CHAT_TYPE_COLORS.has(message_type):
					label.modulate = _CHAT_TYPE_COLORS.get(message_type)
				$ChatLogPanel/ChatLogScrollContainer/ChatLogVBoxContainer.add_child(label)
				print("\t(Type ", logentry["ChatMessage"]["Type"], ") ", label.text)
	while $ChatLogPanel/ChatLogScrollContainer/ChatLogVBoxContainer.get_child_count() > MAX_ENTRIES:
		$ChatLogPanel/ChatLogScrollContainer/ChatLogVBoxContainer.remove_child($ChatLogPanel/ChatLogScrollContainer/ChatLogVBoxContainer.get_child(0))
	$RPCTimer.paused = false
	
	if is_at_bottom:
		$ChatLogPanel/ChatLogScrollContainer.scroll_vertical = 99999
		

func _on_MessageLineEdit_text_entered(message: String):
	$ChatBox/MessageLineEdit.editable = false
	var chat_message_log_entry := {
		# DateTime not used
		# TODO: CharacterId
		"FirstName": "DDOn",
		"LastName": "Tools",
		"ChatMessage": {
			"Type": $ChatBox/MsgTypeOptionButton.get_item_id($ChatBox/MsgTypeOptionButton.selected),
			"Message": message,
			"Deliver": true
		}
	}
	_rpc_client.post_chat(chat_message_log_entry)
	$ChatBox/MessageLineEdit.clear()
	$ChatBox/MessageLineEdit.editable = true
	_on_RPCTimer_timeout()

func _on_Chat_visibility_changed():
	if visible:
		_on_RPCTimer_timeout()
		$RPCTimer.start()
	else:
		$RPCTimer.stop()

# Inefficient af but i didnt find a better way
func _is_duplicate_msg(new_msg: Dictionary) -> bool:
	if $ChatLogPanel/ChatLogScrollContainer/ChatLogVBoxContainer.get_child_count() > 0:
		for msg_idx in range($ChatLogPanel/ChatLogScrollContainer/ChatLogVBoxContainer.get_child_count()-1, -1, -1): # Check in reverse
			var msg: Dictionary = $ChatLogPanel/ChatLogScrollContainer/ChatLogVBoxContainer.get_child(msg_idx).get_meta(_META_LOG_ENTRY)
			if new_msg["CharacterId"] == msg["CharacterId"] and new_msg["FirstName"] == msg["FirstName"] and new_msg["LastName"] == msg["LastName"] and new_msg["DateTime"] == msg["DateTime"] and new_msg["ChatMessage"]["Type"] == msg["ChatMessage"]["Type"] and new_msg["ChatMessage"]["Message"] == msg["ChatMessage"]["Message"] and new_msg["ChatMessage"]["Deliver"] == msg["ChatMessage"]["Deliver"]:
				return true
	return false
