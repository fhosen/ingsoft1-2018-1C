!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #RESTInterfaceTest category: #TusLibros!
TestCase subclass: #RESTInterfaceTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RESTInterfaceTest methodsFor: 'support' stamp: 'FH 6/17/2018 18:55:46'!
createDefaultInterface
	^ RESTInterface allowing: self validUsers withItemsFrom: self defaultCatalog! !

!RESTInterfaceTest methodsFor: 'support' stamp: 'FH 6/17/2018 18:47:40'!
defaultCatalog
	^ testObjectsFactory defaultCatalog ! !

!RESTInterfaceTest methodsFor: 'support' stamp: 'FH 6/17/2018 20:04:32'!
getAnotherValidBook
	^ testObjectsFactory anotherItemSellByTheStore.! !

!RESTInterfaceTest methodsFor: 'support' stamp: 'FH 6/18/2018 13:55:36'!
getCreditCardNumber
	^ '0000222244446666'! !

!RESTInterfaceTest methodsFor: 'support' stamp: 'FH 6/18/2018 13:55:59'!
getCreditCardOwner
	^ 'A credit card valid owner'! !

!RESTInterfaceTest methodsFor: 'support' stamp: 'FH 6/17/2018 19:54:43'!
getInvalidBook
	^ testObjectsFactory itemNotSellByTheStore .! !

!RESTInterfaceTest methodsFor: 'support' stamp: 'FH 6/17/2018 19:45:10'!
getInvalidCartID
	^ -1! !

!RESTInterfaceTest methodsFor: 'support' stamp: 'FH 6/17/2018 19:29:46'!
getInvalidPassword
	^ 'Contraseña No Valida'! !

!RESTInterfaceTest methodsFor: 'support' stamp: 'FH 6/17/2018 19:25:14'!
getInvalidUser
	^ 'Usuario Invalido'! !

!RESTInterfaceTest methodsFor: 'support' stamp: 'FH 6/18/2018 13:56:42'!
getNotExpiredMonth
	^ testObjectsFactory notExpiredMonth! !

!RESTInterfaceTest methodsFor: 'support' stamp: 'FH 6/17/2018 19:35:52'!
getValidBook
	^ testObjectsFactory itemSellByTheStore.! !

!RESTInterfaceTest methodsFor: 'support' stamp: 'FH 6/17/2018 18:42:30'!
getValidPassword
	^ 'Contraseña de Usuario Valido'! !

!RESTInterfaceTest methodsFor: 'support' stamp: 'FH 6/17/2018 18:42:06'!
getValidUser
	^ 'Usuario Valido'! !

!RESTInterfaceTest methodsFor: 'support' stamp: 'FH 6/17/2018 19:18:58'!
validUsers
	| validUsers |
	validUsers  _ Dictionary new.
	validUsers at: self getValidUser put: self getValidPassword.
	^ validUsers ! !


!RESTInterfaceTest methodsFor: 'initialization' stamp: 'FH 6/17/2018 18:48:40'!
setUp
	testObjectsFactory _ StoreTestObjectsFactory new.! !


!RESTInterfaceTest methodsFor: 'tests' stamp: 'FH 6/17/2018 19:03:23'!
test01CanCreateCartWithProperUserAndPassword
	| interface |
	
	interface _ self createDefaultInterface.
	self shouldnt: [interface createCartForUser: self getValidUser andPassword: self getValidPassword] raise: Error.
	! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'FH 6/17/2018 19:26:33'!
test02CanNotCreateCartWithInvalidUser
	| interface |
	
	interface _ self createDefaultInterface.
	self
		should: [interface createCartForUser: self getInvalidUser andPassword: self getValidPassword]
		raise: Error
		withExceptionDo: [ :anError  | self assert: anError  messageText equals: interface class invalidUserOrPasswordErrorMessage ].
	! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'FH 6/17/2018 19:29:57'!
test03CanNotCreateCartWithInvalidPassword
	| interface |
	
	interface _ self createDefaultInterface.
	self
		should: [interface createCartForUser: self getValidUser andPassword: self getInvalidPassword]
		raise: Error
		withExceptionDo: [ :anError  | self assert: anError  messageText equals: interface class invalidUserOrPasswordErrorMessage ].
	! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'FH 6/17/2018 19:44:00'!
test04CanAddProductsToACreatedCart
	| interface cartID |
	
	interface _ self createDefaultInterface.
	cartID  _ interface createCartForUser: self getValidUser andPassword: self getValidPassword .
	self
		shouldnt: [ interface add: self getValidBook withQuantity: 1 toCartWithID: cartID ]
		raise: Error! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'FH 6/17/2018 19:46:42'!
