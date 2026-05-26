Scriptname DES_FormListInjector extends Quest
{copies local formlists into injected ones on quest startup}

Formlist[] Property LocalLists Auto
Formlist[] Property InjectedLists Auto

Event OnInit()
	int i = 0
	int numLocal = LocalLists.length
	int numInjected = InjectedLists.length
	while(i < numLocal && i < numInjected)
		FormList localList = LocalLists[i]
		FormList injectedList = InjectedLists[i]
		int j = 0
		int numForms = localList.getSize()
		while(j < numForms)
			Form f = localList.getAt(j)
			if(!injectedList.hasForm(f))
				injectedList.addForm(f)
			endIf
			j += 1
		endWhile
		i += 1
	endWhile
endEvent