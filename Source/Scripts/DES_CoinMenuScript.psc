Scriptname DES_CoinMenuScript extends SKI_ConfigBase

DES_CoinManager Property CoinData Auto

MiscObject Property DES_Auri Auto
float AuriValue
float defaultAuriValue = 0.6

MiscObject Property DES_DrakrDragon Auto
MiscObject Property DES_DrakrMoth Auto
MiscObject Property DES_DrakrOwl Auto
MiscObject Property DES_DrakrWhale Auto
float DrakrValue
float defaultDrakrValue = 0.15

MiscObject Property DES_Harald Auto
float HaraldValue
float defaultHaraldValue = 0.2

MiscObject Property DES_Mede Auto
float MedeValue
float defaultMedeValue = 0.8

MiscObject Property DES_Nchuark Auto
float NchuarkValue
float defaultNchuarkValue = 0.2

MiscObject Property DES_Sancar Auto
float SancarValue
float defaultSancarValue = 1.25

MiscObject Property DES_Ulfric Auto
float UlfricValue
float defaultUlfricValue  = 0.8

bool autoExchangeDefault = true
bool verboseDefault = false

Form[] coinForms
string[] coinNames
float[] coinValues
int currentIndex
int coinsMaxIndex
string[] coinStates

float maxCoinValue

Event OnConfigInit()
	initializeMCM()
	initializeSettingDefaults()
	initializeNewCoins()
endEvent

function initializeMCM()
	ModName = "C.O.I.N."
	Pages = new string[2]
	Pages[0] = "$COIN_LABEL_SETTINGS"
	Pages[1] = "$COIN_LABEL_VALUES"
	coinsMaxIndex = -1
endFunction

function initializeSettingDefaults()
	autoExchangeDefault = true
	verboseDefault = false
	CoinData.PlayerAlias.autoExchange = autoExchangeDefault
	CoinData.PlayerAlias.verbose = verboseDefault
	maxCoinValue = 1.5
endFunction

function initializeNewCoins()
	AuriValue    = defaultAuriValue
	DrakrValue   = defaultDrakrValue
	HaraldValue  = defaultHaraldValue
	MedeValue    = defaultMedeValue
	NchuarkValue = defaultNchuarkValue
	SancarValue  = defaultSancarValue
	UlfricValue  = defaultUlfricValue
	while (!CoinData.ready)
		utility.wait(0.1)
	endWhile
	CoinData.setCoinValue(DES_Auri,        AuriValue)
	CoinData.setCoinValue(DES_DrakrDragon, DrakrValue)
	CoinData.setCoinValue(DES_DrakrMoth,   DrakrValue)
	CoinData.setCoinValue(DES_DrakrOwl,    DrakrValue)
	CoinData.setCoinValue(DES_DrakrWhale,  DrakrValue)
	CoinData.setCoinValue(DES_Harald,      HaraldValue)
	CoinData.setCoinValue(DES_Mede,        MedeValue)
	CoinData.setCoinValue(DES_Nchuark,     NchuarkValue)
	CoinData.setCoinValue(DES_Sancar,      SancarValue)
	CoinData.setCoinValue(DES_Ulfric,      UlfricValue)
	coinStates = new String[7]
	coinStates[0] = "Auri"
	coinStates[1] = "Drakr"
	coinStates[2] = "Harald"
	coinStates[3] = "Mede"
	coinStates[4] = "Nchuark"
	coinStates[5] = "Sancar"
	coinStates[6] = "Ulfric"
endFunction

function buildSettingsPage()
	setCursorFillMode(TOP_TO_BOTTOM)
	bool autoExchange = CoinData.PlayerAlias.autoExchange
	bool verbose = CoinData.PlayerAlias.verbose
	int verboseFlags = OPTION_FLAG_DISABLED * ((!autoExchange) as int)
	AddToggleOptionST("toggleAutoExchange", "$COIN_LABEL_AUTOEXCHANGE", autoExchange)
	AddToggleOptionST("toggleVerboseExchange", "$COIN_LABEL_VERBOSE", verbose, verboseFlags)
endFunction

int function addCoinsListEntry(MiscObject coin, float value = -1.0, string name = "")
	if(name == "")
		name = coin.getName()
	endIf
	if(value < 0.0)
		value = CoinData.getCoinValue(coin)
	endIf
	coinForms[currentIndex] = coin
	coinNames[currentIndex] = name
	coinValues[currentIndex] = value
	currentIndex += 1
	return currentIndex
endFunction

