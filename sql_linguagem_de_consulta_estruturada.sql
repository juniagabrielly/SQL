/*Exercícos do PA BOND Módulo 2 - Aula 2*/
-- 1.Gere uma tabela com o id do cliente, a cidade e o estado onde ele vive

SELECT 
	c.customer_id,
	c.customer_city,
	c.customer_state
FROM
	customer c 

-- 2. Gere uma tabela com o id do cliente e a cidade, somente dos clientes que vivem em Santa Catarina.
	
SELECT
	c.customer_id ,
	c.customer_city
FROM 
	customer c
WHERE 
	c.customer_state = 'SC'
	
-- 3. Gere uma tabela com o id do cliente e o estado, somente dos clientes que vivem em Florianópolis.
	
SELECT
	c.customer_id,
	c.customer_state
FROM
	customer c 
WHERE
	c.customer_city = 'florianopolis'
	
-- 4. Gere uma tabela com o estado, latitude e longitude do estado de Sã Paulo

SELECT 
	c.customer_state,
	g.geolocation_lat,
	g.geolocation_lng
FROM
	customer c, 
	geolocation g
WHERE 
	c.customer_state = 'SP'

-- 5. Gere uma tabela com o id do produto, a data de envio e o preço, somente para produtos acima de 6300

SELECT 
	p.product_id,
	oi.shipping_limit_date,
	oi.price
FROM
	products p,
	order_items oi
WHERE 
	oi.price > 6300
	
/*6. Gere uma tabela com o id do pedido, o tipo de pagamento e o número de parcelas, somente para produtos 
com parcelas menores que 1.*/

SELECT 
	op.order_id,
	op.payment_type,
	op.payment_installments
FROM
	order_payments op 
WHERE 
	op.payment_installments < 1
	
/*7. Gere uma tabela com o id do pedido, id do cliente, o status do pedido e a data de aprovação , somente para
compras aprovadas até dia 05 de Outubro de 2016*/
 
SELECT
o.order_id ,
o.customer_id ,
o.order_status ,
o.order_approved_at
FROM orders o
WHERE o.order_approved_at < '2016-10-05'

/*Exercícos do PA BOND - Aula 3*/

/*1. Qual o número de clientes únicos do estado de Minas
Gerais?*/

SELECT
COUNT( DISTINCT customer_id )
FROM customer c
WHERE customer_state = 'MG'

/*2. Qual a quantidade de cidades únicas dos vendedores do
estado de Santa Catarina?*/

SELECT
COUNT (DISTINCT seller_city )
FROM sellers s
WHERE seller_state = 'SC'

/*3. Qual a quantidade de cidades únicas de todos os vendedores
da base?*/

SELECT
COUNT (DISTINCT seller_city )
FROM sellers s

/*4. Qual o número total de pedidos únicos acima de R$ 3.500*/

SELECT
COUNT( DISTINCT order_id )
FROM order_items oi
WHERE price > 3500

/*5. Qual o valor médio do preço de todos os pedidos?*/

SELECT
AVG( price )
FROM order_items oi

/*6. Qual maior valor de preço entre todos os pedidos?*/

SELECT
MAX( price )
FROM order_items oi

/*7. Qual o menor valor de preço entre todos os pedidos?*/

SELECT
MIN( price )
FROM order_items oi

/*8. Qual a quantidade de produtos distintos vendidos abaixo do
preço de R$ 100.00?*/

SELECT
COUNT( DISTINCT product_id )
FROM order_items oi
WHERE price < 100

/*9. Qual a quantidade de vendedores distintos que receberam
algum pedido antes do dia 23 de setembro de 2016?*/

SELECT
	COUNT( DISTINCT seller_id )
FROM 
	order_items oi
WHERE 
	shipping_limit_date < '2016-09-23 00:00:00'
	
/* 10. Quais os tipos de pagamentos existentes?*/

SELECT 
	DISTINCT op.payment_type
FROM
	order_payments op 
	
/* 11. Qual o maior número de parcelas realizado?*/
SELECT
MAX( payment_installments )
FROM order_payments op

/*12. Qual o menor número de parcelas realizado?*/

SELECT
MIN( payment_installments )
FROM order_payments op

