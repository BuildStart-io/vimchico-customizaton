import { createClient } from '@supabase/supabase-js'
const supabaseUrl = 'http://localhost:8000'
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyAgCiAgICAicm9sZSI6ICJhbm9uIiwKICAgICJpc3MiOiAic3VwYWJhc2UtZGVtbyIsCiAgICAiaWF0IjogMTY0MTc2OTIwMCwKICAgICJleHAiOiAxNzk5NTM1NjAwCn0.dc_X5iR_VP_qT0zsiyj_I_OZ2T9FtRU2BBNWN8Bu4GE'
const supabase = createClient(supabaseUrl, supabaseKey)

async function signUp() {
  const { data, error } = await supabase.auth.signUp({
    email: 'admin@vimchico.com',
    password: 'password123',
    options: {
      data: {
        role: 'owner',
        name: 'Vimchico Admin'
      }
    }
  })
  if (error) console.error("SignUp error:", error)
  else console.log("User created:", data.user.id)
}
signUp()
