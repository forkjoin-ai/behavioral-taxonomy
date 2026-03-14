------------------------------ MODULE BehaviorLoop_311_the_giggle_loop ------------------------------
EXTENDS Naturals, FiniteSets, Sequences

NODES == {"loop_311_context", "loop_311_context_branch", "loop_311_given_gate", "loop_311_inactive", "loop_311_intervention_interdict", "loop_311_intervention_minimize", "loop_311_intervention_recognize", "loop_311_operator_branch", "loop_311_result_branch", "loop_311_sink", "loop_311_start", "loop_311_taxonomy_branch", "loop_311_then_branch", "loop_311_verdict", "loop_311_when_gate"}
ROOTS == {"loop_311_start"}
TERMINALS == {"loop_311_sink"}
FOLD_TARGETS == {"loop_311_verdict"}
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
  /\ CanFire({"loop_311_start"})
  /\ active' = UpdateActive({"loop_311_start"}, {"loop_311_given_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_311_given_gate"} \cap FOLD_TARGETS # {})
Edge_02_PROCESS ==
  /\ CanFire({"loop_311_given_gate"})
  /\ active' = UpdateActive({"loop_311_given_gate"}, {"loop_311_when_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_311_when_gate"} \cap FOLD_TARGETS # {})
Edge_03_PROCESS ==
  /\ CanFire({"loop_311_given_gate"})
  /\ active' = UpdateActive({"loop_311_given_gate"}, {"loop_311_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_311_inactive"} \cap FOLD_TARGETS # {})
Edge_04_PROCESS ==
  /\ CanFire({"loop_311_when_gate"})
  /\ active' = UpdateActive({"loop_311_when_gate"}, {"loop_311_context"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_311_context"} \cap FOLD_TARGETS # {})
Edge_05_PROCESS ==
  /\ CanFire({"loop_311_when_gate"})
  /\ active' = UpdateActive({"loop_311_when_gate"}, {"loop_311_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_311_inactive"} \cap FOLD_TARGETS # {})
Edge_06_FORK ==
  /\ CanFire({"loop_311_context"})
  /\ active' = UpdateActive({"loop_311_context"}, {"loop_311_context_branch", "loop_311_then_branch", "loop_311_operator_branch", "loop_311_result_branch", "loop_311_taxonomy_branch", "loop_311_intervention_recognize", "loop_311_intervention_interdict", "loop_311_intervention_minimize"})
  /\ beta1' = beta1 + (Cardinality({"loop_311_context_branch", "loop_311_then_branch", "loop_311_operator_branch", "loop_311_result_branch", "loop_311_taxonomy_branch", "loop_311_intervention_recognize", "loop_311_intervention_interdict", "loop_311_intervention_minimize"}) - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_311_context_branch", "loop_311_then_branch", "loop_311_operator_branch", "loop_311_result_branch", "loop_311_taxonomy_branch", "loop_311_intervention_recognize", "loop_311_intervention_interdict", "loop_311_intervention_minimize"} \cap FOLD_TARGETS # {})
Edge_07_FOLD ==
  /\ CanFire({"loop_311_context_branch", "loop_311_then_branch", "loop_311_operator_branch", "loop_311_result_branch", "loop_311_taxonomy_branch", "loop_311_intervention_recognize", "loop_311_intervention_interdict", "loop_311_intervention_minimize"})
  /\ active' = UpdateActive({"loop_311_context_branch", "loop_311_then_branch", "loop_311_operator_branch", "loop_311_result_branch", "loop_311_taxonomy_branch", "loop_311_intervention_recognize", "loop_311_intervention_interdict", "loop_311_intervention_minimize"}, {"loop_311_verdict"})
  /\ beta1' = 0
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_311_verdict"} \cap FOLD_TARGETS # {})
Edge_08_PROCESS ==
  /\ CanFire({"loop_311_inactive"})
  /\ active' = UpdateActive({"loop_311_inactive"}, {"loop_311_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_311_sink"} \cap FOLD_TARGETS # {})
Edge_09_PROCESS ==
  /\ CanFire({"loop_311_verdict"})
  /\ active' = UpdateActive({"loop_311_verdict"}, {"loop_311_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_311_sink"} \cap FOLD_TARGETS # {})
Edge_10_INTERFERE ==
  /\ CanFire({"loop_311_intervention_recognize"})
  /\ active' = UpdateActive({"loop_311_intervention_recognize"}, {"loop_311_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_311_then_branch"} \cap FOLD_TARGETS # {})
Edge_11_INTERFERE ==
  /\ CanFire({"loop_311_intervention_interdict"})
  /\ active' = UpdateActive({"loop_311_intervention_interdict"}, {"loop_311_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_311_then_branch"} \cap FOLD_TARGETS # {})
Edge_12_INTERFERE ==
  /\ CanFire({"loop_311_intervention_minimize"})
  /\ active' = UpdateActive({"loop_311_intervention_minimize"}, {"loop_311_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_311_then_branch"} \cap FOLD_TARGETS # {})

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
