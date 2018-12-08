Class {
	#name : #AoCDay7Worker,
	#superclass : #Object,
	#instVars : [
		'id',
		'workedOn'
	],
	#category : #'AdventOfCode2018-Day7Part2'
}

{ #category : #'as yet unclassified' }
AoCDay7Worker class >> usingId: anInteger [

	^ self new
		id: anInteger;
		yourself
]

{ #category : #'as yet unclassified' }
AoCDay7Worker >> beIdle [
	(String new writeStream
		<< self id;
		nextPutAll: ' finished working on ';
		<< workedOn printString) contents logCr.
	"workedOn visit." "No need, done when beginning"
	workedOn := nil
]

{ #category : #'as yet unclassified' }
AoCDay7Worker >> id [
	^id
]

{ #category : #'as yet unclassified' }
AoCDay7Worker >> id: anInteger [ 
	id := anInteger
]

{ #category : #'as yet unclassified' }
AoCDay7Worker >> isIdle [
	^workedOn isNil
]

{ #category : #printing }
AoCDay7Worker >> printOn: aStream [

	^ aStream
		nextPutAll: 'AoCDay7Worker (';
		<< id;
		nextPutAll: ') ';
		nextPutAll: (self isIdle ifTrue: ['Idle'] ifFalse: ['Active']);
		nextPut: Character space;
		nextPutAll: 'Working on: [ ';
		<< (workedOn ifNotNil: [ workedOn printString ] ifNil: ['Nothing']);
		nextPutAll: ' ]'
]

{ #category : #'as yet unclassified' }
AoCDay7Worker >> startWorkingOn: aNode [
	self isIdle
		ifTrue: [
			workedOn := aNode.
			workedOn visit.
			 (String new writeStream
				<< self id;
				nextPutAll: ' started working on ';
				<< workedOn printString) contents logCr. ]
		ifFalse: [ Error signal: 'Already working on something: ' , aNode printString]
]

{ #category : #'as yet unclassified' }
AoCDay7Worker >> work [
	workedOn
		ifNotNil: [ (String new writeStream
				<< self id;
				nextPutAll: ' working on ';
				<< workedOn printString) contents logCr.
			workedOn workOnIt.
			workedOn isCompleted
				ifTrue: [ self beIdle ] ]
		ifNil: [ Error signal: 'Asked to work on a node but there isn''t any assigned to me' ]
]