/*13. Qual a média do valor pago no cartão de crédito?*/

SELECT 
	AVG(op.payment_value)
FROM 
	order_payments op 
WHERE
	op.payment_type = 'credit_card'

/*14. Quantos tipos de status para um pedido existem?*/

SELECT 
	COUNT( DISTINCT o.order_status )
FROM
	orders o 

/*15. Quais os tipos de status para um pedido?*/

SELECT
	DISTINCT order_status
FROM 
	orders o
	
/*16. Quantos clientes distintos fizeram um pedido?*/
	
SELECT
COUNT( DISTINCT customer_id )
FROM orders o

/*17. Quantos produtos estão cadastrados na empresa?*/

SELECT
COUNT( DISTINCT product_id )
FROM products p

/*18. Qual a quantidade máxima de fotos de um produto?*/

SELECT
MAX( DISTINCT product_photos_qty )
FROM products p

/*19. Qual o maior valor do peso entre todos os produtos?*/

SELECT
MAX( DISTINCT product_weight_g )
FROM products p

/*20. Qual a altura média dos produtos?*/

SELECT
AVG( DISTINCT product_height_cm )
FROM products p

/*Exercícos do PA BOND - Aula 4*/

/*1. Qual o número de clientes únicos de todos os estados?*/

SELECT 
	COUNT( DISTINCT c.customer_id ) AS 'Número de clientes únicos de todos os estados',
	c.customer_state AS Estados
FROM 	
	customer c 
GROUP BY c.customer_state 

/*2. Qual o número de cidades únicas de todos os estados?*/

SELECT 
	g.geolocation_state,	
	COUNT(DISTINCT g.geolocation_city) AS 'Número de cidades'
FROM
	geolocation g 
GROUP BY g.geolocation_state 

/*3. Qual o número de clientes únicos por estado e por cidade?*/

SELECT 
	c.customer_state,
	c.customer_city,
	COUNT(DISTINCT c.customer_id) AS 'Número de clientes'
FROM
	customer c
GROUP BY c.customer_state, c.customer_city

/*4. Qual o número de clientes únicos por cidade e por
estado?*/

SELECT 
c.customer_state,
	c.customer_city,
	COUNT(DISTINCT c.customer_id) AS 'Número de clientes'
FROM
	customer c
GROUP BY c.customer_city, c.customer_state

/*5. Qual o número total de pedidos únicos acima de R$
3.500 por cada vendedor?*/

SELECT 
	COUNT(DISTINCT  o.order_id) AS 'pedidos',
	o.seller_id AS 'vendedores',
	o.price
FROM 
	order_items o
WHERE 
	o.price > 3500
GROUP BY o.seller_id

/*6. Qual o número total de pedidos únicos, a data mínima e
máxima de envio, o valor máximo, mínimo e médio do frete
dos pedidos acima de R$ 1.100 por cada vendedor?*/
SELECT 
	oi.seller_id AS 'Vendedores',
	COUNT(DISTINCT oi.order_id) AS 'Pedidos',
	MIN(oi.shipping_limit_date) AS 'Mínima data',
	MAX(oi.shipping_limit_date) AS 'Máxima data',
	MIN(oi.freight_value) AS 'Valor Mínimo do Frete',
	MAX(oi.freight_value) AS 'Valor Máximo do Frete',
	AVG(oi.freight_value) AS 'Valor Médio do Frete'
FROM 
	order_items oi 
WHERE 
	oi.price > 1.100
GROUP BY oi.seller_id

/*7. Qual o valor médio, máximo e mínimo do preço de todos os pedidos de cada produto?*/

SELECT
oi.product_id,
AVG( oi.price ) AS preco_medio,
MIN( oi.price ) AS preco_minimo,
MAX( oi.price ) AS preco_maximo
FROM order_items oi
GROUP BY oi.product_id

/*8. Qual a quantidade de vendedores distintos que receberam algum pedido antes do dia 23 de setembro de
2016 e qual foi o preço médio desses pedidos?*/
SELECT
oi.shipping_limit_date,
COUNT( DISTINCT seller_id ) AS vendedores,
AVG( oi.price ) AS preco_medio
FROM order_items oi
WHERE shipping_limit_date < '2016-09-23 00:00:00'
GROUP by oi.shipping_limit_date

