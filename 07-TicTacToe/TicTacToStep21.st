!classDefinition: #TicTacToeTest category: #TicTacToStep21!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 18:18:36'!
test01NewGameIsEmpty
	| game |
	game _ TicTacToe new.
	self assert: game Xs isEmpty.
	self assert: game Os isEmpty.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 20:52:10'!
test02XPlaysAndItsPositionIsRecorded
	| game |
	game _ TicTacToe new.
	game MarkWithXAt: 1 @ 1.
	self
		assert: 1
		equals: game Xs size.
	self assert: (game Xs includes: 1 @ 1).
	self assert: game Os isEmpty.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 20:55:44'!
test03XPlaysAndItsPositionIsRecordedOPlaysAndItsPositionIsRecorded
	| game |
	game _ TicTacToe new.
	game MarkWithXAt: 1 @ 1.
	game MarkWithYAt: 2 @ 2.
	self
		assert: 1
		equals: game Xs size.
	self assert: (game Xs includes: 1 @ 1).
	self
		assert: 1
		equals: game Os size.
	self assert: (game Os includes: 2 @ 2).! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 20:52:10'!
test04XCantPlayTwiceInARow
	| game |
	game _ TicTacToe new.
	game MarkWithXAt: 1 @ 1.
	self
		should: [ game MarkWithXAt: 2 @ 2 ]
		raise: Error
		withExceptionDo: [ :anError |
			self
				assert: TicTacToeState notXTurnErrorMessage
				equals: anError messageText.
			self
				assert: 1
				equals: game Xs size.
			self assert: (game Xs includes: 1 @ 1).
			self assert: game Os isEmpty ].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 20:55:44'!
test05AfterXPlaysOCantPlayTwiceInARow
	| game |
	game _ TicTacToe new.
	game MarkWithXAt: 1 @ 1.
	game MarkWithYAt: 2 @ 2.
	self
		should: [ game MarkWithYAt: 3 @ 3 ]
		raise: Error
		withExceptionDo: [ :anError |
			self
				assert: TicTacToeState notOTurnErrorMessage
				equals: anError messageText.
			self
				assert: 1
				equals: game Xs size.
			self assert: (game Xs includes: 1 @ 1).
			self
				assert: 1
				equals: game Os size.
			self assert: (game Os includes: 2 @ 2) ].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 20:55:44'!
test06CantPlayInAPositionTakenByHim
	| game |
	game _ TicTacToe new.
	game MarkWithXAt: 1 @ 1.
	game MarkWithYAt: 2 @ 2.
	self
		should: [ game MarkWithXAt: 1 @ 1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe positionTakenErrorMessage
				equals: anError messageText.
			self
				assert: 1
				equals: game Xs size.
			self assert: (game Xs includes: 1 @ 1).
			self
				assert: 1
				equals: game Os size.
			self assert: (game Os includes: 2 @ 2) ].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 20:55:44'!
test07CantPlayInAPositionTakenByOther
	| game |
	game _ TicTacToe new.
	game MarkWithXAt: 1 @ 1.
	game MarkWithYAt: 2 @ 2.
	self
		should: [ game MarkWithXAt: 2 @ 2 ]
		raise: Error
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe positionTakenErrorMessage
				equals: anError messageText.
			self
				assert: 1
				equals: game Xs size.
			self assert: (game Xs includes: 1 @ 1).
			self
				assert: 1
				equals: game Os size.
			self assert: (game Os includes: 2 @ 2) ].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 20:55:44'!
test10NeitherCanWinInTwoTurns
	| game |
	game _ TicTacToe new.
	game MarkWithXAt: 1 @ 1.
	game MarkWithYAt: 2 @ 1.
	game MarkWithXAt: 2 @ 2.
	game MarkWithYAt: 3 @ 3.
	self deny: game OHasWon.
	self deny: game XHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 20:55:44'!
