!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'Testing' stamp: 'GR 6/7/2018 20:45:49'!
test01aCashierCantCheckoutAnEmptyCart

	self
		should: [
			self cashier
				checkoutWith: self cart
				payWith: self validCreditCard ]
		raise: Error
		withExceptionDo: [ :anError |
			self
				assert: anError messageText
				equals: self cashier class cantCheckoutEmptyCart ].! !

!CashierTest methodsFor: 'Testing' stamp: 'GR 6/7/2018 20:55:59'!
test02CheckoutACartWith1Product
	| aCart aCatalog |
	aCatalog _ self catalog .
	aCatalog
		at: #LOTR
		put: 6.
	aCart _ Cart acceptingItemsOf: aCatalog .
	aCart add: #LOTR.
	self
		assert:
			((Cashier newWith: aCatalog )
				checkoutWith: aCart
				payWith: self validCreditCard)
		equals: 6.! !

!CashierTest methodsFor: 'Testing' stamp: 'GR 6/7/2018 21:13:28'!
test03CheckoutACartWith1ProductAndInvalidCreditCard
	| aCart aCatalog |
	aCatalog _ self catalog .
	aCatalog
		at: #LOTR
		put: 6.
	aCart _ Cart acceptingItemsOf: aCatalog .
	aCart add: #LOTR.
	
		self
		should: [
			((Cashier newWith: aCatalog )
				checkoutWith: aCart
				payWith: self invalidCreditCard) ]
		raise: Error
		withExceptionDo: [ :anError |
			self
				assert: anError messageText
				equals: self invalidCreditCard class cantUseExpiredCard ].
	
	! !

!CashierTest methodsFor: 'Testing' stamp: 'GR 6/7/2018 21:17:34'!
test04CheckoutACartWith2ProductsAndValidCreditCard
	| aCart aCatalog |
	aCatalog _ self catalog .
	aCatalog
		at: #LOTR
		put: 6.
	aCatalog
		at: #TheClockworkOrange
		put: 8.
	aCart _ Cart acceptingItemsOf: aCatalog .
	aCart add: #LOTR.
	aCart add: #TheClockworkOrange. 	
	self
		assert:
			((Cashier newWith: aCatalog )
				checkoutWith: aCart
				payWith: self validCreditCard)
		equals: 14.
	! !

!CashierTest methodsFor: 'Testing' stamp: 'GR 6/7/2018 21:20:16'!
test05CheckoutACartWith2OfSameProductAndValidCreditCard
	| aCart aCatalog |
	aCatalog _ self catalog .
	aCatalog
		at: #LOTR
		put: 6.
	aCatalog
		at: #TheClockworkOrange
		put: 8.
	aCart _ Cart acceptingItemsOf: aCatalog .
	aCart add: 3 of: #LOTR.

	self
		assert:
			((Cashier newWith: aCatalog )
				checkoutWith: aCart
				payWith: self validCreditCard)
		equals: 18.
	! !

!CashierTest methodsFor: 'Testing' stamp: 'GR 6/7/2018 21:21:26'!
test06CheckoutACartWith2ProductsAndInvalidCreditCard
	| aCart aCatalog |
	aCatalog _ self catalog .
	aCatalog
		at: #LOTR
		put: 6.
	aCatalog
		at: #TheClockworkOrange
		put: 8.
	aCart _ Cart acceptingItemsOf: aCatalog .
	aCart add: #LOTR.
	aCart add: #TheClockworkOrange. 	
		self
		should: [
			((Cashier newWith: aCatalog )
				checkoutWith: aCart
				payWith: self invalidCreditCard) ]
		raise: Error
		withExceptionDo: [ :anError |
			self
				assert: anError messageText
				equals: self invalidCreditCard class cantUseExpiredCard ].! !


!CashierTest methodsFor: 'support' stamp: 'GR 6/7/2018 20:47:36'!
cart
	^ Cart acceptingItemsOf: self catalog.! !

!CashierTest methodsFor: 'support' stamp: 'GR 6/7/2018 20:47:54'!
cashier
	^ Cashier newWith: self catalog.
! !

!CashierTest methodsFor: 'support' stamp: 'GR 6/7/2018 20:41:25'!
catalog
	^ Dictionary new.! !

!CashierTest methodsFor: 'support' stamp: 'GR 6/7/2018 21:11:35'!
invalidCreditCard
	^ CreditCard newWithNumber: 123 expiringOn: Date yesterday ownedBy: #Lalo.! !

!CashierTest methodsFor: 'support' stamp: 'GR 6/7/2018 20:40:43'!
validCreditCard
	^ CreditCard newWithNumber: 123 expiringOn: Date tomorrow ownedBy: #Lalo.! !


!classDefinition: #CreditCardTest category: #TusLibros!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'Testing' stamp: 'GR 6/7/2018 19:20:59'!
test01

	CreditCard  
		newWithNumber: 1234567890123456 
		expiration: Date tomorrow 
		ownedBy: #SeniorEjemplo! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'GR 6/7/2018 20:06:49'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !

!Cart methodsFor: 'testing' stamp: 'GR 6/7/2018 21:18:33'!
items
	
	^items copy! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'modification' stamp: 'GR 6/7/2018 20:34:29'!
assertCardIsValid: aCreditCard 
	aCreditCard isExpired ifTrue: [ self error: aCreditCard class cantUseExpiredCard]! !

!Cashier methodsFor: 'modification' stamp: 'GR 6/7/2018 19:55:08'!
assertCartIsNotEmpty: aCarrito 
	aCarrito isEmpty ifTrue: [ self error: self class cantCheckoutEmptyCart ]! !

!Cashier methodsFor: 'modification' stamp: 'GR 6/7/2018 21:18:17'!
checkoutWith: aCarrito payWith: aCreditCard
	self assertCartIsNotEmpty: aCarrito.
	self assertCardIsValid: aCreditCard.
	^ aCarrito items inject: 0 into:
		[:acum :anItem | acum + (priceList at: anItem)]! !

!Cashier methodsFor: 'modification' stamp: 'GR 6/7/2018 19:32:59'!
updatePriceList: aPriceList
	priceList _ aPriceList ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'initialization' stamp: 'GR 6/7/2018 19:31:02'!
newWith: aPriceList
	^self new updatePriceList: aPriceList ! !


!Cashier class methodsFor: 'error' stamp: 'GR 6/7/2018 19:51:09'!
cantCheckoutEmptyCart
	^'Cant checkout an empty cart'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'number expirationDate owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'GR 6/7/2018 20:31:59'!
initializeWithNumber: aNumber expiringOn: aDate ownedBy: aPerson.
	number _ aNumber.
	expirationDate _ aDate.
	owner _ aPerson.
	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'GR 6/7/2018 21:08:41'!
isExpired
	^ expirationDate < Date today! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'GR 6/7/2018 20:35:59'!
cantUseExpiredCard
	^'Cant use an expired credit card'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'GR 6/7/2018 20:30:54'!
newWithNumber: aNumber expiringOn: aDate ownedBy: aPerson
	^self new initializeWithNumber: aNumber expiringOn: aDate ownedBy: aPerson.! !
