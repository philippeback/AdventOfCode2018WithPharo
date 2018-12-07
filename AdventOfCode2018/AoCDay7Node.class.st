Class {
	#name : #AoCDay7Node,
	#superclass : #Object,
	#instVars : [
		'successors',
		'predecessors',
		'nodeId',
		'visited'
	],
	#category : #AdventOfCode2018
}

{ #category : #'as yet unclassified' }
AoCDay7Node class >> withNodeId: aCharacter [ 
	^self new nodeId: aCharacter; yourself
]

{ #category : #accessing }
AoCDay7Node >> = anObject [
	^ nodeId = anObject nodeId
]

{ #category : #accessing }
AoCDay7Node >> addPredecessor: aNode [

	self predecessors add: aNode
]

{ #category : #accessing }
AoCDay7Node >> addSuccessor: aNode [

	self successors add: aNode
]

{ #category : #accessing }
AoCDay7Node >> hash [
	^ nodeId asCharacter asciiValue 
]

{ #category : #initialization }
AoCDay7Node >> initialize [ 

	successors := Set new.
	predecessors := Set new.
	nodeId := $#.
	visited := false


]

{ #category : #accessing }
AoCDay7Node >> isAVailable [

	^predecessors ifEmpty: [ true ] ifNotEmpty: [ predecessors reduce: [ :a :b | a isAvailable & b isAvailable ] ]
]

{ #category : #accessing }
AoCDay7Node >> isAvailable [
	^predecessors ifEmpty: [ true ] ifNotEmpty: [ (predecessors collect: [:each | each isVisited ]) reduce: [ :a :b | a & b ] ] 
]

{ #category : #accessing }
AoCDay7Node >> isVisited [

	^visited
]

{ #category : #accessing }
AoCDay7Node >> nodeId [
	^ nodeId
]

{ #category : #accessing }
AoCDay7Node >> nodeId: anObject [
	nodeId := anObject
]

{ #category : #accessing }
AoCDay7Node >> predecessors [
	^ predecessors
]

{ #category : #accessing }
AoCDay7Node >> printOn: aStream [

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
AoCDay7Node >> showMe [

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
AoCDay7Node >> successors [
	^ successors
]

{ #category : #accessing }
AoCDay7Node >> unvisitedAvailableSuccessors [
	^ successors select: [ :successor | (successor isVisited not) & (successor isAvailable) ]
]

{ #category : #accessing }
AoCDay7Node >> unvisitedSuccessors [
	^ successors select: [ :each | each isVisited not ]
]

{ #category : #accessing }
AoCDay7Node >> visit [
	visited := true
]