test11XWinsWithFirstRow
	| game |
	game _ TicTacToe new.
	game MarkWithXAt: 1 @ 1.
	game MarkWithYAt: 2 @ 1.
	game MarkWithXAt: 1 @ 2.
	game MarkWithYAt: 3 @ 3.
	game MarkWithXAt: 1 @ 3.
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 20:55:44'!
test12XWinsWithSecondColumn
	| game |
	game _ TicTacToe new.
	game MarkWithXAt: 2 @ 1.
	game MarkWithYAt: 1 @ 1.
	game MarkWithXAt: 2 @ 2.
	game MarkWithYAt: 3 @ 1.
	game MarkWithXAt: 2 @ 3.
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 20:55:44'!
test13XWinsWithThirdColumn
	| game |
	game _ TicTacToe new.
	game MarkWithXAt: 3 @ 1.
	game MarkWithYAt: 1 @ 1.
	game MarkWithXAt: 3 @ 2.
	game MarkWithYAt: 2 @ 1.
	game MarkWithXAt: 3 @ 3.
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 20:55:44'!
test14XWinsWithFirstColumn
	| game |
	game _ TicTacToe new.
	game MarkWithXAt: 1 @ 1.
	game MarkWithYAt: 2 @ 2.
	game MarkWithXAt: 2 @ 1.
	game MarkWithYAt: 3 @ 3.
	game MarkWithXAt: 3 @ 1.
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 20:55:44'!
test15XWinsWIthDiagonal
	| game |
	game _ TicTacToe new.
	game MarkWithXAt: 1 @ 1.
	game MarkWithYAt: 2 @ 1.
	game MarkWithXAt: 2 @ 2.
	game MarkWithYAt: 2 @ 3.
	game MarkWithXAt: 3 @ 3.
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 20:55:44'!
test16XWinsWithAntiDiagonal
	| game |
	game _ TicTacToe new.
	game MarkWithXAt: 3 @ 1.
	game MarkWithYAt: 2 @ 1.
	game MarkWithXAt: 2 @ 2.
	game MarkWithYAt: 1 @ 2.
	game MarkWithXAt: 1 @ 3.
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 20:55:44'!
test17OWinsWithFirstRow
	| game |
	game _ TicTacToe new.
	game MarkWithXAt: 3 @ 1.
	game MarkWithYAt: 1 @ 1.
	game MarkWithXAt: 2 @ 2.
	game MarkWithYAt: 1 @ 2.
	game MarkWithXAt: 3 @ 3.
	game MarkWithYAt: 1 @ 3.
	self assert: game OHasWon.
	self deny: game XHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 20:55:44'!
test18OCantPlayAfterXWon
	| game |
	game _ TicTacToe new.
	game MarkWithXAt: 1 @ 1.
	game MarkWithYAt: 2 @ 1.
	game MarkWithXAt: 1 @ 2.
	game MarkWithYAt: 3 @ 1.
	game MarkWithXAt: 1 @ 3.
	self
		should: [ game MarkWithYAt: 3 @ 1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self
				assert: TicTacToeState canNotPlayWhenGameIsOverErrorMessage
				equals: anError messageText.
			self
				assert: 2
				equals: game Os size.
			self assert: (game Os includes: 2 @ 1).
			self assert: (game Os includes: 3 @ 1) ].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 20:55:44'!
test19XCantPlayAfterOWon
	| game |
	game _ TicTacToe new.
	game MarkWithXAt: 2 @ 2.
	game MarkWithYAt: 1 @ 1.
	game MarkWithXAt: 2 @ 1.
	game MarkWithYAt: 1 @ 2.
	game MarkWithXAt: 3 @ 1.
	game MarkWithYAt: 1 @ 3.
	self
		should: [ game MarkWithXAt: 3 @ 2 ]
		raise: Error
		withExceptionDo: [ :anError |
			self
				assert: TicTacToeState canNotPlayWhenGameIsOverErrorMessage
				equals: anError messageText.
			self
				assert: 3
				equals: game Xs size.
			self assert: (game Xs includes: 2 @ 2).
			self assert: (game Xs includes: 2 @ 1).
			self assert: (game Xs includes: 3 @ 1) ].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 20:55:44'!
