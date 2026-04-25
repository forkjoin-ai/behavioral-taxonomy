------------------------------ MODULE BehaviorLoop_263_the_tripping_loop ------------------------------
EXTENDS Naturals, FiniteSets, Sequences

NODES == {"loop_263_context", "loop_263_context_branch", "loop_263_given_gate", "loop_263_inactive", "loop_263_intervention_leverage", "loop_263_intervention_recognize", "loop_263_operator_branch", "loop_263_result_branch", "loop_263_sink", "loop_263_start", "loop_263_taxonomy_branch", "loop_263_then_branch", "loop_263_verdict", "loop_263_when_gate"}
ROOTS == {"loop_263_start"}
TERMINALS == {"loop_263_sink"}
FOLD_TARGETS == {"loop_263_verdict"}
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
  /\ CanFire({"loop_263_start"})
  /\ active' = UpdateActive({"loop_263_start"}, {"loop_263_given_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_263_given_gate"} \cap FOLD_TARGETS # {})
Edge_02_PROCESS ==
  /\ CanFire({"loop_263_given_gate"})
  /\ active' = UpdateActive({"loop_263_given_gate"}, {"loop_263_when_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_263_when_gate"} \cap FOLD_TARGETS # {})
Edge_03_VENT ==
  /\ CanFire({"loop_263_given_gate"})
  /\ active' = UpdateActive({"loop_263_given_gate"}, {"loop_263_inactive"})
  /\ beta1' = Max2(0, beta1 - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_263_inactive"} \cap FOLD_TARGETS # {})
Edge_04_PROCESS ==
  /\ CanFire({"loop_263_when_gate"})
  /\ active' = UpdateActive({"loop_263_when_gate"}, {"loop_263_context"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_263_context"} \cap FOLD_TARGETS # {})
Edge_05_VENT ==
  /\ CanFire({"loop_263_when_gate"})
  /\ active' = UpdateActive({"loop_263_when_gate"}, {"loop_263_inactive"})
  /\ beta1' = Max2(0, beta1 - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_263_inactive"} \cap FOLD_TARGETS # {})
Edge_06_FORK ==
  /\ CanFire({"loop_263_context"})
  /\ active' = UpdateActive({"loop_263_context"}, {"loop_263_context_branch", "loop_263_then_branch", "loop_263_operator_branch", "loop_263_result_branch", "loop_263_taxonomy_branch", "loop_263_intervention_recognize", "loop_263_intervention_leverage"})
  /\ beta1' = beta1 + (Cardinality({"loop_263_context_branch", "loop_263_then_branch", "loop_263_operator_branch", "loop_263_result_branch", "loop_263_taxonomy_branch", "loop_263_intervention_recognize", "loop_263_intervention_leverage"}) - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_263_context_branch", "loop_263_then_branch", "loop_263_operator_branch", "loop_263_result_branch", "loop_263_taxonomy_branch", "loop_263_intervention_recognize", "loop_263_intervention_leverage"} \cap FOLD_TARGETS # {})
Edge_07_FOLD ==
  /\ CanFire({"loop_263_context_branch", "loop_263_then_branch", "loop_263_operator_branch", "loop_263_result_branch", "loop_263_taxonomy_branch", "loop_263_intervention_recognize", "loop_263_intervention_leverage"})
  /\ active' = UpdateActive({"loop_263_context_branch", "loop_263_then_branch", "loop_263_operator_branch", "loop_263_result_branch", "loop_263_taxonomy_branch", "loop_263_intervention_recognize", "loop_263_intervention_leverage"}, {"loop_263_verdict"})
  /\ beta1' = 0
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_263_verdict"} \cap FOLD_TARGETS # {})
Edge_08_PROCESS ==
  /\ CanFire({"loop_263_inactive"})
  /\ active' = UpdateActive({"loop_263_inactive"}, {"loop_263_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_263_sink"} \cap FOLD_TARGETS # {})
Edge_09_PROCESS ==
  /\ CanFire({"loop_263_verdict"})
  /\ active' = UpdateActive({"loop_263_verdict"}, {"loop_263_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_263_sink"} \cap FOLD_TARGETS # {})
Edge_10_MEASURE ==
  /\ CanFire({"loop_263_verdict"})
  /\ active' = UpdateActive({"loop_263_verdict"}, {"loop_263_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_263_sink"} \cap FOLD_TARGETS # {})
Edge_11_PROCESS ==
  /\ CanFire({"loop_263_intervention_recognize"})
  /\ active' = UpdateActive({"loop_263_intervention_recognize"}, {"loop_263_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_263_then_branch"} \cap FOLD_TARGETS # {})
Edge_12_PROCESS ==
  /\ CanFire({"loop_263_intervention_leverage"})
  /\ active' = UpdateActive({"loop_263_intervention_leverage"}, {"loop_263_result_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_263_result_branch"} \cap FOLD_TARGETS # {})

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