test05CanNotAddProductsToAInvalidCart
	| interface cartID |
	
	interface _ self createDefaultInterface.
	cartID  _ self getInvalidCartID.
	self
		should: [ interface add: self getValidBook withQuantity: 1 toCartWithID: cartID ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: interface class invalidCartIDErrorMessage ].! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'FH 6/17/2018 19:56:33'!
test06CanNotAddProductIfNotInCatalog
	| interface cartID |
	
	interface _ self createDefaultInterface.
	cartID  _ interface createCartForUser: self getValidUser andPassword: self getValidPassword .
	self
		should: [ interface add: self getInvalidBook withQuantity: 1 toCartWithID: cartID ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: interface class itemNotInCatalogErrorMessage ].! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'FH 6/17/2018 20:12:56'!
test07ItemListOfEmptyIsEmpty
	| interface cartID |
	
	interface _ self createDefaultInterface.
	cartID  _ interface createCartForUser: self getValidUser andPassword: self getValidPassword .
	
	self assert: (interface itemListOfCartWithID: cartID ) isEmpty .! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'FH 6/17/2018 20:10:33'!
test08ItemListOfCartHasTheRightContent
	| interface cartID content |
	
	interface _ self createDefaultInterface.
	cartID  _ interface createCartForUser: self getValidUser andPassword: self getValidPassword .
	interface add: self getValidBook withQuantity: 2  toCartWithID: cartID .
	interface add: self getAnotherValidBook withQuantity: 5  toCartWithID: cartID .
	content _ interface itemListOfCartWithID: cartID .

	self assert: (content occurrencesOf: self getValidBook ) = 2.
	self assert: (content occurrencesOf: self getAnotherValidBook ) = 5.! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'FH 6/18/2018 13:48:48'!
test09CanNotGetItemListOfInvalidCart
	| interface  |
	
	interface _ self createDefaultInterface.	
	self
		should: [ interface itemListOfCartWithID: self getInvalidCartID  ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: interface class invalidCartIDErrorMessage ].
	
	
	! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'FH 6/18/2018 14:15:24'!
test10CanNotCheckOutEmptyCart
	| interface  cartID |
	
	interface _ self createDefaultInterface.
	cartID _ interface createCartForUser: self getValidUser andPassword: self getValidPassword .
	
	self
		should: [ interface
							checkOutCart: cartID 
							withCardNumber: self getCreditCardNumber
							withOwner: self getCreditCardOwner
							andExpiration:  self getNotExpiredMonth
							]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: interface class canNotCheckOutEmptyCartErrorMessage ].
	
	
	! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'FH 6/18/2018 14:17:39'!
test11CanCheckoutACartWithOneItem
	| interface  cartID |
	
	interface _ self createDefaultInterface.
	cartID _ interface createCartForUser: self getValidUser andPassword: self getValidPassword .
	interface  add: self getValidBook withQuantity: 1 toCartWithID: cartID .
	
	self
		shouldnt: [ interface
							checkOutCart: cartID 
							withCardNumber: self getCreditCardNumber
							withOwner: self getCreditCardOwner
							andExpiration:  self getNotExpiredMonth
							]
		raise: Error! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'FH 6/18/2018 14:19:53'!
test12CanNotCheckoutAnInvalidCart
	| interface  |
	
	interface _ self createDefaultInterface.
	
	self
		should: [ interface
							checkOutCart: self getInvalidCartID 
							withCardNumber: self getCreditCardNumber
							withOwner: self getCreditCardOwner
							andExpiration:  self getNotExpiredMonth
							]
		raise: Error
		withExceptionDo: [ :anError  | self assert: anError messageText equals: interface class invalidCartIDErrorMessage ].! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'FH 6/17/2018 19:57:51'!
invalidItemErrorMessage
	
	^ self class invalidItemErrorMessage! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
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


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'content' stamp: 'FH 6/17/2018 20:17:08'!
content
	| itemList |
	itemList _ Bag  new.
	itemList  addAll: items.
	^ itemList .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'FH 6/17/2018 19:58:36'!
invalidItemErrorMessage
	'Item is not in catalog'! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #RESTInterface category: #TusLibros!
Object subclass: #RESTInterface
	instanceVariableNames: 'validUsers catalog carts lastGeneratedID merchantProcessor salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RESTInterface methodsFor: 'initialization' stamp: 'FH 6/17/2018 19:19:36'!
