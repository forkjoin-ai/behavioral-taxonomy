------------------------------ MODULE BehaviorLoop_548_the_wide_base_loop ------------------------------
EXTENDS Naturals, FiniteSets, Sequences

NODES == {"loop_548_context", "loop_548_context_branch", "loop_548_given_gate", "loop_548_inactive", "loop_548_intervention_interdict", "loop_548_intervention_minimize", "loop_548_intervention_recognize", "loop_548_operator_branch", "loop_548_result_branch", "loop_548_sink", "loop_548_start", "loop_548_taxonomy_branch", "loop_548_then_branch", "loop_548_verdict", "loop_548_when_gate"}
ROOTS == {"loop_548_start"}
TERMINALS == {"loop_548_sink"}
FOLD_TARGETS == {"loop_548_verdict"}
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
  /\ CanFire({"loop_548_start"})
  /\ active' = UpdateActive({"loop_548_start"}, {"loop_548_given_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_548_given_gate"} \cap FOLD_TARGETS # {})
Edge_02_PROCESS ==
  /\ CanFire({"loop_548_given_gate"})
  /\ active' = UpdateActive({"loop_548_given_gate"}, {"loop_548_when_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_548_when_gate"} \cap FOLD_TARGETS # {})
Edge_03_PROCESS ==
  /\ CanFire({"loop_548_given_gate"})
  /\ active' = UpdateActive({"loop_548_given_gate"}, {"loop_548_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_548_inactive"} \cap FOLD_TARGETS # {})
Edge_04_PROCESS ==
  /\ CanFire({"loop_548_when_gate"})
  /\ active' = UpdateActive({"loop_548_when_gate"}, {"loop_548_context"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_548_context"} \cap FOLD_TARGETS # {})
Edge_05_PROCESS ==
  /\ CanFire({"loop_548_when_gate"})
  /\ active' = UpdateActive({"loop_548_when_gate"}, {"loop_548_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_548_inactive"} \cap FOLD_TARGETS # {})
Edge_06_FORK ==
  /\ CanFire({"loop_548_context"})
  /\ active' = UpdateActive({"loop_548_context"}, {"loop_548_context_branch", "loop_548_then_branch", "loop_548_operator_branch", "loop_548_result_branch", "loop_548_taxonomy_branch", "loop_548_intervention_recognize", "loop_548_intervention_interdict", "loop_548_intervention_minimize"})
  /\ beta1' = beta1 + (Cardinality({"loop_548_context_branch", "loop_548_then_branch", "loop_548_operator_branch", "loop_548_result_branch", "loop_548_taxonomy_branch", "loop_548_intervention_recognize", "loop_548_intervention_interdict", "loop_548_intervention_minimize"}) - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_548_context_branch", "loop_548_then_branch", "loop_548_operator_branch", "loop_548_result_branch", "loop_548_taxonomy_branch", "loop_548_intervention_recognize", "loop_548_intervention_interdict", "loop_548_intervention_minimize"} \cap FOLD_TARGETS # {})
Edge_07_FOLD ==
  /\ CanFire({"loop_548_context_branch", "loop_548_then_branch", "loop_548_operator_branch", "loop_548_result_branch", "loop_548_taxonomy_branch", "loop_548_intervention_recognize", "loop_548_intervention_interdict", "loop_548_intervention_minimize"})
  /\ active' = UpdateActive({"loop_548_context_branch", "loop_548_then_branch", "loop_548_operator_branch", "loop_548_result_branch", "loop_548_taxonomy_branch", "loop_548_intervention_recognize", "loop_548_intervention_interdict", "loop_548_intervention_minimize"}, {"loop_548_verdict"})
  /\ beta1' = 0
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_548_verdict"} \cap FOLD_TARGETS # {})
Edge_08_PROCESS ==
  /\ CanFire({"loop_548_inactive"})
  /\ active' = UpdateActive({"loop_548_inactive"}, {"loop_548_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_548_sink"} \cap FOLD_TARGETS # {})
Edge_09_PROCESS ==
  /\ CanFire({"loop_548_verdict"})
  /\ active' = UpdateActive({"loop_548_verdict"}, {"loop_548_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_548_sink"} \cap FOLD_TARGETS # {})
Edge_10_INTERFERE ==
  /\ CanFire({"loop_548_intervention_recognize"})
  /\ active' = UpdateActive({"loop_548_intervention_recognize"}, {"loop_548_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_548_then_branch"} \cap FOLD_TARGETS # {})
Edge_11_INTERFERE ==
  /\ CanFire({"loop_548_intervention_interdict"})
  /\ active' = UpdateActive({"loop_548_intervention_interdict"}, {"loop_548_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_548_then_branch"} \cap FOLD_TARGETS # {})
Edge_12_INTERFERE ==
  /\ CanFire({"loop_548_intervention_minimize"})
  /\ active' = UpdateActive({"loop_548_intervention_minimize"}, {"loop_548_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_548_then_branch"} \cap FOLD_TARGETS # {})

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
