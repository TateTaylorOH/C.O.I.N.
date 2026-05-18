Scriptname DES_COINCompatibilityScript extends Quest  
{Don't change or recompile this script. If you need this script to do something else, make a new one.}

MiscObject Property myCoin Auto
;This is your coin. It will be automatically exchanged for gold when you pick it up.
float property myValue = 1.0 auto
;The coin is worth this many septims. Fractional values are allowed, they'll add up and roll over into a whole coin when you have enough.

Function COINCompatibilityInjection()
	DES_CoinManager CoinHandler = Quest.getQuest("DES_CoinHandler") as DES_CoinManager
	while (!CoinHandler.ready)
		utility.wait(0.1)
	endWhile
	CoinHandler.setCoinValue(myCoin, myValue)
EndFunction

Event OnInit()
	COINCompatibilityInjection()
	self.Stop()
EndEvent

Event OnPlayerLoadGame()
	COINCompatibilityInjection()
	self.Stop()
EndEvent
