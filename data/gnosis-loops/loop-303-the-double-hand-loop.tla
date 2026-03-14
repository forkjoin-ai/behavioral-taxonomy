------------------------------ MODULE BehaviorLoop_303_the_double_hand_loop ------------------------------
EXTENDS Naturals, FiniteSets, Sequences

NODES == {"loop_303_context", "loop_303_context_branch", "loop_303_given_gate", "loop_303_inactive", "loop_303_intervention_leverage", "loop_303_intervention_recognize", "loop_303_operator_branch", "loop_303_result_branch", "loop_303_sink", "loop_303_start", "loop_303_taxonomy_branch", "loop_303_then_branch", "loop_303_verdict", "loop_303_when_gate"}
ROOTS == {"loop_303_start"}
TERMINALS == {"loop_303_sink"}
FOLD_TARGETS == {"loop_303_verdict"}
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
  /\ CanFire({"loop_303_start"})
  /\ active' = UpdateActive({"loop_303_start"}, {"loop_303_given_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_303_given_gate"} \cap FOLD_TARGETS # {})
Edge_02_PROCESS ==
  /\ CanFire({"loop_303_given_gate"})
  /\ active' = UpdateActive({"loop_303_given_gate"}, {"loop_303_when_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_303_when_gate"} \cap FOLD_TARGETS # {})
Edge_03_PROCESS ==
  /\ CanFire({"loop_303_given_gate"})
  /\ active' = UpdateActive({"loop_303_given_gate"}, {"loop_303_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_303_inactive"} \cap FOLD_TARGETS # {})
Edge_04_PROCESS ==
  /\ CanFire({"loop_303_when_gate"})
  /\ active' = UpdateActive({"loop_303_when_gate"}, {"loop_303_context"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_303_context"} \cap FOLD_TARGETS # {})
Edge_05_PROCESS ==
  /\ CanFire({"loop_303_when_gate"})
  /\ active' = UpdateActive({"loop_303_when_gate"}, {"loop_303_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_303_inactive"} \cap FOLD_TARGETS # {})
Edge_06_FORK ==
  /\ CanFire({"loop_303_context"})
  /\ active' = UpdateActive({"loop_303_context"}, {"loop_303_context_branch", "loop_303_then_branch", "loop_303_operator_branch", "loop_303_result_branch", "loop_303_taxonomy_branch", "loop_303_intervention_recognize", "loop_303_intervention_leverage"})
  /\ beta1' = beta1 + (Cardinality({"loop_303_context_branch", "loop_303_then_branch", "loop_303_operator_branch", "loop_303_result_branch", "loop_303_taxonomy_branch", "loop_303_intervention_recognize", "loop_303_intervention_leverage"}) - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_303_context_branch", "loop_303_then_branch", "loop_303_operator_branch", "loop_303_result_branch", "loop_303_taxonomy_branch", "loop_303_intervention_recognize", "loop_303_intervention_leverage"} \cap FOLD_TARGETS # {})
Edge_07_FOLD ==
  /\ CanFire({"loop_303_context_branch", "loop_303_then_branch", "loop_303_operator_branch", "loop_303_result_branch", "loop_303_taxonomy_branch", "loop_303_intervention_recognize", "loop_303_intervention_leverage"})
  /\ active' = UpdateActive({"loop_303_context_branch", "loop_303_then_branch", "loop_303_operator_branch", "loop_303_result_branch", "loop_303_taxonomy_branch", "loop_303_intervention_recognize", "loop_303_intervention_leverage"}, {"loop_303_verdict"})
  /\ beta1' = 0
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_303_verdict"} \cap FOLD_TARGETS # {})
Edge_08_PROCESS ==
  /\ CanFire({"loop_303_inactive"})
  /\ active' = UpdateActive({"loop_303_inactive"}, {"loop_303_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_303_sink"} \cap FOLD_TARGETS # {})
Edge_09_PROCESS ==
  /\ CanFire({"loop_303_verdict"})
  /\ active' = UpdateActive({"loop_303_verdict"}, {"loop_303_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_303_sink"} \cap FOLD_TARGETS # {})
Edge_10_INTERFERE ==
  /\ CanFire({"loop_303_intervention_recognize"})
  /\ active' = UpdateActive({"loop_303_intervention_recognize"}, {"loop_303_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_303_then_branch"} \cap FOLD_TARGETS # {})
Edge_11_INTERFERE ==
  /\ CanFire({"loop_303_intervention_leverage"})
  /\ active' = UpdateActive({"loop_303_intervention_leverage"}, {"loop_303_result_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_303_result_branch"} \cap FOLD_TARGETS # {})

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
