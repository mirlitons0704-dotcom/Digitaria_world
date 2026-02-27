export interface Database {
  public: {
    Tables: {
      characters: {
        Row: {
          id: string;
          name: string;
          name_en: string | null;
          role: string;
          personality: string | null;
          speech_style: string | null;
          appearance: string | null;
          chapter_appearance: number;
          created_at: string;
        };
        Insert: {
          id?: string;
          name: string;
          name_en?: string | null;
          role: string;
          personality?: string | null;
          speech_style?: string | null;
          appearance?: string | null;
          chapter_appearance?: number;
          created_at?: string;
        };
        Update: {
          id?: string;
          name?: string;
          name_en?: string | null;
          role?: string;
          personality?: string | null;
          speech_style?: string | null;
          appearance?: string | null;
          chapter_appearance?: number;
          created_at?: string;
        };
        Relationships: [];
      };
      chapters: {
        Row: {
          id: number;
          title: string;
          title_en: string | null;
          subtitle: string | null;
          subtitle_en: string | null;
          category: string;
          category_name: string;
          category_icon: string;
          description: string | null;
          guide_id: string | null;
          support_guide_id: string | null;
          term_count: number;
          created_at: string;
        };
        Insert: {
          id: number;
          title: string;
          title_en?: string | null;
          subtitle?: string | null;
          subtitle_en?: string | null;
          category: string;
          category_name: string;
          category_icon?: string;
          description?: string | null;
          guide_id?: string | null;
          support_guide_id?: string | null;
          term_count?: number;
          created_at?: string;
        };
        Update: {
          id?: number;
          title?: string;
          title_en?: string | null;
          subtitle?: string | null;
          subtitle_en?: string | null;
          category?: string;
          category_name?: string;
          category_icon?: string;
          description?: string | null;
          guide_id?: string | null;
          support_guide_id?: string | null;
          term_count?: number;
          created_at?: string;
        };
        Relationships: [
          {
            foreignKeyName: 'chapters_guide_id_fkey';
            columns: ['guide_id'];
            isOneToOne: false;
            referencedRelation: 'characters';
            referencedColumns: ['id'];
          },
        ];
      };
      terms: {
        Row: {
          id: string;
          term: string;
          term_ja: string;
          chapter_id: number;
          order_index: number;
          difficulty: number;
          one_liner: string;
          definition: string;
          mechanism: string | null;
          analogy: string | null;
          pitfall: string | null;
          related_terms: string[];
          story_context: string | null;
          created_at: string;
        };
        Insert: {
          id: string;
          term: string;
          term_ja: string;
          chapter_id: number;
          order_index: number;
          difficulty?: number;
          one_liner: string;
          definition: string;
          mechanism?: string | null;
          analogy?: string | null;
          pitfall?: string | null;
          related_terms?: string[];
          story_context?: string | null;
          created_at?: string;
        };
        Update: {
          id?: string;
          term?: string;
          term_ja?: string;
          chapter_id?: number;
          order_index?: number;
          difficulty?: number;
          one_liner?: string;
          definition?: string;
          mechanism?: string | null;
          analogy?: string | null;
          pitfall?: string | null;
          related_terms?: string[];
          story_context?: string | null;
          created_at?: string;
        };
        Relationships: [];
      };
      story_scenes: {
        Row: {
          id: string;
          chapter_id: number;
          scene_number: number;
          title: string | null;
          title_en: string | null;
          content: string;
          content_en: string | null;
          terms_introduced: string[];
          character_ids: string[];
          image_url: string | null;
          created_at: string;
        };
        Insert: {
          id?: string;
          chapter_id: number;
          scene_number: number;
          title?: string | null;
          title_en?: string | null;
          content: string;
          content_en?: string | null;
          terms_introduced?: string[];
          character_ids?: string[];
          image_url?: string | null;
          created_at?: string;
        };
        Update: {
          id?: string;
          chapter_id?: number;
          scene_number?: number;
          title?: string | null;
          title_en?: string | null;
          content?: string;
          content_en?: string | null;
          terms_introduced?: string[];
          character_ids?: string[];
          image_url?: string | null;
          created_at?: string;
        };
        Relationships: [];
      };
      user_profiles: {
        Row: {
          id: string;
          display_name: string | null;
          avatar_url: string | null;
          total_butterflies: number;
          current_chapter: number;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id: string;
          display_name?: string | null;
          avatar_url?: string | null;
          total_butterflies?: number;
          current_chapter?: number;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          display_name?: string | null;
          avatar_url?: string | null;
          total_butterflies?: number;
          current_chapter?: number;
          created_at?: string;
          updated_at?: string;
        };
        Relationships: [];
      };
      user_term_progress: {
        Row: {
          id: string;
          user_id: string;
          term_id: string;
          mastery_level: number;
          times_reviewed: number;
          last_reviewed_at: string | null;
          butterfly_stage: 'none' | 'light' | 'egg' | 'larva' | 'pupa' | 'butterfly';
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          user_id: string;
          term_id: string;
          mastery_level?: number;
          times_reviewed?: number;
          last_reviewed_at?: string | null;
          butterfly_stage?: 'none' | 'light' | 'egg' | 'larva' | 'pupa' | 'butterfly';
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          user_id?: string;
          term_id?: string;
          mastery_level?: number;
          times_reviewed?: number;
          last_reviewed_at?: string | null;
          butterfly_stage?: 'none' | 'light' | 'egg' | 'larva' | 'pupa' | 'butterfly';
          created_at?: string;
          updated_at?: string;
        };
        Relationships: [];
      };
      user_chapter_progress: {
        Row: {
          id: string;
          user_id: string;
          chapter_id: number;
          is_unlocked: boolean;
          is_completed: boolean;
          terms_mastered: number;
          story_progress: number;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          user_id: string;
          chapter_id: number;
          is_unlocked?: boolean;
          is_completed?: boolean;
          terms_mastered?: number;
          story_progress?: number;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          user_id?: string;
          chapter_id?: number;
          is_unlocked?: boolean;
          is_completed?: boolean;
          terms_mastered?: number;
          story_progress?: number;
          created_at?: string;
          updated_at?: string;
        };
        Relationships: [];
      };
      quiz_history: {
        Row: {
          id: string;
          user_id: string;
          quiz_type: 'term_to_definition' | 'definition_to_term' | 'mixed';
          chapter_id: number | null;
          score: number;
          total_questions: number;
          completed_at: string;
        };
        Insert: {
          id?: string;
          user_id: string;
          quiz_type: 'term_to_definition' | 'definition_to_term' | 'mixed';
          chapter_id?: number | null;
          score?: number;
          total_questions: number;
          completed_at?: string;
        };
        Update: {
          id?: string;
          user_id?: string;
          quiz_type?: 'term_to_definition' | 'definition_to_term' | 'mixed';
          chapter_id?: number | null;
          score?: number;
          total_questions?: number;
          completed_at?: string;
        };
        Relationships: [];
      };
      profiles: {
        Row: {
          id: string;
          username: string;
          email: string;
          is_admin: boolean;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id: string;
          username: string;
          email: string;
          is_admin?: boolean;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          username?: string;
          email?: string;
          is_admin?: boolean;
          created_at?: string;
          updated_at?: string;
        };
        Relationships: [];
      };
    };
    Views: {
      [_ in never]: never;
    };
    Functions: {
      get_random_terms: {
        Args: { p_chapter_id: number | null; p_count: number };
        Returns: Database['public']['Tables']['terms']['Row'][];
      };
    };
    Enums: {
      [_ in never]: never;
    };
    CompositeTypes: {
      [_ in never]: never;
    };
  };
}

export type Character = Database['public']['Tables']['characters']['Row'];
export type Chapter = Database['public']['Tables']['chapters']['Row'];
export type Term = Database['public']['Tables']['terms']['Row'];
export type StoryScene = Database['public']['Tables']['story_scenes']['Row'];
export type UserProfile = Database['public']['Tables']['user_profiles']['Row'];
export type UserTermProgress = Database['public']['Tables']['user_term_progress']['Row'];
export type UserChapterProgress = Database['public']['Tables']['user_chapter_progress']['Row'];
export type QuizHistory = Database['public']['Tables']['quiz_history']['Row'];

export type ButterflyStage = 'none' | 'light' | 'egg' | 'larva' | 'pupa' | 'butterfly';
export type MasteryLevel = 0 | 1 | 2 | 3;
