--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-10-12 15:36:52

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5182 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 229 (class 1255 OID 16505)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
   NEW.updated_at = NOW();
   RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 16526)
-- Name: cart_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_items (
    cart_item_id integer NOT NULL,
    cart_id integer,
    product_id integer,
    quantity integer DEFAULT 1,
    price numeric(10,2) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.cart_items OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16525)
-- Name: cart_items_cart_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cart_items_cart_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cart_items_cart_item_id_seq OWNER TO postgres;

--
-- TOC entry 5183 (class 0 OID 0)
-- Dependencies: 223
-- Name: cart_items_cart_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cart_items_cart_item_id_seq OWNED BY public.cart_items.cart_item_id;


--
-- TOC entry 222 (class 1259 OID 16513)
-- Name: carts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carts (
    cart_id integer NOT NULL,
    user_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.carts OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16512)
-- Name: carts_cart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carts_cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carts_cart_id_seq OWNER TO postgres;

--
-- TOC entry 5184 (class 0 OID 0)
-- Dependencies: 221
-- Name: carts_cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carts_cart_id_seq OWNED BY public.carts.cart_id;


--
-- TOC entry 218 (class 1259 OID 16413)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    category_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16412)
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_category_id_seq OWNER TO postgres;

--
-- TOC entry 5185 (class 0 OID 0)
-- Dependencies: 217
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- TOC entry 228 (class 1259 OID 43162)
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    order_item_id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    price numeric(10,2) NOT NULL
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 43161)
-- Name: order_items_order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_order_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_order_item_id_seq OWNER TO postgres;

--
-- TOC entry 5186 (class 0 OID 0)
-- Dependencies: 227
-- Name: order_items_order_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_order_item_id_seq OWNED BY public.order_items.order_item_id;


--
-- TOC entry 226 (class 1259 OID 43145)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    user_id integer NOT NULL,
    total_price numeric(10,2) NOT NULL,
    status character varying(255) DEFAULT 'pendente'::character varying NOT NULL,
    payment_method character varying(255) NOT NULL,
    address character varying(255),
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 43144)
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_order_id_seq OWNER TO postgres;

--
-- TOC entry 5187 (class 0 OID 0)
-- Dependencies: 225
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- TOC entry 220 (class 1259 OID 16422)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    product_id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    price numeric(10,2) DEFAULT 0 NOT NULL,
    stock integer NOT NULL,
    category_id integer NOT NULL,
    unit_price numeric(10,2) DEFAULT 0 NOT NULL,
    box_price numeric(10,2) DEFAULT 0 NOT NULL,
    image_url text DEFAULT ''::text
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16421)
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_product_id_seq OWNER TO postgres;

--
-- TOC entry 5188 (class 0 OID 0)
-- Dependencies: 219
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;


--
-- TOC entry 216 (class 1259 OID 16400)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    name character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    created_at timestamp with time zone,
    phone character varying(255) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16399)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 5189 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 4728 (class 2604 OID 16529)
-- Name: cart_items cart_item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN cart_item_id SET DEFAULT nextval('public.cart_items_cart_item_id_seq'::regclass);


--
-- TOC entry 4726 (class 2604 OID 16516)
-- Name: carts cart_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts ALTER COLUMN cart_id SET DEFAULT nextval('public.carts_cart_id_seq'::regclass);


--
-- TOC entry 4720 (class 2604 OID 16416)
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- TOC entry 4733 (class 2604 OID 43165)
-- Name: order_items order_item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN order_item_id SET DEFAULT nextval('public.order_items_order_item_id_seq'::regclass);


--
-- TOC entry 4731 (class 2604 OID 43148)
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- TOC entry 4721 (class 2604 OID 16425)
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- TOC entry 4719 (class 2604 OID 16403)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 5172 (class 0 OID 16526)
-- Dependencies: 224
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_items (cart_item_id, cart_id, product_id, quantity, price, created_at) FROM stdin;
\.


--
-- TOC entry 5170 (class 0 OID 16513)
-- Dependencies: 222
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carts (cart_id, user_id, created_at) FROM stdin;
\.


--
-- TOC entry 5166 (class 0 OID 16413)
-- Dependencies: 218
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (category_id, name, description) FROM stdin;
1	Gaseificados	Bebidas gaseificadas e saborizadas
2	Balas/Doces/Gomas	Balas, doces e gomas de mascar
3	Destilados	Bebidas alcoólicas destiladas
4	Fermentadas	Bebidas alcoólicas fermentadas
5	Adega	Vinhos e outras bebidas da adega
6	Tabacaria	Produtos relacionados a tabaco
7	Drinks Prontos	Drinks prontos para o consumo
8	Outros	Outros produtos diversos
\.


--
-- TOC entry 5176 (class 0 OID 43162)
-- Dependencies: 228
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (order_item_id, order_id, product_id, quantity, price) FROM stdin;
\.


