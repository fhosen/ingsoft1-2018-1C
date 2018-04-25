!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'GR 4/24/2018 16:53:23'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #Base category: #'Stack-Exercise'!
Object subclass: #Base
	instanceVariableNames: 'value next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Base methodsFor: 'information' stamp: 'GR 4/24/2018 16:41:59'!
size
	^0! !


!Base methodsFor: 'modificators' stamp: 'GR 4/24/2018 16:55:02'!
popOf: aStack
	^self error: OOStack stackEmptyErrorDescription ! !


!Base methodsFor: 'accesors' stamp: 'GR 4/24/2018 16:55:29'!
value
	^self error: OOStack stackEmptyErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Base class' category: #'Stack-Exercise'!
Base class
	instanceVariableNames: ''!

!Base class methodsFor: 'as yet unclassified' stamp: 'GR 4/24/2018 16:39:12'!
new
	^self basicNew ! !


!classDefinition: #Element category: #'Stack-Exercise'!
Object subclass: #Element
	instanceVariableNames: 'value next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Element methodsFor: 'information' stamp: 'GR 4/24/2018 16:37:59'!
size
	^1 + next size! !

!Element methodsFor: 'information' stamp: 'GR 4/23/2018 21:55:02'!
value
	^value! !


!Element methodsFor: 'modifications' stamp: 'GR 4/23/2018 21:41:22'!
createWithValue: aValue after: nextElement
	value := aValue.
	next := nextElement.! !

!Element methodsFor: 'modifications' stamp: 'GR 4/24/2018 16:44:44'!
popOf: aStack
	aStack first: self next.
	^self value! !


!Element methodsFor: 'accesor' stamp: 'GR 4/23/2018 21:46:06'!
next
	^next! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Element class' category: #'Stack-Exercise'!
Element class
	instanceVariableNames: ''!

!Element class methodsFor: 'as yet unclassified' stamp: 'GR 4/23/2018 21:47:16'!
createWithValue: aValue after: nextElement
	^self new createWithValue: aValue after: nextElement! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'first'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'modifications' stamp: 'GR 4/24/2018 16:41:14'!
first: anElement
	first := anElement.! !

!OOStack methodsFor: 'modifications' stamp: 'GR 4/24/2018 16:38:58'!
initialize
	first:= Base new.! !

!OOStack methodsFor: 'modifications' stamp: 'GR 4/24/2018 16:39:55'!
pop
	^first popOf: self! !

!OOStack methodsFor: 'modifications' stamp: 'GR 4/24/2018 16:43:34'!
push: aSomething
	| newElem |
	newElem := Element createWithValue: aSomething after: first.
	first := newElem.! !


!OOStack methodsFor: 'information' stamp: 'GR 4/24/2018 16:42:55'!
isEmpty
	^self size = 0.! !

!OOStack methodsFor: 'information' stamp: 'GR 4/24/2018 16:37:41'!
size
	^first size! !

!OOStack methodsFor: 'information' stamp: 'GR 4/23/2018 21:56:21'!
top
	^first value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!OOStack class methodsFor: 'as yet unclassified' stamp: 'GR 4/23/2018 21:38:46'!
new
	^self basicNew initialize! !
