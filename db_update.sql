-- 1. Drop existing constraints if they exist
ALTER TABLE public.orders DROP CONSTRAINT IF EXISTS orders_status_check;
ALTER TABLE public.orders DROP CONSTRAINT IF EXISTS orders_payment_method_check;

-- 2. Add new columns to orders table
ALTER TABLE public.orders
ADD COLUMN IF NOT EXISTS customer_phone_2 text,
ADD COLUMN IF NOT EXISTS deposit_required boolean DEFAULT false,
ADD COLUMN IF NOT EXISTS deposit_amount numeric(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS payment_slip_url text,
ADD COLUMN IF NOT EXISTS payment_verification_status text DEFAULT 'pending',
ADD COLUMN IF NOT EXISTS delivery_status text DEFAULT 'pending',
ADD COLUMN IF NOT EXISTS lead_source text DEFAULT 'WhatsApp',
ADD COLUMN IF NOT EXISTS followup_status text DEFAULT 'active',
ADD COLUMN IF NOT EXISTS manual_handoff_status boolean DEFAULT false;

-- 3. Add updated status constraints
ALTER TABLE public.orders
ADD CONSTRAINT orders_status_check CHECK (
  status IN (
    'New', 'Confirmed', 'Deposit Pending', 'Slip Received', 
    'Deposit Verified', 'Manual Processing', 'Out for Delivery', 
    'Delivered', 'Completed', 'Cancelled', 'pending', 'processing', 'shipped', 'delivered', 'cancelled'
  )
);