initializeAllowing: someValidUsers withItemsFrom: aCatalog
	validUsers _ someValidUsers.
	catalog  _ aCatalog .
	lastGeneratedID  _ 1.
	carts _ Dictionary new.! !


!RESTInterface methodsFor: 'errors' stamp: 'FH 6/17/2018 19:42:24'!
invalidCartIDError
	^ self error: self class invalidCartIDErrorMessage.! !

!RESTInterface methodsFor: 'errors' stamp: 'FH 6/17/2018 19:13:36'!
invalidUserOrPasswordError
	^ self error: self class invalidUserOrPasswordErrorMessage.! !


!RESTInterface methodsFor: 'cartCreation' stamp: 'FH 6/17/2018 19:02:30'!
createCartForUser: anUser andPassword: aPassword 

	|cartID|
	
	(self isValid: anUser withPassword: aPassword ) ifFalse: [ self invalidUserOrPasswordError ].
	
	cartID _ self getNewCartID.
	carts at: cartID  put: (Cart acceptingItemsOf: catalog).
	
	^ cartID .! !

!RESTInterface methodsFor: 'cartCreation' stamp: 'FH 6/17/2018 19:16:20'!
getNewCartID
	lastGeneratedID _ lastGeneratedID + 1.
	^ lastGeneratedID! !

!RESTInterface methodsFor: 'cartCreation' stamp: 'FH 6/17/2018 19:12:51'!
isValid: anUser withPassword: aPassword

	validUsers
		at: anUser
		ifPresent: [ :pass | ^ aPassword = pass]
		ifAbsent: [^ false].! !


!RESTInterface methodsFor: 'item adding' stamp: 'FH 6/17/2018 19:41:41'!
add: anItem withQuantity: aQuantity toCartWithID: cartID
	carts
			at: cartID
			ifPresent: [ :cart | cart add: aQuantity of: anItem ]
			ifAbsent: [ self invalidCartIDError]! !


!RESTInterface methodsFor: 'content' stamp: 'FH 6/17/2018 20:28:14'!
itemListOfCartWithID: cartID
	carts
		at: cartID 
		ifPresent: [ : aCart  | ^ aCart content ]
		ifAbsent: [self invalidCartIDError ]! !


!RESTInterface methodsFor: 'check out' stamp: 'FH 6/18/2018 14:15:49'!
checkOutCart: cartID withCardNumber: aCreditCardNumber withOwner: anOwner andExpiration:  aMonth

	| cart |
	
	cart _ carts  at: cartID ifAbsent: [self invalidCartIDError ].
	
	Cashier 
		toCheckout: cart 
		charging: (CreditCard expiringOn: aMonth ) 
		throught: merchantProcessor 
		on: DateAndTime today
		registeringOn: salesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RESTInterface class' category: #TusLibros!
RESTInterface class
	instanceVariableNames: ''!

!RESTInterface class methodsFor: 'class initialization' stamp: 'FH 6/17/2018 18:51:55'!
allowing: validUsers withItemsFrom:  aCatalog
	^ self new initializeAllowing: validUsers withItemsFrom: aCatalog! !


!RESTInterface class methodsFor: 'errorMessages' stamp: 'FH 6/18/2018 14:12:42'!
canNotCheckOutEmptyCartErrorMessage
	^ Cashier cartCanNotBeEmptyErrorMessage! !

!RESTInterface class methodsFor: 'errorMessages' stamp: 'FH 6/17/2018 19:42:57'!
invalidCartIDErrorMessage
	^ 'El carrito con el ID propuesto no existe'! !

!RESTInterface class methodsFor: 'errorMessages' stamp: 'FH 6/17/2018 19:14:16'!
invalidUserOrPasswordErrorMessage
	^ 'El usuario y/o la contraseña son incorrectas'! !

!RESTInterface class methodsFor: 'errorMessages' stamp: 'FH 6/17/2018 19:56:54'!
itemNotInCatalogErrorMessage
	^ Cart ! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'FH 6/17/2018 20:05:44'!
anotherItemSellByTheStore
	
	^ 'Otro libro valido'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'FH 6/17/2018 20:06:02'!
anotherItemSellByTheStorePrice
	
	^ 20! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'FH 6/17/2018 20:06:28'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice ;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'FH 6/18/2018 13:59:07'!
notExpiredCreditCard
	
	^CreditCard expiringOn: self notExpiredMonth ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'FH 6/18/2018 13:58:09'!
notExpiredMonth
	^ Month month: today monthIndex year: today yearNumber + 10! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
