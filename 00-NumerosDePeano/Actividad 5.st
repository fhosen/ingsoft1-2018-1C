!classDefinition: #I category: #'Actividad 5'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Actividad 5'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Actividad 5'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'GR 3/26/2018 21:29:02'!
* aNumber 
	^aNumber! !

!I class methodsFor: 'as yet unclassified' stamp: 'GR 3/22/2018 21:06:26'!
+ unNumeroDePeano
	^ unNumeroDePeano next! !

!I class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:24:22'!
- aNumber 
	^ self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 12:38:03'!
/ unNumeroDePeano
	self >= unNumeroDePeano ifTrue: [^ self].
	^ self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor! !

!I class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:13:19'!
< unNumeroDePeano
	^ True! !

!I class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 12:25:48'!
>= unNumeroDePeano
	^ self isEqualTo: unNumeroDePeano! !

!I class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 12:11:51'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor.'! !

!I class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 12:07:18'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'No se soportan numeros negativos'! !

!I class methodsFor: 'as yet unclassified' stamp: 'GR 3/22/2018 20:58:53'!
next
	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'GR 3/22/2018 21:04:29'!
previous
	self error: 'Anda a estudiar matematica, tarado'! !

!I class methodsFor: 'as yet unclassified' stamp: 'GR 3/26/2018 21:17:43'!
siEsUnoDevolve: aValue siNo: anotherValue 
	^aValue value! !

!I class methodsFor: 'as yet unclassified' stamp: 'GR 3/26/2018 21:26:25'!
unNumeroMenosYo: aNumber 
	^aNumber previous! !

!I class methodsFor: 'as yet unclassified' stamp: 'GR 3/26/2018 21:28:46'!
unNumeroMultiplicadoPorMi: aNumber 
	^aNumber! !


!classDefinition: #II category: #'Actividad 5'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Actividad 5'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Actividad 5'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'GR 3/26/2018 21:39:09'!
* aNumber
	^ self previous * (aNumber  + aNumber)! !

!II class methodsFor: 'as yet unclassified' stamp: 'GR 3/22/2018 21:08:44'!
+ unNumeroDePeano
	^self previous +  unNumeroDePeano  next! !

!II class methodsFor: 'as yet unclassified' stamp: 'GR 3/26/2018 21:26:10'!
- unNumero
	^unNumero unNumeroMenosYo: self
	
	"unNumero siEsUnoDevolve: [^self previous] siNo: [^((self previous) - (unNumero previous))]

	(unNumero isEqualTo: I) ifTrue: [
		^ self previous.
		] ifFalse: [
		^(self previous) - (unNumero previous)
		]"! !

!II class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:15:19'!
/ unNumero
	self < unNumero ifTrue: [
		^ self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
		].
	((unNumero * II) - I) >= self ifTrue: [
		^ I
		].
	^ I + ((self - unNumero) / unNumero).! !

!II class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:14:31'!
< unNumeroDePeano
	^ (self >= unNumeroDePeano) not.! !

!II class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 12:34:51'!
>= unNumeroDePeano
	^ (unNumeroDePeano isEqualTo: I) or: [self previous >= unNumeroDePeano previous].! !

!II class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 12:48:16'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un numero mayor.'! !

!II class methodsFor: 'as yet unclassified' stamp: 'GR 3/22/2018 21:17:26'!
next
	next ifNil:
	[
		next:= self cloneNamed:  (self name, 'I').
		next previous: self 		
	].
	^next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'GR 3/22/2018 21:29:51'!
next: aNumber
	next := aNumber! !

!II class methodsFor: 'as yet unclassified' stamp: 'GR 3/22/2018 21:19:41'!
previous
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'GR 3/22/2018 21:20:05'!
previous: aNumber
	previous := aNumber.! !

!II class methodsFor: 'as yet unclassified' stamp: 'GR 3/22/2018 21:48:24'!
removeAllNext
	next ifNotNil: 
	[
		next removeAllNext.
		next removeFromSystem .
		next := nil.
	]! !

!II class methodsFor: 'as yet unclassified' stamp: 'GR 3/26/2018 21:17:51'!
siEsUnoDevolve: aValue siNo: anotherValue 
	^anotherValue value! !

!II class methodsFor: 'as yet unclassified' stamp: 'GR 3/26/2018 21:25:49'!
unNumeroMenosYo: unNumero
	^unNumero previous - self previous
	
	"unNumero siEsUnoDevolve: [^self previous] siNo: [^((self previous) - (unNumero previous))]

	(unNumero isEqualTo: I) ifTrue: [
		^ self previous.
		] ifFalse: [
		^(self previous) - (unNumero previous)
		]"! !

