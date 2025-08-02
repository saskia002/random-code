#Requires AutoHotkey v2.0
#SingleInstance Force
Persistent
;SetBatchLines -1

global isCoffeeHot := 0
global TrayMenu := A_TrayMenu

BuildTrayMenu()

BuildTrayMenu() {
	TrayMenu.Delete()
	TrayMenu.Add("Enable", StartCoffee)
	TrayMenu.Add("Disable", StopCoffee)
	TrayMenu.Add("")
	TrayMenu.Add("Exit", ExitAppCallback)
	TrayMenu.ClickCallback := TrayCallback

	UpdateTrayItems()
}

TrayCallback(ItemName, ItemPos, Menu) {
	UpdateTrayItems()
}

UpdateTrayItems() {
	if isCoffeeHot {
		TrayMenu.Enable("Disable")
		TrayMenu.Disable("Enable")
	} else {
		TrayMenu.Enable("Enable")
		TrayMenu.Disable("Disable")
	}
}

StartCoffee(*) {
	isCoffeeHot := 1
	UpdateTrayItems()
	loop {
		if !isCoffeeHot {
			break
		}
		Send "{F22}"
		Sleep 30000
	}
}

StopCoffee(*) {
	isCoffeeHot := 0
	UpdateTrayItems()
}

ExitAppCallback(*) {
	ExitApp
}
