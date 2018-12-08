Class {
	#name : #AoCDay7NodePart1,
	#superclass : #Object,
	#instVars : [
		'successors',
		'predecessors',
		'nodeId',
		'visited'
	],
	#category : #'AdventOfCode2018-Day7Part1'
}

{ #category : #'as yet unclassified' }
AoCDay7NodePart1 class >> withNodeId: aCharacter [ 
	^self new nodeId: aCharacter; yourself
]

{ #category : #accessing }
AoCDay7NodePart1 >> = anObject [
	^ nodeId = anObject nodeId
]

{ #category : #accessing }
AoCDay7NodePart1 >> addPredecessor: aNode [

	self predecessors add: aNode
]

{ #category : #accessing }
AoCDay7NodePart1 >> addSuccessor: aNode [

	self successors add: aNode
]

{ #category : #accessing }
AoCDay7NodePart1 >> hash [
	^ nodeId asCharacter asciiValue 
]

{ #category : #initialization }
AoCDay7NodePart1 >> initialize [ 

	successors := Set new.
	predecessors := Set new.
	nodeId := $#.
	visited := false


]

{ #category : #accessing }
AoCDay7NodePart1 >> isAVailable [

	^predecessors ifEmpty: [ true ] ifNotEmpty: [ predecessors reduce: [ :a :b | a isAvailable & b isAvailable ] ]
]

{ #category : #accessing }
AoCDay7NodePart1 >> isAvailable [
	^predecessors ifEmpty: [ true ] ifNotEmpty: [ (predecessors collect: [:each | each isVisited ]) reduce: [ :a :b | a & b ] ] 
]

{ #category : #accessing }
AoCDay7NodePart1 >> isVisited [

	^visited
]

{ #category : #accessing }
AoCDay7NodePart1 >> nodeId [
	^ nodeId
]

{ #category : #accessing }
AoCDay7NodePart1 >> nodeId: anObject [
	nodeId := anObject
]

{ #category : #accessing }
AoCDay7NodePart1 >> predecessors [
	^ predecessors
]

{ #category : #accessing }
AoCDay7NodePart1 >> printOn: aStream [

	^ aStream
		nextPutAll: 'AoCDay7Node (';
		nextPut: nodeId;
		nextPutAll: ') ';
		nextPutAll: (visited ifTrue: ['*'] ifFalse: [' ']);
		nextPutAll: 'Pred: [ ';
		nextPutAll: (' / ' join: (self predecessors collect: #nodeId));
		nextPutAll: ' ]  Succ: [ ';
		nextPutAll: (' / ' join: (self successors collect: #nodeId));
		nextPutAll: ' ]'
]

{ #category : #accessing }
AoCDay7NodePart1 >> showMe [

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
AoCDay7NodePart1 >> successors [
	^ successors
]

{ #category : #accessing }
AoCDay7NodePart1 >> unvisitedAvailableSuccessors [
	^ successors select: [ :successor | (successor isVisited not) & (successor isAvailable) & (self isCompleted) ]
]

{ #category : #accessing }
AoCDay7NodePart1 >> unvisitedSuccessors [
	^ successors select: [ :each | each isVisited not ]
]

{ #category : #accessing }
AoCDay7NodePart1 >> visit [
	visited := true
]
