--- ANÁLISE PRODUTOS

--- Quais produtos temos no catálogo? (Exemplo 1)
SELECT nome_produto FROM produtos;

--- Quais são os produtos mais caros? (Exemplo 2)
SELECT nome_produto, 
preco_atual 
FROM produtos 
ORDER BY preco_atual DESC;

--- Quais são os 10 primeiros produtos mais caros? (Exemplo 3)
SELECT nome_produto, 
preco_atual 
FROM produtos 
ORDER BY preco_atual 
DESC LIMIT 10;

--- Quais produtos custam mais de R$ 500? (Exemplo 4)
SELECT nome_produto, 
preco_atual 
FROM produtos 
WHERE preco_atual > 500;

--- Quais produtos nunca foram vendidos? (Exemplo 15)
SELECT 
    p.id_produto,
    p.nome_produto,
    p.categoria,
    p.preco_atual,
    COUNT(v.id_venda) AS total_vendas
FROM 
    produtos p
    LEFT JOIN vendas v ON p.id_produto = v.id_produto
GROUP BY 
    p.id_produto, p.nome_produto, p.categoria, p.preco_atual
HAVING 
    COUNT(v.id_venda) = 0
ORDER BY 
    p.preco_atual DESC;

--- Classifique os produtos por faixa de preço (Exemplo 7)
SELECT 
    nome_produto,
    preco_atual,
    CASE 
        WHEN preco_atual < 100 THEN 'Econômico'
        WHEN preco_atual < 300 THEN 'Médio'
        WHEN preco_atual < 600 THEN 'Alto'
        ELSE 'Premium'
    END AS faixa_preco
FROM 
    produtos
ORDER BY 
    preco_atual DESC;
    
--- Quais produtos têm preço acima da média geral? (Exemplo 12)
SELECT nome_produto, 
preco_atual
FROM produtos 
WHERE preco_atual > (SELECT AVG(preco_atual) FROM PRODUTOS)
ORDER BY preco_atual DESC;