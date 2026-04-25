------------------------------ MODULE BehaviorLoop_957_the_donut_loop ------------------------------
EXTENDS Naturals, FiniteSets, Sequences

NODES == {"loop_957_context", "loop_957_context_branch", "loop_957_given_gate", "loop_957_inactive", "loop_957_intervention_interdict", "loop_957_intervention_minimize", "loop_957_intervention_recognize", "loop_957_operator_branch", "loop_957_result_branch", "loop_957_sink", "loop_957_start", "loop_957_taxonomy_branch", "loop_957_then_branch", "loop_957_verdict", "loop_957_when_gate"}
ROOTS == {"loop_957_start"}
TERMINALS == {"loop_957_sink"}
FOLD_TARGETS == {"loop_957_verdict"}
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
  /\ CanFire({"loop_957_start"})
  /\ active' = UpdateActive({"loop_957_start"}, {"loop_957_given_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_957_given_gate"} \cap FOLD_TARGETS # {})
Edge_02_PROCESS ==
  /\ CanFire({"loop_957_given_gate"})
  /\ active' = UpdateActive({"loop_957_given_gate"}, {"loop_957_when_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_957_when_gate"} \cap FOLD_TARGETS # {})
Edge_03_VENT ==
  /\ CanFire({"loop_957_given_gate"})
  /\ active' = UpdateActive({"loop_957_given_gate"}, {"loop_957_inactive"})
  /\ beta1' = Max2(0, beta1 - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_957_inactive"} \cap FOLD_TARGETS # {})
Edge_04_PROCESS ==
  /\ CanFire({"loop_957_when_gate"})
  /\ active' = UpdateActive({"loop_957_when_gate"}, {"loop_957_context"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_957_context"} \cap FOLD_TARGETS # {})
Edge_05_VENT ==
  /\ CanFire({"loop_957_when_gate"})
  /\ active' = UpdateActive({"loop_957_when_gate"}, {"loop_957_inactive"})
  /\ beta1' = Max2(0, beta1 - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_957_inactive"} \cap FOLD_TARGETS # {})
Edge_06_FORK ==
  /\ CanFire({"loop_957_context"})
  /\ active' = UpdateActive({"loop_957_context"}, {"loop_957_context_branch", "loop_957_then_branch", "loop_957_operator_branch", "loop_957_result_branch", "loop_957_taxonomy_branch", "loop_957_intervention_recognize", "loop_957_intervention_interdict", "loop_957_intervention_minimize"})
  /\ beta1' = beta1 + (Cardinality({"loop_957_context_branch", "loop_957_then_branch", "loop_957_operator_branch", "loop_957_result_branch", "loop_957_taxonomy_branch", "loop_957_intervention_recognize", "loop_957_intervention_interdict", "loop_957_intervention_minimize"}) - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_957_context_branch", "loop_957_then_branch", "loop_957_operator_branch", "loop_957_result_branch", "loop_957_taxonomy_branch", "loop_957_intervention_recognize", "loop_957_intervention_interdict", "loop_957_intervention_minimize"} \cap FOLD_TARGETS # {})
Edge_07_FOLD ==
  /\ CanFire({"loop_957_context_branch", "loop_957_then_branch", "loop_957_operator_branch", "loop_957_result_branch", "loop_957_taxonomy_branch", "loop_957_intervention_recognize", "loop_957_intervention_interdict", "loop_957_intervention_minimize"})
  /\ active' = UpdateActive({"loop_957_context_branch", "loop_957_then_branch", "loop_957_operator_branch", "loop_957_result_branch", "loop_957_taxonomy_branch", "loop_957_intervention_recognize", "loop_957_intervention_interdict", "loop_957_intervention_minimize"}, {"loop_957_verdict"})
  /\ beta1' = 0
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_957_verdict"} \cap FOLD_TARGETS # {})
Edge_08_PROCESS ==
  /\ CanFire({"loop_957_inactive"})
  /\ active' = UpdateActive({"loop_957_inactive"}, {"loop_957_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_957_sink"} \cap FOLD_TARGETS # {})
Edge_09_PROCESS ==
  /\ CanFire({"loop_957_verdict"})
  /\ active' = UpdateActive({"loop_957_verdict"}, {"loop_957_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_957_sink"} \cap FOLD_TARGETS # {})
Edge_10_MEASURE ==
  /\ CanFire({"loop_957_verdict"})
  /\ active' = UpdateActive({"loop_957_verdict"}, {"loop_957_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_957_sink"} \cap FOLD_TARGETS # {})
Edge_11_PROCESS ==
  /\ CanFire({"loop_957_intervention_recognize"})
  /\ active' = UpdateActive({"loop_957_intervention_recognize"}, {"loop_957_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_957_then_branch"} \cap FOLD_TARGETS # {})
Edge_12_PROCESS ==
  /\ CanFire({"loop_957_intervention_interdict"})
  /\ active' = UpdateActive({"loop_957_intervention_interdict"}, {"loop_957_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_957_then_branch"} \cap FOLD_TARGETS # {})
Edge_13_PROCESS ==
  /\ CanFire({"loop_957_intervention_minimize"})
  /\ active' = UpdateActive({"loop_957_intervention_minimize"}, {"loop_957_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_957_then_branch"} \cap FOLD_TARGETS # {})

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