test20GameOverWhenIsATie
	| game |
	game _ TicTacToe new.
	game MarkWithXAt: 2 @ 2.
	game MarkWithYAt: 1 @ 1.
	game MarkWithXAt: 1 @ 3.
	game MarkWithYAt: 3 @ 1.
	game MarkWithXAt: 2 @ 1.
	game MarkWithYAt: 2 @ 3.
	game MarkWithXAt: 1 @ 2.
	game MarkWithYAt: 3 @ 2.
	game MarkWithXAt: 3 @ 3.
	self assert: game isOver.
	self deny: game XHasWon.
	self deny: game OHasWon.
	self assert: game isTied.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 20:55:44'!
test21AWonGameIsNotATie
	| game |
	game _ TicTacToe new.
	game MarkWithXAt: 2 @ 2.
	game MarkWithYAt: 1 @ 2.
	game MarkWithXAt: 1 @ 1.
	game MarkWithYAt: 2 @ 1.
	game MarkWithXAt: 1 @ 3.
	game MarkWithYAt: 2 @ 3.
	game MarkWithXAt: 3 @ 2.
	game MarkWithYAt: 3 @ 1.
	game MarkWithXAt: 3 @ 3.
	self assert: game isOver.
	self assert: game XHasWon.
	self deny: game OHasWon.
	self deny: game isTied.! !


!classDefinition: #TicTacToe category: #TicTacToStep21!
Object subclass: #TicTacToe
	instanceVariableNames: 'os xs state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 21:58:15'!
MarkWithXAt: aPosition
	state playX: aPosition.
	state _ state nextState ! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 21:58:27'!
MarkWithYAt: aPosition
	state playO: aPosition.
	state _ state nextState ! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 19:44:38'!
OHasWon
	
	^ state OHasWon! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 10:01:34'!
Os

	^os copy.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 19:56:42'!
XHasWon
	
	^ state XHasWon ! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 10:01:25'!
Xs

	^xs copy.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 21:52:47'!
addPositionToO: aPosition

	(self isPositionTaken: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
	os add: aPosition.
	! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 21:45:23'!
addPositionToX: aPosition
	(self isPositionTaken: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
	xs add: aPosition.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 22:00:05'!
goToOTurn	
	^ state _ TicTacToeOTurn newWith: self.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 22:00:10'!
goToTie
	
	^ state _ TicTacToeTied newWith: self.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 22:00:15'!
goToWonO
	
	^ state _ TicTacToeOWon newWith: self.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 22:00:18'!
goToWonX
	
	^ state _ TicTacToeXWon newWith: self.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 22:00:26'!
goToXTurn	
	^ state _ TicTacToeXTurn newWith: self.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 12:51:23'!
hasCompletedColumn: positions
	
	^ (1 to: 3) anySatisfy: [ :y | (positions count: [ :position | position y = y ]) = 3 ]! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 12:36:01'!
hasCompletedRow: positions

	^ (1 to: 3) anySatisfy: [ :x | (positions count: [ :posicion | posicion x = x ]) = 3 ]! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 12:56:21'!
hasDownDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@n ]
! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 13:02:13'!
hasUpDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@(4-n) ]! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 13:01:53'!
hasWin: positions

	^(self hasCompletedRow: positions)
		or: [(self hasCompletedColumn: positions) 
				or: [(self hasDownDiagonal: positions)
					or: [(self hasUpDiagonal: positions)]]]


! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 21:27:12'!
hasWinO
	^ self hasWin: os! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 21:26:57'!
hasWinX
	^ self hasWin: xs! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 21:50:03'!
initialize
	
	xs:= Set new.
	os:= Set new.
	
	state _ TicTacToeXTurn newWith: self.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 19:39:49'!
isOver
	^ state isOver! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 18:33:24'!
