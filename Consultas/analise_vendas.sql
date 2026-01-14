--- ANÁLISE VENDAS

--- Qual é o total de vendas, receita total e ticket médio? (Exemplo 5)
SELECT 
COUNT (*) as total_vendas,
SUM(quantidade) AS quantidade_vendida,
SUM(quantidade * preco_unitario) AS receita_total, 
AVG(quantidade * preco_unitario) AS ticket_medio
FROM vendas;

--- Qual é a maior e menor venda? (Exemplo 5)
SELECT id_venda,
(quantidade * preco_unitario) AS total_venda
FROM vendas
WHERE (preco_unitario * quantidade) IN (
SELECT MAX(quantidade * preco_unitario) FROM vendas
UNION
SELECT MIN(quantidade * preco_unitario) FROM vendas);

--- Como ver o nome do produto junto com a venda? (Exemplo 6)
SELECT p.nome_produto,
(v.quantidade * v.preco_unitario) as valor_venda
FROM vendas v
INNER JOIN produtos p ON p.id_produto = v.id_produto;

--- Quantas vendas e qual a receita total por categoria? (Exemplo 8)
SELECT p.categoria,
ROUND(SUM(v.quantidade * v.preco_unitario)::numeric,2) as valor_venda
FROM vendas v
INNER JOIN produtos p ON p.id_produto = v.id_produto
GROUP BY p.categoria
ORDER BY valor_venda DESC;

--- Quais categorias geram mais de R$ 50.000 em receita? (Exemplo 9)
SELECT p.categoria,
ROUND(SUM(v.quantidade * v.preco_unitario)::numeric,2) as valor_venda
FROM vendas v
INNER JOIN produtos p ON p.id_produto = v.id_produto
GROUP BY p.categoria
HAVING ROUND(SUM(v.quantidade * v.preco_unitario)::numeric,2) > 50000
ORDER BY valor_venda DESC;

--- Qual é a distribuição percentual de receita por canal? (Exemplo 17)
SELECT 
canal_venda,
COUNT (*) AS total_vendas,
SUM(quantidade * preco_unitario) AS total_recita,
ROUND(SUM(quantidade * preco_unitario)::numeric,2) * 100.0 / (
SELECT SUM(quantidade * preco_unitario) FROM vendas) AS percentual_receita
FROM vendas
GROUP BY canal_venda;