int function buildCoinsList()
	int numDefaultCoins = 7
	int numDrakrAlts = 3 ; 4 drakrs share one entry
	currentIndex = 0
	int numCoins = CoinData.getNumCoins() - numDrakrAlts
	coinForms = Utility.createFormArray(numCoins)
	coinNames = Utility.createStringArray(numCoins)
	coinValues = Utility.createFloatArray(numCoins)
	addCoinsListEntry(DES_Auri, AuriValue)
	addCoinsListEntry(None, DrakrValue, DES_DrakrDragon.getName())
	addCoinsListEntry(DES_Harald, HaraldValue)
	addCoinsListEntry(DES_Mede, MedeValue)
	addCoinsListEntry(DES_Nchuark, NchuarkValue)
	addCoinsListEntry(DES_Sancar, SancarValue)
	addCoinsListEntry(DES_Ulfric, UlfricValue)
	int i = 0
	while(i < coinsMaxIndex && currentIndex < numCoins)
		MiscObject coin = CoinData.getCoin(i)
		string coinName = coin.getName()
		if(coinNames.find(coinName) < 0)
			addCoinsListEntry(coin, name = coinName)
		endIf
		i += 1
	endWhile
	return CoinData.getNumCoins()
endFunction

function buildCoinsPage()
	int numDefaultCoins = 7
	if(CoinData.getNumCoins() > coinsMaxIndex) ; rebuild coin arrays if they're out of date
		coinsMaxIndex = buildCoinsList()
	endIf
	setCursorFillMode(TOP_TO_BOTTOM)
	int i = 0
	int numCoins = coinNames.length
	while(i < numCoins)
		if(i < numDefaultCoins)
			AddSliderOptionST(coinStates[i], coinNames[i], coinValues[i], "$COIN_FORMAT_VALUE")
		else; non default coins are handled by index instead of name
			AddSliderOption(coinNames[i], coinValues[i], "$COIN_FORMAT_VALUE")
		endIf
		i += 1
	endWhile
endFunction

Event OnPageReset(string page)
	if(page == Pages[0])
		buildSettingsPage()
	elseif(page == Pages[1])
		buildCoinsPage()
	endIf
endEvent

Event OnConfigClose()
	int i = 0
	int n = coinForms.length
	while(i < n)
		Form f = coinForms[i]
		MiscObject coin = f as MiscObject
		float value = coinValues[i]
		if(coin)
			CoinData.setCoinValue(coin, value)
		elseif(!f)
			CoinData.setCoinValue(DES_DrakrDragon, value)
			CoinData.setCoinValue(DES_DrakrMoth, value)
			CoinData.setCoinValue(DES_DrakrOwl, value)
			CoinData.setCoinValue(DES_DrakrWhale, value)
		endIf
		i += 1
	endWhile
endEvent

state toggleAutoExchange
	Event OnHighlightST()
		setInfoText("$COIN_INFO_AUTOEXCHANGE")
	endEvent
	Event OnDefaultST()
		CoinData.PlayerAlias.autoExchange = autoExchangeDefault
		SetToggleOptionValueST(autoExchangeDefault, true)
		int verboseFlags = OPTION_FLAG_DISABLED * ((!autoExchangeDefault) as int)
		SetOptionFlagsST(verboseFlags, false, "toggleVerboseExchange")
	endEvent
	Event OnSelectST()
		bool autoExchange = !CoinData.PlayerAlias.autoExchange
		CoinData.PlayerAlias.autoExchange = autoExchange
		SetToggleOptionValueST(autoExchange, true)
		int verboseFlags = OPTION_FLAG_DISABLED * ((!autoExchange) as int)
		SetOptionFlagsST(verboseFlags, false, "toggleVerboseExchange")
	endEvent
endState

state toggleVerboseExchange
	Event OnHighlightST()
		setInfoText("$COIN_INFO_VERBOSE")
	endEvent
	Event OnDefaultST()
		CoinData.PlayerAlias.verbose = verboseDefault
		SetToggleOptionValueST(verboseDefault)
	endEvent
	Event OnSelectST()
		bool verbose = !CoinData.PlayerAlias.verbose
		CoinData.PlayerAlias.verbose = verbose
		SetToggleOptionValueST(verbose)
	endEvent
endState

state Auri
	Event OnHighlightST()
		;setInfoText(AuriInfoText)
	endEvent
	Event OnDefaultST()
		AuriValue = defaultAuriValue
	endEvent
	Event OnSliderOpenST()
		SetSliderDialogStartValue(AuriValue)
		SetSliderDialogDefaultValue(AuriValue)
		SetSliderDialogRange(0.0, maxCoinValue)
		SetSliderDialogInterval(0.05)
	endEvent
	Event OnSliderAcceptST(float value)
		AuriValue = value
		coinValues[0] = value
		SetSliderOptionValueST(value, "$COIN_FORMAT_VALUE")
	endEvent
endState

state Drakr
	Event OnHighlightST()
		;setInfoText(DrakrInfoText)
	endEvent
	Event OnDefaultST()
		DrakrValue = defaultDrakrValue
	endEvent
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DrakrValue)
		SetSliderDialogDefaultValue(DrakrValue)
		SetSliderDialogRange(0.0, maxCoinValue)
		SetSliderDialogInterval(0.05)
	endEvent
	Event OnSliderAcceptST(float value)
		DrakrValue = value
		coinValues[1] = value
		SetSliderOptionValueST(value, "$COIN_FORMAT_VALUE")
	endEvent