isPositionTaken: aPosition
	^ (xs includes: aPosition) or: [os includes: aPosition].! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 15:06:57'!
isTied
	
	^xs size = 5 and: [ os size = 4 and: [ self XHasWon not ]] " and: [ self YHasWon not ]]]"! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToStep21!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'errors' stamp: 'jg 5/22/2018 11:20:12'!
positionTakenErrorMessage
	
	^'Position taken'! !


!classDefinition: #TicTacToeState category: #TicTacToStep21!
Object subclass: #TicTacToeState
	instanceVariableNames: 'myTicTacToe'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToeState methodsFor: 'initializing' stamp: 'FH 5/28/2018 21:48:35'!
initializeWith: aTicTacToe
	myTicTacToe _ aTicTacToe ! !


!TicTacToeState methodsFor: 'playing' stamp: 'FH 5/28/2018 19:56:15'!
OHasWon
	self subclassResponsibility 
	! !

!TicTacToeState methodsFor: 'playing' stamp: 'FH 5/28/2018 19:56:12'!
XHasWon
	self subclassResponsibility 
	! !

!TicTacToeState methodsFor: 'playing' stamp: 'FH 5/28/2018 19:40:12'!
isOver
	self subclassResponsibility 
	! !

!TicTacToeState methodsFor: 'playing' stamp: 'FH 5/28/2018 19:52:51'!
playO: aPosition
	self subclassResponsibility.! !

!TicTacToeState methodsFor: 'playing' stamp: 'FH 5/28/2018 19:33:25'!
playX: aPosition
	self subclassResponsibility 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeState class' category: #TicTacToStep21!
TicTacToeState class
	instanceVariableNames: ''!

!TicTacToeState class methodsFor: 'errors' stamp: 'FH 5/28/2018 19:35:28'!
canNotPlayWhenGameIsOverErrorMessage
	
	^'Can not play when game is over'! !

!TicTacToeState class methodsFor: 'errors' stamp: 'FH 5/28/2018 20:08:02'!
notOTurnErrorMessage
	^ 'Not O turn'.! !

!TicTacToeState class methodsFor: 'errors' stamp: 'FH 5/28/2018 19:23:46'!
notXTurnErrorMessage

	^'Not X turn'! !


!TicTacToeState class methodsFor: 'initialization' stamp: 'FH 5/28/2018 21:47:49'!
newWith: aTicTacToe
	^ self new initializeWith: aTicTacToe ! !


!classDefinition: #TicTacToeFinalized category: #TicTacToStep21!
TicTacToeState subclass: #TicTacToeFinalized
	instanceVariableNames: 'winner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!


!classDefinition: #TicTacToeOTurn category: #TicTacToStep21!
TicTacToeState subclass: #TicTacToeOTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToeOTurn methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 19:55:59'!
OHasWon
	^ false! !

!TicTacToeOTurn methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 19:55:55'!
XHasWon
	^ false! !

!TicTacToeOTurn methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 19:41:02'!
isOver
	^ false! !

!TicTacToeOTurn methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 22:02:37'!
nextState	
	myTicTacToe hasWinO ifTrue: [ ^ myTicTacToe goToWonO ].
	myTicTacToe  isTied ifTrue: [ ^ myTicTacToe goToTie ].
	^ myTicTacToe goToXTurn.
	! !

!TicTacToeOTurn methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 21:53:41'!
playO:  aPosition 
	^ myTicTacToe addPositionToO: aPosition
	! !

!TicTacToeOTurn methodsFor: 'as yet unclassified' stamp: 'FH 5/28/2018 21:54:16'!
playX:  aPosition 
	self error: self class notXTurnErrorMessage.! !


!classDefinition: #TicTacToeOWon category: #TicTacToStep21!
TicTacToeState subclass: #TicTacToeOWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToeOWon methodsFor: 'playing' stamp: 'FH 5/28/2018 19:53:59'!
OHasWon
	^ true! !

