------------------------------ MODULE BehaviorLoop_982_the_sneak_loop ------------------------------
EXTENDS Naturals, FiniteSets, Sequences

NODES == {"loop_982_context", "loop_982_context_branch", "loop_982_given_gate", "loop_982_inactive", "loop_982_intervention_leverage", "loop_982_intervention_recognize", "loop_982_operator_branch", "loop_982_result_branch", "loop_982_sink", "loop_982_start", "loop_982_taxonomy_branch", "loop_982_then_branch", "loop_982_verdict", "loop_982_when_gate"}
ROOTS == {"loop_982_start"}
TERMINALS == {"loop_982_sink"}
FOLD_TARGETS == {"loop_982_verdict"}
CORRIDOR_TARGETS == {}
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
  /\ CanFire({"loop_982_start"})
  /\ active' = UpdateActive({"loop_982_start"}, {"loop_982_given_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_982_given_gate"} \cap FOLD_TARGETS # {})
Edge_02_PROCESS ==
  /\ CanFire({"loop_982_given_gate"})
  /\ active' = UpdateActive({"loop_982_given_gate"}, {"loop_982_when_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_982_when_gate"} \cap FOLD_TARGETS # {})
Edge_03_VENT ==
  /\ CanFire({"loop_982_given_gate"})
  /\ active' = UpdateActive({"loop_982_given_gate"}, {"loop_982_inactive"})
  /\ beta1' = Max2(0, beta1 - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_982_inactive"} \cap FOLD_TARGETS # {})
Edge_04_PROCESS ==
  /\ CanFire({"loop_982_when_gate"})
  /\ active' = UpdateActive({"loop_982_when_gate"}, {"loop_982_context"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_982_context"} \cap FOLD_TARGETS # {})
Edge_05_VENT ==
  /\ CanFire({"loop_982_when_gate"})
  /\ active' = UpdateActive({"loop_982_when_gate"}, {"loop_982_inactive"})
  /\ beta1' = Max2(0, beta1 - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_982_inactive"} \cap FOLD_TARGETS # {})
Edge_06_FORK ==
  /\ CanFire({"loop_982_context"})
  /\ active' = UpdateActive({"loop_982_context"}, {"loop_982_context_branch", "loop_982_then_branch", "loop_982_operator_branch", "loop_982_result_branch", "loop_982_taxonomy_branch", "loop_982_intervention_recognize", "loop_982_intervention_leverage"})
  /\ beta1' = beta1 + (Cardinality({"loop_982_context_branch", "loop_982_then_branch", "loop_982_operator_branch", "loop_982_result_branch", "loop_982_taxonomy_branch", "loop_982_intervention_recognize", "loop_982_intervention_leverage"}) - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_982_context_branch", "loop_982_then_branch", "loop_982_operator_branch", "loop_982_result_branch", "loop_982_taxonomy_branch", "loop_982_intervention_recognize", "loop_982_intervention_leverage"} \cap FOLD_TARGETS # {})
Edge_07_FOLD ==
  /\ CanFire({"loop_982_context_branch", "loop_982_then_branch", "loop_982_operator_branch", "loop_982_result_branch", "loop_982_taxonomy_branch", "loop_982_intervention_recognize", "loop_982_intervention_leverage"})
  /\ active' = UpdateActive({"loop_982_context_branch", "loop_982_then_branch", "loop_982_operator_branch", "loop_982_result_branch", "loop_982_taxonomy_branch", "loop_982_intervention_recognize", "loop_982_intervention_leverage"}, {"loop_982_verdict"})
  /\ beta1' = 0
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_982_verdict"} \cap FOLD_TARGETS # {})
Edge_08_PROCESS ==
  /\ CanFire({"loop_982_inactive"})
  /\ active' = UpdateActive({"loop_982_inactive"}, {"loop_982_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_982_sink"} \cap FOLD_TARGETS # {})
Edge_09_PROCESS ==
  /\ CanFire({"loop_982_verdict"})
  /\ active' = UpdateActive({"loop_982_verdict"}, {"loop_982_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_982_sink"} \cap FOLD_TARGETS # {})
Edge_10_MEASURE ==
  /\ CanFire({"loop_982_verdict"})
  /\ active' = UpdateActive({"loop_982_verdict"}, {"loop_982_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_982_sink"} \cap FOLD_TARGETS # {})
Edge_11_PROCESS ==
  /\ CanFire({"loop_982_intervention_recognize"})
  /\ active' = UpdateActive({"loop_982_intervention_recognize"}, {"loop_982_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_982_then_branch"} \cap FOLD_TARGETS # {})
Edge_12_PROCESS ==
  /\ CanFire({"loop_982_intervention_leverage"})
  /\ active' = UpdateActive({"loop_982_intervention_leverage"}, {"loop_982_result_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_982_result_branch"} \cap FOLD_TARGETS # {})

Next ==
  \/ Edge_01_PROCESS
  \/ Edge_02_PROCESS
  \/ Edge_03_VENT
  \/ Edge_04_PROCESS
  \/ Edge_05_VENT
  \/ Edge_06_FORK
  \/ Edge_07_FOLD
  \/ Edge_08_PROCESS
  \/ Edge_09_PROCESS
  \/ Edge_10_MEASURE
  \/ Edge_11_PROCESS
  \/ Edge_12_PROCESS

TypeInvariant ==
  /\ active \subseteq NODES
  /\ beta1 \in Nat
  /\ payloadPresent \in BOOLEAN
  /\ consensusReached \in BOOLEAN

NoLostPayloadInvariant == payloadPresent = TRUE
HasFoldTargets == FOLD_TARGETS # {}
HasCorridorTargets == CORRIDOR_TARGETS # {}
EventuallyTerminal == <> (active \cap TERMINALS # {})
EventuallyConsensus == IF HasFoldTargets THEN <> consensusReached ELSE TRUE
EventuallyMiddleOutCompression == IF HasCorridorTargets THEN <> (active \cap CORRIDOR_TARGETS # {}) ELSE TRUE
FirstSufficientCompression == IF HasCorridorTargets THEN <> ((active \cap CORRIDOR_TARGETS # {}) /\ beta1 <= Cardinality(CORRIDOR_TARGETS)) ELSE TRUE
DeadlockFree == []<>(ENABLED Next)

Spec ==
  /\ Init
  /\ [][Next]_vars
  /\ WF_vars(Next)

THEOREM Spec => []NoLostPayloadInvariant

=============================================================================
