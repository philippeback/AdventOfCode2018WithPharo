Class {
	#name : #AoCDay7NodePart2,
	#superclass : #Object,
	#instVars : [
		'successors',
		'predecessors',
		'nodeId',
		'visited',
		'workedOn'
	],
	#category : #AdventOfCode2018
}

{ #category : #'as yet unclassified' }
AoCDay7NodePart2 class >> withNodeId: aCharacter [ 
	^self new nodeId: aCharacter; yourself
]

{ #category : #accessing }
AoCDay7NodePart2 >> = anObject [
	^ nodeId = anObject nodeId
]

{ #category : #accessing }
AoCDay7NodePart2 >> addPredecessor: aNode [

	self predecessors add: aNode
]

{ #category : #accessing }
AoCDay7NodePart2 >> addSuccessor: aNode [

	self successors add: aNode
]

{ #category : #accessing }
AoCDay7NodePart2 >> effort [

	^ 60 + nodeId asciiValue - $A asciiValue + 1
]

{ #category : #accessing }
AoCDay7NodePart2 >> hash [
	^ nodeId asCharacter asciiValue 
]

{ #category : #initialization }
AoCDay7NodePart2 >> initialize [ 

	successors := Set new.
	predecessors := Set new.
	nodeId := $#.
	visited := false.
	workedOn := 0.


]

{ #category : #accessing }
AoCDay7NodePart2 >> isAVailable [

	^predecessors ifEmpty: [ true ] ifNotEmpty: [ predecessors reduce: [ :a :b | a isAvailable & b isAvailable ] ]
]

{ #category : #accessing }
AoCDay7NodePart2 >> isAvailable [
	^predecessors ifEmpty: [ true ] ifNotEmpty: [ (predecessors collect: [:each | each isVisited ]) reduce: [ :a :b | a & b ] ] 
]

{ #category : #accessing }
AoCDay7NodePart2 >> isVisited [

	^visited
]

{ #category : #accessing }
AoCDay7NodePart2 >> nodeId [
	^ nodeId
]

{ #category : #accessing }
AoCDay7NodePart2 >> nodeId: anObject [
	nodeId := anObject
]

{ #category : #accessing }
AoCDay7NodePart2 >> predecessors [
	^ predecessors
]

{ #category : #accessing }
AoCDay7NodePart2 >> printOn: aStream [
	
	aStream
		nextPutAll: 'AoCDay7Node (';
		nextPut: nodeId;
		nextPutAll: ') ';
		nextPutAll: 'Dur: [ ';
		nextPutAll: self duration printString;
		nextPutAll: ' ] ';
		nextPutAll: (visited ifTrue: ['*'] ifFalse: [' ']);
		nextPutAll: 'Pred: [ ';
		nextPutAll: (' / ' join: (self predecessors collect: #nodeId));
		nextPutAll: ' ]  Succ: [ ';
		nextPutAll: (' / ' join: (self successors collect: #nodeId));
		nextPutAll: ' ]'
]

{ #category : #accessing }
AoCDay7NodePart2 >> showMe [

	^ (String new writeStreamDo: [ : s | 
		s
		nextPutAll: 'AoCDay7Node (';
		nextPut: nodeId;
		nextPutAll: ') ';
		nextPutAll: 'Pred:';
		nextPutAll: (self predecessors collect: #nodeId);
		nextPutAll: 'Succ:';
		nextPutAll: (self successors collect: #nodeId);
		yourself
		]) contents
		
]

{ #category : #accessing }
AoCDay7NodePart2 >> successors [
	^ successors
]

{ #category : #accessing }
AoCDay7NodePart2 >> unvisitedAvailableSuccessors [
	^ successors select: [ :successor | (successor isVisited not) & (successor isAvailable) ]
]

{ #category : #accessing }
AoCDay7NodePart2 >> unvisitedSuccessors [
	^ successors select: [ :each | each isVisited not ]
]

{ #category : #accessing }
AoCDay7NodePart2 >> visit [
	visited := true
]

{ #category : #accessing }
AoCDay7NodePart2 >> workOnIt [
	"Work on it for one second"
	workedOn < self effort ifTrue: [ 	workedOn := workedOn + 1 ]
		ifFalse: [ Error signal: 'Worked enough on ', self ]
]
