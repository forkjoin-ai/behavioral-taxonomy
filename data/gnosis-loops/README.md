# Behavioral Loop Gnosis Artifacts

Parent: [Behavioral Taxonomy Data](../README.md)

This directory is generated from `behavioralLoops.json` through Gnosis.

## Contents

- `loop-*.gg`: executable Gnosis topology for an individual behavioral loop.
- `loop-*.tla`: TLA+ module emitted from the corresponding `.gg` topology.
- `loop-*.cfg`: TLC config for the corresponding `.tla` module.
- `manifest.json`: per-loop artifact index with file names, Buley scores, Wallace scores, quantum index, topology metrics, and TLA bridge stats.

## Notes

- Text-heavy loop fields are percent-encoded in node properties so natural-language strings do not collide with the Gnosis parser.
- When the dataset reuses a loop ID across categories, artifact filenames and TLA module names are prefixed with the category slug to keep the triplets distinct.
- Regenerate this directory with `bun open-source/gnosis/src/behavioral-taxonomy.ts --write-loop-executions open-source/behavioral-taxonomy/data/gnosis-loops`.
