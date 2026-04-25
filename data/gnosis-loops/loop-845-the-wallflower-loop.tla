------------------------------ MODULE BehaviorLoop_845_the_wallflower_loop ------------------------------
EXTENDS Naturals, FiniteSets, Sequences

NODES == {"loop_845_context", "loop_845_context_branch", "loop_845_given_gate", "loop_845_inactive", "loop_845_intervention_interdict", "loop_845_intervention_minimize", "loop_845_intervention_recognize", "loop_845_operator_branch", "loop_845_result_branch", "loop_845_sink", "loop_845_start", "loop_845_taxonomy_branch", "loop_845_then_branch", "loop_845_verdict", "loop_845_when_gate"}
ROOTS == {"loop_845_start"}
TERMINALS == {"loop_845_sink"}
FOLD_TARGETS == {"loop_845_verdict"}
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
  /\ CanFire({"loop_845_start"})
  /\ active' = UpdateActive({"loop_845_start"}, {"loop_845_given_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_845_given_gate"} \cap FOLD_TARGETS # {})
Edge_02_PROCESS ==
  /\ CanFire({"loop_845_given_gate"})
  /\ active' = UpdateActive({"loop_845_given_gate"}, {"loop_845_when_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_845_when_gate"} \cap FOLD_TARGETS # {})
Edge_03_VENT ==
  /\ CanFire({"loop_845_given_gate"})
  /\ active' = UpdateActive({"loop_845_given_gate"}, {"loop_845_inactive"})
  /\ beta1' = Max2(0, beta1 - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_845_inactive"} \cap FOLD_TARGETS # {})
Edge_04_PROCESS ==
  /\ CanFire({"loop_845_when_gate"})
  /\ active' = UpdateActive({"loop_845_when_gate"}, {"loop_845_context"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_845_context"} \cap FOLD_TARGETS # {})
Edge_05_VENT ==
  /\ CanFire({"loop_845_when_gate"})
  /\ active' = UpdateActive({"loop_845_when_gate"}, {"loop_845_inactive"})
  /\ beta1' = Max2(0, beta1 - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_845_inactive"} \cap FOLD_TARGETS # {})
Edge_06_FORK ==
  /\ CanFire({"loop_845_context"})
  /\ active' = UpdateActive({"loop_845_context"}, {"loop_845_context_branch", "loop_845_then_branch", "loop_845_operator_branch", "loop_845_result_branch", "loop_845_taxonomy_branch", "loop_845_intervention_recognize", "loop_845_intervention_interdict", "loop_845_intervention_minimize"})
  /\ beta1' = beta1 + (Cardinality({"loop_845_context_branch", "loop_845_then_branch", "loop_845_operator_branch", "loop_845_result_branch", "loop_845_taxonomy_branch", "loop_845_intervention_recognize", "loop_845_intervention_interdict", "loop_845_intervention_minimize"}) - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_845_context_branch", "loop_845_then_branch", "loop_845_operator_branch", "loop_845_result_branch", "loop_845_taxonomy_branch", "loop_845_intervention_recognize", "loop_845_intervention_interdict", "loop_845_intervention_minimize"} \cap FOLD_TARGETS # {})
Edge_07_FOLD ==
  /\ CanFire({"loop_845_context_branch", "loop_845_then_branch", "loop_845_operator_branch", "loop_845_result_branch", "loop_845_taxonomy_branch", "loop_845_intervention_recognize", "loop_845_intervention_interdict", "loop_845_intervention_minimize"})
  /\ active' = UpdateActive({"loop_845_context_branch", "loop_845_then_branch", "loop_845_operator_branch", "loop_845_result_branch", "loop_845_taxonomy_branch", "loop_845_intervention_recognize", "loop_845_intervention_interdict", "loop_845_intervention_minimize"}, {"loop_845_verdict"})
  /\ beta1' = 0
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_845_verdict"} \cap FOLD_TARGETS # {})
Edge_08_PROCESS ==
  /\ CanFire({"loop_845_inactive"})
  /\ active' = UpdateActive({"loop_845_inactive"}, {"loop_845_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_845_sink"} \cap FOLD_TARGETS # {})
Edge_09_PROCESS ==
  /\ CanFire({"loop_845_verdict"})
  /\ active' = UpdateActive({"loop_845_verdict"}, {"loop_845_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_845_sink"} \cap FOLD_TARGETS # {})
Edge_10_MEASURE ==
  /\ CanFire({"loop_845_verdict"})
  /\ active' = UpdateActive({"loop_845_verdict"}, {"loop_845_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_845_sink"} \cap FOLD_TARGETS # {})
Edge_11_PROCESS ==
  /\ CanFire({"loop_845_intervention_recognize"})
  /\ active' = UpdateActive({"loop_845_intervention_recognize"}, {"loop_845_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_845_then_branch"} \cap FOLD_TARGETS # {})
Edge_12_PROCESS ==
  /\ CanFire({"loop_845_intervention_interdict"})
  /\ active' = UpdateActive({"loop_845_intervention_interdict"}, {"loop_845_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_845_then_branch"} \cap FOLD_TARGETS # {})
Edge_13_PROCESS ==
  /\ CanFire({"loop_845_intervention_minimize"})
  /\ active' = UpdateActive({"loop_845_intervention_minimize"}, {"loop_845_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_845_then_branch"} \cap FOLD_TARGETS # {})

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
  \/ Edge_13_PROCESS

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
