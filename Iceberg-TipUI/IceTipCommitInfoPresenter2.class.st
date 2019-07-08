Class {
	#name : #IceTipCommitInfoPresenter2,
	#superclass : #SpPresenter,
	#instVars : [
		'model',
		'selectedModel',
		'headTabContainer',
		'ancestorTabContainer',
		'notebookPanel',
		'infoPage',
		'headPage',
		'ancestorPage'
	],
	#category : #'Iceberg-TipUI-View'
}

{ #category : #specs }
IceTipCommitInfoPresenter2 class >> defaultSpec [
	<spec: #default>
	^ SpBoxLayout newVertical
		add: #notebookPanel;
		yourself
]

{ #category : #examples }
IceTipCommitInfoPresenter2 class >> example [ <example>
^self new openWithSpec 
]

{ #category : #accessing }
IceTipCommitInfoPresenter2 >> beForCommit [

	headTabContainer := IceTipHistoryDiffFromHead tab: headPage.
	ancestorTabContainer := IceTipHistoryDiffToAncestor tab: ancestorPage
]

{ #category : #accessing }
IceTipCommitInfoPresenter2 >> beForMerge [

	headTabContainer := IceTipHistoryDiffToHead tab: headPage.
	ancestorTabContainer := IceTipHistoryDiffToAncestor tab: ancestorPage
]

{ #category : #private }
IceTipCommitInfoPresenter2 >> commitInfo [

	selectedModel ifNil: [ ^ self newEmpty ].
	^ IceTipReadOnlyForm items: selectedModel info
]

{ #category : #private }
IceTipCommitInfoPresenter2 >> diffFromAncestor [
	
	selectedModel ifNil: [ ^ self newEmpty ].
	^ IceTipDiffPanel on: (ancestorTabContainer diffFor: selectedModel)
]

{ #category : #private }
IceTipCommitInfoPresenter2 >> diffFromHead [
	
	selectedModel ifNil: [ ^ self newEmpty ].
	^ IceTipDiffPanel on: (headTabContainer diffFor: selectedModel)
]

{ #category : #initialization }
IceTipCommitInfoPresenter2 >> initialize [
	self beForCommit.
	super initialize
]

{ #category : #initialization }
IceTipCommitInfoPresenter2 >> initializeCommitPanel [
	"This will be initialised in fact on the first refresh"

	notebookPanel
		addPage: (infoPage := self newInfoPage);
		addPage: (headPage := self newDiffPage 
			title: 'Diff from HEAD';
			presenterProvider: [ self diffFromHead ];
			yourself);
		addPage: (ancestorPage := self newDiffPage 
			title: 'Diff from ancestor';
			presenterProvider: [ self diffFromAncestor ];
			yourself)
]

{ #category : #initialization }
IceTipCommitInfoPresenter2 >> initializeWidgets [

	notebookPanel := self newNotebook.
	self initializeCommitPanel.
	
	self focusOrder add: notebookPanel
]

{ #category : #'private factory' }
IceTipCommitInfoPresenter2 >> newDiffPage [

	^ NotebookPage 
		title: 'Diff'
		icon: (self iconNamed: #diff)
		provider: [ "It will be overriden" ]
]

{ #category : #'private factory' }
IceTipCommitInfoPresenter2 >> newDiffTab [
	^ self newTab 
		label: 'Diff';
		icon: (self iconNamed: #diff);
		closeable: false;
		yourself
]

{ #category : #'private factory' }
IceTipCommitInfoPresenter2 >> newEmpty [

	^ (self instantiate: LabelPresenter) label: '(No commit selected)'
]

{ #category : #'private factory' }
IceTipCommitInfoPresenter2 >> newEmptyTab [
	^ self newTab 
		label: 'Info';
		icon: (self iconNamed: #smallQuestion);
		closeable: false;
		contents: '(No commit selected)' asMorph;
		yourself
]

{ #category : #'private factory' }
IceTipCommitInfoPresenter2 >> newInfoPage [

	^ NotebookPage 
		title: 'Info'
		icon: (self iconNamed: #smallQuestion)
		provider: [ self commitInfo ]
]

{ #category : #'private factory' }
IceTipCommitInfoPresenter2 >> newInfoTab [
	^ self newTab 
		label: 'Info';
		icon: (self iconNamed: #smallQuestion);
		closeable: false;
		yourself
]

{ #category : #accessing }
IceTipCommitInfoPresenter2 >> refresh [
	
	selectedModel ifNil: [ ^ self ].
	
	headPage title: (headTabContainer labelFor: selectedModel).
	ancestorPage title: (ancestorTabContainer labelFor: selectedModel).
	notebookPanel resetAllPageContents
]

{ #category : #private }
IceTipCommitInfoPresenter2 >> refreshDiffFromAncestor [
	ancestorTabContainer updateContentsOn: selectedModel
]

{ #category : #private }
IceTipCommitInfoPresenter2 >> refreshDiffFromAncestorLabel [
	ancestorTabContainer updateLabelOn: selectedModel
]

{ #category : #private }
IceTipCommitInfoPresenter2 >> refreshDiffFromHead [
	headTabContainer updateContentsOn: selectedModel
]

{ #category : #private }
IceTipCommitInfoPresenter2 >> refreshDiffFromHeadLabel [
	headTabContainer updateLabelOn: selectedModel
]

{ #category : #accessing }
IceTipCommitInfoPresenter2 >> selectedModel: aModel [

	selectedModel := aModel.
	self refresh
]

{ #category : #initialization }
IceTipCommitInfoPresenter2 >> setModelBeforeInitialization: anObject [
	model := anObject
]
