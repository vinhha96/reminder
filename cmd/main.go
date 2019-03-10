package main

import (
	"fmt"
	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mysql"
)

func main() {
	db, err := gorm.Open("mysql", "arun:password@(35.185.111.106:3306)/reminderdb?charset=utf8&parseTime=True&loc=Local")
	if err != nil {
		mes, _ := fmt.Printf("[MySQL] Connect DB error with: %s", err.Error())
		panic(mes)
	}
	fmt.Println("[MySQL] Connect DB successfully")
	db.HasTable()
	defer db.Close()
}
