package models

type Content struct {
	ID          int `gorm:"primary_key"`
	Title       string
	Description string
	Template    string
	Action      Action
	ActionID    int
}