--
-- TOC entry 5174 (class 0 OID 43145)
-- Dependencies: 226
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, user_id, total_price, status, payment_method, address, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 5168 (class 0 OID 16422)
-- Dependencies: 220
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (product_id, name, description, price, stock, category_id, unit_price, box_price, image_url) FROM stdin;
123	Gatorade Laranja 500ml	Gatorade oferece uma explosão de energia com uma variedade de sabores que atendem ao gosto de cada atleta. 	2.00	100	1	7.00	40.00	/images/40.png
124	Gatorade Tangerina 500ml	Gatorade oferece uma explosão de energia com uma variedade de sabores que atendem ao gosto de cada atleta. 	2.00	100	1	7.00	40.00	/images/40.png
125	Gatorade Maracujá 500ml	Gatorade oferece uma explosão de energia com uma variedade de sabores que atendem ao gosto de cada atleta. 	2.00	100	1	7.00	40.00	/images/41.png
126	Sucos Del Valle Uva 1L	Desde 1947, Del Valle Uva traz o sabor puro e intenso das vinhas diretamente para o seu copo.	2.00	100	1	11.00	60.00	/images/50.png
127	Sucos Del Valle Maracuja 1L	Explore o sabor tropical e vibrante do maracujá com Del Valle, perfeito para refrescar qualquer momento do seu dia.	2.00	100	1	11.00	60.00	/images/54.png
128	Sucos Del Valle Manga 1L	Saboreie a doçura natural da manga com o suco Del Valle, uma explosão tropical a cada gole.	2.00	100	1	11.00	60.00	/images/52.png
129	Sucos Del Valle Pessego 1L	Del Valle Pêssego envolve você em um sabor suave e reconfortante, ideal para uma pausa relaxante.	2.00	100	1	11.00	60.00	/images/53.png
130	Sucos Del Valle Abacaxi 1L	Refrescante e picante, o suco de abacaxi Del Valle é a sua escapadela tropical sem sair de casa.	2.00	100	1	11.00	60.00	/images/55.png
131	Sucos Del Valle Laranja 1L	Prensado da fruta, Del Valle Laranja oferece toda a vitamina C e o frescor que você precisa para começar o dia energizado.	2.00	100	1	11.00	60.00	/images/51.png
137	Agua Com Gás 500ml	Com um toque de efervescência, nossa Água Com Gás eleva sua experiência de hidratação.	2.00	100	1	4.00	30.00	/images/65.png
138	Agua Sem gás 500ml	Mantenha-se hidratado com a conveniência e pureza da nossa Água Sem Gás em 500ml.	2.00	100	1	3.00	28.00	/images/64.png
139	Toddynho 200ml	O lanche divertido e nutritivo que as crianças adoram, Toddynho é o parceiro ideal para a energia dos pequenos.	2.00	100	1	4.00	85.05	/images/62.png
301	Suco Kapo Maracuja 200ml\n	...	2.00	100	1	3.50	42.00	/images/59.png
302	Suco Kapo Abacaxi 200 ml 	...\n	2.00	100	1	3.50	42.00	/images/60.png
303	Suco Kapo Laranja 200ml 	...\n	2.00	100	1	3.50	42.00	/images/61.png
76	Ice 51 Morango+Laranja 275ml	Ice 51 Morango+Laranja 275ml	2.00	100	7	8.00	42.00	/images/w4.png
401	Gelo Uva\n	...	2.00	100	8	7.00	1.00	/images/k3.png
403	Gelo Maça Verde 	...	2.00	100	8	7.00	1.00	/images/k1.png
402	Gelo Abacaxi 	...	2.00	100	8	7.00	1.00	/images/k2.png
5	Dunhill-One Red	Cigarro Dunhill One Red	2.00	100	6	13.00	72.00	/images/156.png
7	Rothmans Red-Box	Cigarro Rothmans Red Box	2.00	100	6	9.50	60.00	/images/160.png
8	Rothmans Blue Global Connection	Cigarro Rothmans Blue Global Connection	2.00	100	6	8.00	63.00	/images/161.png
9	Lucky Strike (Hollywood) Original-Box	Cigarro Lucky Strike (Hollywood) Original Box	2.00	100	6	13.00	66.00	/images/164.png
10	Luck Strike Fresh Double Ice-Box	Cigarro Luck Strike Fresh Double Ice Box	2.00	100	6	13.00	69.00	/images/162.png
11	Lucky Strike Fresh Wild	Cigarro Lucky Strike Fresh Wild	2.00	100	6	13.00	66.00	/images/163.png
12	Kent Red Prime-Box	Cigarro Kent Red Prime Box	2.00	100	6	9.00	60.00	/images/Kent.png\n
13	Duhill Evoque-Box	Cigarro Duhill Evoque Box	2.00	100	6	15.00	75.00	/images/158.png
14	Duhill Tropical-Box	Cigarro Duhill Tropical Box	2.00	100	6	15.00	75.00	/images/157.png
15	Gudan Garan	Cigarro Gudan Garan	2.00	100	6	35.00	48.00	/images/165.png
16	Black	Cigarro Black	2.00	100	6	25.00	48.00	/images/166.png
17	Fumo Trevo	Fumo Trevo	2.00	100	6	6.00	36.00	/images/188.png
18	Fumo Cavalinho	Fumo Cavalinho	2.00	100	6	6.00	39.00	/images/187.png
19	Papel Trevo	Papel para enrolar Trevo, leve e resistente, perfeito para uma queima suave e controlada.	2.00	100	6	3.00	15.00	/images/209.png
20	Palha Jurupi	Palha para enrolar Jurupi, a escolha natural para um palheiro tradicional.	2.00	100	6	7.00	18.00	/images/213.png
21	Palheiro Paulistinha Tradicional	Palheiro Paulistinha Tradicional, com fumo de alta qualidade para uma experiência clássica e suave.	2.00	100	6	30.00	30.00	/images/168.png
22	Palheiro Paulistinha Ouro	Palheiro Paulistinha Ouro, fumo selecionado com cuidado para proporcionar uma experiência refinada.	2.00	100	6	35.00	33.00	/images/167.png
23	Palheiro Paulistinha Menta	Palheiro Paulistinha Menta, uma combinação refrescante de fumo de qualidade e toque de menta.	2.00	100	6	32.00	33.00	/images/169.png
24	Palheiro Paulistinha Cereja	Palheiro Paulistinha Cereja, com um toque doce e aromático para uma experiência única.	2.00	100	6	32.00	36.00	/images/170.png
25	Palheiro Piracanjuba Tradicional	Palheiro Piracanjuba Tradicional, um clássico que combina fumo de alta qualidade e tradição.	2.00	100	6	23.00	30.00	/images/171.png
26	Palheiro Piracanjuba Ouro	Palheiro Piracanjuba Ouro, com fumo selecionado e sabor intenso para os apreciadores exigentes.	2.00	100	6	25.00	36.00	/images/172.png
27	Palheiro Souza Paiol Tradicional	Palheiro Souza Paiol Tradicional, feito com fumo de alta qualidade, preservando a tradição do palheiro brasileiro.	2.00	100	6	20.00	33.00	/images/177.png
28	Palheiro Souza Paiol Ouro	Palheiro Souza Paiol Ouro, com fumo premium para uma experiência mais sofisticada e intensa.	2.00	100	6	25.00	36.00	/images/178.png
194	Trident Melancia	Experimente a refrescância suculenta de Melancia com Trident, garantindo frescor prolongado e gosto delicioso.	2.00	100	2	3.00	84.48	/images/94.png
195	Trident Tutti-Frutti	Trident Tutti-Frutti é uma festa de sabores frutados na sua boca, ideal para alegrar qualquer momento.	2.00	100	2	3.00	84.48	/images/94.png
196	Trident Hortelã/Menta	Desfrute da sensação revigorante de Trident Hortelã/Menta, que oferece frescor duradouro e um sabor puro.	2.00	100	2	3.00	84.48	/images/94.png
197	Trident Intense	Trident Intense é para aqueles momentos que pedem um sabor mais forte e uma sensação mais intensa.	2.00	100	2	3.00	84.48	/images/94.png
198	Halls Extra-Forte	Halls Extra-Forte proporciona um alívio imediato e intenso, ideal para respirar mais fundo.	2.00	100	2	3.00	66.00	/images/95.png
199	Halls Melancia	Refresque-se com o sabor doce e suculento de Halls Melancia, perfeito para uma pausa refrescante.	2.00	100	2	3.00	66.00	/images/95.png
200	Halls Morango	Halls Morango traz o gosto doce e refrescante de morangos frescos em um formato prático e delicioso.	2.00	100	2	3.00	66.00	/images/95.png
201	Halls Uva Verde	Experimente o sabor levemente ácido e totalmente refrescante de Halls Uva Verde, um clássico amado.	2.00	100	2	3.00	66.00	/images/95.png
202	Halls Hortelã	Halls Hortelã oferece um sopro de frescor puro e cristalino, ideal para clarear sua mente e seu paladar.	2.00	100	2	3.00	66.00	/images/95.png
203	Halls Menta	Desfrute da frescura duradoura de Halls Menta, que limpa o paladar e refresca o hálito com sua potência.	2.00	100	2	3.00	66.00	/images/95.png
29	Palheiro Souza Paiol Mama Cadela	Palheiro Souza Paiol Mama Cadela, uma experiência única com fumo de qualidade e sabor marcante.	2.00	100	6	20.00	42.00	/images/179.png
30	Palheiro Jack Paiols Ouro	Palheiro Jack Paiols Ouro, feito com fumo refinado para os apreciadores de um bom palheiro.	2.00	100	6	25.00	39.00	/images/176.png
31	Palheiro Jack Paiols Cereja	Palheiro Jack Paiols Cereja, com um toque doce de cereja, perfeito para quem busca um sabor diferenciado.	2.00	100	6	22.00	42.00	/images/175.png
32	Palheiro Jack Paiols Ice	Palheiro Jack Paiols Ice, uma combinação refrescante de fumo com notas de menta para uma experiência fresca.	2.00	100	6	15.00	42.00	/images/174.png
33	Palheiro Jack Paiols Uva	Palheiro Jack Paiols Uva, um toque frutado de uva que adiciona uma nova dimensão ao palheiro tradicional.	2.00	100	6	15.00	42.00	/images/173.png
34	Seda Zomo Natural Perfect	Seda Zomo Natural Perfect, uma opção natural e suave para uma queima limpa e agradável.	2.00	100	6	5.00	18.00	/images/190.png
35	Seda Zomo Slim Alfafa	Seda Zomo Slim Alfafa, feita com materiais naturais para uma queima lenta e uniforme.	2.00	100	6	6.00	18.00	/images/191.png
36	Seda Zomo Natural Mini	Seda Zomo Natural Mini, compacta e prática, perfeita para quem busca conveniência e qualidade.	2.00	100	6	4.00	15.00	/images/192.png
37	Smoking Brown King Size	Seda Smoking Brown King Size	2.00	100	6	10.00	21.00	/images/202.png
38	Smoking Master King Size	Seda Smoking Master King Size	2.00	100	6	10.00	21.00	/images/204.png
39	Smoking Deluxe King Size	Seda Smoking Deluxe King Size	2.00	100	6	10.00	24.00	/images/203.png
40	Seda Papelito C. Piteira Tradicional	Seda Papelito com Piteira Tradicional, prática e com piteira integrada para maior conforto e controle durante a queima.	2.00	100	6	12.00	18.00	/images/201.png
41	Seda Papelito C. Piteira Brown	Seda Papelito com Piteira Brown, feita com papel não branqueado e piteira integrada para uma experiência mais natural.	2.00	100	6	12.00	18.00	/images/200.png
42	Seda Papelito Tradicional	Seda Papelito Tradicional, uma escolha clássica para quem busca uma seda de qualidade com queima uniforme.	2.00	100	6	10.00	15.00	/images/193.png
43	Seda Papelito Slim	Seda Papelito Slim, com queima lenta e tamanho compacto, ideal para quem prefere praticidade.	2.00	100	6	10.00	15.00	/images/196.png
225	Conhaque São Joao Da Barra 1L	Desde 1849, Conhaque São João da Barra é sinônimo de tradição e qualidade. Seu sabor encorpado e refinado agrada aos paladares mais exigentes.	2.00	100	3	28.00	180.00	/images/135.png
226	Conhaque Dreher 1L	Com mais de 100 anos de história, Dreher é o conhaque mais vendido no Brasil. Seu sabor suave e frutado é perfeito para ser apreciado puro ou em drinks.	2.00	100	3	25.00	270.00	/images/130.png
227	Conhaque Presidente 1L	Com sua história rica e sabor aveludado, o Conhaque Presidente é ideal para aquecer momentos especiais, trazendo notas de frutas secas e especiarias.	2.00	100	3	18.00	110.00	/images/129.png
228	Martinis Biano 1L	Desde 1863, Martini Bianco é sinônimo de sofisticação. Este vermute combina ervas aromáticas com flores brancas, resultando em um sabor suave e equilibrado.	2.00	100	3	34.00	408.00	/images/m1.png
229	Leão Do Norte 1L	Leão do Norte é uma aguardente brasileira que representa a força e a tradição do nordeste. Com sabor forte e marcante, é ideal para ser apreciada pura ou em drinks.	2.00	100	3	20.00	276.00	/images/145.png
230	Vodka Orllof 1L	Orloff é uma vodka clássica e versátil, perfeita para qualquer ocasião. Com sua pureza e leveza, é ideal para ser apreciada em coquetéis ou pura com gelo.	2.00	100	3	38.00	456.00	/images/123.png
231	Vodka Sminorf 1L	Desde 1864, Smirnoff é reconhecida mundialmente por sua qualidade e suavidade. Com tripla destilação, é perfeita para criar os melhores drinks ou ser apreciada pura.	2.00	100	3	45.00	520.00	/images/124.png
232	Vodka Absolut 1L	Produzida na Suécia desde 1879, Absolut é uma das vodkas mais puras do mundo, feita com ingredientes naturais e sem adição de açúcar. A vodka que se destaca em qualquer ocasião.	2.00	100	3	110.00	1320.00	/images/125.png
233	Gin Tanqueray Flor De Sevilla 700ml	Tanqueray Flor de Sevilla combina a tradição inglesa com o sabor vibrante das laranjas de Sevilha. Um gin distinto, com notas cítricas perfeitas para coquetéis únicos.	2.00	100	3	150.00	1680.00	/images/147.png
234	Gin Taqueray Londo Dry 750ml	Com 180 anos de tradição, Tanqueray London Dry é a definição de gin clássico. Seu sabor seco e equilibrado, com botânicos refinados, faz dele uma escolha impecável.	2.00	100	3	160.00	1500.00	/images/146.png
235	Gin Tanqueray Royale 700ml	Tanqueray Royale é um gin luxuoso com toques de cassis, inspirado nos vinhedos franceses. Rico em sabor, é ideal para os apreciadores de coquetéis sofisticados.	2.00	100	3	170.00	1800.00	/images/148.png
236	Licor 43 (Cuarenta y Tres) 700ml	Desde 1946, Licor 43 é elaborado a partir de uma receita secreta com 43 ingredientes. Suas notas de baunilha e frutas cítricas o tornam irresistivelmente doce e equilibrado.	2.00	100	3	170.00	1020.00	/images/106.png
237	Gin Rock's Tradicional 1L	Rock's Tradicional é um gin brasileiro de alta qualidade, feito com botânicos cuidadosamente selecionados. Suave e aromático, é perfeito para drinks sofisticados.	2.00	100	3	45.00	234.00	/images/142.png
239	Gin Rock's Sunset 1L	Com um perfil aromático envolvente, Gin Rock’s Sunset mistura botânicos exóticos para criar uma experiência vibrante e revigorante, ideal para momentos descontraídos.	2.00	100	3	45.00	234.00	/images/144.png
240	Bananazinha 1 L	Um licor brasileiro tradicional que combina a doçura da banana com a intensidade de uma aguardente. Perfeito para ser apreciado puro ou em sobremesas.	2.00	100	3	60.00	300.00	/images/117.png
241	Motila Carta Cristal 1L	Montilla Carta Cristal é um rum leve e cristalino, ideal para coquetéis tropicais. Seu sabor suave e sutil é perfeito para quem aprecia drinks refrescantes.	2.00	100	3	46.00	1.00	/images/132.png
242	Montila Carta Branca 1L	Montilla Carta Branca oferece a pureza e tradição do rum clássico, com notas leves de baunilha e caramelo. Ideal para coquetéis como mojitos e daiquiris.	2.00	100	3	46.00	1.00	/images/133.png
44	Seda Papelito Brown	Seda Papelito Brown, uma opção mais natural, sem produtos químicos, para uma queima mais limpa.	2.00	100	6	10.00	15.00	/images/194.png
45	Seda Papelito Brawn Slim	Seda Papelito Brawn Slim, perfeita para quem procura uma seda fina com um toque mais natural.	2.00	100	6	10.00	15.00	/images/195.png
46	Seda Papelito Mini Tradicional	Seda Papelito Mini Tradicional, compacta e prática, ideal para quem busca conveniência sem perder a qualidade.	2.00	100	6	5.00	15.00	/images/197.png
47	Seda Papelito Mini Brawn	Seda Papelito Mini Brawn, uma versão menor da clássica Brawn, ideal para quem busca uma queima rápida e natural.	2.00	100	6	5.00	15.00	/images/199.png
48	Piteira Papelito Tradicional	Piteira Papelito Tradicional, projetada para maior conforto e controle durante o uso, feita com papel de qualidade.	2.00	100	6	4.00	18.00	/images/205.png
57	Carvão Zomo	Carvão Zomo, perfeito para garantir uma queima consistente e prolongada durante o uso de narguilés.	2.00	100	6	1.50	30.00	/images/183.png
58	Papel Alumínio Brasuka	Papel Alumínio Brasuka, ideal para o preparo de narguilé, proporcionando um aquecimento uniforme e duradouro.	2.00	100	6	1.00	40.00	/images/182.png
60	Borracha Vaso 30cm	Borracha Vaso 30cm, essencial para garantir a vedação perfeita em narguilés de maior tamanho.	2.00	100	6	7.00	1.00	/images/214.png
61	Borracha Vaso 26cm	Borracha Vaso 26cm, ideal para vedar narguilés de médio porte com segurança e eficiência.	2.00	100	6	7.00	1.00	/images/215.png
67	Massarico Firestar	Massarico Firestar, compacto e eficiente, oferecendo a precisão necessária para acender rapidamente qualquer objeto.	2.00	100	6	25.00	1.00	/images/153.png
68	Fosforo	Caixa de fósforo, um item essencial e prático para acender fogo em diversas situações cotidianas.	2.00	100	6	1.00	12.00	/images/154.png
69	Skol Beats Sense 269ml	Skol Beats Sense 269ml	2.00	100	7	9.00	50.00	/images/240.png
70	Skol Beats GT 269ml	Skol Beats GT 269ml	2.00	100	7	9.00	50.00	/images/239.png
71	Skol Beats Tropical 269ml	Skol Beats Tropical 269ml	2.00	100	7	9.00	50.00	/images/241.png
72	Ice Smirnoff Limão 275ml	Ice Smirnoff Limão 275ml	2.00	100	7	9.00	50.00	/images/245.png
243	Montilla Carta Ouro 1L	Com notas ricas de carvalho e mel, Montilla Carta Ouro é um rum premium envelhecido, perfeito para ser apreciado puro ou em coquetéis sofisticados.	2.00	100	3	46.00	1.00	/images/131.png
244	Pinga Da Terra Tradicional 1L	Pinga da Terra Tradicional captura a essência da cachaça brasileira com um sabor intenso e puro, ideal para quem aprecia o autêntico sabor das destilarias artesanais.	2.00	100	3	22.00	1.00	/images/118.png
245	Pinga da Terra de saborizada 1L	A Pinga da Terra Saborizada oferece uma explosão de sabores frutados, trazendo inovação e frescor à tradicional cachaça brasileira. Perfeita para caipirinhas ousadas.	2.00	100	3	25.00	1.00	/images/119.png
246	Champanhe Aurora Tradicional 1L	Desde 1875, Aurora Tradicional é símbolo de celebração. Com perlage fina e sabor fresco, este espumante é ideal para brindar momentos especiais com elegância.	2.00	100	3	45.00	1.00	/images/120.png
247	Champanhe Aurora Rose 1L	Com um delicado tom rosé e sabor frutado, Aurora Rosé é o espumante perfeito para ocasiões que pedem sofisticação e leveza. Ideal para brindar a vida com estilo.	2.00	100	3	45.00	1.00	/images/121.png
270	Vinho Pérgola Tinto (Suave) 1L	Vinho Pérgola Tinto (Suave)	2.00	100	5	30.00	285.00	/images/103.png
62	Borracha Magueira	Borracha Magueira, para garantir a vedação ideal entre o vaso e a mangueira do narguilé, proporcionando uma experiência sem vazamentos.	2.00	100	6	6.50	1.00	/images/Rosh.png\n
56	Fumo Capoeirinha 5cm	Fumo Capoeirinha 5cm, um fumo tradicional brasileiro com aroma e sabor únicos, ideal para palheiros.	2.00	100	6	5.00	1.00	/images/212.png
59	Narguilé Pocket Completo	Narguilé Pocket Completo, compacto e prático, perfeito para quem busca mobilidade e qualidade no uso de narguilés.	2.00	100	6	250.00	1.00	/images/184.png
88	Gelo Cubo 2kg	Gelo Cubo 2kg, ideal para manter suas bebidas geladas em qualquer ocasião.	2.00	100	8	8.00	1.00	/images/246.png
89	Gelo Meia Barra 4kg	Gelo Meia Barra 4kg, oferece maior durabilidade e é ideal para grandes eventos e festas.	2.00	100	8	9.00	1.00	/images/248.png
90	Gelo Barra 8kg	Gelo Barra 8kg, perfeito para manter grandes volumes de bebidas frias por longos períodos.	2.00	100	8	16.00	1.00	/images/247.png
91	Gelo Morango	Gelo com sabor de Morango, adiciona um toque de sabor frutado enquanto mantém suas bebidas frias.	2.00	100	8	7.00	1.00	/images/249.png
92	Gelo Melancia	Gelo com sabor de Melancia, traz frescor e sabor tropical às suas bebidas.	2.00	100	8	7.00	1.00	/images/251.png
93	Gelo Maracujá	Gelo com sabor de Maracujá, perfeito para adicionar um toque exótico às suas bebidas.	2.00	100	8	7.00	1.00	/images/250.png
94	Gelo Coco Ducoco	Gelo de Coco Ducoco, refresque suas bebidas com o autêntico sabor do coco.	2.00	100	8	7.00	1.00	/images/252.png
96	Caixa Térmica Termolar 20L	Caixa Térmica Termolar de 20 litros, perfeita para manter suas bebidas geladas durante eventos e viagens.	2.00	50	8	110.00	1.00	/images/149.png
238	Gin Rock's Strawberry 1L	Com o frescor das morangos, Rock’s Strawberry oferece um toque frutado e doce a cada gole. Ideal para quem busca um gin refrescante e delicado.	2.00	100	3	45.00	234.00	/images/R1.png
65	Isqueiro Bic Grande	Isqueiro Bic Grande, confiável e duradouro, ideal para todas as suas necessidades diárias de acendimento.	2.00	100	6	7.00	1.00	/images/151.png
66	Massarico Prof	Massarico Profissional, com alta potência e precisão, perfeito para aplicações que exigem um acendimento forte e focado.	2.00	100	6	30.00	1.00	/images/152.png
173	Chocolate Garoto Baton Duo	Baton Duo da Garoto, onde o leite encontra o chocolate branco para uma experiência de sabor dual.	2.00	100	2	3.00	60.00	/images/70.png
174	Chocolate Garoto Baton Extra Milk	Extra leite, extra delicioso. Baton Extra Milk é a escolha perfeita para os amantes de chocolate ao leite.	2.00	100	2	3.00	60.00	/images/72.png
101	Coca-Cola 310ml	Desde 1886 com o sabor único e incomparável. 	2.00	100	1	5.00	57.00	/images/15.png
77	Ice Cabaré Limão 275ml	Ice Cabaré Limão 275ml	2.00	100	7	8.00	45.00	/images/243.png\n
78	Ice Cabaré Maracujá 275ml	Ice Cabaré Maracujá 275ml	2.00	100	7	8.00	45.00	/images/243.png
79	Corote Morango 500ml	Corote Morango 500ml	2.00	100	7	6.00	84.00	/images/244.png
80	Corote Tutti-Frutti 500ml	Corote Tutti-Frutti 500ml	2.00	100	7	6.00	84.00	/images/244.png
81	Corote Maracujá 500ml	Corote Maracujá 500ml	2.00	100	7	6.00	84.00	/images/244.png
82	Corote Blueberry 500ml	Corote Blueberry 500ml	2.00	100	7	6.00	84.00	/images/244.png
83	Corote Pêssego 500ml	Corote Pêssego 500ml	2.00	100	7	6.00	84.00	/images/244.png
84	Corote Limão 500ml	Corote Limão 500ml	2.00	100	7	6.00	84.00	/images/244.png
85	Corote Limão+Menta 500ml	Corote Limão com Menta 500ml	2.00	100	7	6.00	84.00	/images/244.png
86	BiriNight 1L	BiriNight 1L	2.00	100	7	15.00	60.00	/images/137.png
87	BiriNight 375ml	BiriNight 375ml	2.00	100	7	6.00	54.00	/images/138.png
99	Coca Cola 2L	Desde 1886 com o sabor único e incomparável. 	2.00	100	1	12.00	105.00	/images/3.png
97	Caixa Térmica Termolar 32L	Caixa Térmica Termolar de 32 litros, ideal para grandes eventos, com alta capacidade de refrigeração.	2.00	50	8	150.00	1.00	/images/150.png
167	Batata Fã Cebola	Combinação clássica de cebola que traz um sabor rico e profundo, tornando as Batatas Fã irresistíveis.	2.00	100	2	5.00	70.00	/images/83.png
168	Biscoito Oreo	Oreo, o biscoito que oferece uma experiência única com seu delicioso creme entre dois biscoitos de chocolate.	2.00	100	2	4.00	168.00	/images/Oreo.png
169	Bala Fini Gelatina Banana	Delicie-se com o sabor suave e doce da banana com as Balas Fini Gelatina, um verdadeiro prazer em cada mordida.	2.00	100	2	3.00	36.00	/images/88.png
95	Carvão Vegetal Churrasco	Carvão Vegetal para Churrasco, proporciona uma queima prolongada e eficiente para um churrasco perfeito.	2.00	100	8	12.00	1.00	/images/1.png
170	Bala Fini Tubes Morango	Saboreie a explosão frutada de morango com as Balas Fini Tubes, perfeitas para adoçar seu dia.	2.00	100	2	3.00	36.00	/images/Tubes.png
171	Bala Fini Dentadura	Com um toque de humor e sabor inconfundível, as Balas Fini Dentadura são divertidas e deliciosas.	2.00	100	2	3.00	36.00	/images/90.png
172	Bala Fini Beijo	Balas Fini Beijo, uma doce forma de enviar amor e sabor com cada goma mastigável.	2.00	100	2	3.00	36.00	/images/89.png
63	Borracha Vaso	Borracha Vaso, uma vedação essencial para garantir que seu narguilé funcione sem problemas.	2.00	100	6	6.00	1.00	/images/Rosh.png\n
107	Fanta Uva lata 310ml	Desde 1940, Fanta Uva desafia o comum com seu sabor intenso e vibrante.	2.00	100	1	4.50	50.00	/images/16.png
108	Sprite 2L	Desde 1961, Sprite refresca com sua combinação chocante de limão e lima.	2.00	100	1	10.00	84.00	/images/8.png
109	Schweppes 1,5L	Desde 1783, Schweppes é a escolha clássica para quem busca sofisticação e sabor inconfundível em suas bebidas. Descubra o prazer de saborear o autêntico Schweppes, com sua efervescência única e sabor que tem complementado momentos especiais por séculos!	2.00	100	1	10.00	57.00	/images/11.png
110	Guaraná Antarctica 2,5L	Desfrute do sabor autêntico do Brasil com Guaraná Antarctica. Desde 1921, esta bebida refrescante é feita com guaranás cultivados no coração da Amazônia.	2.00	100	1	11.50	68.00	/images/6.png
111	Guaraná Antarctica 1,5L	Desfrute do sabor autêntico do Brasil com Guaraná Antarctica. Desde 1921, esta bebida refrescante é feita com guaranás cultivados no coração da Amazônia	2.00	100	1	7.00	42.00	/images/7.png
175	Chocolate Garoto Baton Leite	Clássico e irresistível, Baton de Leite oferece a suavidade e o sabor rico do verdadeiro chocolate ao leite.	2.00	100	2	3.00	60.00	/images/69.png
279	Chocolate Baton Branco 	O melhor do nosso chocolate branco.	2.00	100	2	3.00	60.00	/images/71.png
280	Chocolate Lacta Laka 	O Melhor da Lacta para você.	2.00	100	2	9.00	127.50	/Images/75.png
281	Chocolate Lacta Diamante Negro	O melhor da lacta para você.	2.00	100	2	9.00	127.50	/images/76.png
100	Coca Cola 1,5L	Desde 1886 com o sabor único e incomparável. 	2.00	100	1	10.00	96.00	/images/4.png
102	Coca Cola 250ml	Desde 1886 com o sabor único e incomparável. 	2.00	100	1	3.50	55.00	/images/15.png
103	Coca Cola Zero 1,5L	Desde 2005 trazendo tradição e leveza.	2.00	100	1	10.00	102.00	/images/5.png
104	Fanta Laranja 2L	Desde 1940, Fanta Laranja é a explosão de sabor cítrico que alegra seus momentos.	2.00	100	1	10.00	84.00	/images/9.png
105	Fanta Laranja Lata 310ml	Desde 1940, Fanta Laranja é a explosão de sabor cítrico que alegra seus momentos.	2.00	100	1	4.50	50.00	/images/17.png
112	Guaraná Antarctica 269ml	Desfrute do sabor autêntico do Brasil com Guaraná Antarctica. Desde 1921, esta bebida refrescante é feita com guaranás cultivados no coração da Amazônia	2.00	100	1	4.00	48.00	/images/18.png
113	Guaraná Antarctica PET 200ml	Desfrute do sabor autêntico do Brasil com Guaraná Antarctica. Desde 1921, esta bebida refrescante é feita com guaranás cultivados no coração da Amazônia	2.00	100	1	2.50	30.00	/images/20.png
64	Fumo Paulistinha Rolo 8cm	Fumo Paulistinha Rolo 8cm, um fumo tradicional enrolado à mão, ideal para palheiros caseiros com sabor autêntico.	2.00	100	6	7.00	1.00	/images/PR1.png
73	Ice 51 Limão 275ml	Ice 51 Limão 275ml	2.00	100	7	8.00	42.00	/images/w1.png
74	Ice 51 Balada 275ml	Ice 51 Balada 275ml	2.00	100	7	8.00	42.00	/images/w2.png
75	Ice 51 Kiwi 275ml	Ice 51 Kiwi 275ml	2.00	100	7	8.00	42.00	/images/w3.png
117	H2oH! Limoneto 1,5L	Refresque-se com H2OH!, a bebida leve que combina a pureza da água com um toque sutil de sabor frutado.	2.00	100	1	10.00	51.00	/images/12.png
118	H2oH! Limoneto 500ml	Refresque-se com H2OH!, a bebida leve que combina a pureza da água com um toque sutil de sabor frutado.	2.00	100	1	6.00	40.00	/images/13.png
119	H2oH! Limão 500ml	Refresque-se com H2OH!, a bebida leve que combina a pureza da água com um toque sutil de sabor frutado.	2.00	100	1	6.00	40.00	/images/14.png
98	Coca Cola 3L	Desde 1886 com o sabor único e incomparável. 	2.00	100	1	14.00	84.00	/images/2.png
106	Fanta Uva 1,5L	Desde 1940, Fanta Uva desafia o comum com seu sabor intenso e vibrante.	2.00	100	1	8.00	84.00	/images/10.png
140	Red Bull Tradicional 473ml	Red Bull te dá asas! Experimente o boost de energia que só Red Bull Tradicional pode oferecer.	2.00	100	1	16.00	180.00	/images/35.png
141	Red Bull Tradicional 250ml	Concentre-se e mantenha-se ativo, Red Bull em 269ml proporciona a energia necessária para conquistar desafios.	2.00	100	1	10.00	60.00	/images/36.png
142	Red Bull Tropical 250ml	Sabor tropical e uma carga de energia, Red Bull Tropical é sua ala para um dia ativo.	2.00	100	1	10.00	40.00	/images/37.png
152	Bally Melancia 2L	Sabor de melancia que seduz o paladar, Bally Melancia é o refrigerante que transforma qualquer refeição em festa.	2.00	100	1	20.00	96.00	/images/28.png\n
153	Bally Coco 2L	Refrescante e tropical, Bally Coco leva você para uma escapada na praia a cada gole.	2.00	100	1	20.00	96.00	/images/30.png
154	Bally Morango-Pessego	A combinação perfeita de morango e pêssego, Bally traz uma mistura refrescante para seu dia a dia.	2.00	100	1	20.00	96.00	/images/28.png
155	Bally Maçã Verde	Vibrante e refrescante, Bally Maçã Verde é a escolha perfeita para quem busca uma opção deliciosa e revigorante.	2.00	100	1	20.00	96.00	/images/31.png
114	Agua Antarctica Tônica Zero 350ml	Desfrute do sabor refrescante e sofisticado da Água Tônica Antarctica Zero, sem abrir mão da saúde.	2.00	100	1	6.00	45.00	/images/45.png
115	Agua Antarctica Tônica 3 Limões 269ml	Viva uma experiência cítrica revigorante com a Água Tônica Antarctica de 3 Limões. Uma mistura harmoniosa dos sabores de limão siciliano, tahiti e cravo, criando um perfil aromático único.	2.00	100	1	4.50	40.00	/images/46.png
116	Agua Antarctica Tônica Tradicional 350ml	Experimente o equilíbrio perfeito entre sabor e sofisticação com a Água Tônica Antarctica Tradicional.	2.00	100	1	6.00	45.00	/images/44.png
120	Gatorade Uva 500ml	Gatorade oferece uma explosão de energia com uma variedade de sabores que atendem ao gosto de cada atleta. 	2.00	100	1	7.00	40.00	/images/42.png
121	Gatorade Morango+Maracujá 500ml	Gatorade oferece uma explosão de energia com uma variedade de sabores que atendem ao gosto de cada atleta. 	2.00	100	1	7.00	40.00	/images/43.png
122	Gatorade Limão 500ml	Gatorade oferece uma explosão de energia com uma variedade de sabores que atendem ao gosto de cada atleta. 	2.00	100	1	7.00	40.00	/images/39.png
143	Red Bull Zero 250ml	Zero calorias, todo o vigor. Red Bull Zero é para aqueles que querem energia sem compromissos.	2.00	100	1	10.00	40.00	/images/38.png
144	Monster Tradicional 473ml	Libere a besta com Monster Energy, o energético que alimenta sua sede de aventura e desempenho.	2.00	100	1	12.00	60.00	/images/32.png
145	Monster Asolutely Zero 473ml	Todo o punch energético de Monster sem as calorias – Monster Absolutely Zero.	2.00	100	1	12.00	60.00	/images/34.png
146	Monster Ultra Watermelon 473ml	Refrescante e revigorante, Monster Ultra Watermelon é a escolha perfeita para energizar seu dia.	2.00	100	1	12.00	60.00	/images/33.png
132	Suco Aurora Uva Integral 1,5L	Desde 1975, Suco Aurora Uva Integral encanta com seu sabor robusto e natural, direto das uvas mais frescas.	2.00	100	1	11.00	141.00	/images/56.png
133	Agua De Coco Sococo 1L	Água de Coco Sococo, a hidratação tropical que refresca e nutre, qualquer que seja o momento.	2.00	100	1	15.00	165.00	/images/47.png
134	Agua De coco Dococo 1L	Dococo, a água de coco que traz toda a frescura do coco natural em cada gole.	2.00	100	1	10.00	120.00	/images/48.png
135	Agua De coco Dococo 200ml	Pequena e poderosa, a Água de Coco Dococo em 200ml oferece uma dose rápida de hidratação e sabor tropical.	2.00	100	1	4.00	67.00	/images/49.png
136	Agua Sem gás 1,5L	Pura e refrescante, a Água Sem Gás é sua companheira ideal para a hidratação diária.	2.00	100	1	6.00	35.00	/images/63.png
150	Bally Tradicional 2L	Bally Tradicional, o refrigerante que traz sabor clássico para momentos especiais.	2.00	100	1	20.00	96.00	/images/26.png
151	Bally Tropical 2L	Experimente a explosão de sabor exótico com Bally Tropical, perfeito para refrescar seu dia.	2.00	100	1	20.00	96.00	/images/27.png
147	Monster Juice 473ml	Monster Juice combina o melhor de Monster com suco real, para uma experiência energética deliciosamente diferente.	2.00	100	1	12.00	60.00	/images/Juice.png
148	Suco Kapo Uva 200ml	Kapo Uva traz diversão e sabor frutado em uma embalagem prática, perfeita para o lanche das criança.	2.00	100	1	3.50	42.00	/images/57.png
149	Suco Kapo Morango 200ml	Delicioso e divertido, Suco Kapo Morango é a escolha refrescante para os pequenos em qualquer momento.	2.00	100	1	3.50	42.00	/images/58.png
186	Mentos Potinho Fresh Mint	A frescura do Mentos Fresh Mint revitaliza seu paladar e seu hálito, oferecendo uma sensação refrescante.	2.00	100	2	15.00	72.00	/images/F3.png
187	Mentos Potinho Morango	Saboreie a doçura vibrante do morango com cada pastilha de Mentos, ideal para um doce impulso de frescor.	2.00	100	2	15.00	72.00	/images/F5.png
157	Extra Power Tropical 2L	Saboreie a energia tropical com Extra Power Tropical, ideal para revitalizar seu espírito aventureiro.	2.00	100	1	22.00	114.00	/images/22.png
156	Extra Power Tradicional 2L	Extra Power, o energético que te dá a força necessária para enfrentar longas horas e desafios.	2.00	100	1	22.00	114.00	/images/21.png
158	Extra Power Melancia 2L	Desfrute do sabor de melancia enquanto ganha um extra de energia com Extra Power Melancia.	2.00	100	1	22.00	114.00	/images/23.png
159	Extra Power Manga 2L	Extra Power Manga, uma explosão de sabor frutado que energiza seu dia de forma deliciosa.	2.00	100	1	22.00	114.00	/images/25.png
160	Extra Power Pitaia 2L	Exótico e energizante, Extra Power Pitaia é perfeito para quem busca um boost de energia com sabor único.	2.00	100	1	22.00	114.00	/images/24.png
161	Batata Pringles Tradicional	Pringles Tradicional, onde cada chip é uma oportunidade para experienciar o sabor clássico que desafia a monotonia.	2.00	100	2	15.00	190.00	/images/80.png
162	Batata Pringles Cebola/Salsa	Desfrute do sabor tangente de cebola e salsa com Pringles, o snack perfeito para qualquer ocasião.	2.00	100	2	15.00	190.00	/images/81.png
163	Batata Pringles Churrasco	Com um sabor defumado e intenso, Pringles Churrasco traz o gosto do grill em cada mordida.	2.00	100	2	15.00	190.00	/images/82.png
164	Batata Fã Tradicional	Batata Fã Tradicional, crocante por fora e macia por dentro, é o complemento perfeito para qualquer refeição ou lanche.	2.00	100	2	5.00	70.00	/images/85.png
165	Batata Fã Costelinha com Limão	A ousadia da costelinha com um toque de limão faz das Batatas Fã uma escolha ousada e deliciosa.	2.00	100	2	5.00	70.00	/images/84.png
166	Batata Fã Frango Grelhado	Sabor de frango grelhado em cada batata, para um snack saboroso e reconfortante.	2.00	100	2	5.00	70.00	/images/86.png
176	Chocolate Snickers Original	Snickers Original, com nougat, amendoins, caramelo e cobertura de chocolate, é o snack ideal para matar a fome de forma saborosa.	2.00	100	2	6.00	70.00	/images/66.png
177	Chocolate Nestle Kit Kat Leite	Kit Kat de Leite, com suas camadas de wafer cobertas de chocolate ao leite, é perfeito para uma pausa deliciosa.	2.00	100	2	6.00	120.00	/images/67.png
178	Chocolate Nestle Prestigio	Prestígio combina o coco tropical com o rico chocolate ao leite para um momento de indulgência pura.	2.00	100	2	4.00	105.00	/images/68.png
179	Chocolate Lacta Amargo	Para os verdadeiros apreciadores de chocolate, Lacta Amargo oferece uma experiência rica e profunda.	2.00	100	2	9.00	127.50	/images/74.png
181	Chocolate Suflair	Suflair, o chocolate aerado que é uma nuvem de sabor em cada mordida.	2.00	100	2	6.00	100.00	/images/78.png
182	Chocolate Diamante Negro	Crocante e irresistível, Diamante Negro é uma joia rara no mundo do chocolate, com seus pedaços de caramelo salpicados.	2.00	100	2	4.50	41.50	/images/77.png
183	Chocolate Kit Kat Tradicional	Faça uma pausa com Kit Kat Tradicional, onde camadas de wafer são delicadamente cobertas por chocolate ao leite.	2.00	100	2	6.00	120.00	/images/67.png
184	Amendoim Japonês Agtal 400g	Explore o sabor exótico do Amendoim Japonês Agtal, perfeito para um lanche saboroso e crocante.	2.00	100	2	10.00	170.00	/images/79.png
185	Mentos Potinho Tutti-Frutti	Mentos Tutti-Frutti traz um arco-íris de sabores frutados em cada pastilha, para um frescor divertido e duradouro.	2.00	100	2	15.00	72.00	/images/F6.png
188	Mentos Potinho White Mint	White Mint da Mentos, uma explosão de frescor minty que clareia seu paladar e seu dia.	2.00	100	2	15.00	72.00	/images/F4.png
189	Mentos Kiss Strong Mint	Mentos Kiss Strong Mint é a escolha perfeita para quem busca um sopro de frescor intenso e duradouro.	2.00	100	2	15.00	72.00	/images/d3.png
205	White Houser 1L	Com origem nas Highlands da Escócia, White Houser é envelhecido por 8 anos, proporcionando um sabor equilibrado e complexo, perfeito para os amantes de um scotch clássico.	2.00	100	3	99.99	878.00	/images/114.png
190	Mentos Kiss Morango	Delicie-se com a doçura de Morango do Mentos Kiss, que combina o sabor frutado com um toque de romance.	2.00	100	2	15.00	144.00	/images/d2.png
191	Mentos Kiss Mint	Mentos Kiss Mint oferece a suavidade da menta em uma pastilha que refresca e encanta	2.00	100	2	15.00	144.00	/images/d1.png
192	Babalu (Mix)	Babalu Mix traz uma variedade de sabores frutados em uma só embalagem, para uma experiência mastigável e colorida.	2.00	100	2	0.50	144.00	/images/91.png
193	Trident Morango	Trident Morango oferece uma explosão de sabor frutado com cada mastigada, perfeito para refrescar o seu dia.	2.00	100	2	3.00	84.48	/images/94.png
206	Buchanan's Deluxe 1L	Com 12 anos de envelhecimento, Buchanan's Deluxe é a expressão perfeita do whisky escocês refinado. Seu sabor suave e encorpado faz dele um dos blends mais admirados no mundo.	2.00	100	3	220.00	2049.00	/images/109.png
207	Red Label 1L	Desde 1820, Johnnie Walker Red Label leva a tradição escocesa a cada garrafa. Um blend vibrante e ousado, ideal para momentos de celebração com 5 a 8 anos de maturação.	2.00	100	3	150.00	987.00	/images/115.png
208	Jack Daniel's 1L	Produzido desde 1866 em Lynchburg, Tennessee, Jack Daniel's é filtrado pelo método de carvão vegetal e amadurecido em barris de carvalho, garantindo seu sabor suave e autêntico.	2.00	100	3	150.00	1680.00	/images/110.png
209	Jack Daniel's Fire 1L	A fusão do clássico Jack Daniel's com um toque de canela picante. Perfeito para quem busca uma experiência de sabor intensa e calorosa, mantendo a alma do Tennessee whiskey.	2.00	100	3	170.00	1800.00	/images/111.png
210	Jack Daniel's Honey 1L	Jack Daniel’s Honey é uma combinação suave e doce do tradicional Tennessee whiskey com o licor de mel natural. Uma experiência única e refinada.	2.00	100	3	170.00	1800.00	/images/112.png
211	Jack Daniel's Apple 1L	ack Daniel's Apple traz o equilíbrio perfeito entre o sabor robusto do whisky de Tennessee e o frescor natural das maçãs verdes, criando um sabor doce e cativante.	2.00	100	3	170.00	1800.00	/images/113.png
212	Natu Nobilis 1L	Com mais de 60 anos de história, Natu Nobilis é um whisky escocês de blend leve e sabor marcante. Suas notas de caramelo e baunilha são apreciadas pelos conhecedores.	2.00	100	3	60.00	660.00	/images/116.png
213	Passaport 1L	Desde 1965, Passport é um whisky escocês jovem, com sabores frutados e notas suaves de carvalho. Ideal para quem busca modernidade em um blend tradicional.	2.00	100	3	80.00	780.00	/images/108.png
204	Old Parr 1L	Old Parr 1L "Desde 1909, Old Parr representa a excelência em whiskies escoceses envelhecidos. Com sua suavidade inconfundível, cada gole revela 12 anos de tradição e maturação perfeita.	2.00	100	3	170.00	1580.00	/images/107.png
214	Paratudo 1L	Conhecido por sua versatilidade, Paratudo é a escolha perfeita para qualquer ocasião. Seu sabor equilibrado e levemente adocicado o torna ideal para drinks ou puro.	2.00	100	3	20.00	191.00	/images/134.png
215	Camapri 900ml	Com suas notas intensas de ervas e frutas, Campari é sinônimo de tradição e sofisticação desde 1860. Um clássico italiano que eleva qualquer coquetel a um novo nível de sabor.	2.00	100	3	75.00	741.00	/images/139.png
216	Campari 748ml	Elegância em cada gota, Campari é produzido a partir de uma receita secreta que combina ervas aromáticas e frutas, criando um amargor refrescante e complexo.	2.00	100	3	65.00	734.00	/images/140.png
217	Catuaba Selvagem Açaí 1L	Uma combinação exótica de Catuaba com o sabor vibrante do açaí, criando uma bebida brasileira única. Perfeita para aqueles que buscam inovação e intensidade.	2.00	100	3	18.00	204.00	/images/136.png
218	Kriskof Limão 1L	Kriskof Limão é a combinação perfeita de frescor cítrico com a robustez de uma vodka premium. Ideal para ser apreciado em festas ou drinks criativos.	2.00	100	3	20.00	102.00	/images/g1.png
219	Kriskof Bluberry 1L	Com seu sabor de blueberry envolvente, Kriskof Bluberry é uma vodka leve e refrescante, ideal para quem busca originalidade em cada gole.	2.00	100	3	20.00	102.00	/images/g2.png
220	Kriskof Melancia 1L	Kriskof Melancia oferece uma explosão de sabor frutado, perfeito para criar drinks refrescantes ou ser apreciada pura.	2.00	100	3	20.00	102.00	/images/g4.png
221	Kriskof Limão e Menta 1L	Uma vodka refrescante que mistura o sabor cítrico do limão com a suavidade da menta, Kriskof Limão e Menta é perfeita para drinks vibrantes.	2.00	100	3	20.00	102.00	/images/g3.png
222	Pinga 51 1L	Desde 1959, a Cachaça 51 representa a tradição brasileira em destilados. Sua pureza e sabor autêntico fazem dela a escolha ideal para caipirinhas e outras receitas clássicas.	2.00	100	3	18.00	179.00	/images/126.png
223	Pinga Velho Barreiro 1L	Velho Barreiro é uma cachaça clássica, envelhecida em tonéis de madeira, trazendo um sabor suave e levemente amadeirado. Perfeita para quem aprecia um destilado tradicional.	2.00	100	3	18.00	186.00	/images/127.png
1	Vinho Trivento Argentino Malbec (Seco) 750ml	Vinho Trivento Argentino Malbec (Seco)	2.00	100	5	65.00	600.00	/images/96.png
4	Dunhill Carlton-Box	Cigarro Dunhill Carlton Box	2.00	100	6	14.00	72.00	/images/155.png
224	Pinga 88 1L	Com sabor marcante e autêntico, Pinga 88 é a escolha perfeita para aqueles que preferem uma cachaça de personalidade forte e inesquecível.	2.00	100	3	18.00	170.00	/images/128.png
2	Vinho Casal Garcia Rosé Português (Meio Seco) 750ml	Vinho Casal Garcia Rosé Português (Meio Seco)	2.00	100	5	76.00	390.00	/images/99.png
3	Vinho Cantina da Serra (Suave) 880ml	Vinho Cantina da Serra (Suave)	2.00	100	5	15.00	144.00	/images/105.png
6	Rothmans Blue-Box	Cigarro Rothmans Blue Box	2.00	100	6	9.50	60.00	/images/159.png
248	Antarctica Pilsen 269ml	Cerveja Antarctica Pilsen, com seu sabor leve e refrescante, ideal para qualquer ocasião.	2.00	100	4	4.00	43.00	/images/218.png
249	Skol Pilsen 269ml	Cerveja Skol Pilsen, a escolha perfeita para quem busca leveza e refrescância.	2.00	100	4	4.00	44.00	/images/221.png
250	Brahma Chopp 269ml	Cerveja Brahma Chopp, com seu sabor inconfundível e cremosa espuma, ideal para compartilhar com amigos.	2.00	100	4	4.00	40.00	/images/219.png
49	Piteira Papelito Slim	Piteira Papelito Slim, compacta e prática, oferece um controle perfeito durante o uso para uma queima suave.	2.00	100	6	4.00	18.00	/images/206.png
50	Piteira Papelito Longa	Piteira Papelito Longa, ideal para quem busca uma experiência prolongada e com mais controle durante a queima.	2.00	100	6	7.00	18.00	/images/207.png
51	Seda King Blunt (Mix)	Seda King Blunt Mix, uma seleção variada de sabores para quem busca uma experiência de enrolar mais divertida e saborosa.	2.00	100	6	10.00	1.00	/images/208.png
52	Dichavador Acrílico Bem Bolado Grande	Dichavador Acrílico Bem Bolado Grande, resistente e eficiente, ideal para triturar grandes quantidades com facilidade.	2.00	100	6	20.00	1.00	/images/210.png
53	Dichavador Acrílico Bem Bolado Pequeno	Dichavador Acrílico Bem Bolado Pequeno, prático e portátil, perfeito para triturar pequenas quantidades com rapidez.	2.00	100	6	30.00	1.00	/images/211.png
54	Fumo Sasso Premium Destalado	Fumo Sasso Premium Destalado, um fumo de alta qualidade, cuidadosamente selecionado e destalado para uma queima perfeita.	2.00	100	6	20.00	180.00	/images/186.png
55	Bola De Fumo Capoeirinha/Juriti 8 Metros	Bola de Fumo Capoeirinha/Juriti, uma tradição brasileira com fumo de qualidade, ideal para quem busca um sabor autêntico.	2.00	100	6	500.00	1.00	/images/212.png
251	Brahma Duplo Malte 269ml	Cerveja Brahma Duplo Malte, combinando o melhor dos maltes para uma experiência única e encorpada.	2.00	100	4	4.00	46.00	/images/222.png
252	Original 269ml	Cerveja Original, clássica e marcante, com sabor único que agrada aos paladares mais exigentes.	2.00	100	4	4.00	50.00	/images/220.png
253	Budweiser 269ml	Cerveja Budweiser, o sabor clássico americano com tradição e qualidade desde 1876.	2.00	100	4	4.00	30.00	/images/223.png
254	Spaten 350 ml	Cerveja Spaten, o sabor autêntico da Alemanha, com um toque suave de malte.	2.00	100	4	6.00	52.00	/images/224.png
255	Kaiser 350ml	Cerveja Kaiser, sabor tradicional e refrescante, perfeita para momentos de descontração.	2.00	100	4	3.50	38.00	/images/226.png
256	Caracu 350ml	Cerveja Caracu, escura e encorpada, ideal para os apreciadores de cervejas fortes.	2.00	100	4	6.00	55.00	/images/225.png
257	Heineken 350ml	Cerveja Heineken, com seu sabor puro e refrescante, fermentada com levedura especial desde 1873.	2.00	100	4	7.00	65.00	/images/229.png
258	Heineken 269ml	Cerveja Heineken, em um tamanho prático para saborear seu sabor puro a qualquer momento.	2.00	100	4	6.00	36.00	/images/230.png
259	Amstel 350ml	Cerveja Amstel, puro malte, com sabor equilibrado e amargor na medida certa.	2.00	100	4	5.00	46.00	/images/227.png
260	Amstel 269ml	Cerveja Amstel, em embalagem compacta, ideal para curtir em qualquer lugar.	2.00	100	4	4.00	41.00	/images/228.png
261	Budweiser L.N 330ml	Cerveja Budweiser Long Neck, sabor icônico americano em uma garrafa para momentos especiais.	2.00	100	4	7.00	37.00	/images/234.png
262	Spaten L.N 355ml	Cerveja Spaten Long Neck, a autêntica experiência alemã, com um toque de malte e suavidade.	2.00	100	4	7.00	38.00	/images/237.png
263	Corona Extra L.N 330ml	Cerveja Corona Extra, leve e refrescante, perfeita para ser apreciada com uma fatia de limão.	2.00	100	4	8.00	40.00	/images/236.png
264	Budweiser Zero L.N 330ml	Cerveja Budweiser Zero, o sabor clássico sem álcool, para quem busca moderação.	2.00	100	4	7.00	37.00	/images/234.png
265	Heineken Zero L.N 330ml	Cerveja Heineken Zero, toda a qualidade Heineken com 0% de álcool, ideal para qualquer hora.	2.00	100	4	8.00	45.00	/images/232.png
266	Stella Artois L.N 330ml	Cerveja Stella Artois Long Neck, uma cerveja premium belga, com sabor suave e sofisticado.	2.00	100	4	7.00	38.00	/images/235.png
267	Heineken L.N 330ml	Cerveja Heineken Long Neck, perfeita para momentos especiais com seu sabor puro e refrescante.	2.00	100	4	8.00	45.00	/images/231.png
268	Vinho Aurora 2018 Millésime (Seco) 750ml	Vinho Aurora 2018 Millésime (Seco)	2.00	100	5	200.00	1.00	/images/97.png
269	Vinho Pérgola Tinto (Seco) 1L	Vinho Pérgola Tinto (Seco)	2.00	100	5	30.00	285.00	/images/104.png
271	Vinho Mioranza Tinto (Seco) 750ml	Vinho Mioranza Tinto (Seco)	2.00	100	5	22.00	240.00	/images/101.png
272	Vinho Mioranza Tinto (Suave) 750ml	Vinho Mioranza Tinto (Suave)	2.00	100	5	25.00	300.00	/images/102.png
273	Vinho Dom Bosco Branco (Suave) 750ml	Vinho Dom Bosco Branco (Suave)	2.00	100	5	15.00	180.00	/images/98.png
274	Vinho Quinta Do Morgado (Seco) 750ml	Vinho Quinta Do Morgado (Seco)	2.00	100	5	35.00	420.00	/images/100.png
\.


