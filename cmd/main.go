package main

import (
	"fmt"
	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	"github.com/vinhha96/reminder/models"
	"gopkg.in/gin-gonic/gin.v1/json"
)

func main() {
	db, err := gorm.Open("mysql", "arun:password@(34.73.45.126:3306)/reminderdb?charset=utf8&parseTime=True&loc=Local")
	if err != nil {
		mes, _ := fmt.Printf("[MySQL] Connect DB error with: %s", err.Error())
		panic(mes)
	}
	fmt.Println("[MySQL] Connect DB successfully")
	db.LogMode(true)

	// Declare var for once object
	var reminder []models.Reminder

	// Check exist table inDB
	fmt.Println("Exist table contents: ", db.HasTable(&models.Content{}))
	fmt.Println("Exist table Reminder: ", db.HasTable(&models.Reminder{}))

	db.Set("gorm:auto_preload", true).Find(&reminder)

	// Convert to Json object
	res3, _ := json.Marshal(reminder)

	// Write result
	fmt.Println(string(res3))

	defer db.Close()
}
