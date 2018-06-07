!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'aCart aMarket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'testing' stamp: 'FH 6/5/2018 19:18:19'!
test01ANewCartIsCreatedEmpty
	self assert: aCart empty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'FH 6/7/2018 00:00:52'!
test02ACartWithProductsIsNotEmpty
	aMarket  add: #LOTR.
	aCart add: #LOTR withAmount: 1.
	self deny: aCart empty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'FH 6/7/2018 00:05:24'!
test03ACartHasABookAfterAddingIt
	aMarket add: #LOTR.
	aCart add: #LOTR withAmount: 1. 
	self assert: (aCart  hasBook: #LOTR).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'FH 6/7/2018 00:06:04'!
test04ACartDoesntHaveABookIfNotAdded
	aMarket add: #ElViejoYElMar.
	aCart add: #ElViejoYElMar withAmount: 1.
	self deny:  (aCart  hasBook: #LOTR).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'FH 6/7/2018 00:09:55'!
test05ACartCantAddABookNotOwnByTheMarket
	aMarket add: #MartinFierro.
	self
		should: [ aCart add: #LOTR withAmount: 2 ]
		raise: Error
		withExceptionDo: [ :anError |
			self
				assert: Cart bookNotAvailable
				equals: anError messageText.
		].! !

!TusLibrosTest methodsFor: 'testing' stamp: 'FH 6/7/2018 00:14:28'!
test06ACartHasTheExactQuantityOfABookWhenAdded
	aMarket add: #LOTR.
	aCart
		add: #LOTR
		withAmount: 2.
	self
		assert: (aCart quantityOf: #LOTR)
		equals: 2.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'FH 6/7/2018 00:15:15'!
test07ACartWithNoBooksHasNoQuantityOfAnyBook
	aMarket add: #LOTR1.
	aMarket add: #LOTR2.
	aMarket add: #LOTR3.

	self
		assert: (aCart quantityOf: #LOTR1)
		equals: 0.
	self
		assert: (aCart quantityOf: #LOTR2)
		equals: 0.
	self
		assert: (aCart quantityOf: #LOTR3)
		equals: 0.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'FH 6/7/2018 00:15:38'!
test08ACartWithABookHasNoQuantityOfOtherBook
	aMarket add: #LOTR1.
	aMarket add: #LOTR2.
	aMarket add: #LOTR3.
	
	aCart
		add: #LOTR1
		withAmount: 2.
	self
		assert: (aCart quantityOf: #LOTR1)
		equals: 2.
	self
		assert: (aCart quantityOf: #LOTR2)
		equals: 0.
	self
		assert: (aCart quantityOf: #LOTR3)
		equals: 0.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'FH 6/5/2018 19:41:12'!
test09AnEmptyCartHasNoContent
	self assert: aCart content isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'FH 6/7/2018 00:16:15'!
test10ACartWithManyBooksHasCorrectContent
	
	aMarket add: #LOTR1.
	aMarket add: #LOTR2.
	aMarket add: #LOTR3.

	aCart
		add: #LOTR1
		withAmount: 1.
	aCart
		add: #LOTR2
		withAmount: 2.
	aCart
		add: #LOTR3
		withAmount: 3.
	self assert: aCart content size equals: 3.
	self assert: [ aCart content includes: #LOTR1 -> 1 ].
	self assert: [ aCart content includes: #LOTR2 -> 2 ].
	self assert: [ aCart content includes: #LOTR3 -> 3 ].! !


!TusLibrosTest methodsFor: 'initialization' stamp: 'FH 6/6/2018 23:57:18'!
setUp
	aMarket _ Market new.
	aCart _ Cart newWith: aMarket.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'books market'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'FH 6/5/2018 19:04:17'!
empty
	^ books isEmpty ! !

!Cart methodsFor: 'testing' stamp: 'FH 6/6/2018 23:33:19'!
hasBook: aBook 
	^ books includes: aBook.! !


!Cart methodsFor: 'adding' stamp: 'FH 6/7/2018 00:13:47'!
add: aBook withAmount: quantity
	(market has: aBook)  ifFalse: [	^ self error: self class bookNotAvailable .].
	books add: aBook withOccurrences: quantity.! !


!Cart methodsFor: 'initialization' stamp: 'FH 6/7/2018 00:01:52'!
initializeWith: aMarket
	books _ Bag new.
	market _ aMarket.! !


!Cart methodsFor: 'accessing' stamp: 'FH 6/6/2018 23:45:11'!
content
	^ books sortedElements ! !

!Cart methodsFor: 'accessing' stamp: 'FH 6/6/2018 23:39:00'!
quantityOf: aBook
	^ books occurrencesOf: aBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'class initialization' stamp: 'FH 6/6/2018 23:58:18'!
newWith: aMarket
	^ super new initializeWith: aMarket.! !


!Cart class methodsFor: 'error' stamp: 'FH 6/7/2018 00:11:31'!
bookNotAvailable
	^ 'The book is not available in the Market'! !


!classDefinition: #Market category: #TusLibros!
Object subclass: #Market
	instanceVariableNames: 'availableBooks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Market methodsFor: 'initialization' stamp: 'FH 6/6/2018 23:53:04'!
initialize
	availableBooks _ Set new.! !


!Market methodsFor: 'testing' stamp: 'FH 6/7/2018 00:04:38'!
has: aBook
	^ availableBooks includes: aBook! !


!Market methodsFor: 'adding' stamp: 'FH 6/6/2018 23:54:05'!
add: aBook
	availableBooks add: aBook ! !