--
-- TOC entry 5164 (class 0 OID 16400)
-- Dependencies: 216
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, name, password, email, created_at, phone) FROM stdin;
21	Thiago Torres De Oliveira	$2b$10$AYORepMcdj6NYj3lDEGA..ylsccPnHFIzVTjSn2Vo8CGVGSLH5sVm	thiagotorres5517@gmail.com	2024-09-29 17:37:39.512-03	62996916206
22	Joa Batista	$2b$10$j43H4Dlok90GbtRVdXWkE.flKLvlfTSOO/t8uB/zw2Qusy/vHzcOK	joaobatista2020@gmial.com	2024-09-29 23:44:59.183-03	62998615060
23	rafael tavares	$2b$10$1aGXr7LoA8kxIBrTNcNSf.jQFaSMlfYboh8TZqUH3y0Rph8rCAqlO	tavaresrafael457@gmail.com	2024-09-29 23:50:17.229-03	62999472418
\.


--
-- TOC entry 5190 (class 0 OID 0)
-- Dependencies: 223
-- Name: cart_items_cart_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_items_cart_item_id_seq', 1, false);


--
-- TOC entry 5191 (class 0 OID 0)
-- Dependencies: 221
-- Name: carts_cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carts_cart_id_seq', 1, false);


--
-- TOC entry 5192 (class 0 OID 0)
-- Dependencies: 217
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_category_id_seq', 1, true);


