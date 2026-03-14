------------------------------ MODULE BehaviorLoop_728_the_arm_cross_loop ------------------------------
EXTENDS Naturals, FiniteSets, Sequences

NODES == {"loop_728_context", "loop_728_context_branch", "loop_728_given_gate", "loop_728_inactive", "loop_728_intervention_interdict", "loop_728_intervention_minimize", "loop_728_intervention_recognize", "loop_728_operator_branch", "loop_728_result_branch", "loop_728_sink", "loop_728_start", "loop_728_taxonomy_branch", "loop_728_then_branch", "loop_728_verdict", "loop_728_when_gate"}
ROOTS == {"loop_728_start"}
TERMINALS == {"loop_728_sink"}
FOLD_TARGETS == {"loop_728_verdict"}
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
  /\ CanFire({"loop_728_start"})
  /\ active' = UpdateActive({"loop_728_start"}, {"loop_728_given_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_728_given_gate"} \cap FOLD_TARGETS # {})
Edge_02_PROCESS ==
  /\ CanFire({"loop_728_given_gate"})
  /\ active' = UpdateActive({"loop_728_given_gate"}, {"loop_728_when_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_728_when_gate"} \cap FOLD_TARGETS # {})
Edge_03_PROCESS ==
  /\ CanFire({"loop_728_given_gate"})
  /\ active' = UpdateActive({"loop_728_given_gate"}, {"loop_728_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_728_inactive"} \cap FOLD_TARGETS # {})
Edge_04_PROCESS ==
  /\ CanFire({"loop_728_when_gate"})
  /\ active' = UpdateActive({"loop_728_when_gate"}, {"loop_728_context"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_728_context"} \cap FOLD_TARGETS # {})
Edge_05_PROCESS ==
  /\ CanFire({"loop_728_when_gate"})
  /\ active' = UpdateActive({"loop_728_when_gate"}, {"loop_728_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_728_inactive"} \cap FOLD_TARGETS # {})
Edge_06_FORK ==
  /\ CanFire({"loop_728_context"})
  /\ active' = UpdateActive({"loop_728_context"}, {"loop_728_context_branch", "loop_728_then_branch", "loop_728_operator_branch", "loop_728_result_branch", "loop_728_taxonomy_branch", "loop_728_intervention_recognize", "loop_728_intervention_interdict", "loop_728_intervention_minimize"})
  /\ beta1' = beta1 + (Cardinality({"loop_728_context_branch", "loop_728_then_branch", "loop_728_operator_branch", "loop_728_result_branch", "loop_728_taxonomy_branch", "loop_728_intervention_recognize", "loop_728_intervention_interdict", "loop_728_intervention_minimize"}) - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_728_context_branch", "loop_728_then_branch", "loop_728_operator_branch", "loop_728_result_branch", "loop_728_taxonomy_branch", "loop_728_intervention_recognize", "loop_728_intervention_interdict", "loop_728_intervention_minimize"} \cap FOLD_TARGETS # {})
Edge_07_FOLD ==
  /\ CanFire({"loop_728_context_branch", "loop_728_then_branch", "loop_728_operator_branch", "loop_728_result_branch", "loop_728_taxonomy_branch", "loop_728_intervention_recognize", "loop_728_intervention_interdict", "loop_728_intervention_minimize"})
  /\ active' = UpdateActive({"loop_728_context_branch", "loop_728_then_branch", "loop_728_operator_branch", "loop_728_result_branch", "loop_728_taxonomy_branch", "loop_728_intervention_recognize", "loop_728_intervention_interdict", "loop_728_intervention_minimize"}, {"loop_728_verdict"})
  /\ beta1' = 0
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_728_verdict"} \cap FOLD_TARGETS # {})
Edge_08_PROCESS ==
  /\ CanFire({"loop_728_inactive"})
  /\ active' = UpdateActive({"loop_728_inactive"}, {"loop_728_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_728_sink"} \cap FOLD_TARGETS # {})
Edge_09_PROCESS ==
  /\ CanFire({"loop_728_verdict"})
  /\ active' = UpdateActive({"loop_728_verdict"}, {"loop_728_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_728_sink"} \cap FOLD_TARGETS # {})
Edge_10_INTERFERE ==
  /\ CanFire({"loop_728_intervention_recognize"})
  /\ active' = UpdateActive({"loop_728_intervention_recognize"}, {"loop_728_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_728_then_branch"} \cap FOLD_TARGETS # {})
Edge_11_INTERFERE ==
  /\ CanFire({"loop_728_intervention_interdict"})
  /\ active' = UpdateActive({"loop_728_intervention_interdict"}, {"loop_728_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_728_then_branch"} \cap FOLD_TARGETS # {})
Edge_12_INTERFERE ==
  /\ CanFire({"loop_728_intervention_minimize"})
  /\ active' = UpdateActive({"loop_728_intervention_minimize"}, {"loop_728_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_728_then_branch"} \cap FOLD_TARGETS # {})

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
