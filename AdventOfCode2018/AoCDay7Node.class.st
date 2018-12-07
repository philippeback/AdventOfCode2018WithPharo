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
		nextPutAll: 'Pred:';
		nextPutAll: (self predecessors collect: #nodeId);
		nextPutAll: 'Succ:';
		nextPutAll: (self successors collect: #nodeId)
		
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