--
-- TOC entry 5193 (class 0 OID 0)
-- Dependencies: 227
-- Name: order_items_order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_order_item_id_seq', 1, false);


--
-- TOC entry 5194 (class 0 OID 0)
-- Dependencies: 225
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 1, false);


--
-- TOC entry 5195 (class 0 OID 0)
-- Dependencies: 219
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_product_id_seq', 11, true);


--
-- TOC entry 5196 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 23, true);


--
-- TOC entry 5008 (class 2606 OID 16533)
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (cart_item_id);


--
-- TOC entry 5006 (class 2606 OID 16519)
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (cart_id);


--
-- TOC entry 5001 (class 2606 OID 16420)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- TOC entry 5012 (class 2606 OID 43167)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (order_item_id);


--
-- TOC entry 5010 (class 2606 OID 43155)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 5004 (class 2606 OID 16430)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- TOC entry 4737 (class 2606 OID 49013)
-- Name: users unique_phone; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_phone UNIQUE (phone);


--
-- TOC entry 4739 (class 2606 OID 48908)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4741 (class 2606 OID 48910)
-- Name: users users_email_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key1 UNIQUE (email);


--
-- TOC entry 4743 (class 2606 OID 48764)
-- Name: users users_email_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key10 UNIQUE (email);


--
-- TOC entry 4745 (class 2606 OID 48920)
-- Name: users users_email_key100; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key100 UNIQUE (email);


