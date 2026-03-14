# @affectively/behavioral-taxonomy

`@affectively/behavioral-taxonomy` is a structured dataset of human behavioral loops, emotions, cognitive biases, and personality traits.

The fair brag is scale and structure. The package already ships more than 1,140 behavioral loops, organized into machine-readable categories with metadata, intervention fields, and related taxonomies, alongside separate emotion, bias, and trait datasets.

## What It Is Useful For

- behavior-aware applications
- NLP and classification workflows
- research tooling
- narrative and simulation systems
- applications that need structured emotion or bias data

## Installation

```bash
npm install @affectively/behavioral-taxonomy
# or
bun add @affectively/behavioral-taxonomy
```

## Quick Start

```ts
import {
  getBehavioralLoops,
  getEmotions,
  getBiases,
  getTraits,
} from '@affectively/behavioral-taxonomy';

const loops = getBehavioralLoops();
const emotions = getEmotions();
const biases = getBiases();
const traits = getTraits();
```

## What The Dataset Includes

- behavioral loops with logic, taxonomy, operator, veracity, intervention, and metadata fields
- categorized loop collections
- emotion taxonomy data
- cognitive bias data
- personality trait data
- generated Gnosis per-loop projections under [data](./data/README.md), including `.gg`, `.tla`, `.cfg`, and score manifest artifacts

## Direct JSON Access

You can also import the raw data directly:

```ts
import behavioralLoops from '@affectively/behavioral-taxonomy/data/behavioral-loops';
import emotions from '@affectively/behavioral-taxonomy/data/emotions';
import biases from '@affectively/behavioral-taxonomy/data/biases';
import traits from '@affectively/behavioral-taxonomy/data/traits';
```

## Repository Data Tree

- [data](./data/README.md): raw JSON datasets plus generated Gnosis loop artifacts in [`data/gnosis-loops`](./data/gnosis-loops/README.md)

## License

This dataset is licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).

## Why This README Is Grounded

Behavioral Taxonomy does not need hype. The strongest fair brag is that it is already a large, structured dataset with enough shape to be useful in real software and research workflows.
