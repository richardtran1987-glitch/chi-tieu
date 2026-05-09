-- Chi Tiêu Cá Nhân - Supabase Setup
-- Chạy script này trong Supabase SQL Editor (https://supabase.com/dashboard → SQL Editor)

-- 1. Bảng transactions
CREATE TABLE IF NOT EXISTS transactions (
  id text PRIMARY KEY,
  amount int8 NOT NULL,
  parent_id text,
  child text,
  date date,
  time text,
  note text,
  created_at timestamptz DEFAULT now()
);

-- 2. Bảng settings (budgets, recurrings, categories)
CREATE TABLE IF NOT EXISTS settings (
  key text PRIMARY KEY,
  value jsonb
);

-- 3. Bật RLS (Row Level Security) nhưng cho phép anon access
-- Vì app single-user, cho phép mọi thao tác từ anon key
ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE settings ENABLE ROW LEVEL SECURITY;

-- Policy: cho phép tất cả thao tác (single-user app)
CREATE POLICY "Allow all on transactions" ON transactions FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all on settings" ON settings FOR ALL USING (true) WITH CHECK (true);