/*9. Qual a quantidade de pedidos por tipo de pagamentos?*/

SELECT
payment_type,
COUNT( op.order_id ) as pedidos
FROM order_payments op
GROUP BY op.payment_type

/*10. Qual a quantidade de pedidos, a média do valor do
pagamento e o número máximo de parcelas por tipo de
pagamentos?*/

SELECT
payment_type,
COUNT( op.order_id ) AS pedidos,
AVG( op.payment_value ) AS pagamento_medio,
MAX( op.payment_installments ) AS maior_numero_parcelas
FROM order_payments op
GROUP BY op.payment_type

/*11. Qual a valor mínimo, máximo, médio e as soma total
paga por cada tipo de pagamento e número de parcelas
disponíveis?*/

SELECT
payment_type,
payment_installments,
MIN( payment_value ) AS pagamento_minimo,
MAX( payment_value ) AS pagamento_maximo,
AVG( payment_value ) AS pagamento_medio,
SUM( payment_value ) AS pagamento_total
FROM order_payments op
GROUP BY payment_type, payment_installments

/*12. Qual a média de pedidos por cliente?*/

SELECT
customer_id ,
AVG( order_id ) AS media_pedidos
FROM orders o
GROUP BY customer_id

/*13. Qual a quantidade de pedidos por status?*/
SELECT
count(*) as qtd_produtos,
order_status
from orders
GROUP by order_status

/*14. Qual a quantidade de pedidos realizados por dia, a
partir do dia 23 de Setembro de 2016?*/

SELECT
DATE( order_approved_at ) AS data_ ,
COUNT( order_id ) AS pedidos
FROM orders o
WHERE order_approved_at > '2016-09-23 00:00:00'
GROUP BY DATE( order_approved_at )


/*15. Quantos produtos estão cadastrados na empresa por
categoria?*/

SELECT
product_category_name ,
COUNT( DISTINCT product_id ) AS produtos
FROM products p
GROUP BY product_category_name

/*Exercícos do PA BOND - Aula 5*/
/*1. Qual o número de clientes únicos do estado de São
Paulo?*/

SELECT
COUNT( DISTINCT c.customer_id ) AS numero_clientes
FROM customer c
WHERE c.customer_state = 'SP'

/*3. Qual o número total de pedidos únicos feitos a partir do
dia 08 de Outubro de 2016*/

SELECT
COUNT( DISTINCT order_id )
FROM order_items oi
WHERE DATE( shipping_limit_date ) > '2016-10-08'

/*4. Qual o número total de pedidos únicos feitos a partir do
dia 08 de Outubro de 2016 incluso.*/

SELECT
COUNT( DISTINCT order_id )
FROM order_items oi
WHERE DATE( shipping_limit_date ) >= '2016-10-08'

/*5. Qual o número total de pedidos únicos e o valor médio
do frete dos pedidos abaixo de R$ 1.100 por cada vendedor*/

SELECT
oi.seller_id,
COUNT( DISTINCT oi.order_id ) AS pedidos_unicos,
AVG( oi.freight_value ) AS valor_frete_medio
FROM order_items oi
WHERE price < 1100
GROUP BY oi.seller_id

/*6. Qual o número total de pedidos únicos, a data mínima e
máxima de envio, o valor máximo, mínimo e médio do frete
dos pedidos abaixo de R$ 1.100 incluso por cada vendedor?*/

SELECT
oi.seller_id as VENDEDOR,
COUNT(DISTINCT oi.order_id) as TOTAL_PEDIDOS,
MIN(oi.shipping_limit_date) as DT_MIN_ENVIO,
MAX(oi.shipping_limit_date) as DT_MAX_ENVIO,
MAX(oi.freight_value) as VL_MAX_FRETE,
MIN(oi.freight_value) as VL_MIN_FRETE,
AVG(oi.freight_value) as VL_MEDIO_FRETE
FROM order_items oi
WHERE freight_value <= 1100
GROUP BY oi.seller_id

/*Exercícos do PA BOND Módulo 2 - Aula 6*/
/*1. Qual o número de clientes únicos nos estado de Minas Gerais ou Rio de
Janeiro?*/

