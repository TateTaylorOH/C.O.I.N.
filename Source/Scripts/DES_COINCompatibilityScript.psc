Scriptname DES_COINCompatibilityScript extends Quest  

;-- Propeties ---------------------------------------

MiscObject Property myCoin  Auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

Function COINCompatibilityInjection()
;Debug.Notification("COINCompatibilityInjection has fired!")
FormList DES_NonGoldCoins = Game.GetForm(0x1DE5002) As FormList
	DES_NonGoldCoins.AddForm(myCoin)
	;Debug.Notification("myCoin has been added to the formlist!")
EndFunction

Event OnInit()
	;Debug.Notification("OnInit has fired!")
	COINCompatibilityInjection()
	self.Stop()
EndEvent

Event OnPlayerLoadGame()
	;Debug.Notification("OnPlayerLoadGame has fired!")
	COINCompatibilityInjection()
	self.Stop()
EndEvent