--
-- TOC entry 4747 (class 2606 OID 48924)
-- Name: users users_email_key101; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key101 UNIQUE (email);


--
-- TOC entry 4749 (class 2606 OID 48922)
-- Name: users users_email_key102; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key102 UNIQUE (email);


--
-- TOC entry 4751 (class 2606 OID 48784)
-- Name: users users_email_key103; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key103 UNIQUE (email);


--
-- TOC entry 4753 (class 2606 OID 48782)
-- Name: users users_email_key104; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key104 UNIQUE (email);


--
-- TOC entry 4755 (class 2606 OID 48890)
-- Name: users users_email_key105; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key105 UNIQUE (email);


--
-- TOC entry 4757 (class 2606 OID 48880)
-- Name: users users_email_key106; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key106 UNIQUE (email);


--
-- TOC entry 4759 (class 2606 OID 48884)
-- Name: users users_email_key107; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key107 UNIQUE (email);


--
-- TOC entry 4761 (class 2606 OID 48882)
-- Name: users users_email_key108; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key108 UNIQUE (email);


--
-- TOC entry 4763 (class 2606 OID 48954)
-- Name: users users_email_key109; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key109 UNIQUE (email);


--
-- TOC entry 4765 (class 2606 OID 48878)
-- Name: users users_email_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key11 UNIQUE (email);


