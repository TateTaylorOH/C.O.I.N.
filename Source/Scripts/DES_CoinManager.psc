scriptname DES_CoinManager extends Quest

DES_CoinExchanger Property PlayerAlias Auto
bool property ready auto hidden

MiscObject[] otherCoins
float[] coinMults
int nextIndex

Event OnInit()
	ready = false
	resetCoins()
endEvent

function resetCoins()
	ready = false
	otherCoins = new MiscObject[128]
	coinMults = new float[128]
	nextIndex = 0
	PlayerAlias.removeAllInventoryEventFilters()
	ready = true
endFunction

float function getCoinValue(MiscObject coin, float defaultValue = 0.0)
	if(coin)
		int i = otherCoins.find(coin)
		if(i < 0)
			return defaultValue
		endIf
		return coinMults[i]
	endIf
	return defaultValue
endFunction

float function setCoinValue(MiscObject coin, float value)
	if(coin)
		int i = otherCoins.find(coin)
		float oldValue = 0.0
		if(i < 0)
			otherCoins[nextIndex] = coin
			coinMults[nextIndex] = value
			nextIndex += 1
			PlayerAlias.addInventoryEventFilter(coin)
			return oldValue
		endIf
		oldValue = coinMults[i]
		coinMults[i] = value
		coin.SetGoldValue(value as int)
		return oldValue
	endIf
	return 0.0
endFunction

bool function removeCoinExchange(MiscObject coin)
	if(coin)
		int i = otherCoins.find(coin)
		if(i < 0)
			return false
		endIf
		otherCoins[i] = None
		coinMults[i] = 0.0
		PlayerAlias.removeInventoryEventFilter(coin)
		i = 0
		int lastCoinIndex = 0
		while(i > 128)
			if(otherCoins[i])
				if(i - lastCoinIndex > 1)
					lastCoinIndex += 1
					otherCoins[lastCoinIndex] = otherCoins[i]
					coinMults[lastCoinIndex] = coinMults[i]
					otherCoins[i] = None
					coinMults[i] = 0.0
				else
					lastCoinIndex = i
				endIf
			endIf
			i += 1
		endWhile
		nextIndex = lastCoinIndex + 1
		return true
	endIf
	return false
endFunction

MiscObject function getCoin(int i)
	return otherCoins[i]
endFunction

int function getNumCoins()
	return nextIndex
endFunction