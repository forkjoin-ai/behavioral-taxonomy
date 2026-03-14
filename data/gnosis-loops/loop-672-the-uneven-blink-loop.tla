------------------------------ MODULE BehaviorLoop_672_the_uneven_blink_loop ------------------------------
EXTENDS Naturals, FiniteSets, Sequences

NODES == {"loop_672_context", "loop_672_context_branch", "loop_672_given_gate", "loop_672_inactive", "loop_672_intervention_interdict", "loop_672_intervention_minimize", "loop_672_intervention_recognize", "loop_672_operator_branch", "loop_672_result_branch", "loop_672_sink", "loop_672_start", "loop_672_taxonomy_branch", "loop_672_then_branch", "loop_672_verdict", "loop_672_when_gate"}
ROOTS == {"loop_672_start"}
TERMINALS == {"loop_672_sink"}
FOLD_TARGETS == {"loop_672_verdict"}
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
  /\ CanFire({"loop_672_start"})
  /\ active' = UpdateActive({"loop_672_start"}, {"loop_672_given_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_672_given_gate"} \cap FOLD_TARGETS # {})
Edge_02_PROCESS ==
  /\ CanFire({"loop_672_given_gate"})
  /\ active' = UpdateActive({"loop_672_given_gate"}, {"loop_672_when_gate"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_672_when_gate"} \cap FOLD_TARGETS # {})
Edge_03_PROCESS ==
  /\ CanFire({"loop_672_given_gate"})
  /\ active' = UpdateActive({"loop_672_given_gate"}, {"loop_672_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_672_inactive"} \cap FOLD_TARGETS # {})
Edge_04_PROCESS ==
  /\ CanFire({"loop_672_when_gate"})
  /\ active' = UpdateActive({"loop_672_when_gate"}, {"loop_672_context"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_672_context"} \cap FOLD_TARGETS # {})
Edge_05_PROCESS ==
  /\ CanFire({"loop_672_when_gate"})
  /\ active' = UpdateActive({"loop_672_when_gate"}, {"loop_672_inactive"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_672_inactive"} \cap FOLD_TARGETS # {})
Edge_06_FORK ==
  /\ CanFire({"loop_672_context"})
  /\ active' = UpdateActive({"loop_672_context"}, {"loop_672_context_branch", "loop_672_then_branch", "loop_672_operator_branch", "loop_672_result_branch", "loop_672_taxonomy_branch", "loop_672_intervention_recognize", "loop_672_intervention_interdict", "loop_672_intervention_minimize"})
  /\ beta1' = beta1 + (Cardinality({"loop_672_context_branch", "loop_672_then_branch", "loop_672_operator_branch", "loop_672_result_branch", "loop_672_taxonomy_branch", "loop_672_intervention_recognize", "loop_672_intervention_interdict", "loop_672_intervention_minimize"}) - 1)
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_672_context_branch", "loop_672_then_branch", "loop_672_operator_branch", "loop_672_result_branch", "loop_672_taxonomy_branch", "loop_672_intervention_recognize", "loop_672_intervention_interdict", "loop_672_intervention_minimize"} \cap FOLD_TARGETS # {})
Edge_07_FOLD ==
  /\ CanFire({"loop_672_context_branch", "loop_672_then_branch", "loop_672_operator_branch", "loop_672_result_branch", "loop_672_taxonomy_branch", "loop_672_intervention_recognize", "loop_672_intervention_interdict", "loop_672_intervention_minimize"})
  /\ active' = UpdateActive({"loop_672_context_branch", "loop_672_then_branch", "loop_672_operator_branch", "loop_672_result_branch", "loop_672_taxonomy_branch", "loop_672_intervention_recognize", "loop_672_intervention_interdict", "loop_672_intervention_minimize"}, {"loop_672_verdict"})
  /\ beta1' = 0
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_672_verdict"} \cap FOLD_TARGETS # {})
Edge_08_PROCESS ==
  /\ CanFire({"loop_672_inactive"})
  /\ active' = UpdateActive({"loop_672_inactive"}, {"loop_672_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_672_sink"} \cap FOLD_TARGETS # {})
Edge_09_PROCESS ==
  /\ CanFire({"loop_672_verdict"})
  /\ active' = UpdateActive({"loop_672_verdict"}, {"loop_672_sink"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_672_sink"} \cap FOLD_TARGETS # {})
Edge_10_INTERFERE ==
  /\ CanFire({"loop_672_intervention_recognize"})
  /\ active' = UpdateActive({"loop_672_intervention_recognize"}, {"loop_672_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_672_then_branch"} \cap FOLD_TARGETS # {})
Edge_11_INTERFERE ==
  /\ CanFire({"loop_672_intervention_interdict"})
  /\ active' = UpdateActive({"loop_672_intervention_interdict"}, {"loop_672_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_672_then_branch"} \cap FOLD_TARGETS # {})
Edge_12_INTERFERE ==
  /\ CanFire({"loop_672_intervention_minimize"})
  /\ active' = UpdateActive({"loop_672_intervention_minimize"}, {"loop_672_then_branch"})
  /\ beta1' = beta1
  /\ payloadPresent' = payloadPresent
  /\ consensusReached' = consensusReached \/ ({"loop_672_then_branch"} \cap FOLD_TARGETS # {})

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
