!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #IdiomTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #IdiomTest
	instanceVariableNames: 'customerBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!IdiomTest methodsFor: 'testing' stamp: 'FH 4/12/2018 20:54:30'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	
	self verifyDurationOf: [ customerBook addCustomerNamed: 'John Lennon' ] isUnderMiliseconds: 50.
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'FH 4/12/2018 20:58:07'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| paulMcCartney |
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	
	self verifyDurationOf:  [
		customerBook removeCustomerNamed: paulMcCartney. ]
		isUnderMiliseconds:  100
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'FH 4/12/2018 21:23:23'!
test03CanNotAddACustomerWithEmptyName 

	self verifyThisFails: [ 
		customerBook addCustomerNamed: ''.]
	withError: Error
	andCheck: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!IdiomTest methodsFor: 'testing' stamp: 'FH 4/12/2018 21:23:31'!
test04CanNotRemoveAnInvalidCustomer
	
	| johnLennon |
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
		
	self verifyThisFails:  [
		 customerBook removeCustomerNamed: 'Paul McCartney']
	withError: NotFound
	andCheck: [ :anError | 
		self assert: customerBook numberOfCustomers = 1.
		self assert: (customerBook includesCustomerNamed: johnLennon) ]
		
! !


!IdiomTest methodsFor: 'private' stamp: 'FH 4/12/2018 20:54:13'!
setUp

	customerBook := CustomerBook  new.! !

!IdiomTest methodsFor: 'private' stamp: 'FH 4/12/2018 20:56:04'!
verifyDurationOf: actionToMeasure isUnderMiliseconds: upperBound 

	| millisecondsBeforeRunning millisecondsAfterRunning |
	millisecondsBeforeRunning := Time millisecondClockValue.
	actionToMeasure value.
	millisecondsAfterRunning := Time millisecondClockValue.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < upperBound! !

!IdiomTest methodsFor: 'private' stamp: 'FH 4/12/2018 21:22:53'!
verifyThisFails: aFailingBlock withError: anError andCheck: aValidationBlock
	
	
	[aFailingBlock value. self fail.]
		on: anError 
		do: aValidationBlock.! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(customers includes: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 4/14/2017 16:55:43'!
removeCustomerNamed: aName
 
	customers remove: aName ifAbsent: [ NotFound signal ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
