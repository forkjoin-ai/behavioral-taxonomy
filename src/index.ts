/**
 * @affectively/behavioral-taxonomy
 *
 * A comprehensive taxonomy of human behavioral loops, emotions,
 * cognitive biases, and personality traits.
 *
 * @license CC-BY-4.0
 * @see https://github.com/affectively-ai/behavioral-taxonomy
 */

import behavioralLoopsData from '../data/behavioralLoops.json';
import emotionsData from '../data/emotions.json';
import biasesData from '../data/biases.json';
import traitsData from '../data/traits.json';

// ============================================================================
// Types
// ============================================================================

export interface BehavioralLoopLogic {
  given: string;
  when: string;
  then: string;
  result: string;
}

export type LoopOrigin =
  | 'GENETIC'
  | 'BEHAVIORAL'
  | 'NARRATIVE'
  | 'DIGITAL'
  | 'ENVIRONMENTAL';

export type LoopModality =
  | 'VISUAL_STATIC'
  | 'VISUAL_DYNAMIC'
  | 'AUDITORY'
  | 'HAPTIC'
  | 'OLFACTORY'
  | 'META'
  | 'PROXEMIC';

export type LoopMutability = 'IMMUTABLE' | 'STUBBORN' | 'FLUID' | 'VOLATILE';

export type LoopValence =
  | 'ATTRACTION'
  | 'REPULSION'
  | 'DOMINANCE'
  | 'SUBMISSION'
  | 'TRUST'
  | 'DECEPTION'
  | 'DISRUPTION';

export interface LoopTaxonomy {
  origin: LoopOrigin;
  modality: LoopModality;
  mutability: LoopMutability | number;
  valences: LoopValence[];
}

export interface LoopOperator {
  name: string;
  mechanism: string;
}

export interface LoopVeracity {
  objectiveGrounding: number;
  socialConsensus: number;
  recursiveAmplification: number;
  frictionIndex: number;
}

export interface LoopIntervention {
  difficulty: number;
  interdict?: string;
  minimize?: string;
  recognize?: string;
  leverage?: string;
}

export interface LoopMeta {
  tags: string[];
  relatedArchetypes?: string[];
  academicFields?: string[];
}

export interface BehavioralLoop {
  id: number;
  name: string;
  logic: BehavioralLoopLogic;
  taxonomy: LoopTaxonomy;
  operator: LoopOperator;
  veracity: LoopVeracity;
  intervention: LoopIntervention;
  meta: LoopMeta;
}

export interface BehavioralCategory {
  id: string;
  categoryNumber: number;
  name: string;
  description: string;
  loops: BehavioralLoop[];
}

export interface BehavioralLoopsMetadata {
  title: string;
  version: string;
  description: string;
  totalCategories: number;
  totalLoops: number;
  generatedAt: string;
  interventionsAdded: number;
  updatedAt: string;
}

export interface BehavioralLoopsData {
  metadata: BehavioralLoopsMetadata;
  categories: BehavioralCategory[];
}

export interface Emotion {
  id: string;
  name: string;
  description: string;
  level: 'primary' | 'secondary' | 'tertiary';
  valence: 'Positive' | 'Negative' | 'Neutral' | 'Mixed';
  arousal: 'High' | 'Medium' | 'Moderate' | 'Low' | 'Very High' | 'Very Low';
  color?: string;
  ekmanCategory?: string;
  relatedEmotions?: string[];
  example?: string;
  reflectionTip?: string;
  deescalationTip?: string;
  selfJudgmentTip?: string;
  tertiaryIds?: string[];
}

export interface CognitiveBias {
  id: string;
  name: string;
  definition: string;
  category: string;
  domain?: string;
  subcategory?: string;
  mechanism?: string;
  system?: string;
  observable_markers?: string[];
  low_entropy_insight?: string;
  layer_associations?: string[];
  tag_id?: string;
  synonyms?: string[];
  antonyms?: string[];
  related_heuristics?: string[];
  examples?: string[];
  related_biases?: string[];
  research_notes?: string;
  core_pattern?: string;
}

export interface PersonalityTrait {
  id: string;
  category: string;
  core_pattern: string;
  observable_behaviors: string[];
  mitigation_focus: string;
}

// ============================================================================
// Data Accessors
// ============================================================================

/**
 * Get the complete behavioral loops dataset
 */
export function getBehavioralLoops(): BehavioralLoopsData {
  return behavioralLoopsData as BehavioralLoopsData;
}

/**
 * Get all behavioral loops as a flat array
 */
export function getAllLoops(): BehavioralLoop[] {
  const data = getBehavioralLoops();
  return data.categories.flatMap((cat) => cat.loops);
}

/**
 * Get loops by category ID
 */
export function getLoopsByCategory(categoryId: string): BehavioralLoop[] {
  const data = getBehavioralLoops();
  const category = data.categories.find((c) => c.id === categoryId);
  return category?.loops ?? [];
}

/**
 * Find loops by tag
 */
export function findLoopsByTag(tag: string): BehavioralLoop[] {
  return getAllLoops().filter((loop) =>
    loop.meta.tags.some((t) => t.toLowerCase().includes(tag.toLowerCase()))
  );
}

