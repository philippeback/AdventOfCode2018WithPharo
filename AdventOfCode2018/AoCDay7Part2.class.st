Class {
	#name : #AoCDay7Part2,
	#superclass : #Object,
	#instVars : [
		'ticks',
		'workers'
	],
	#category : #AdventOfCode2018
}

{ #category : #examples }
AoCDay7Part2 class >> run [
	<example>
	self new run inspect
]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> findStart: someNodes [
	"Assuming there is only one start. But there are more than one in the problem..."

	^ someNodes select: [ :node | node predecessors isEmpty ]
]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> instructions: anInputString [
	^ anInputString lines
		collect: [ :line | 
			(line splitOn: Character space)
				in: [ :chunked | 
					{(chunked at: 2).
					(chunked at: 8)} ] ]
]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> link: nodesDict accordingTo: instructions [
	instructions
		do: [ :instruction | 
			| to from |
			from := nodesDict at: instruction first first.
			to := nodesDict at: instruction second first.
			from successors addIfNotPresent: to.
			to predecessors addIfNotPresent: from ]
]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> nodes: someInstructions [

	| nodeIds |
	nodeIds := ((someInstructions collect: [ :instruction |
		instruction first, instruction second ]) joinUsing: '') asSet.
	
	^ nodeIds collect: [ :nodeId | AoCDay7NodePart2 withNodeId: nodeId ]
	
]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> nodesDict: someNodes [

	^ (someNodes collect: [ :node | node nodeId -> node  ]) asDictionary
	
]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> puzzleInput [
	^ 'Step U must be finished before step A can begin.
Step F must be finished before step Z can begin.
Step B must be finished before step J can begin.
Step O must be finished before step R can begin.
Step H must be finished before step S can begin.
Step T must be finished before step R can begin.
Step L must be finished before step W can begin.
Step M must be finished before step I can begin.
Step Q must be finished before step K can begin.
Step Z must be finished before step V can begin.
Step C must be finished before step E can begin.
Step W must be finished before step I can begin.
Step K must be finished before step S can begin.
Step I must be finished before step Y can begin.
Step P must be finished before step V can begin.
Step V must be finished before step X can begin.
Step R must be finished before step E can begin.
Step N must be finished before step E can begin.
Step X must be finished before step J can begin.
Step A must be finished before step J can begin.
Step S must be finished before step G can begin.
Step J must be finished before step E can begin.
Step Y must be finished before step E can begin.
Step D must be finished before step G can begin.
Step E must be finished before step G can begin.
Step K must be finished before step N can begin.
Step B must be finished before step I can begin.
Step X must be finished before step S can begin.
Step V must be finished before step S can begin.
Step U must be finished before step L can begin.
Step N must be finished before step G can begin.
Step O must be finished before step L can begin.
Step X must be finished before step E can begin.
Step V must be finished before step E can begin.
Step Y must be finished before step G can begin.
Step A must be finished before step Y can begin.
Step M must be finished before step E can begin.
Step F must be finished before step Q can begin.
Step F must be finished before step X can begin.
Step L must be finished before step C can begin.
Step T must be finished before step L can begin.
Step B must be finished before step C can begin.
Step Q must be finished before step N can begin.
Step T must be finished before step G can begin.
Step R must be finished before step D can begin.
Step I must be finished before step A can begin.
Step B must be finished before step M can begin.
Step H must be finished before step A can begin.
Step F must be finished before step K can begin.
Step U must be finished before step F can begin.
Step R must be finished before step A can begin.
Step J must be finished before step D can begin.
Step V must be finished before step Y can begin.
Step F must be finished before step J can begin.
Step C must be finished before step K can begin.
Step M must be finished before step C can begin.
Step F must be finished before step E can begin.
Step I must be finished before step E can begin.
Step T must be finished before step A can begin.
Step J must be finished before step Y can begin.
Step R must be finished before step X can begin.
Step W must be finished before step S can begin.
Step V must be finished before step R can begin.
Step U must be finished before step V can begin.
Step C must be finished before step V can begin.
Step F must be finished before step Y can begin.
Step R must be finished before step G can begin.
Step W must be finished before step N can begin.
Step H must be finished before step N can begin.
Step H must be finished before step Y can begin.
Step B must be finished before step W can begin.
Step M must be finished before step Z can begin.
Step X must be finished before step A can begin.
Step A must be finished before step G can begin.
Step N must be finished before step A can begin.
Step H must be finished before step J can begin.
Step B must be finished before step O can begin.
Step W must be finished before step A can begin.
Step P must be finished before step N can begin.
Step Z must be finished before step G can begin.
Step W must be finished before step D can begin.
Step D must be finished before step E can begin.
Step W must be finished before step J can begin.
Step N must be finished before step D can begin.
Step C must be finished before step J can begin.
Step B must be finished before step Y can begin.
Step F must be finished before step P can begin.
Step L must be finished before step P can begin.
Step X must be finished before step G can begin.
Step R must be finished before step Y can begin.
Step K must be finished before step A can begin.
Step M must be finished before step Y can begin.
Step W must be finished before step Y can begin.
Step F must be finished before step I can begin.
Step L must be finished before step X can begin.
Step R must be finished before step J can begin.
Step V must be finished before step J can begin.
Step V must be finished before step D can begin.
Step H must be finished before step C can begin.
Step O must be finished before step G can begin.
Step P must be finished before step R can begin.'

]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> puzzleInputSample [
^ 'Step C must be finished before step A can begin.
Step C must be finished before step F can begin.
Step A must be finished before step B can begin.
Step A must be finished before step D can begin.
Step B must be finished before step E can begin.
Step D must be finished before step E can begin.
Step F must be finished before step E can begin.'
]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> run [
	| selector input instructions nodes nodesDict startNode tracks  sequence s |
	selector := #puzzleInputSample.
	selector := #puzzleInput.
	input := self perform: selector.
	instructions := self instructions: input.
	nodes := self nodes: instructions.
	nodesDict := self nodesDict: nodes.
	self link: nodesDict accordingTo: instructions.
	nodesDict inspect.

	
	tracks := self walkFrom: nodes.
	
	s := String new writeStream.
	tracks do: [ :node | s nextPut: (node nodeId) ].
	sequence := s contents.
	
	^ { nodes. startNode. tracks. sequence}
]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> tick [ 
	ticks := ticks + 1.
	

]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> walkFrom: someNodes [
	| availableTargets path addNodeToPath waitingList currentNode availableTargetsFinder startNodes |
	path := OrderedCollection new.
	waitingList := SortedCollection sortBlock: [:a :b | a nodeId < b nodeId ].
	addNodeToPath := [ :node | 	path add: node.	node visit ].
	availableTargetsFinder := [ :node | node unvisitedAvailableSuccessors asSortedCollection: [ :a :b | a nodeId < b nodeId ] ].
	{  path. waitingList } inspect.
	startNodes := self findStart: someNodes.
	(startNodes asSortedCollection: [ :a :b | a nodeId < b nodeId ]) reversed do: [ :each | waitingList addIfNotPresent: each ].
	currentNode := waitingList removeFirst.
	150
		timesRepeat: [ 
			addNodeToPath value: currentNode.
			
			(availableTargets := availableTargetsFinder value: currentNode) ifNotEmpty: [ :targets | targets reversed do: [ :each | waitingList addIfNotPresent: each ] ].
			waitingList ifNotEmpty: [ 
			currentNode := waitingList removeFirst]
			ifEmpty: [ ^ path  ]  ].
]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> workers: aNumberOfWorkers [

	workers := (1 to: aNumberOfWorkers) collect: [ :i | AoCDay7Worker usingId: i ]
	

]
