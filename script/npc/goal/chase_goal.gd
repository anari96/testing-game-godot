extends Goal

func validity():
	if get_parent().get_parent().target != null:
		return true

func priority():
	return 2
