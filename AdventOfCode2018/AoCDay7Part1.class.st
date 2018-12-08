"
Day 7: The Sum of Its Parts

Step C must be finished before step A can begin.
Step C must be finished before step F can begin.
Step A must be finished before step B can begin.
Step A must be finished before step D can begin.
Step B must be finished before step E can begin.
Step D must be finished before step E can begin.
Step F must be finished before step E can begin.

Visually, these requirements look like this:


  -->A--->B--
 /    \      \
C      -->D----->E
 \           /
  ---->F-----

Your first goal is to determine the order in which the steps should be completed. If more than one step is ready, choose the step which is first alphabetically. In this example, the steps would be completed as follows:

    Only C is available, and so it is done first.
    Next, both A and F are available. A is first alphabetically, so it is done next.
    Then, even though F was available earlier, steps B and D are now also available, and B is the first alphabetically of the three.
    After that, only D and F are available. E is not available because only some of its prerequisites are complete. Therefore, D is completed next.
    F is the only choice, so it is done next.
    Finally, E is completed.

So, in this example, the correct order is CABDFE.

In what order should the steps in your instructions be completed?
"
Class {
	#name : #AoCDay7Part1,
	#superclass : #Object,
	#category : #'AdventOfCode2018-Day7Part1'
}

{ #category : #examples }
AoCDay7Part1 class >> part1 [
	<example>
	self new part1 inspect
]

{ #category : #'as yet unclassified' }
AoCDay7Part1 >> findStart: someNodes [
	"Assuming there is only one start. But there are more than one in the problem..."

	^ someNodes select: [ :node | node predecessors isEmpty ]
]

{ #category : #'as yet unclassified' }
AoCDay7Part1 >> instructions: anInputString [
	^ anInputString lines
		collect: [ :line | 
			(line splitOn: Character space)
				in: [ :chunked | 
					{(chunked at: 2).
					(chunked at: 8)} ] ]
]

{ #category : #'as yet unclassified' }
AoCDay7Part1 >> link: nodesDict accordingTo: instructions [
	instructions
		do: [ :instruction | 
			| to from |
			from := nodesDict at: instruction first first.
			to := nodesDict at: instruction second first.
			from successors addIfNotPresent: to.
			to predecessors addIfNotPresent: from ]
]

{ #category : #'as yet unclassified' }
AoCDay7Part1 >> nodes: someInstructions [

	| nodeIds |
	nodeIds := ((someInstructions collect: [ :instruction |
		instruction first, instruction second ]) joinUsing: '') asSet.
	
	^ nodeIds collect: [ :nodeId | AoCDay7NodePart1 withNodeId: nodeId ]
	
]

{ #category : #'as yet unclassified' }
AoCDay7Part1 >> nodesDict: someNodes [

	^ (someNodes collect: [ :node | node nodeId -> node  ]) asDictionary
	
]

{ #category : #'as yet unclassified' }
AoCDay7Part1 >> part1 [
	| selector input instructions nodes nodesDict startNode tracks  sequence s |
	selector := #puzzleInputSample.
	selector := #puzzleInput.
	input := self perform: selector.
	instructions := self instructions: input.
	nodes := self nodes: instructions.
	nodesDict := self nodesDict: nodes.
	self link: nodesDict accordingTo: instructions.
	"nodesDict inspect."

	
	tracks := self walkFrom: nodes.
	
	s := String new writeStream.
	tracks do: [ :node | s nextPut: (node nodeId) ].
	sequence := s contents.
	
	^ { nodes. startNode. tracks. sequence}
]

{ #category : #'as yet unclassified' }
AoCDay7Part1 >> puzzleInput [
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
AoCDay7Part1 >> puzzleInputSample [
^ 'Step C must be finished before step A can begin.
Step C must be finished before step F can begin.
Step A must be finished before step B can begin.
Step A must be finished before step D can begin.
Step B must be finished before step E can begin.
Step D must be finished before step E can begin.
Step F must be finished before step E can begin.'
]

{ #category : #'as yet unclassified' }
AoCDay7Part1 >> walkFrom: someNodes [
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
