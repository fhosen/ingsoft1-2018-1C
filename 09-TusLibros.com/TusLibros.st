!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'aCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'testing' stamp: 'FH 6/5/2018 19:18:19'!
test01ANewCartIsCreatedEmpty
	self assert: aCart empty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'FH 6/5/2018 19:18:55'!
test02ACartWithProductsIsNotEmpty
	aCart add: #LOTR withAmount: 1.
	self deny: aCart empty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'FH 6/5/2018 19:18:59'!
test03ACartHasABookAfterAddingIt
	aCart add: #LOTR withAmount: 1. 
	self assert: (aCart  hasBook: #LOTR).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'FH 6/5/2018 19:19:05'!
test04ACartDoesntHaveABookIfNotAdded
	aCart add: #ElViejoYElMar withAmount: 1.
	self deny:  (aCart  hasBook: #LOTR).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'FH 6/5/2018 19:42:49'!
test05ACartDoesntHaveABookWhenAddedWithZeroQuantity
	aCart add: #LOTR withAmount: 0.
	self deny:  (aCart  hasBook: #LOTR).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'FH 6/5/2018 19:40:02'!
test06ACartHasTheExactQuantityOfABookWhenAdded
	aCart
		add: #LOTR
		withAmount: 2.
	self
		assert: (aCart quantityOf: #LOTR)
		equals: 2.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'FH 6/5/2018 19:40:34'!
test07ACartWithNoBooksHasNoQuantityOfAnyBook
	self
		assert: (aCart quantityOf: #LOTR1)
		equals: 0.
	self
		assert: (aCart quantityOf: #LOTR2)
		equals: 0.
	self
		assert: (aCart quantityOf: #LOTR3)
		equals: 0.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'FH 6/5/2018 19:40:55'!
test08ACartWithABookHasNoQuantityOfOtherBook
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

!TusLibrosTest methodsFor: 'testing' stamp: 'FH 6/5/2018 19:48:18'!
test10ACartWithManyBooksHasCorrectContent
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


!TusLibrosTest methodsFor: 'initialization' stamp: 'FH 6/5/2018 19:18:43'!
setUp
	aCart _ Cart new.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'FH 6/5/2018 19:04:17'!
empty
	^ books isEmpty ! !

!Cart methodsFor: 'testing' stamp: 'FH 6/5/2018 19:07:14'!
hasBook: aSymbol 
	^ books includesKey: aSymbol .! !


!Cart methodsFor: 'adding' stamp: 'FH 6/5/2018 19:44:48'!
add: aBook withAmount: anAmount 
	anAmount  = 0 ifFalse: [
		books at: aBook put: anAmount.
	]! !


!Cart methodsFor: 'initialization' stamp: 'FH 6/5/2018 19:04:05'!
initialize
	books _ Dictionary new.! !


!Cart methodsFor: 'accessing' stamp: 'FH 6/5/2018 19:34:43'!
content
	^ books associations ! !

!Cart methodsFor: 'accessing' stamp: 'FH 6/5/2018 19:13:59'!
quantityOf: aBook
	^ books at: aBook ifAbsent: [^ 0].! !