--
-- TOC entry 4767 (class 2606 OID 48944)
-- Name: users users_email_key110; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key110 UNIQUE (email);


--
-- TOC entry 4769 (class 2606 OID 48952)
-- Name: users users_email_key111; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key111 UNIQUE (email);


--
-- TOC entry 4771 (class 2606 OID 48946)
-- Name: users users_email_key112; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key112 UNIQUE (email);


--
-- TOC entry 4773 (class 2606 OID 48950)
-- Name: users users_email_key113; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key113 UNIQUE (email);


--
-- TOC entry 4775 (class 2606 OID 48948)
-- Name: users users_email_key114; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key114 UNIQUE (email);


--
-- TOC entry 4777 (class 2606 OID 48876)
-- Name: users users_email_key115; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key115 UNIQUE (email);


--
-- TOC entry 4779 (class 2606 OID 48874)
-- Name: users users_email_key116; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key116 UNIQUE (email);


--
-- TOC entry 4781 (class 2606 OID 48766)
-- Name: users users_email_key117; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key117 UNIQUE (email);


--
-- TOC entry 4783 (class 2606 OID 48914)
-- Name: users users_email_key118; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key118 UNIQUE (email);


--
-- TOC entry 4785 (class 2606 OID 48932)
-- Name: users users_email_key119; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key119 UNIQUE (email);


