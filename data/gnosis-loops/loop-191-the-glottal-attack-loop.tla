------------------------------ MODULE BehaviorLoop_191_the_glottal_attack_loop ------------------------------
EXTENDS Naturals, FiniteSets, Sequences

NODES == {"loop_191_context", "loop_191_context_branch", "loop_191_given_gate", "loop_191_inactive", "loop_191_intervention_interdict", "loop_191_intervention_minimize", "loop_191_intervention_recognize", "loop_191_operator_branch", "loop_191_result_branch", "loop_191_sink", "loop_191_start", "loop_191_taxonomy_branch", "loop_191_then_branch", "loop_191_verdict", "loop_191_when_gate"}
ROOTS == {"loop_191_start"}
TERMINALS == {"loop_191_sink"}
FOLD_TARGETS == {"loop_191_verdict"}
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
  /\ CanFire({"loop_191_start"})
  /\ active' = UpdateActive({"loop_191_start"}, {"loop_191_given_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_191_given_gate"} \cap FOLD_TARGETS # {})
Edge_02_PROCESS ==
  /\ CanFire({"loop_191_given_gate"})
  /\ active' = UpdateActive({"loop_191_given_gate"}, {"loop_191_when_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_191_when_gate"} \cap FOLD_TARGETS # {})
Edge_03_PROCESS ==
  /\ CanFire({"loop_191_given_gate"})
  /\ active' = UpdateActive({"loop_191_given_gate"}, {"loop_191_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_191_inactive"} \cap FOLD_TARGETS # {})
Edge_04_PROCESS ==
  /\ CanFire({"loop_191_when_gate"})
  /\ active' = UpdateActive({"loop_191_when_gate"}, {"loop_191_context"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_191_context"} \cap FOLD_TARGETS # {})
Edge_05_PROCESS ==
  /\ CanFire({"loop_191_when_gate"})
  /\ active' = UpdateActive({"loop_191_when_gate"}, {"loop_191_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_191_inactive"} \cap FOLD_TARGETS # {})
Edge_06_FORK ==
  /\ CanFire({"loop_191_context"})
  /\ active' = UpdateActive({"loop_191_context"}, {"loop_191_context_branch", "loop_191_then_branch", "loop_191_operator_branch", "loop_191_result_branch", "loop_191_taxonomy_branch", "loop_191_intervention_recognize", "loop_191_intervention_interdict", "loop_191_intervention_minimize"})
  /\ beta1' = beta1 + (Cardinality({"loop_191_context_branch", "loop_191_then_branch", "loop_191_operator_branch", "loop_191_result_branch", "loop_191_taxonomy_branch", "loop_191_intervention_recognize", "loop_191_intervention_interdict", "loop_191_intervention_minimize"}) - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_191_context_branch", "loop_191_then_branch", "loop_191_operator_branch", "loop_191_result_branch", "loop_191_taxonomy_branch", "loop_191_intervention_recognize", "loop_191_intervention_interdict", "loop_191_intervention_minimize"} \cap FOLD_TARGETS # {})
Edge_07_FOLD ==
  /\ CanFire({"loop_191_context_branch", "loop_191_then_branch", "loop_191_operator_branch", "loop_191_result_branch", "loop_191_taxonomy_branch", "loop_191_intervention_recognize", "loop_191_intervention_interdict", "loop_191_intervention_minimize"})
  /\ active' = UpdateActive({"loop_191_context_branch", "loop_191_then_branch", "loop_191_operator_branch", "loop_191_result_branch", "loop_191_taxonomy_branch", "loop_191_intervention_recognize", "loop_191_intervention_interdict", "loop_191_intervention_minimize"}, {"loop_191_verdict"})
  /\ beta1' = 0
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_191_verdict"} \cap FOLD_TARGETS # {})
Edge_08_PROCESS ==
  /\ CanFire({"loop_191_inactive"})
  /\ active' = UpdateActive({"loop_191_inactive"}, {"loop_191_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_191_sink"} \cap FOLD_TARGETS # {})
Edge_09_PROCESS ==
  /\ CanFire({"loop_191_verdict"})
  /\ active' = UpdateActive({"loop_191_verdict"}, {"loop_191_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_191_sink"} \cap FOLD_TARGETS # {})
Edge_10_INTERFERE ==
  /\ CanFire({"loop_191_intervention_recognize"})
  /\ active' = UpdateActive({"loop_191_intervention_recognize"}, {"loop_191_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_191_then_branch"} \cap FOLD_TARGETS # {})
Edge_11_INTERFERE ==
  /\ CanFire({"loop_191_intervention_interdict"})
  /\ active' = UpdateActive({"loop_191_intervention_interdict"}, {"loop_191_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_191_then_branch"} \cap FOLD_TARGETS # {})
Edge_12_INTERFERE ==
  /\ CanFire({"loop_191_intervention_minimize"})
  /\ active' = UpdateActive({"loop_191_intervention_minimize"}, {"loop_191_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_191_then_branch"} \cap FOLD_TARGETS # {})

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
