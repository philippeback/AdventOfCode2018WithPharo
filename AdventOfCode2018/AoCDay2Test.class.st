"
AoC day 2 tests
"
Class {
	#name : #AoCDay2Test,
	#superclass : #TestCase,
	#instVars : [
		'subject'
	],
	#category : #AdventOfCode2018
}

{ #category : #running }
AoCDay2Test >> setUp [ 
	
	subject := (self class environment at:  (self className allButLast: 4) asSymbol) new
]

{ #category : #tests }
AoCDay2Test >> testBoxesIds [
	self assert: (subject boxesIds size > 100)
]

{ #category : #tests }
AoCDay2Test >> testChecksum [
	self assert: (subject checksum) equals: 7533
]

{ #category : #tests }
AoCDay2Test >> testCommonLettersOfPrototypeBoxes [
	self assert: (subject commonLettersOfPrototypeBoxes) equals: 'mphcuasvrnjzzkbgdtqeoylva'
]
