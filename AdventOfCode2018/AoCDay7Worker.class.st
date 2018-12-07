Class {
	#name : #AoCDay7Worker,
	#superclass : #Object,
	#instVars : [
		'id'
	],
	#category : #AdventOfCode2018
}

{ #category : #'as yet unclassified' }
AoCDay7Worker class >> usingId: anInteger [

	^ self new
		id: anInteger;
		yourself
]

{ #category : #'as yet unclassified' }
AoCDay7Worker >> id: anInteger [ 
	id := anInteger
]
