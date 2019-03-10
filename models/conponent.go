package models

type Component struct {
	ID        int
	Type      int
	Text      string
	Imageurl  string
	Style     Style
	StyleID   int
	Action    Action
	ActionID  int
	Content   Content
	ContentID int
}
