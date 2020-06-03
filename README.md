README - 2020_fairness-dishonesty
===================================

Data and analysis scripts for Melis et al.: "The impact of justified and
unjustified inequality on perceived fairness and dishonesty"


Data files
==========

The `data/` folder contains the data files. Here is the key for the columns:


`exp1_participant_info.csv`
--------------------------

Contains background information on the participants who participated in 
Experiment 1, which was provided in the exit survey.

- *subject*: unique participant identifier
- *justification*: whether payment rate was justified or not (manipulated
	between pairs)
- *pay*: whether payment rate was high or low (manipulated within pairs)
- *age*
- *gender*
- *anagram_score*: number of correctly solved anagrams
- *donate_sweets*: whether they would like to donate any sweets to the other
	participant
- *donate_number*: how many, if yes to the previous question
- *like_sweets*: whether they liked the sweets offered to them 
- *lied*: whether they lied
- *tempted_lie*: whether they were tempted to lie
- *fairness*: how fair was the study on a scale from 1 (very unfair) to 10
	(very fair)


`exp1_dice_rolls.csv`
---------------------

Reported dice rolls.

- *subject*: unique participant identifier
- *roll*: indexes each of the five sets of dice rolls during test
- *reported_score*: reported outcome of the dice rolls
- *RDR*: whether it was a rewarded dice roll (RDR): 1=yes, 0=no


`exp2_participant_info.csv`
--------------------------

Contains background information on the participants who participated in 
Experiment 2, as provided in the exit survey.

- *dyad*: unique dyad identifier
- *subject*: unique participant identifier
- *procedure*: whether the procedure was fair or unfair
- *outcome*: whether participants in a dyad received an equal or unequal pay rate
- *quiz_actual*: the actual result of the quiz
- *quiz_official*: the result of the quiz communicated to the participants
- *pay_rate*: pay rate in pennies
- *valence*: was the outcome beneficial for the participant
- *fair*: did the participant find the rewards were distributed fairly?
- *cheated*: did the participant cheat?
- *tempted_cheat*: was the participant tempted to cheat? (scale from 1-5)
- *age*
- *gender*


`exp2_dice_rolls.csv`
---------------------

Reported dice rolls.

- *dyad*: as above
- *subject*: as above
- *roll*: which of the 12 rolls per participant
- *pips*: number of pips reported
