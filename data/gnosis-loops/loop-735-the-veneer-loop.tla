------------------------------ MODULE BehaviorLoop_735_the_veneer_loop ------------------------------
EXTENDS Naturals, FiniteSets, Sequences

NODES == {"loop_735_context", "loop_735_context_branch", "loop_735_given_gate", "loop_735_inactive", "loop_735_intervention_leverage", "loop_735_intervention_recognize", "loop_735_operator_branch", "loop_735_result_branch", "loop_735_sink", "loop_735_start", "loop_735_taxonomy_branch", "loop_735_then_branch", "loop_735_verdict", "loop_735_when_gate"}
ROOTS == {"loop_735_start"}
TERMINALS == {"loop_735_sink"}
FOLD_TARGETS == {"loop_735_verdict"}
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
  /\ CanFire({"loop_735_start"})
  /\ active' = UpdateActive({"loop_735_start"}, {"loop_735_given_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_735_given_gate"} \cap FOLD_TARGETS # {})
Edge_02_PROCESS ==
  /\ CanFire({"loop_735_given_gate"})
  /\ active' = UpdateActive({"loop_735_given_gate"}, {"loop_735_when_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_735_when_gate"} \cap FOLD_TARGETS # {})
Edge_03_PROCESS ==
  /\ CanFire({"loop_735_given_gate"})
  /\ active' = UpdateActive({"loop_735_given_gate"}, {"loop_735_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_735_inactive"} \cap FOLD_TARGETS # {})
Edge_04_PROCESS ==
  /\ CanFire({"loop_735_when_gate"})
  /\ active' = UpdateActive({"loop_735_when_gate"}, {"loop_735_context"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_735_context"} \cap FOLD_TARGETS # {})
Edge_05_PROCESS ==
  /\ CanFire({"loop_735_when_gate"})
  /\ active' = UpdateActive({"loop_735_when_gate"}, {"loop_735_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_735_inactive"} \cap FOLD_TARGETS # {})
Edge_06_FORK ==
  /\ CanFire({"loop_735_context"})
  /\ active' = UpdateActive({"loop_735_context"}, {"loop_735_context_branch", "loop_735_then_branch", "loop_735_operator_branch", "loop_735_result_branch", "loop_735_taxonomy_branch", "loop_735_intervention_recognize", "loop_735_intervention_leverage"})
  /\ beta1' = beta1 + (Cardinality({"loop_735_context_branch", "loop_735_then_branch", "loop_735_operator_branch", "loop_735_result_branch", "loop_735_taxonomy_branch", "loop_735_intervention_recognize", "loop_735_intervention_leverage"}) - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_735_context_branch", "loop_735_then_branch", "loop_735_operator_branch", "loop_735_result_branch", "loop_735_taxonomy_branch", "loop_735_intervention_recognize", "loop_735_intervention_leverage"} \cap FOLD_TARGETS # {})
Edge_07_FOLD ==
  /\ CanFire({"loop_735_context_branch", "loop_735_then_branch", "loop_735_operator_branch", "loop_735_result_branch", "loop_735_taxonomy_branch", "loop_735_intervention_recognize", "loop_735_intervention_leverage"})
  /\ active' = UpdateActive({"loop_735_context_branch", "loop_735_then_branch", "loop_735_operator_branch", "loop_735_result_branch", "loop_735_taxonomy_branch", "loop_735_intervention_recognize", "loop_735_intervention_leverage"}, {"loop_735_verdict"})
  /\ beta1' = 0
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_735_verdict"} \cap FOLD_TARGETS # {})
Edge_08_PROCESS ==
  /\ CanFire({"loop_735_inactive"})
  /\ active' = UpdateActive({"loop_735_inactive"}, {"loop_735_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_735_sink"} \cap FOLD_TARGETS # {})
Edge_09_PROCESS ==
  /\ CanFire({"loop_735_verdict"})
  /\ active' = UpdateActive({"loop_735_verdict"}, {"loop_735_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_735_sink"} \cap FOLD_TARGETS # {})
Edge_10_INTERFERE ==
  /\ CanFire({"loop_735_intervention_recognize"})
  /\ active' = UpdateActive({"loop_735_intervention_recognize"}, {"loop_735_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_735_then_branch"} \cap FOLD_TARGETS # {})
Edge_11_INTERFERE ==
  /\ CanFire({"loop_735_intervention_leverage"})
  /\ active' = UpdateActive({"loop_735_intervention_leverage"}, {"loop_735_result_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_735_result_branch"} \cap FOLD_TARGETS # {})

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
