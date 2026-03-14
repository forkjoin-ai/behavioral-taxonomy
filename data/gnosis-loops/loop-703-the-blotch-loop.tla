------------------------------ MODULE BehaviorLoop_703_the_blotch_loop ------------------------------
EXTENDS Naturals, FiniteSets, Sequences

NODES == {"loop_703_context", "loop_703_context_branch", "loop_703_given_gate", "loop_703_inactive", "loop_703_intervention_interdict", "loop_703_intervention_minimize", "loop_703_intervention_recognize", "loop_703_operator_branch", "loop_703_result_branch", "loop_703_sink", "loop_703_start", "loop_703_taxonomy_branch", "loop_703_then_branch", "loop_703_verdict", "loop_703_when_gate"}
ROOTS == {"loop_703_start"}
TERMINALS == {"loop_703_sink"}
FOLD_TARGETS == {"loop_703_verdict"}
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
  /\ CanFire({"loop_703_start"})
  /\ active' = UpdateActive({"loop_703_start"}, {"loop_703_given_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_703_given_gate"} \cap FOLD_TARGETS # {})
Edge_02_PROCESS ==
  /\ CanFire({"loop_703_given_gate"})
  /\ active' = UpdateActive({"loop_703_given_gate"}, {"loop_703_when_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_703_when_gate"} \cap FOLD_TARGETS # {})
Edge_03_PROCESS ==
  /\ CanFire({"loop_703_given_gate"})
  /\ active' = UpdateActive({"loop_703_given_gate"}, {"loop_703_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_703_inactive"} \cap FOLD_TARGETS # {})
Edge_04_PROCESS ==
  /\ CanFire({"loop_703_when_gate"})
  /\ active' = UpdateActive({"loop_703_when_gate"}, {"loop_703_context"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_703_context"} \cap FOLD_TARGETS # {})
Edge_05_PROCESS ==
  /\ CanFire({"loop_703_when_gate"})
  /\ active' = UpdateActive({"loop_703_when_gate"}, {"loop_703_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_703_inactive"} \cap FOLD_TARGETS # {})
Edge_06_FORK ==
  /\ CanFire({"loop_703_context"})
  /\ active' = UpdateActive({"loop_703_context"}, {"loop_703_context_branch", "loop_703_then_branch", "loop_703_operator_branch", "loop_703_result_branch", "loop_703_taxonomy_branch", "loop_703_intervention_recognize", "loop_703_intervention_interdict", "loop_703_intervention_minimize"})
  /\ beta1' = beta1 + (Cardinality({"loop_703_context_branch", "loop_703_then_branch", "loop_703_operator_branch", "loop_703_result_branch", "loop_703_taxonomy_branch", "loop_703_intervention_recognize", "loop_703_intervention_interdict", "loop_703_intervention_minimize"}) - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_703_context_branch", "loop_703_then_branch", "loop_703_operator_branch", "loop_703_result_branch", "loop_703_taxonomy_branch", "loop_703_intervention_recognize", "loop_703_intervention_interdict", "loop_703_intervention_minimize"} \cap FOLD_TARGETS # {})
Edge_07_FOLD ==
  /\ CanFire({"loop_703_context_branch", "loop_703_then_branch", "loop_703_operator_branch", "loop_703_result_branch", "loop_703_taxonomy_branch", "loop_703_intervention_recognize", "loop_703_intervention_interdict", "loop_703_intervention_minimize"})
  /\ active' = UpdateActive({"loop_703_context_branch", "loop_703_then_branch", "loop_703_operator_branch", "loop_703_result_branch", "loop_703_taxonomy_branch", "loop_703_intervention_recognize", "loop_703_intervention_interdict", "loop_703_intervention_minimize"}, {"loop_703_verdict"})
  /\ beta1' = 0
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_703_verdict"} \cap FOLD_TARGETS # {})
Edge_08_PROCESS ==
  /\ CanFire({"loop_703_inactive"})
  /\ active' = UpdateActive({"loop_703_inactive"}, {"loop_703_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_703_sink"} \cap FOLD_TARGETS # {})
Edge_09_PROCESS ==
  /\ CanFire({"loop_703_verdict"})
  /\ active' = UpdateActive({"loop_703_verdict"}, {"loop_703_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_703_sink"} \cap FOLD_TARGETS # {})
Edge_10_INTERFERE ==
  /\ CanFire({"loop_703_intervention_recognize"})
  /\ active' = UpdateActive({"loop_703_intervention_recognize"}, {"loop_703_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_703_then_branch"} \cap FOLD_TARGETS # {})
Edge_11_INTERFERE ==
  /\ CanFire({"loop_703_intervention_interdict"})
  /\ active' = UpdateActive({"loop_703_intervention_interdict"}, {"loop_703_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_703_then_branch"} \cap FOLD_TARGETS # {})
Edge_12_INTERFERE ==
  /\ CanFire({"loop_703_intervention_minimize"})
  /\ active' = UpdateActive({"loop_703_intervention_minimize"}, {"loop_703_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_703_then_branch"} \cap FOLD_TARGETS # {})

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