SELECT COUNT(DISTINCT  c.customer_state ) AS 'número de clientes',
c.customer_state AS 'Estados'
FROM customer c 
WHERE c.customer_state = 'RJ' or c.customer_state ='MG'
GROUP BY c.customer_state

/*2. Qual a quantidade de cidades únicas dos vendedores no estado de São
Paulo ou Rio de Janeiro com a latitude maior que -24.54 e longitude menor que
-45.63?*/

SELECT
	s.seller_state,
	COUNT(distinct s.seller_city),
	g.geolocation_city,
	g.geolocation_state,
	g.geolocation_lat,
	g.geolocation_lng
FROM 
	sellers s,
	geolocation g
WHERE 
	s.seller_state = g.geolocation_state,
	s.seller_city = g.geolocation_city,
	s.seller_city = 'SP' ors.seller_city = 'RJ'
	AND g.geolocation_lat > '-24,54' AND g.geolocation_lng < '-45,63'
GROUP BY
g.geolocation_state

/*3. Qual o número total de pedidos únicos, o número total de produtos e o
preço médio dos pedidos com o preço de frete maior que R$ 20 e a data limite
de envio entre os dias 1 e 31 de Outubro de 2016?*/
SELECT
	COUNT(DISTINCT oi.order_id),
	COUNT(oi.product_id),
	AVG(oi.price)
FROM order_items oi 
WHERE 
	oi.freight_value > 20 
	AND DATE(oi.shipping_limit_date) >= '2016-10-01' 
	AND DATE(oi.shipping_limit_date) <= '2016-10-31'


/* 4. Mostre a quantidade total dos pedidos e o valor total do pagamento, para
pagamentos entre 1 e 5 prestações ou um valor de pagamento acima de R$
5000. Agrupe por quantidade de prestações.*/
	
SELECT 
	op.payment_installments AS 'prestações',
	COUNT(op.order_id) AS 'Quantidade_total_pedidos',
	COUNT(op.payment_value) AS 'Valor_total'
FROM
	order_payments op 
WHERE (op.payment_installments >= '1' AND op.payment_installments <= '5')
	  OR (op.payment_value > '5000')
GROUP BY op.payment_installments 

/*5. Qual a quantidade de pedidos com o status em processamento ou
cancelada acontecem com a data estimada de entrega maior que 01 de Janeiro
de 2017 ou menor que 23 de Novembro de 2016?*/

SELECT
order_status ,
COUNT( order_id ) AS pedidos
FROM orders o
WHERE ( order_status = 'processing' OR order_status = 'canceled' )
AND ( o.order_estimated_delivery_date > '2017-01-01' OR o.order_estimated_delivery_date < '2016-11-23' )
GROUP BY order_status

/*6. Quantos produtos estão cadastrados nas categorias: perfumaria,
brinquedos, esporte lazer, cama mesa e banho e móveis de escritório que
possuem mais de 5 fotos, um peso maior que 5 g, um altura maior que 10 cm,
uma largura maior que 20 cm?*/

SELECT
product_category_name ,
COUNT( DISTINCT product_id )
FROM products p
WHERE ( product_category_name = 'perfumaria'
OR product_category_name = 'brinquedos'
OR product_category_name = 'esporte_lazer'
OR product_category_name = 'cama_mesa_banho'
OR product_category_name = 'moveis_escritorio')
AND product_photos_qty > 5
AND product_weight_g > 5
AND product_height_cm > 10
AND product_width_cm > 20
GROUP BY product_category_name

/*Exercícos do PA BOND Módulo 2 - Aula 7*/

/*1. Quantos clientes únicos tiveram seu pedidos com status de “processing”,
“shipped” e “delivered”, feitos entre os dias 01 e 31 de Outubro de 2016.
Mostrar o resultado somente se o número total de clientes for acima de 5.*/

SELECT 
	COUNT(DISTINCT o.customer_id) AS 'Clientes',
	o.order_status AS 'status_pedidos'
FROM 
	orders o 
