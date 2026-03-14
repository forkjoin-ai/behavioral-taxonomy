------------------------------ MODULE BehaviorLoop_3401_the_misunderstood_victim_fi_ni_loop ------------------------------
EXTENDS Naturals, FiniteSets, Sequences

NODES == {"loop_3401_context", "loop_3401_context_branch", "loop_3401_given_gate", "loop_3401_inactive", "loop_3401_intervention_interdict", "loop_3401_intervention_minimize", "loop_3401_intervention_recognize", "loop_3401_operator_branch", "loop_3401_result_branch", "loop_3401_sink", "loop_3401_start", "loop_3401_taxonomy_branch", "loop_3401_then_branch", "loop_3401_verdict", "loop_3401_when_gate"}
ROOTS == {"loop_3401_start"}
TERMINALS == {"loop_3401_sink"}
FOLD_TARGETS == {"loop_3401_verdict"}
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
  /\ CanFire({"loop_3401_start"})
  /\ active' = UpdateActive({"loop_3401_start"}, {"loop_3401_given_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_3401_given_gate"} \cap FOLD_TARGETS # {})
Edge_02_PROCESS ==
  /\ CanFire({"loop_3401_given_gate"})
  /\ active' = UpdateActive({"loop_3401_given_gate"}, {"loop_3401_when_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_3401_when_gate"} \cap FOLD_TARGETS # {})
Edge_03_PROCESS ==
  /\ CanFire({"loop_3401_given_gate"})
  /\ active' = UpdateActive({"loop_3401_given_gate"}, {"loop_3401_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_3401_inactive"} \cap FOLD_TARGETS # {})
Edge_04_PROCESS ==
  /\ CanFire({"loop_3401_when_gate"})
  /\ active' = UpdateActive({"loop_3401_when_gate"}, {"loop_3401_context"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_3401_context"} \cap FOLD_TARGETS # {})
Edge_05_PROCESS ==
  /\ CanFire({"loop_3401_when_gate"})
  /\ active' = UpdateActive({"loop_3401_when_gate"}, {"loop_3401_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_3401_inactive"} \cap FOLD_TARGETS # {})
Edge_06_FORK ==
  /\ CanFire({"loop_3401_context"})
  /\ active' = UpdateActive({"loop_3401_context"}, {"loop_3401_context_branch", "loop_3401_then_branch", "loop_3401_operator_branch", "loop_3401_result_branch", "loop_3401_taxonomy_branch", "loop_3401_intervention_recognize", "loop_3401_intervention_interdict", "loop_3401_intervention_minimize"})
  /\ beta1' = beta1 + (Cardinality({"loop_3401_context_branch", "loop_3401_then_branch", "loop_3401_operator_branch", "loop_3401_result_branch", "loop_3401_taxonomy_branch", "loop_3401_intervention_recognize", "loop_3401_intervention_interdict", "loop_3401_intervention_minimize"}) - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_3401_context_branch", "loop_3401_then_branch", "loop_3401_operator_branch", "loop_3401_result_branch", "loop_3401_taxonomy_branch", "loop_3401_intervention_recognize", "loop_3401_intervention_interdict", "loop_3401_intervention_minimize"} \cap FOLD_TARGETS # {})
Edge_07_FOLD ==
  /\ CanFire({"loop_3401_context_branch", "loop_3401_then_branch", "loop_3401_operator_branch", "loop_3401_result_branch", "loop_3401_taxonomy_branch", "loop_3401_intervention_recognize", "loop_3401_intervention_interdict", "loop_3401_intervention_minimize"})
  /\ active' = UpdateActive({"loop_3401_context_branch", "loop_3401_then_branch", "loop_3401_operator_branch", "loop_3401_result_branch", "loop_3401_taxonomy_branch", "loop_3401_intervention_recognize", "loop_3401_intervention_interdict", "loop_3401_intervention_minimize"}, {"loop_3401_verdict"})
  /\ beta1' = 0
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_3401_verdict"} \cap FOLD_TARGETS # {})
Edge_08_PROCESS ==
  /\ CanFire({"loop_3401_inactive"})
  /\ active' = UpdateActive({"loop_3401_inactive"}, {"loop_3401_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_3401_sink"} \cap FOLD_TARGETS # {})
Edge_09_PROCESS ==
  /\ CanFire({"loop_3401_verdict"})
  /\ active' = UpdateActive({"loop_3401_verdict"}, {"loop_3401_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_3401_sink"} \cap FOLD_TARGETS # {})
Edge_10_INTERFERE ==
  /\ CanFire({"loop_3401_intervention_recognize"})
  /\ active' = UpdateActive({"loop_3401_intervention_recognize"}, {"loop_3401_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_3401_then_branch"} \cap FOLD_TARGETS # {})
Edge_11_INTERFERE ==
  /\ CanFire({"loop_3401_intervention_interdict"})
  /\ active' = UpdateActive({"loop_3401_intervention_interdict"}, {"loop_3401_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_3401_then_branch"} \cap FOLD_TARGETS # {})
Edge_12_INTERFERE ==
  /\ CanFire({"loop_3401_intervention_minimize"})
  /\ active' = UpdateActive({"loop_3401_intervention_minimize"}, {"loop_3401_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_3401_then_branch"} \cap FOLD_TARGETS # {})

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
