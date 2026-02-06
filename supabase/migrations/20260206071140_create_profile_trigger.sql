/*
  # Auto-create profile on user signup

  1. Changes
    - Creates a function to handle new user profile creation
    - Creates a trigger on auth.users to automatically create profiles
    - This ensures profiles are created with proper permissions using SECURITY DEFINER

  2. Security
    - Function runs with elevated privileges to bypass RLS
    - Only triggered by Supabase auth system
*/

CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public
AS $$
BEGIN
  INSERT INTO public.profiles (id, email, username)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'username', split_part(NEW.email, '@', 1))
  )
  ON CONFLICT (id) DO NOTHING;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