endState

state Harald
	Event OnHighlightST()
		;setInfoText(HaraldInfoText)
	endEvent
	Event OnDefaultST()
		HaraldValue = defaultHaraldValue
	endEvent
	Event OnSliderOpenST()
		SetSliderDialogStartValue(HaraldValue)
		SetSliderDialogDefaultValue(HaraldValue)
		SetSliderDialogRange(0.0, maxCoinValue)
		SetSliderDialogInterval(0.05)
	endEvent
	Event OnSliderAcceptST(float value)
		HaraldValue = value
		coinValues[2] = value
		SetSliderOptionValueST(value, "$COIN_FORMAT_VALUE")
	endEvent
endState

state Mede
	Event OnHighlightST()
		;setInfoText(MedeInfoText)
	endEvent
	Event OnDefaultST()
		MedeValue = defaultMedeValue
	endEvent
	Event OnSliderOpenST()
		SetSliderDialogStartValue(MedeValue)
		SetSliderDialogDefaultValue(MedeValue)
		SetSliderDialogRange(0.0, maxCoinValue)
		SetSliderDialogInterval(0.05)
	endEvent
	Event OnSliderAcceptST(float value)
		MedeValue = value
		coinValues[3] = value
		SetSliderOptionValueST(value, "$COIN_FORMAT_VALUE")
	endEvent
endState

state Nchuark
	Event OnHighlightST()
		;setInfoText(NchuarkInfoText)
	endEvent
	Event OnDefaultST()
		NchuarkValue = defaultNchuarkValue
	endEvent
	Event OnSliderOpenST()
		SetSliderDialogStartValue(NchuarkValue)
		SetSliderDialogDefaultValue(NchuarkValue)
		SetSliderDialogRange(0.0, maxCoinValue)
		SetSliderDialogInterval(0.05)
	endEvent
	Event OnSliderAcceptST(float value)
		NchuarkValue = value
		coinValues[4] = value
		SetSliderOptionValueST(value, "$COIN_FORMAT_VALUE")
	endEvent
endState

state Sancar
	Event OnHighlightST()
		;setInfoText(SancarInfoText)
	endEvent
	Event OnDefaultST()
		SancarValue = defaultSancarValue
	endEvent
	Event OnSliderOpenST()
		SetSliderDialogStartValue(SancarValue)
		SetSliderDialogDefaultValue(SancarValue)
		SetSliderDialogRange(0.0, maxCoinValue)
		SetSliderDialogInterval(0.05)
	endEvent
	Event OnSliderAcceptST(float value)
		SancarValue = value
		coinValues[5] = value
		SetSliderOptionValueST(value, "$COIN_FORMAT_VALUE")
	endEvent
endState

state Ulfric
	Event OnHighlightST()
		;setInfoText(UlfricInfoText)
	endEvent
	Event OnDefaultST()
		UlfricValue = defaultUlfricValue
	endEvent
	Event OnSliderOpenST()
		SetSliderDialogStartValue(UlfricValue)
		SetSliderDialogDefaultValue(UlfricValue)
		SetSliderDialogRange(0.0, maxCoinValue)
		SetSliderDialogInterval(0.05)
	endEvent
	Event OnSliderAcceptST(float value)
		UlfricValue = value
		coinValues[6] = value
		SetSliderOptionValueST(value, "$COIN_FORMAT_VALUE")
	endEvent
endState

Event OnOptionSliderOpen(int option)
	int index = option/2
	float value = coinValues[index]
	SetSliderDialogStartValue(value)
	SetSliderDialogDefaultValue(value)
	SetSliderDialogRange(0.0, maxCoinValue)
	SetSliderDialogInterval(0.05)
endEvent

Event OnOptionSliderAccept(int option, float value)
	int index = option/2
	coinValues[index] = value
	SetSliderOptionValue(option, value, "$COIN_FORMAT_VALUE")
endEvent

state TemplateStateCloneMe
	Event onHighlightST() ; text, toggles, sliders, menus, colors, keymaps, inputs
	endEvent
	Event onDefaultST() ; text, toggles, sliders, menus, colors, keymaps, inputs
	endEvent
	Event onSelectST() ; text, toggles
	endEvent
	Event onSliderOpenST() ; sliders
	endEvent
	Event onSliderAcceptST(float value) ; sliders
	endEvent
	Event onMenuOpenST() ; menus
	endEvent
	Event onMenuAcceptST(int index) ; menus
	endEvent
	Event onColorOpenST() ; colors
	endEvent
	Event onColorAcceptST(int color) ; colors
	endEvent
	Event onKeyMapChangeST(int keyCode, string conflictControl, string conflictName) ; keymaps
	endEvent
	Event onInputOpenST() ; inputs
	endEvent
	Event onInputAcceptST(string value) ; inputs
	endEvent
endState