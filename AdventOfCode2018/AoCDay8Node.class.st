Class {
	#name : #AoCDay8Node,
	#superclass : #SPTreeLW,
	#instVars : [
		'vector',
		'level',
		'startIndex',
		'metadata',
		'childrenCount',
		'metadataSize',
		'endIndex',
		'extractedMetadata'
	],
	#category : #AdventOfCode2018
}

{ #category : #accessing }
AoCDay8Node >> childrenCount [
	^ childrenCount
]

{ #category : #accessing }
AoCDay8Node >> childrenCount: anObject [
	childrenCount := anObject
]

{ #category : #accessing }
AoCDay8Node >> endIndex [
	^ endIndex
]

{ #category : #accessing }
AoCDay8Node >> endIndex: anObject [
	endIndex := anObject
]

{ #category : #accessing }
AoCDay8Node >> extractedMetadata [
	^ extractedMetadata
]

{ #category : #accessing }
AoCDay8Node >> extractedMetadata: anObject [
	extractedMetadata := anObject
]

{ #category : #accessing }
AoCDay8Node >> level [
	^ level
]

{ #category : #accessing }
AoCDay8Node >> level: anObject [
	level := anObject
]

{ #category : #accessing }
AoCDay8Node >> metadata [
	^ metadata
]

{ #category : #accessing }
AoCDay8Node >> metadata: anObject [
	metadata := anObject
]

{ #category : #accessing }
AoCDay8Node >> metadataSize [
	^ metadataSize
]

{ #category : #accessing }
AoCDay8Node >> metadataSize: anObject [
	metadataSize := anObject
]

{ #category : #accessing }
AoCDay8Node >> startIndex [
	^ startIndex
]

{ #category : #accessing }
AoCDay8Node >> startIndex: anObject [
	startIndex := anObject
]

{ #category : #accessing }
AoCDay8Node >> vector [
	^ vector
]

{ #category : #accessing }
AoCDay8Node >> vector: anObject [
	vector := anObject
]