!TicTacToeOWon methodsFor: 'playing' stamp: 'FH 5/28/2018 19:54:14'!
XHasWon
	^ false! !

!TicTacToeOWon methodsFor: 'playing' stamp: 'FH 5/28/2018 19:44:14'!
isOver
	^ true! !

!TicTacToeOWon methodsFor: 'playing' stamp: 'FH 5/28/2018 19:52:51'!
playO: aPosition
	self error: self class canNotPlayWhenGameIsOverErrorMessage.! !

!TicTacToeOWon methodsFor: 'playing' stamp: 'FH 5/28/2018 19:43:02'!
playX: aPosition
	self error: self class canNotPlayWhenGameIsOverErrorMessage! !


!classDefinition: #TicTacToeTied category: #TicTacToStep21!
TicTacToeState subclass: #TicTacToeTied
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToeTied methodsFor: 'playing' stamp: 'FH 5/28/2018 19:59:03'!
OHasWon
	^ false! !

!TicTacToeTied methodsFor: 'playing' stamp: 'FH 5/28/2018 19:58:50'!
XHasWon
	^ false! !

!TicTacToeTied methodsFor: 'playing' stamp: 'FH 5/28/2018 19:58:50'!
isOver
	^ true! !

!TicTacToeTied methodsFor: 'playing' stamp: 'FH 5/28/2018 19:58:50'!
playO: aPosition
	self error: self class canNotPlayWhenGameIsOverErrorMessage.! !

!TicTacToeTied methodsFor: 'playing' stamp: 'FH 5/28/2018 19:58:50'!
playX: aPosition
	self error: self class canNotPlayWhenGameIsOverErrorMessage! !


!classDefinition: #TicTacToeXTurn category: #TicTacToStep21!
TicTacToeState subclass: #TicTacToeXTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToeXTurn methodsFor: 'playing' stamp: 'FH 5/28/2018 19:45:12'!
OHasWon
	^ false! !

!TicTacToeXTurn methodsFor: 'playing' stamp: 'FH 5/28/2018 19:55:42'!
XHasWon
	^ false! !

!TicTacToeXTurn methodsFor: 'playing' stamp: 'FH 5/28/2018 19:40:36'!
isOver
	^ false
! !

!TicTacToeXTurn methodsFor: 'playing' stamp: 'FH 5/28/2018 21:41:57'!
nextState	
	myTicTacToe hasWinX ifTrue: [ ^ myTicTacToe goToWonX ].
	myTicTacToe  isTied ifTrue: [ ^ myTicTacToe goToTie ].
	^ myTicTacToe goToOTurn.
	! !

!TicTacToeXTurn methodsFor: 'playing' stamp: 'FH 5/28/2018 20:07:46'!
playO: aPosition
	self error: self class notOTurnErrorMessage.! !

!TicTacToeXTurn methodsFor: 'playing' stamp: 'FH 5/28/2018 21:45:35'!
playX:  aPosition 
	^ myTicTacToe addPositionToX: aPosition
	! !


!classDefinition: #TicTacToeXWon category: #TicTacToStep21!
TicTacToeState subclass: #TicTacToeXWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToeXWon methodsFor: 'playing' stamp: 'FH 5/28/2018 19:53:40'!
OHasWon
	^ false! !

!TicTacToeXWon methodsFor: 'playing' stamp: 'FH 5/28/2018 19:55:14'!
XHasWon
	^ true! !

!TicTacToeXWon methodsFor: 'playing' stamp: 'FH 5/28/2018 19:44:03'!
isOver
	^ true! !

!TicTacToeXWon methodsFor: 'playing' stamp: 'FH 5/28/2018 19:52:51'!
playO: aPosition
	self error: self class canNotPlayWhenGameIsOverErrorMessage.! !

!TicTacToeXWon methodsFor: 'playing' stamp: 'FH 5/28/2018 19:34:56'!
playX: aPosition
	self error: self class canNotPlayWhenGameIsOverErrorMessage! !
