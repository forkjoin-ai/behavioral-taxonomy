------------------------------ MODULE BehaviorLoop_804_the_spring_loop ------------------------------
EXTENDS Naturals, FiniteSets, Sequences

NODES == {"loop_804_context", "loop_804_context_branch", "loop_804_given_gate", "loop_804_inactive", "loop_804_intervention_interdict", "loop_804_intervention_minimize", "loop_804_intervention_recognize", "loop_804_operator_branch", "loop_804_result_branch", "loop_804_sink", "loop_804_start", "loop_804_taxonomy_branch", "loop_804_then_branch", "loop_804_verdict", "loop_804_when_gate"}
ROOTS == {"loop_804_start"}
TERMINALS == {"loop_804_sink"}
FOLD_TARGETS == {"loop_804_verdict"}
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
  /\ CanFire({"loop_804_start"})
  /\ active' = UpdateActive({"loop_804_start"}, {"loop_804_given_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_804_given_gate"} \cap FOLD_TARGETS # {})
Edge_02_PROCESS ==
  /\ CanFire({"loop_804_given_gate"})
  /\ active' = UpdateActive({"loop_804_given_gate"}, {"loop_804_when_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_804_when_gate"} \cap FOLD_TARGETS # {})
Edge_03_PROCESS ==
  /\ CanFire({"loop_804_given_gate"})
  /\ active' = UpdateActive({"loop_804_given_gate"}, {"loop_804_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_804_inactive"} \cap FOLD_TARGETS # {})
Edge_04_PROCESS ==
  /\ CanFire({"loop_804_when_gate"})
  /\ active' = UpdateActive({"loop_804_when_gate"}, {"loop_804_context"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_804_context"} \cap FOLD_TARGETS # {})
Edge_05_PROCESS ==
  /\ CanFire({"loop_804_when_gate"})
  /\ active' = UpdateActive({"loop_804_when_gate"}, {"loop_804_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_804_inactive"} \cap FOLD_TARGETS # {})
Edge_06_FORK ==
  /\ CanFire({"loop_804_context"})
  /\ active' = UpdateActive({"loop_804_context"}, {"loop_804_context_branch", "loop_804_then_branch", "loop_804_operator_branch", "loop_804_result_branch", "loop_804_taxonomy_branch", "loop_804_intervention_recognize", "loop_804_intervention_interdict", "loop_804_intervention_minimize"})
  /\ beta1' = beta1 + (Cardinality({"loop_804_context_branch", "loop_804_then_branch", "loop_804_operator_branch", "loop_804_result_branch", "loop_804_taxonomy_branch", "loop_804_intervention_recognize", "loop_804_intervention_interdict", "loop_804_intervention_minimize"}) - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_804_context_branch", "loop_804_then_branch", "loop_804_operator_branch", "loop_804_result_branch", "loop_804_taxonomy_branch", "loop_804_intervention_recognize", "loop_804_intervention_interdict", "loop_804_intervention_minimize"} \cap FOLD_TARGETS # {})
Edge_07_FOLD ==
  /\ CanFire({"loop_804_context_branch", "loop_804_then_branch", "loop_804_operator_branch", "loop_804_result_branch", "loop_804_taxonomy_branch", "loop_804_intervention_recognize", "loop_804_intervention_interdict", "loop_804_intervention_minimize"})
  /\ active' = UpdateActive({"loop_804_context_branch", "loop_804_then_branch", "loop_804_operator_branch", "loop_804_result_branch", "loop_804_taxonomy_branch", "loop_804_intervention_recognize", "loop_804_intervention_interdict", "loop_804_intervention_minimize"}, {"loop_804_verdict"})
  /\ beta1' = 0
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_804_verdict"} \cap FOLD_TARGETS # {})
Edge_08_PROCESS ==
  /\ CanFire({"loop_804_inactive"})
  /\ active' = UpdateActive({"loop_804_inactive"}, {"loop_804_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_804_sink"} \cap FOLD_TARGETS # {})
Edge_09_PROCESS ==
  /\ CanFire({"loop_804_verdict"})
  /\ active' = UpdateActive({"loop_804_verdict"}, {"loop_804_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_804_sink"} \cap FOLD_TARGETS # {})
Edge_10_INTERFERE ==
  /\ CanFire({"loop_804_intervention_recognize"})
  /\ active' = UpdateActive({"loop_804_intervention_recognize"}, {"loop_804_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_804_then_branch"} \cap FOLD_TARGETS # {})
Edge_11_INTERFERE ==
  /\ CanFire({"loop_804_intervention_interdict"})
  /\ active' = UpdateActive({"loop_804_intervention_interdict"}, {"loop_804_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_804_then_branch"} \cap FOLD_TARGETS # {})
Edge_12_INTERFERE ==
  /\ CanFire({"loop_804_intervention_minimize"})
  /\ active' = UpdateActive({"loop_804_intervention_minimize"}, {"loop_804_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_804_then_branch"} \cap FOLD_TARGETS # {})

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