--
-- TOC entry 4787 (class 2606 OID 48906)
-- Name: users users_email_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key12 UNIQUE (email);


--
-- TOC entry 4789 (class 2606 OID 48916)
-- Name: users users_email_key120; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key120 UNIQUE (email);


--
-- TOC entry 4791 (class 2606 OID 48804)
-- Name: users users_email_key121; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key121 UNIQUE (email);


--
-- TOC entry 4793 (class 2606 OID 48802)
-- Name: users users_email_key122; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key122 UNIQUE (email);


--
-- TOC entry 4795 (class 2606 OID 48776)
-- Name: users users_email_key123; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key123 UNIQUE (email);


--
-- TOC entry 4797 (class 2606 OID 48770)
-- Name: users users_email_key124; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key124 UNIQUE (email);


--
-- TOC entry 4799 (class 2606 OID 48774)
-- Name: users users_email_key125; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key125 UNIQUE (email);


--
-- TOC entry 4801 (class 2606 OID 48772)
-- Name: users users_email_key126; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key126 UNIQUE (email);


--
-- TOC entry 4803 (class 2606 OID 48754)
-- Name: users users_email_key127; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key127 UNIQUE (email);


--
-- TOC entry 4805 (class 2606 OID 49010)
-- Name: users users_email_key128; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key128 UNIQUE (email);


--
-- TOC entry 4807 (class 2606 OID 48886)
-- Name: users users_email_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key13 UNIQUE (email);


--
-- TOC entry 4809 (class 2606 OID 48904)
-- Name: users users_email_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key14 UNIQUE (email);


--
-- TOC entry 4811 (class 2606 OID 48888)
-- Name: users users_email_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key15 UNIQUE (email);


--
-- TOC entry 4813 (class 2606 OID 48892)
-- Name: users users_email_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key16 UNIQUE (email);


--
-- TOC entry 4815 (class 2606 OID 48902)
-- Name: users users_email_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key17 UNIQUE (email);


--
-- TOC entry 4817 (class 2606 OID 48960)
-- Name: users users_email_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key18 UNIQUE (email);


--
-- TOC entry 4819 (class 2606 OID 48962)
-- Name: users users_email_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key19 UNIQUE (email);


--
-- TOC entry 4821 (class 2606 OID 48912)
-- Name: users users_email_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key2 UNIQUE (email);


--
-- TOC entry 4823 (class 2606 OID 48760)
-- Name: users users_email_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key20 UNIQUE (email);


--
-- TOC entry 4825 (class 2606 OID 48964)
-- Name: users users_email_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key21 UNIQUE (email);


--
-- TOC entry 4827 (class 2606 OID 48966)
-- Name: users users_email_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key22 UNIQUE (email);


--
-- TOC entry 4829 (class 2606 OID 48968)
-- Name: users users_email_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key23 UNIQUE (email);


--
-- TOC entry 4831 (class 2606 OID 48758)
-- Name: users users_email_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key24 UNIQUE (email);


--
-- TOC entry 4833 (class 2606 OID 48970)
-- Name: users users_email_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key25 UNIQUE (email);


--
-- TOC entry 4835 (class 2606 OID 48756)
-- Name: users users_email_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key26 UNIQUE (email);


--
-- TOC entry 4837 (class 2606 OID 49008)
-- Name: users users_email_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key27 UNIQUE (email);


--
-- TOC entry 4839 (class 2606 OID 48972)
-- Name: users users_email_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key28 UNIQUE (email);


--
-- TOC entry 4841 (class 2606 OID 48852)
-- Name: users users_email_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key29 UNIQUE (email);


--
-- TOC entry 4843 (class 2606 OID 48768)
-- Name: users users_email_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key3 UNIQUE (email);


--
-- TOC entry 4845 (class 2606 OID 48974)
-- Name: users users_email_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key30 UNIQUE (email);


--
-- TOC entry 4847 (class 2606 OID 48840)
-- Name: users users_email_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key31 UNIQUE (email);


--
-- TOC entry 4849 (class 2606 OID 48850)
-- Name: users users_email_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key32 UNIQUE (email);


--
-- TOC entry 4851 (class 2606 OID 48842)
-- Name: users users_email_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key33 UNIQUE (email);


--
-- TOC entry 4853 (class 2606 OID 48844)
-- Name: users users_email_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key34 UNIQUE (email);


--
-- TOC entry 4855 (class 2606 OID 48848)
-- Name: users users_email_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key35 UNIQUE (email);


