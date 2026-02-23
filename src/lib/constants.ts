// Total number of programming terms in the app
export const TOTAL_TERMS = 520;

// Supabase Storage base URL for assets
const supabaseUrl = import.meta.env.VITE_SUPABASE_URL as string;
export const STORAGE_URL = `${supabaseUrl}/storage/v1/object/public/assets`;

// Asset paths
export const ASSETS = {
  // Character images
  bitKun: `${STORAGE_URL}/c1_bit.png`,
  byteSan: `${STORAGE_URL}/c2_bite.png`,

  // Character videos
  bitKunHappy: `${STORAGE_URL}/c1_happy.mp4`,
  bitKunProud: `${STORAGE_URL}/c1_proud.mp4`,
  bitKunThink: `${STORAGE_URL}/c1_think.mp4`,
  byteSanEncourage: `${STORAGE_URL}/c2_encourage.mp4`,
  byteSanProud: `${STORAGE_URL}/c2_proud.mp4`,

  // Butterfly images
  butterflyBlue: `${STORAGE_URL}/c3_bfb.png`,
  butterflyGold: `${STORAGE_URL}/c3_bfg.png`,

  // Landing page video
  landingVideo: `${STORAGE_URL}/movie_top02.mp4`,
} as const;
