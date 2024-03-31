CREATE TABLE
  kimia_farma.table_analisa AS
SELECT
  t.transaction_id,
  t.date,
  t.branch_id,
  kc.branch_name,
  kc.kota,
  kc.provinsi,
  kc.rating AS rating_cabang,
  t.customer_name,
  t.product_id,
  p.product_name,
  p.price AS actual_price,
  t.discount_percentage,
  CASE
    WHEN p.price <= 50000 THEN 0.10
    WHEN p.price <= 100000 THEN 0.15
    WHEN p.price <= 300000 THEN 0.20
    WHEN p.price <= 500000 THEN 0.25
  ELSE
  0.30
END
  AS persentase_gross_laba,
  ROUND(p.price * (1 - t.discount_percentage), 0) AS nett_sales,
  ROUND(p.price * (1 - t.discount_percentage) *
    CASE
      WHEN p.price <= 50000 THEN 0.10
      WHEN p.price <= 100000 THEN 0.15
      WHEN p.price <= 300000 THEN 0.20
      WHEN p.price <= 500000 THEN 0.25
    ELSE
    0.30
  END
    , 0) AS nett_profit,
  t.rating AS rating_transaksi
FROM
  `kimia_farma.kf_final_transaction` t
LEFT JOIN
  `kimia_farma.kf_kantor_cabang` kc
ON
  t.branch_id = kc.branch_id
LEFT JOIN
  `kimia_farma.kf_product` p
ON
  t.product_id = p.product_id;