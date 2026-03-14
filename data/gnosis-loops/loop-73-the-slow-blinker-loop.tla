------------------------------ MODULE BehaviorLoop_73_the_slow_blinker_loop ------------------------------
EXTENDS Naturals, FiniteSets, Sequences

NODES == {"loop_73_context", "loop_73_context_branch", "loop_73_given_gate", "loop_73_inactive", "loop_73_intervention_leverage", "loop_73_intervention_recognize", "loop_73_operator_branch", "loop_73_result_branch", "loop_73_sink", "loop_73_start", "loop_73_taxonomy_branch", "loop_73_then_branch", "loop_73_verdict", "loop_73_when_gate"}
ROOTS == {"loop_73_start"}
TERMINALS == {"loop_73_sink"}
FOLD_TARGETS == {"loop_73_verdict"}
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
  /\ CanFire({"loop_73_start"})
  /\ active' = UpdateActive({"loop_73_start"}, {"loop_73_given_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_73_given_gate"} \cap FOLD_TARGETS # {})
Edge_02_PROCESS ==
  /\ CanFire({"loop_73_given_gate"})
  /\ active' = UpdateActive({"loop_73_given_gate"}, {"loop_73_when_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_73_when_gate"} \cap FOLD_TARGETS # {})
Edge_03_PROCESS ==
  /\ CanFire({"loop_73_given_gate"})
  /\ active' = UpdateActive({"loop_73_given_gate"}, {"loop_73_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_73_inactive"} \cap FOLD_TARGETS # {})
Edge_04_PROCESS ==
  /\ CanFire({"loop_73_when_gate"})
  /\ active' = UpdateActive({"loop_73_when_gate"}, {"loop_73_context"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_73_context"} \cap FOLD_TARGETS # {})
Edge_05_PROCESS ==
  /\ CanFire({"loop_73_when_gate"})
  /\ active' = UpdateActive({"loop_73_when_gate"}, {"loop_73_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_73_inactive"} \cap FOLD_TARGETS # {})
Edge_06_FORK ==
  /\ CanFire({"loop_73_context"})
  /\ active' = UpdateActive({"loop_73_context"}, {"loop_73_context_branch", "loop_73_then_branch", "loop_73_operator_branch", "loop_73_result_branch", "loop_73_taxonomy_branch", "loop_73_intervention_recognize", "loop_73_intervention_leverage"})
  /\ beta1' = beta1 + (Cardinality({"loop_73_context_branch", "loop_73_then_branch", "loop_73_operator_branch", "loop_73_result_branch", "loop_73_taxonomy_branch", "loop_73_intervention_recognize", "loop_73_intervention_leverage"}) - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_73_context_branch", "loop_73_then_branch", "loop_73_operator_branch", "loop_73_result_branch", "loop_73_taxonomy_branch", "loop_73_intervention_recognize", "loop_73_intervention_leverage"} \cap FOLD_TARGETS # {})
Edge_07_FOLD ==
  /\ CanFire({"loop_73_context_branch", "loop_73_then_branch", "loop_73_operator_branch", "loop_73_result_branch", "loop_73_taxonomy_branch", "loop_73_intervention_recognize", "loop_73_intervention_leverage"})
  /\ active' = UpdateActive({"loop_73_context_branch", "loop_73_then_branch", "loop_73_operator_branch", "loop_73_result_branch", "loop_73_taxonomy_branch", "loop_73_intervention_recognize", "loop_73_intervention_leverage"}, {"loop_73_verdict"})
  /\ beta1' = 0
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_73_verdict"} \cap FOLD_TARGETS # {})
Edge_08_PROCESS ==
  /\ CanFire({"loop_73_inactive"})
  /\ active' = UpdateActive({"loop_73_inactive"}, {"loop_73_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_73_sink"} \cap FOLD_TARGETS # {})
Edge_09_PROCESS ==
  /\ CanFire({"loop_73_verdict"})
  /\ active' = UpdateActive({"loop_73_verdict"}, {"loop_73_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_73_sink"} \cap FOLD_TARGETS # {})
Edge_10_INTERFERE ==
  /\ CanFire({"loop_73_intervention_recognize"})
  /\ active' = UpdateActive({"loop_73_intervention_recognize"}, {"loop_73_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_73_then_branch"} \cap FOLD_TARGETS # {})
Edge_11_INTERFERE ==
  /\ CanFire({"loop_73_intervention_leverage"})
  /\ active' = UpdateActive({"loop_73_intervention_leverage"}, {"loop_73_result_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_73_result_branch"} \cap FOLD_TARGETS # {})

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
