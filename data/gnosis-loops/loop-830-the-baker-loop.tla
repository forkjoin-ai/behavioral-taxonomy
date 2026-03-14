------------------------------ MODULE BehaviorLoop_830_the_baker_loop ------------------------------
EXTENDS Naturals, FiniteSets, Sequences

NODES == {"loop_830_context", "loop_830_context_branch", "loop_830_given_gate", "loop_830_inactive", "loop_830_intervention_interdict", "loop_830_intervention_minimize", "loop_830_intervention_recognize", "loop_830_operator_branch", "loop_830_result_branch", "loop_830_sink", "loop_830_start", "loop_830_taxonomy_branch", "loop_830_then_branch", "loop_830_verdict", "loop_830_when_gate"}
ROOTS == {"loop_830_start"}
TERMINALS == {"loop_830_sink"}
FOLD_TARGETS == {"loop_830_verdict"}
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
  /\ CanFire({"loop_830_start"})
  /\ active' = UpdateActive({"loop_830_start"}, {"loop_830_given_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_830_given_gate"} \cap FOLD_TARGETS # {})
Edge_02_PROCESS ==
  /\ CanFire({"loop_830_given_gate"})
  /\ active' = UpdateActive({"loop_830_given_gate"}, {"loop_830_when_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_830_when_gate"} \cap FOLD_TARGETS # {})
Edge_03_PROCESS ==
  /\ CanFire({"loop_830_given_gate"})
  /\ active' = UpdateActive({"loop_830_given_gate"}, {"loop_830_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_830_inactive"} \cap FOLD_TARGETS # {})
Edge_04_PROCESS ==
  /\ CanFire({"loop_830_when_gate"})
  /\ active' = UpdateActive({"loop_830_when_gate"}, {"loop_830_context"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_830_context"} \cap FOLD_TARGETS # {})
Edge_05_PROCESS ==
  /\ CanFire({"loop_830_when_gate"})
  /\ active' = UpdateActive({"loop_830_when_gate"}, {"loop_830_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_830_inactive"} \cap FOLD_TARGETS # {})
Edge_06_FORK ==
  /\ CanFire({"loop_830_context"})
  /\ active' = UpdateActive({"loop_830_context"}, {"loop_830_context_branch", "loop_830_then_branch", "loop_830_operator_branch", "loop_830_result_branch", "loop_830_taxonomy_branch", "loop_830_intervention_recognize", "loop_830_intervention_interdict", "loop_830_intervention_minimize"})
  /\ beta1' = beta1 + (Cardinality({"loop_830_context_branch", "loop_830_then_branch", "loop_830_operator_branch", "loop_830_result_branch", "loop_830_taxonomy_branch", "loop_830_intervention_recognize", "loop_830_intervention_interdict", "loop_830_intervention_minimize"}) - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_830_context_branch", "loop_830_then_branch", "loop_830_operator_branch", "loop_830_result_branch", "loop_830_taxonomy_branch", "loop_830_intervention_recognize", "loop_830_intervention_interdict", "loop_830_intervention_minimize"} \cap FOLD_TARGETS # {})
Edge_07_FOLD ==
  /\ CanFire({"loop_830_context_branch", "loop_830_then_branch", "loop_830_operator_branch", "loop_830_result_branch", "loop_830_taxonomy_branch", "loop_830_intervention_recognize", "loop_830_intervention_interdict", "loop_830_intervention_minimize"})
  /\ active' = UpdateActive({"loop_830_context_branch", "loop_830_then_branch", "loop_830_operator_branch", "loop_830_result_branch", "loop_830_taxonomy_branch", "loop_830_intervention_recognize", "loop_830_intervention_interdict", "loop_830_intervention_minimize"}, {"loop_830_verdict"})
  /\ beta1' = 0
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_830_verdict"} \cap FOLD_TARGETS # {})
Edge_08_PROCESS ==
  /\ CanFire({"loop_830_inactive"})
  /\ active' = UpdateActive({"loop_830_inactive"}, {"loop_830_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_830_sink"} \cap FOLD_TARGETS # {})
Edge_09_PROCESS ==
  /\ CanFire({"loop_830_verdict"})
  /\ active' = UpdateActive({"loop_830_verdict"}, {"loop_830_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_830_sink"} \cap FOLD_TARGETS # {})
Edge_10_INTERFERE ==
  /\ CanFire({"loop_830_intervention_recognize"})
  /\ active' = UpdateActive({"loop_830_intervention_recognize"}, {"loop_830_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_830_then_branch"} \cap FOLD_TARGETS # {})
Edge_11_INTERFERE ==
  /\ CanFire({"loop_830_intervention_interdict"})
  /\ active' = UpdateActive({"loop_830_intervention_interdict"}, {"loop_830_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_830_then_branch"} \cap FOLD_TARGETS # {})
Edge_12_INTERFERE ==
  /\ CanFire({"loop_830_intervention_minimize"})
  /\ active' = UpdateActive({"loop_830_intervention_minimize"}, {"loop_830_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_830_then_branch"} \cap FOLD_TARGETS # {})

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