--
-- TOC entry 4857 (class 2606 OID 48846)
-- Name: users users_email_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key36 UNIQUE (email);


--
-- TOC entry 4859 (class 2606 OID 48900)
-- Name: users users_email_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key37 UNIQUE (email);


--
-- TOC entry 4861 (class 2606 OID 48894)
-- Name: users users_email_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key38 UNIQUE (email);


--
-- TOC entry 4863 (class 2606 OID 48896)
-- Name: users users_email_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key39 UNIQUE (email);


--
-- TOC entry 4865 (class 2606 OID 48778)
-- Name: users users_email_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key4 UNIQUE (email);


--
-- TOC entry 4867 (class 2606 OID 48898)
-- Name: users users_email_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key40 UNIQUE (email);


--
-- TOC entry 4869 (class 2606 OID 48854)
-- Name: users users_email_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key41 UNIQUE (email);


--
-- TOC entry 4871 (class 2606 OID 49006)
-- Name: users users_email_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key42 UNIQUE (email);


--
-- TOC entry 4873 (class 2606 OID 48856)
-- Name: users users_email_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key43 UNIQUE (email);


--
-- TOC entry 4875 (class 2606 OID 48858)
-- Name: users users_email_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key44 UNIQUE (email);


--
-- TOC entry 4877 (class 2606 OID 49004)
-- Name: users users_email_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key45 UNIQUE (email);


--
-- TOC entry 4879 (class 2606 OID 48986)
-- Name: users users_email_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key46 UNIQUE (email);


--
-- TOC entry 4881 (class 2606 OID 48860)
-- Name: users users_email_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key47 UNIQUE (email);


--
-- TOC entry 4883 (class 2606 OID 48862)
-- Name: users users_email_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key48 UNIQUE (email);


--
-- TOC entry 4885 (class 2606 OID 48984)
-- Name: users users_email_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key49 UNIQUE (email);


--
-- TOC entry 4887 (class 2606 OID 48780)
-- Name: users users_email_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key5 UNIQUE (email);


--
-- TOC entry 4889 (class 2606 OID 48982)
-- Name: users users_email_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key50 UNIQUE (email);


--
-- TOC entry 4891 (class 2606 OID 48864)
-- Name: users users_email_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key51 UNIQUE (email);


--
-- TOC entry 4893 (class 2606 OID 48866)
-- Name: users users_email_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key52 UNIQUE (email);


--
-- TOC entry 4895 (class 2606 OID 48868)
-- Name: users users_email_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key53 UNIQUE (email);


--
-- TOC entry 4897 (class 2606 OID 48980)
-- Name: users users_email_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key54 UNIQUE (email);


--
-- TOC entry 4899 (class 2606 OID 48870)
-- Name: users users_email_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key55 UNIQUE (email);


--
-- TOC entry 4901 (class 2606 OID 48976)
-- Name: users users_email_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key56 UNIQUE (email);


--
-- TOC entry 4903 (class 2606 OID 48978)
-- Name: users users_email_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key57 UNIQUE (email);


--
-- TOC entry 4905 (class 2606 OID 48838)
-- Name: users users_email_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key58 UNIQUE (email);


--
-- TOC entry 4907 (class 2606 OID 48786)
-- Name: users users_email_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key59 UNIQUE (email);


--
-- TOC entry 4909 (class 2606 OID 48872)
-- Name: users users_email_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key6 UNIQUE (email);


--
-- TOC entry 4911 (class 2606 OID 48788)
-- Name: users users_email_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key60 UNIQUE (email);


--
-- TOC entry 4913 (class 2606 OID 48836)
-- Name: users users_email_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key61 UNIQUE (email);


--
-- TOC entry 4915 (class 2606 OID 48790)
-- Name: users users_email_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key62 UNIQUE (email);


--
-- TOC entry 4917 (class 2606 OID 48834)
-- Name: users users_email_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key63 UNIQUE (email);


--
-- TOC entry 4919 (class 2606 OID 48832)
-- Name: users users_email_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key64 UNIQUE (email);


--
-- TOC entry 4921 (class 2606 OID 48792)
-- Name: users users_email_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key65 UNIQUE (email);


--
-- TOC entry 4923 (class 2606 OID 48830)
-- Name: users users_email_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key66 UNIQUE (email);


--
-- TOC entry 4925 (class 2606 OID 48956)
-- Name: users users_email_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key67 UNIQUE (email);


--
-- TOC entry 4927 (class 2606 OID 48796)
-- Name: users users_email_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key68 UNIQUE (email);


--
-- TOC entry 4929 (class 2606 OID 48942)
-- Name: users users_email_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key69 UNIQUE (email);


--
-- TOC entry 4931 (class 2606 OID 48794)
-- Name: users users_email_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key7 UNIQUE (email);


--
-- TOC entry 4933 (class 2606 OID 48940)
-- Name: users users_email_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key70 UNIQUE (email);


--
-- TOC entry 4935 (class 2606 OID 48798)
-- Name: users users_email_key71; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key71 UNIQUE (email);


--
-- TOC entry 4937 (class 2606 OID 48938)
-- Name: users users_email_key72; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key72 UNIQUE (email);


--
-- TOC entry 4939 (class 2606 OID 48936)
-- Name: users users_email_key73; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key73 UNIQUE (email);


--
-- TOC entry 4941 (class 2606 OID 48800)
-- Name: users users_email_key74; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key74 UNIQUE (email);


--
-- TOC entry 4943 (class 2606 OID 48934)
-- Name: users users_email_key75; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key75 UNIQUE (email);


--
-- TOC entry 4945 (class 2606 OID 48930)
-- Name: users users_email_key76; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key76 UNIQUE (email);


--
-- TOC entry 4947 (class 2606 OID 48806)
-- Name: users users_email_key77; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key77 UNIQUE (email);


--
-- TOC entry 4949 (class 2606 OID 48808)
-- Name: users users_email_key78; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key78 UNIQUE (email);


--
-- TOC entry 4951 (class 2606 OID 48928)
-- Name: users users_email_key79; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key79 UNIQUE (email);


--
-- TOC entry 4953 (class 2606 OID 48958)
-- Name: users users_email_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key8 UNIQUE (email);


--
-- TOC entry 4955 (class 2606 OID 48810)
-- Name: users users_email_key80; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key80 UNIQUE (email);


--
-- TOC entry 4957 (class 2606 OID 48918)
-- Name: users users_email_key81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key81 UNIQUE (email);


--
-- TOC entry 4959 (class 2606 OID 48828)
-- Name: users users_email_key82; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key82 UNIQUE (email);


--
-- TOC entry 4961 (class 2606 OID 48812)
-- Name: users users_email_key83; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key83 UNIQUE (email);


--
-- TOC entry 4963 (class 2606 OID 48826)
-- Name: users users_email_key84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key84 UNIQUE (email);


--
-- TOC entry 4965 (class 2606 OID 48824)
-- Name: users users_email_key85; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key85 UNIQUE (email);


--
-- TOC entry 4967 (class 2606 OID 48814)
-- Name: users users_email_key86; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key86 UNIQUE (email);


--
-- TOC entry 4969 (class 2606 OID 48822)
-- Name: users users_email_key87; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key87 UNIQUE (email);


--
-- TOC entry 4971 (class 2606 OID 48820)
-- Name: users users_email_key88; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key88 UNIQUE (email);


--
-- TOC entry 4973 (class 2606 OID 48816)
-- Name: users users_email_key89; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key89 UNIQUE (email);


--
-- TOC entry 4975 (class 2606 OID 48762)
-- Name: users users_email_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key9 UNIQUE (email);


--
-- TOC entry 4977 (class 2606 OID 48818)
-- Name: users users_email_key90; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key90 UNIQUE (email);


--
-- TOC entry 4979 (class 2606 OID 49002)
-- Name: users users_email_key91; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key91 UNIQUE (email);


--
-- TOC entry 4981 (class 2606 OID 48988)
-- Name: users users_email_key92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key92 UNIQUE (email);


--
-- TOC entry 4983 (class 2606 OID 49000)
-- Name: users users_email_key93; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key93 UNIQUE (email);


--
-- TOC entry 4985 (class 2606 OID 48990)
-- Name: users users_email_key94; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key94 UNIQUE (email);


--
-- TOC entry 4987 (class 2606 OID 48998)
-- Name: users users_email_key95; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key95 UNIQUE (email);


--
-- TOC entry 4989 (class 2606 OID 48992)
-- Name: users users_email_key96; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key96 UNIQUE (email);


--
-- TOC entry 4991 (class 2606 OID 48996)
-- Name: users users_email_key97; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key97 UNIQUE (email);


--
-- TOC entry 4993 (class 2606 OID 48994)
-- Name: users users_email_key98; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key98 UNIQUE (email);


--
-- TOC entry 4995 (class 2606 OID 48926)
-- Name: users users_email_key99; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key99 UNIQUE (email);


--
-- TOC entry 4997 (class 2606 OID 16406)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4999 (class 2606 OID 48749)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (name);


--
-- TOC entry 5002 (class 1259 OID 48734)
-- Name: idx_products_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_products_name ON public.products USING btree (name);


--
-- TOC entry 4734 (class 1259 OID 49011)
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_email ON public.users USING btree (email);


--
-- TOC entry 4735 (class 1259 OID 48750)
-- Name: idx_users_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_username ON public.users USING btree (name);


--
-- TOC entry 5015 (class 2606 OID 16534)
-- Name: cart_items cart_items_cart_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_cart_id_fkey FOREIGN KEY (cart_id) REFERENCES public.carts(cart_id) ON DELETE CASCADE;


--
-- TOC entry 5016 (class 2606 OID 16539)
-- Name: cart_items cart_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE CASCADE;


--
-- TOC entry 5014 (class 2606 OID 16520)
-- Name: carts carts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 5018 (class 2606 OID 49021)
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5019 (class 2606 OID 49026)
-- Name: order_items order_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- TOC entry 5017 (class 2606 OID 49014)
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 5013 (class 2606 OID 48737)
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(category_id);


-- Completed on 2024-10-12 15:36:53

--
-- PostgreSQL database dump complete
--