/**
 * Find loops by origin type
 */
export function findLoopsByOrigin(origin: LoopOrigin): BehavioralLoop[] {
  return getAllLoops().filter((loop) => loop.taxonomy.origin === origin);
}

/**
 * Get a single loop by ID
 */
export function getLoopById(id: number): BehavioralLoop | undefined {
  return getAllLoops().find((loop) => loop.id === id);
}

/**
 * Search loops by name or description
 */
export function searchLoops(query: string): BehavioralLoop[] {
  const lowerQuery = query.toLowerCase();
  return getAllLoops().filter(
    (loop) =>
      loop.name.toLowerCase().includes(lowerQuery) ||
      loop.logic.given.toLowerCase().includes(lowerQuery) ||
      loop.logic.result.toLowerCase().includes(lowerQuery)
  );
}

/**
 * Raw emotion record from JSON (primary emotions use "primary" field instead of "name")
 */
interface RawEmotionRecord {
  id: string;
  name?: string;
  primary?: string;
  description?: string;
  valence?: string;
  arousal?: string;
  color?: string;
  ekmanCategory?: string;
  example?: string;
  reflectionTip?: string;
  deescalationTip?: string;
  selfJudgmentTip?: string;
  tertiaryIds?: string[];
}

interface RawEmotionsData {
  primary?: RawEmotionRecord[];
  secondary?: RawEmotionRecord[];
  tertiary?: RawEmotionRecord[];
}

function normalizeEmotion(
  raw: RawEmotionRecord,
  level: 'primary' | 'secondary' | 'tertiary'
): Emotion {
  return {
    id: raw.id,
    name: raw.name ?? raw.primary ?? raw.id,
    description: raw.description ?? '',
    level,
    valence: (raw.valence as Emotion['valence']) ?? 'Neutral',
    arousal: (raw.arousal as Emotion['arousal']) ?? 'Medium',
    color: raw.color,
    ekmanCategory: raw.ekmanCategory,
    example: raw.example,
    reflectionTip: raw.reflectionTip,
    deescalationTip: raw.deescalationTip,
    selfJudgmentTip: raw.selfJudgmentTip,
    tertiaryIds: raw.tertiaryIds,
  };
}

/**
 * Get the emotions dataset
 */
export function getEmotions(): Emotion[] {
  const data = emotionsData as RawEmotionsData;
  return [
    ...(data.primary ?? []).map((e) => normalizeEmotion(e, 'primary')),
    ...(data.secondary ?? []).map((e) => normalizeEmotion(e, 'secondary')),
    ...(data.tertiary ?? []).map((e) => normalizeEmotion(e, 'tertiary')),
  ];
}

/**
 * Get cognitive biases dataset
 */
export function getBiases(): CognitiveBias[] {
  const data = biasesData as Record<string, unknown>;
  return Object.entries(data)
    .filter(
      ([key, value]) =>
        key !== '_metadata' &&
        value != null &&
        typeof value === 'object' &&
        'id' in (value as Record<string, unknown>)
    )
    .map(([, value]) => value as CognitiveBias);
}

/**
 * Raw trait record from JSON
 */
interface RawTraitRecord {
  category?: string;
  core_pattern?: string;
  observable_behaviors?: string[];
  mitigation_focus?: string;
}

/**
 * Get personality traits dataset
 */
export function getTraits(): PersonalityTrait[] {
  const data = traitsData as Record<string, RawTraitRecord>;
  return Object.entries(data).map(([id, trait]) => ({
    id,
    category: trait.category ?? '',
    core_pattern: trait.core_pattern ?? '',
    observable_behaviors: trait.observable_behaviors ?? [],
    mitigation_focus: trait.mitigation_focus ?? '',
  }));
}

// ============================================================================
// Statistics
// ============================================================================

/**
 * Get statistics about the behavioral loops dataset
 */
export function getStatistics(): {
  totalLoops: number;
  totalCategories: number;
  loopsByOrigin: Record<LoopOrigin, number>;
  averageInterventionDifficulty: number;
} {
  const data = getBehavioralLoops();
  const allLoops = getAllLoops();

  const loopsByOrigin = allLoops.reduce((acc, loop) => {
    const origin = loop.taxonomy.origin;
    acc[origin] = (acc[origin] || 0) + 1;
    return acc;
  }, {} as Record<LoopOrigin, number>);

  const avgDifficulty =
    allLoops.length > 0
      ? allLoops.reduce((sum, loop) => sum + loop.intervention.difficulty, 0) /
        allLoops.length
      : 0;

  return {
    totalLoops: data.metadata.totalLoops,
    totalCategories: data.metadata.totalCategories,
    loopsByOrigin,
    averageInterventionDifficulty: Math.round(avgDifficulty * 10) / 10,
  };
}

// ============================================================================
// Default Export
// ============================================================================

export default {
  getBehavioralLoops,
  getAllLoops,
  getLoopsByCategory,
  findLoopsByTag,
  findLoopsByOrigin,
  getLoopById,
  searchLoops,
  getEmotions,
  getBiases,
  getTraits,
  getStatistics,
};