!II class methodsFor: 'as yet unclassified' stamp: 'GR 3/26/2018 21:31:03'!
unNumeroMultiplicadoPorMi: aNumber
	^(self previous) * (aNumber + aNumber)! !


!II class methodsFor: 'fileout' stamp: 'FH 4/2/2018 13:25:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading pourposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: #'Actividad 5'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Actividad 5'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Actividad 5'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
* aNumber
	^ self previous * (aNumber  + aNumber)! !

!III class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
+ unNumeroDePeano
	^self previous +  unNumeroDePeano  next! !

!III class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
- unNumero
	^unNumero unNumeroMenosYo: self
	
	"unNumero siEsUnoDevolve: [^self previous] siNo: [^((self previous) - (unNumero previous))]

	(unNumero isEqualTo: I) ifTrue: [
		^ self previous.
		] ifFalse: [
		^(self previous) - (unNumero previous)
		]"! !

!III class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
/ unNumero
	self < unNumero ifTrue: [
		^ self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
		].
	((unNumero * II) - I) >= self ifTrue: [
		^ I
		].
	^ I + ((self - unNumero) / unNumero).! !

!III class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
< unNumeroDePeano
	^ (self >= unNumeroDePeano) not.! !

!III class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
>= unNumeroDePeano
	^ (unNumeroDePeano isEqualTo: I) or: [self previous >= unNumeroDePeano previous].! !

!III class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un numero mayor.'! !

!III class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
next
	next ifNil:
	[
		next:= self cloneNamed:  (self name, 'I').
		next previous: self 		
	].
	^next.! !

!III class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
next: aNumber
	next := aNumber! !

!III class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
previous
	^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
previous: aNumber
	previous := aNumber.! !

!III class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
removeAllNext
	next ifNotNil: 
	[
		next removeAllNext.
		next removeFromSystem .
		next := nil.
	]! !

!III class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
siEsUnoDevolve: aValue siNo: anotherValue 
	^anotherValue value! !

!III class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
unNumeroMenosYo: unNumero
	^unNumero previous - self previous
	
	"unNumero siEsUnoDevolve: [^self previous] siNo: [^((self previous) - (unNumero previous))]

	(unNumero isEqualTo: I) ifTrue: [
		^ self previous.
		] ifFalse: [
		^(self previous) - (unNumero previous)
		]"! !

!III class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
unNumeroMultiplicadoPorMi: aNumber
	^(self previous) * (aNumber + aNumber)! !


!III class methodsFor: 'fileout' stamp: 'FH 4/2/2018 13:25:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading pourposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: #'Actividad 5'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Actividad 5'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Actividad 5'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
* aNumber
	^ self previous * (aNumber  + aNumber)! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
+ unNumeroDePeano
	^self previous +  unNumeroDePeano  next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
- unNumero
	^unNumero unNumeroMenosYo: self
	
	"unNumero siEsUnoDevolve: [^self previous] siNo: [^((self previous) - (unNumero previous))]

	(unNumero isEqualTo: I) ifTrue: [
		^ self previous.
		] ifFalse: [
		^(self previous) - (unNumero previous)
		]"! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
/ unNumero
	self < unNumero ifTrue: [
		^ self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
		].
	((unNumero * II) - I) >= self ifTrue: [
		^ I
		].
	^ I + ((self - unNumero) / unNumero).! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
< unNumeroDePeano
	^ (self >= unNumeroDePeano) not.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
>= unNumeroDePeano
	^ (unNumeroDePeano isEqualTo: I) or: [self previous >= unNumeroDePeano previous].! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un numero mayor.'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
next
	next ifNil:
	[
		next:= self cloneNamed:  (self name, 'I').
		next previous: self 		
	].
	^next.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
next: aNumber
	next := aNumber! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
previous
	^previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
previous: aNumber
	previous := aNumber.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
removeAllNext
	next ifNotNil: 
	[
		next removeAllNext.
		next removeFromSystem .
		next := nil.
	]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
siEsUnoDevolve: aValue siNo: anotherValue 
	^anotherValue value! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
unNumeroMenosYo: unNumero
	^unNumero previous - self previous
	
	"unNumero siEsUnoDevolve: [^self previous] siNo: [^((self previous) - (unNumero previous))]

	(unNumero isEqualTo: I) ifTrue: [
		^ self previous.
		] ifFalse: [
		^(self previous) - (unNumero previous)
		]"! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FH 4/2/2018 13:21:28'!
unNumeroMultiplicadoPorMi: aNumber
	^(self previous) * (aNumber + aNumber)! !


!IIII class methodsFor: 'fileout' stamp: 'FH 4/2/2018 13:25:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading pourposes - Do not modify it"

	next := nil.
	previous := III.! !

II initializeCollaboratorsFromFile!
III initializeCollaboratorsFromFile!
IIII initializeCollaboratorsFromFile!