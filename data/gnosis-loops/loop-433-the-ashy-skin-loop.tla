------------------------------ MODULE BehaviorLoop_433_the_ashy_skin_loop ------------------------------
EXTENDS Naturals, FiniteSets, Sequences

NODES == {"loop_433_context", "loop_433_context_branch", "loop_433_given_gate", "loop_433_inactive", "loop_433_intervention_leverage", "loop_433_intervention_recognize", "loop_433_operator_branch", "loop_433_result_branch", "loop_433_sink", "loop_433_start", "loop_433_taxonomy_branch", "loop_433_then_branch", "loop_433_verdict", "loop_433_when_gate"}
ROOTS == {"loop_433_start"}
TERMINALS == {"loop_433_sink"}
FOLD_TARGETS == {"loop_433_verdict"}
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
  /\ CanFire({"loop_433_start"})
  /\ active' = UpdateActive({"loop_433_start"}, {"loop_433_given_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_433_given_gate"} \cap FOLD_TARGETS # {})
Edge_02_PROCESS ==
  /\ CanFire({"loop_433_given_gate"})
  /\ active' = UpdateActive({"loop_433_given_gate"}, {"loop_433_when_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_433_when_gate"} \cap FOLD_TARGETS # {})
Edge_03_PROCESS ==
  /\ CanFire({"loop_433_given_gate"})
  /\ active' = UpdateActive({"loop_433_given_gate"}, {"loop_433_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_433_inactive"} \cap FOLD_TARGETS # {})
Edge_04_PROCESS ==
  /\ CanFire({"loop_433_when_gate"})
  /\ active' = UpdateActive({"loop_433_when_gate"}, {"loop_433_context"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_433_context"} \cap FOLD_TARGETS # {})
Edge_05_PROCESS ==
  /\ CanFire({"loop_433_when_gate"})
  /\ active' = UpdateActive({"loop_433_when_gate"}, {"loop_433_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_433_inactive"} \cap FOLD_TARGETS # {})
Edge_06_FORK ==
  /\ CanFire({"loop_433_context"})
  /\ active' = UpdateActive({"loop_433_context"}, {"loop_433_context_branch", "loop_433_then_branch", "loop_433_operator_branch", "loop_433_result_branch", "loop_433_taxonomy_branch", "loop_433_intervention_recognize", "loop_433_intervention_leverage"})
  /\ beta1' = beta1 + (Cardinality({"loop_433_context_branch", "loop_433_then_branch", "loop_433_operator_branch", "loop_433_result_branch", "loop_433_taxonomy_branch", "loop_433_intervention_recognize", "loop_433_intervention_leverage"}) - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_433_context_branch", "loop_433_then_branch", "loop_433_operator_branch", "loop_433_result_branch", "loop_433_taxonomy_branch", "loop_433_intervention_recognize", "loop_433_intervention_leverage"} \cap FOLD_TARGETS # {})
Edge_07_FOLD ==
  /\ CanFire({"loop_433_context_branch", "loop_433_then_branch", "loop_433_operator_branch", "loop_433_result_branch", "loop_433_taxonomy_branch", "loop_433_intervention_recognize", "loop_433_intervention_leverage"})
  /\ active' = UpdateActive({"loop_433_context_branch", "loop_433_then_branch", "loop_433_operator_branch", "loop_433_result_branch", "loop_433_taxonomy_branch", "loop_433_intervention_recognize", "loop_433_intervention_leverage"}, {"loop_433_verdict"})
  /\ beta1' = 0
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_433_verdict"} \cap FOLD_TARGETS # {})
Edge_08_PROCESS ==
  /\ CanFire({"loop_433_inactive"})
  /\ active' = UpdateActive({"loop_433_inactive"}, {"loop_433_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_433_sink"} \cap FOLD_TARGETS # {})
Edge_09_PROCESS ==
  /\ CanFire({"loop_433_verdict"})
  /\ active' = UpdateActive({"loop_433_verdict"}, {"loop_433_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_433_sink"} \cap FOLD_TARGETS # {})
Edge_10_INTERFERE ==
  /\ CanFire({"loop_433_intervention_recognize"})
  /\ active' = UpdateActive({"loop_433_intervention_recognize"}, {"loop_433_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_433_then_branch"} \cap FOLD_TARGETS # {})
Edge_11_INTERFERE ==
  /\ CanFire({"loop_433_intervention_leverage"})
  /\ active' = UpdateActive({"loop_433_intervention_leverage"}, {"loop_433_result_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_433_result_branch"} \cap FOLD_TARGETS # {})

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
