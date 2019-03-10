package models

import "time"

type Reminder struct {
	ID        int
	CreateAt  time.Time
	UpdateAt  time.Time
	DeleteAt  time.Time
	Type      int
	Priority  int
	Due       time.Time
	Content   Content
	ContentID int
}
