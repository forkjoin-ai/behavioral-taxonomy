------------------------------ MODULE BehaviorLoop_164_the_yellow_loop ------------------------------
EXTENDS Naturals, FiniteSets, Sequences

NODES == {"loop_164_context", "loop_164_context_branch", "loop_164_given_gate", "loop_164_inactive", "loop_164_intervention_interdict", "loop_164_intervention_minimize", "loop_164_intervention_recognize", "loop_164_operator_branch", "loop_164_result_branch", "loop_164_sink", "loop_164_start", "loop_164_taxonomy_branch", "loop_164_then_branch", "loop_164_verdict", "loop_164_when_gate"}
ROOTS == {"loop_164_start"}
TERMINALS == {"loop_164_sink"}
FOLD_TARGETS == {"loop_164_verdict"}
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
  /\ CanFire({"loop_164_start"})
  /\ active' = UpdateActive({"loop_164_start"}, {"loop_164_given_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_164_given_gate"} \cap FOLD_TARGETS # {})
Edge_02_PROCESS ==
  /\ CanFire({"loop_164_given_gate"})
  /\ active' = UpdateActive({"loop_164_given_gate"}, {"loop_164_when_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_164_when_gate"} \cap FOLD_TARGETS # {})
Edge_03_PROCESS ==
  /\ CanFire({"loop_164_given_gate"})
  /\ active' = UpdateActive({"loop_164_given_gate"}, {"loop_164_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_164_inactive"} \cap FOLD_TARGETS # {})
Edge_04_PROCESS ==
  /\ CanFire({"loop_164_when_gate"})
  /\ active' = UpdateActive({"loop_164_when_gate"}, {"loop_164_context"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_164_context"} \cap FOLD_TARGETS # {})
Edge_05_PROCESS ==
  /\ CanFire({"loop_164_when_gate"})
  /\ active' = UpdateActive({"loop_164_when_gate"}, {"loop_164_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_164_inactive"} \cap FOLD_TARGETS # {})
Edge_06_FORK ==
  /\ CanFire({"loop_164_context"})
  /\ active' = UpdateActive({"loop_164_context"}, {"loop_164_context_branch", "loop_164_then_branch", "loop_164_operator_branch", "loop_164_result_branch", "loop_164_taxonomy_branch", "loop_164_intervention_recognize", "loop_164_intervention_interdict", "loop_164_intervention_minimize"})
  /\ beta1' = beta1 + (Cardinality({"loop_164_context_branch", "loop_164_then_branch", "loop_164_operator_branch", "loop_164_result_branch", "loop_164_taxonomy_branch", "loop_164_intervention_recognize", "loop_164_intervention_interdict", "loop_164_intervention_minimize"}) - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_164_context_branch", "loop_164_then_branch", "loop_164_operator_branch", "loop_164_result_branch", "loop_164_taxonomy_branch", "loop_164_intervention_recognize", "loop_164_intervention_interdict", "loop_164_intervention_minimize"} \cap FOLD_TARGETS # {})
Edge_07_FOLD ==
  /\ CanFire({"loop_164_context_branch", "loop_164_then_branch", "loop_164_operator_branch", "loop_164_result_branch", "loop_164_taxonomy_branch", "loop_164_intervention_recognize", "loop_164_intervention_interdict", "loop_164_intervention_minimize"})
  /\ active' = UpdateActive({"loop_164_context_branch", "loop_164_then_branch", "loop_164_operator_branch", "loop_164_result_branch", "loop_164_taxonomy_branch", "loop_164_intervention_recognize", "loop_164_intervention_interdict", "loop_164_intervention_minimize"}, {"loop_164_verdict"})
  /\ beta1' = 0
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_164_verdict"} \cap FOLD_TARGETS # {})
Edge_08_PROCESS ==
  /\ CanFire({"loop_164_inactive"})
  /\ active' = UpdateActive({"loop_164_inactive"}, {"loop_164_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_164_sink"} \cap FOLD_TARGETS # {})
Edge_09_PROCESS ==
  /\ CanFire({"loop_164_verdict"})
  /\ active' = UpdateActive({"loop_164_verdict"}, {"loop_164_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_164_sink"} \cap FOLD_TARGETS # {})
Edge_10_INTERFERE ==
  /\ CanFire({"loop_164_intervention_recognize"})
  /\ active' = UpdateActive({"loop_164_intervention_recognize"}, {"loop_164_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_164_then_branch"} \cap FOLD_TARGETS # {})
Edge_11_INTERFERE ==
  /\ CanFire({"loop_164_intervention_interdict"})
  /\ active' = UpdateActive({"loop_164_intervention_interdict"}, {"loop_164_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_164_then_branch"} \cap FOLD_TARGETS # {})
Edge_12_INTERFERE ==
  /\ CanFire({"loop_164_intervention_minimize"})
  /\ active' = UpdateActive({"loop_164_intervention_minimize"}, {"loop_164_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_164_then_branch"} \cap FOLD_TARGETS # {})

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
