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
	var contents []models.Content
	var styles []models.Style
	var reminder []models.Reminder

	// Check exist table inDB
	fmt.Println("Exist table contents: ", db.HasTable(&models.Content{}))
	fmt.Println("Exist table Reminder: ", db.HasTable(&models.Reminder{}))

	// Get all record for table
	db.Find(&contents)
	db.Find(&styles)
	db.Find(&reminder)

	for i := range reminder {
		db.Model(&reminder[i]).Related(&reminder[i].Content)
		db.Model(&reminder[i].Content).Related(&reminder[i].Content.Action)

	}

	// Convert to Json object
	res, _ := json.Marshal(contents)
	res2, _ := json.Marshal(styles)
	res3, _ := json.Marshal(reminder)

	// Write result
	fmt.Println(string(res))
	fmt.Println()
	fmt.Println(string(res2))
	fmt.Println()
	fmt.Println(string(res3))

	defer db.Close()
}