WHERE
	o.order_status IN ('processing','shipped','delivered')
	AND o.order_purchase_timestamp BETWEEN '2016-10-01' AND '2016-10-31'
	GROUP BY o.order_status 
	HAVING COUNT(DISTINCT o.customer_id) > 5

/*2. Mostre a quantidade total dos pedidos e o valor total do pagamento, para
pagamentos entre 1 e 5 prestações ou um valor de pagamento acima de R$
5000.*/
	
SELECT 
	COUNT(op.order_id) AS 'quantidade_de_pedidos',
	SUM(op.payment_value) AS 'valor_total',
	op.payment_installments AS 'numero_de_pretacoes'
FROM 
	order_payments op 
WHERE 
	op.payment_installments BETWEEN '1' AND '5'
	OR op.payment_value > '5000'
	GROUP BY op.payment_installments
/*Exercícos do ciclo 3 - Módulo 5*/
	
/*1. Gerar uma tabela de dados com 10 linhas, contendo o id do pedido, o id do cliente, o status do pedido, o id do produto
e o preço do produto.*/
	
SELECT 
	o.order_id AS 'id_do_pedido',
	o.customer_id AS 'id_do_cliente',
	o.order_status AS 'status_do_pedido',
	oi.product_id AS 'id_do_produto',
	oi.price AS 'preço_do_produto'
FROM 
	orders o INNER JOIN order_items oi ON (o.order_id = oi.order_id)
	LIMIT 10

/*2. Gerar uma tabela de dados com 20 linhas, contendo o id do pedido, o estado do cliente, a cidade do cliente, o status
do pedido, o id do produto e o preço do produto, somente para clientes do estado de São Paulo*/
	
SELECT 
	o.order_id AS 'id_do_pedido',
	c.customer_state AS 'estado_do_cliente',
	c.customer_city AS 'cidade_do_cliente',
	o.order_status AS 'status_do_pedido',
	oi.product_id AS 'id_do_produto',
	oi.price AS 'preço_do_produto'
FROM 
	orders o INNER JOIN customer c ON (c.customer_id = o.customer_id)
			 INNER JOIN order_items oi ON (oi.order_id = o.order_id)
WHERE 
	c.customer_state = 'SP'
	LIMIT 20
	
/*3. Gerar uma tabela de dados com 50 linhas, contendo o id do pedido, o estado e a cidade do cliente, o status do
pedido, o nome da categoria do produto e o preço do produto, somente para pedidos com o status igual a
cancelado.*/

SELECT 
	o.order_id AS 'id_do_pedido',
	c.customer_state AS 'estado_do_cliente',
	c.customer_city AS 'cidade_do_cliente',
	o.order_status AS 'status_do_pedido',
	p.product_category_name AS 'categoria_do_produto',
	oi.price AS 'preço_do_produto'
FROM 
	orders o INNER JOIN customer c ON (c.customer_id = o.customer_id)
			 INNER JOIN order_items oi ON (oi.order_id = o.order_id)
			 INNER JOIN products p ON (p.product_id = oi.product_id)
WHERE 
	o.order_status = 'canceled'
	LIMIT 50
	
/* 4. Gerar uma tabela de dados com 80 linhas, contendo o id do pedido, o estado e a cidade do cliente, o status do pedido,
o nome da categoria do produto, o preço do produto, a cidade e o estado do vendedor e a data de aprovação do
pedido, somente para os pedidos aprovadas a partir do dia 16 de Setembro de 2016.*/	

SELECT 	
	o.order_id AS 'id_do_pedido',
	c.customer_state AS 'estado_do_cliente',
	c.customer_city AS 'cidade_do_cliente',
	o.order_status AS 'status_do_pedido',
	p.product_category_name AS 'categoria_do_produto',
	oi.price AS 'preço_do_produto',
	o.order_approved_at AS 'data_da_aprovacao'
FROM 
	orders o INNER JOIN customer c ON (c.customer_id = o.customer_id)
			 INNER JOIN order_items oi ON (oi.order_id = o.order_id)
			 INNER JOIN products p ON (p.product_id = oi.product_id)
			 INNER JOIN sellers s ON (s.seller_id = oi.seller_id)
WHERE 
	o.order_approved_at > '2016-09-16 00:00:00'
LIMIT 80

	


	
	










	


