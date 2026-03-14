------------------------------ MODULE BehaviorLoop_445_the_short_tie_loop ------------------------------
EXTENDS Naturals, FiniteSets, Sequences

NODES == {"loop_445_context", "loop_445_context_branch", "loop_445_given_gate", "loop_445_inactive", "loop_445_intervention_interdict", "loop_445_intervention_minimize", "loop_445_intervention_recognize", "loop_445_operator_branch", "loop_445_result_branch", "loop_445_sink", "loop_445_start", "loop_445_taxonomy_branch", "loop_445_then_branch", "loop_445_verdict", "loop_445_when_gate"}
ROOTS == {"loop_445_start"}
TERMINALS == {"loop_445_sink"}
FOLD_TARGETS == {"loop_445_verdict"}
EFFECTS == {}
DECLARED_EFFECTS == {}
INFERRED_EFFECTS == {}

VARIABLES active, beta1, payloadPresent, consensusReached
vars == <<active, beta1, payloadPresent, consensusReached>>

Max2(a, b) == IF a > b THEN a ELSE b
CanFire(sourceSet) == sourceSet \subseteq active
UpdateActive(sourceSet, targetSet) == (active \ sourceSet) \cup targetSet

Init ==
  /\ active = ROOTS
  /\ beta1 = 0
  /\ payloadPresent = TRUE
  /\ consensusReached = FALSE

Edge_01_PROCESS ==
  /\ CanFire({"loop_445_start"})
  /\ active' = UpdateActive({"loop_445_start"}, {"loop_445_given_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_445_given_gate"} \cap FOLD_TARGETS # {})
Edge_02_PROCESS ==
  /\ CanFire({"loop_445_given_gate"})
  /\ active' = UpdateActive({"loop_445_given_gate"}, {"loop_445_when_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_445_when_gate"} \cap FOLD_TARGETS # {})
Edge_03_PROCESS ==
  /\ CanFire({"loop_445_given_gate"})
  /\ active' = UpdateActive({"loop_445_given_gate"}, {"loop_445_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_445_inactive"} \cap FOLD_TARGETS # {})
Edge_04_PROCESS ==
  /\ CanFire({"loop_445_when_gate"})
  /\ active' = UpdateActive({"loop_445_when_gate"}, {"loop_445_context"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_445_context"} \cap FOLD_TARGETS # {})
Edge_05_PROCESS ==
  /\ CanFire({"loop_445_when_gate"})
  /\ active' = UpdateActive({"loop_445_when_gate"}, {"loop_445_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_445_inactive"} \cap FOLD_TARGETS # {})
Edge_06_FORK ==
  /\ CanFire({"loop_445_context"})
  /\ active' = UpdateActive({"loop_445_context"}, {"loop_445_context_branch", "loop_445_then_branch", "loop_445_operator_branch", "loop_445_result_branch", "loop_445_taxonomy_branch", "loop_445_intervention_recognize", "loop_445_intervention_interdict", "loop_445_intervention_minimize"})
  /\ beta1' = beta1 + (Cardinality({"loop_445_context_branch", "loop_445_then_branch", "loop_445_operator_branch", "loop_445_result_branch", "loop_445_taxonomy_branch", "loop_445_intervention_recognize", "loop_445_intervention_interdict", "loop_445_intervention_minimize"}) - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_445_context_branch", "loop_445_then_branch", "loop_445_operator_branch", "loop_445_result_branch", "loop_445_taxonomy_branch", "loop_445_intervention_recognize", "loop_445_intervention_interdict", "loop_445_intervention_minimize"} \cap FOLD_TARGETS # {})
Edge_07_FOLD ==
  /\ CanFire({"loop_445_context_branch", "loop_445_then_branch", "loop_445_operator_branch", "loop_445_result_branch", "loop_445_taxonomy_branch", "loop_445_intervention_recognize", "loop_445_intervention_interdict", "loop_445_intervention_minimize"})
  /\ active' = UpdateActive({"loop_445_context_branch", "loop_445_then_branch", "loop_445_operator_branch", "loop_445_result_branch", "loop_445_taxonomy_branch", "loop_445_intervention_recognize", "loop_445_intervention_interdict", "loop_445_intervention_minimize"}, {"loop_445_verdict"})
  /\ beta1' = 0
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_445_verdict"} \cap FOLD_TARGETS # {})
Edge_08_PROCESS ==
  /\ CanFire({"loop_445_inactive"})
  /\ active' = UpdateActive({"loop_445_inactive"}, {"loop_445_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_445_sink"} \cap FOLD_TARGETS # {})
Edge_09_PROCESS ==
  /\ CanFire({"loop_445_verdict"})
  /\ active' = UpdateActive({"loop_445_verdict"}, {"loop_445_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_445_sink"} \cap FOLD_TARGETS # {})
Edge_10_INTERFERE ==
  /\ CanFire({"loop_445_intervention_recognize"})
  /\ active' = UpdateActive({"loop_445_intervention_recognize"}, {"loop_445_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_445_then_branch"} \cap FOLD_TARGETS # {})
Edge_11_INTERFERE ==
  /\ CanFire({"loop_445_intervention_interdict"})
  /\ active' = UpdateActive({"loop_445_intervention_interdict"}, {"loop_445_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_445_then_branch"} \cap FOLD_TARGETS # {})
Edge_12_INTERFERE ==
  /\ CanFire({"loop_445_intervention_minimize"})
  /\ active' = UpdateActive({"loop_445_intervention_minimize"}, {"loop_445_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_445_then_branch"} \cap FOLD_TARGETS # {})

Next ==
  \/ Edge_01_PROCESS
  \/ Edge_02_PROCESS
  \/ Edge_03_PROCESS
  \/ Edge_04_PROCESS
  \/ Edge_05_PROCESS
  \/ Edge_06_FORK
  \/ Edge_07_FOLD
  \/ Edge_08_PROCESS
  \/ Edge_09_PROCESS
  \/ Edge_10_INTERFERE
  \/ Edge_11_INTERFERE
  \/ Edge_12_INTERFERE

TypeInvariant ==
  /\ active \subseteq NODES
  /\ beta1 \in Nat
  /\ payloadPresent \in BOOLEAN
  /\ consensusReached \in BOOLEAN

NoLostPayloadInvariant == payloadPresent = TRUE
HasFoldTargets == FOLD_TARGETS # {}
EventuallyTerminal == <> (active \cap TERMINALS # {})
EventuallyConsensus == IF HasFoldTargets THEN <> consensusReached ELSE TRUE
DeadlockFree == []<>(ENABLED Next)

Spec ==
  /\ Init
  /\ [][Next]_vars
  /\ WF_vars(Next)

THEOREM Spec => []NoLostPayloadInvariant

=============================================================================
