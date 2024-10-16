PGDMP  (                	    |            imperio_bebidas_e_tabacos    16.3    16.3 �    ;           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            <           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            =           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            >           1262    16398    imperio_bebidas_e_tabacos    DATABASE     �   CREATE DATABASE imperio_bebidas_e_tabacos WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';
 )   DROP DATABASE imperio_bebidas_e_tabacos;
                root_2    false            ?           0    0 "   DATABASE imperio_bebidas_e_tabacos    ACL     v   GRANT ALL ON DATABASE imperio_bebidas_e_tabacos TO "Root3";
GRANT ALL ON DATABASE imperio_bebidas_e_tabacos TO root4;
                   root_2    false    5182                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            @           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    4            �            1255    16505    update_updated_at_column()    FUNCTION     �   CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
   NEW.updated_at = NOW();
   RETURN NEW;
END;
$$;
 1   DROP FUNCTION public.update_updated_at_column();
       public          postgres    false    4            �            1259    16526 
   cart_items    TABLE     �   CREATE TABLE public.cart_items (
    cart_item_id integer NOT NULL,
    cart_id integer,
    product_id integer,
    quantity integer DEFAULT 1,
    price numeric(10,2) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.cart_items;
       public         heap    postgres    false    4            �            1259    16525    cart_items_cart_item_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cart_items_cart_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.cart_items_cart_item_id_seq;
       public          postgres    false    4    224            A           0    0    cart_items_cart_item_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.cart_items_cart_item_id_seq OWNED BY public.cart_items.cart_item_id;
          public          postgres    false    223            �            1259    16513    carts    TABLE     �   CREATE TABLE public.carts (
    cart_id integer NOT NULL,
    user_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.carts;
       public         heap    postgres    false    4            �            1259    16512    carts_cart_id_seq    SEQUENCE     �   CREATE SEQUENCE public.carts_cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.carts_cart_id_seq;
       public          postgres    false    222    4            B           0    0    carts_cart_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.carts_cart_id_seq OWNED BY public.carts.cart_id;
          public          postgres    false    221            �            1259    16413 
   categories    TABLE     �   CREATE TABLE public.categories (
    category_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text
);
    DROP TABLE public.categories;
       public         heap    postgres    false    4            �            1259    16412    categories_category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.categories_category_id_seq;
       public          postgres    false    4    218            C           0    0    categories_category_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;
          public          postgres    false    217            �            1259    43162    order_items    TABLE     �   CREATE TABLE public.order_items (
    order_item_id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    price numeric(10,2) NOT NULL
);
    DROP TABLE public.order_items;
       public         heap    postgres    false    4            �            1259    43161    order_items_order_item_id_seq    SEQUENCE     �   CREATE SEQUENCE public.order_items_order_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.order_items_order_item_id_seq;
       public          postgres    false    4    228            D           0    0    order_items_order_item_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.order_items_order_item_id_seq OWNED BY public.order_items.order_item_id;
          public          postgres    false    227            �            1259    43145    orders    TABLE     �  CREATE TABLE public.orders (
    order_id integer NOT NULL,
    user_id integer NOT NULL,
    total_price numeric(10,2) NOT NULL,
    status character varying(255) DEFAULT 'pendente'::character varying NOT NULL,
    payment_method character varying(255) NOT NULL,
    address character varying(255),
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);
    DROP TABLE public.orders;
       public         heap    postgres    false    4            �            1259    43144    orders_order_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.orders_order_id_seq;
       public          postgres    false    226    4            E           0    0    orders_order_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;
          public          postgres    false    225            �            1259    16422    products    TABLE     {  CREATE TABLE public.products (
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
    DROP TABLE public.products;
       public         heap    postgres    false    4            �            1259    16421    products_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.products_product_id_seq;
       public          postgres    false    4    220            F           0    0    products_product_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;
          public          postgres    false    219            �            1259    16400    users    TABLE       CREATE TABLE public.users (
    user_id integer NOT NULL,
    name character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    created_at timestamp with time zone,
    phone character varying(255) NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false    4            �            1259    16399    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          postgres    false    216    4            G           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          postgres    false    215            x           2604    16529    cart_items cart_item_id    DEFAULT     �   ALTER TABLE ONLY public.cart_items ALTER COLUMN cart_item_id SET DEFAULT nextval('public.cart_items_cart_item_id_seq'::regclass);
 F   ALTER TABLE public.cart_items ALTER COLUMN cart_item_id DROP DEFAULT;
       public          postgres    false    224    223    224            v           2604    16516    carts cart_id    DEFAULT     n   ALTER TABLE ONLY public.carts ALTER COLUMN cart_id SET DEFAULT nextval('public.carts_cart_id_seq'::regclass);
 <   ALTER TABLE public.carts ALTER COLUMN cart_id DROP DEFAULT;
       public          postgres    false    222    221    222            p           2604    16416    categories category_id    DEFAULT     �   ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);
 E   ALTER TABLE public.categories ALTER COLUMN category_id DROP DEFAULT;
       public          postgres    false    217    218    218            }           2604    43165    order_items order_item_id    DEFAULT     �   ALTER TABLE ONLY public.order_items ALTER COLUMN order_item_id SET DEFAULT nextval('public.order_items_order_item_id_seq'::regclass);
 H   ALTER TABLE public.order_items ALTER COLUMN order_item_id DROP DEFAULT;
       public          postgres    false    227    228    228            {           2604    43148    orders order_id    DEFAULT     r   ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);
 >   ALTER TABLE public.orders ALTER COLUMN order_id DROP DEFAULT;
       public          postgres    false    225    226    226            q           2604    16425    products product_id    DEFAULT     z   ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);
 B   ALTER TABLE public.products ALTER COLUMN product_id DROP DEFAULT;
       public          postgres    false    219    220    220            o           2604    16403    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    216    215    216            4          0    16526 
   cart_items 
   TABLE DATA           d   COPY public.cart_items (cart_item_id, cart_id, product_id, quantity, price, created_at) FROM stdin;
    public          postgres    false    224   ��       2          0    16513    carts 
   TABLE DATA           =   COPY public.carts (cart_id, user_id, created_at) FROM stdin;
    public          postgres    false    222   ��       .          0    16413 
   categories 
   TABLE DATA           D   COPY public.categories (category_id, name, description) FROM stdin;
    public          postgres    false    218   ��       8          0    43162    order_items 
   TABLE DATA           [   COPY public.order_items (order_item_id, order_id, product_id, quantity, price) FROM stdin;
    public          postgres    false    228   ��       6          0    43145    orders 
   TABLE DATA           {   COPY public.orders (order_id, user_id, total_price, status, payment_method, address, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    226   ��       0          0    16422    products 
   TABLE DATA           ~   COPY public.products (product_id, name, description, price, stock, category_id, unit_price, box_price, image_url) FROM stdin;
    public          postgres    false    220   �       ,          0    16400    users 
   TABLE DATA           R   COPY public.users (user_id, name, password, email, created_at, phone) FROM stdin;
    public          postgres    false    216   ]       H           0    0    cart_items_cart_item_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.cart_items_cart_item_id_seq', 1, false);
          public          postgres    false    223            I           0    0    carts_cart_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.carts_cart_id_seq', 1, false);
          public          postgres    false    221            J           0    0    categories_category_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.categories_category_id_seq', 1, true);
          public          postgres    false    217            K           0    0    order_items_order_item_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.order_items_order_item_id_seq', 1, false);
          public          postgres    false    227            L           0    0    orders_order_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.orders_order_id_seq', 1, false);
          public          postgres    false    225            M           0    0    products_product_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.products_product_id_seq', 11, true);
          public          postgres    false    219            N           0    0    users_user_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_user_id_seq', 23, true);
          public          postgres    false    215            �           2606    16533    cart_items cart_items_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (cart_item_id);
 D   ALTER TABLE ONLY public.cart_items DROP CONSTRAINT cart_items_pkey;
       public            postgres    false    224            �           2606    16519    carts carts_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (cart_id);
 :   ALTER TABLE ONLY public.carts DROP CONSTRAINT carts_pkey;
       public            postgres    false    222            �           2606    16420    categories categories_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public            postgres    false    218            �           2606    43167    order_items order_items_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (order_item_id);
 F   ALTER TABLE ONLY public.order_items DROP CONSTRAINT order_items_pkey;
       public            postgres    false    228            �           2606    43155    orders orders_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            postgres    false    226            �           2606    16430    products products_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public            postgres    false    220            �           2606    49013    users unique_phone 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_phone UNIQUE (phone);
 <   ALTER TABLE ONLY public.users DROP CONSTRAINT unique_phone;
       public            postgres    false    216            �           2606    48908    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    216            �           2606    48910    users users_email_key1 
   CONSTRAINT     R   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key1 UNIQUE (email);
 @   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key1;
       public            postgres    false    216            �           2606    48764    users users_email_key10 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key10 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key10;
       public            postgres    false    216            �           2606    48920    users users_email_key100 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key100 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key100;
       public            postgres    false    216            �           2606    48924    users users_email_key101 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key101 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key101;
       public            postgres    false    216            �           2606    48922    users users_email_key102 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key102 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key102;
       public            postgres    false    216            �           2606    48784    users users_email_key103 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key103 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key103;
       public            postgres    false    216            �           2606    48782    users users_email_key104 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key104 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key104;
       public            postgres    false    216            �           2606    48890    users users_email_key105 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key105 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key105;
       public            postgres    false    216            �           2606    48880    users users_email_key106 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key106 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key106;
       public            postgres    false    216            �           2606    48884    users users_email_key107 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key107 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key107;
       public            postgres    false    216            �           2606    48882    users users_email_key108 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key108 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key108;
       public            postgres    false    216            �           2606    48954    users users_email_key109 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key109 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key109;
       public            postgres    false    216            �           2606    48878    users users_email_key11 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key11 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key11;
       public            postgres    false    216            �           2606    48944    users users_email_key110 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key110 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key110;
       public            postgres    false    216            �           2606    48952    users users_email_key111 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key111 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key111;
       public            postgres    false    216            �           2606    48946    users users_email_key112 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key112 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key112;
       public            postgres    false    216            �           2606    48950    users users_email_key113 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key113 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key113;
       public            postgres    false    216            �           2606    48948    users users_email_key114 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key114 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key114;
       public            postgres    false    216            �           2606    48876    users users_email_key115 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key115 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key115;
       public            postgres    false    216            �           2606    48874    users users_email_key116 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key116 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key116;
       public            postgres    false    216            �           2606    48766    users users_email_key117 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key117 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key117;
       public            postgres    false    216            �           2606    48914    users users_email_key118 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key118 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key118;
       public            postgres    false    216            �           2606    48932    users users_email_key119 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key119 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key119;
       public            postgres    false    216            �           2606    48906    users users_email_key12 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key12 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key12;
       public            postgres    false    216            �           2606    48916    users users_email_key120 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key120 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key120;
       public            postgres    false    216            �           2606    48804    users users_email_key121 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key121 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key121;
       public            postgres    false    216            �           2606    48802    users users_email_key122 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key122 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key122;
       public            postgres    false    216            �           2606    48776    users users_email_key123 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key123 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key123;
       public            postgres    false    216            �           2606    48770    users users_email_key124 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key124 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key124;
       public            postgres    false    216            �           2606    48774    users users_email_key125 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key125 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key125;
       public            postgres    false    216            �           2606    48772    users users_email_key126 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key126 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key126;
       public            postgres    false    216            �           2606    48754    users users_email_key127 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key127 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key127;
       public            postgres    false    216            �           2606    49010    users users_email_key128 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key128 UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key128;
       public            postgres    false    216            �           2606    48886    users users_email_key13 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key13 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key13;
       public            postgres    false    216            �           2606    48904    users users_email_key14 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key14 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key14;
       public            postgres    false    216            �           2606    48888    users users_email_key15 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key15 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key15;
       public            postgres    false    216            �           2606    48892    users users_email_key16 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key16 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key16;
       public            postgres    false    216            �           2606    48902    users users_email_key17 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key17 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key17;
       public            postgres    false    216            �           2606    48960    users users_email_key18 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key18 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key18;
       public            postgres    false    216            �           2606    48962    users users_email_key19 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key19 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key19;
       public            postgres    false    216            �           2606    48912    users users_email_key2 
   CONSTRAINT     R   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key2 UNIQUE (email);
 @   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key2;
       public            postgres    false    216            �           2606    48760    users users_email_key20 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key20 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key20;
       public            postgres    false    216            �           2606    48964    users users_email_key21 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key21 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key21;
       public            postgres    false    216            �           2606    48966    users users_email_key22 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key22 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key22;
       public            postgres    false    216            �           2606    48968    users users_email_key23 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key23 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key23;
       public            postgres    false    216            �           2606    48758    users users_email_key24 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key24 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key24;
       public            postgres    false    216            �           2606    48970    users users_email_key25 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key25 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key25;
       public            postgres    false    216            �           2606    48756    users users_email_key26 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key26 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key26;
       public            postgres    false    216            �           2606    49008    users users_email_key27 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key27 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key27;
       public            postgres    false    216            �           2606    48972    users users_email_key28 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key28 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key28;
       public            postgres    false    216            �           2606    48852    users users_email_key29 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key29 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key29;
       public            postgres    false    216            �           2606    48768    users users_email_key3 
   CONSTRAINT     R   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key3 UNIQUE (email);
 @   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key3;
       public            postgres    false    216            �           2606    48974    users users_email_key30 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key30 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key30;
       public            postgres    false    216            �           2606    48840    users users_email_key31 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key31 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key31;
       public            postgres    false    216            �           2606    48850    users users_email_key32 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key32 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key32;
       public            postgres    false    216            �           2606    48842    users users_email_key33 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key33 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key33;
       public            postgres    false    216            �           2606    48844    users users_email_key34 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key34 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key34;
       public            postgres    false    216            �           2606    48848    users users_email_key35 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key35 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key35;
       public            postgres    false    216            �           2606    48846    users users_email_key36 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key36 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key36;
       public            postgres    false    216            �           2606    48900    users users_email_key37 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key37 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key37;
       public            postgres    false    216            �           2606    48894    users users_email_key38 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key38 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key38;
       public            postgres    false    216            �           2606    48896    users users_email_key39 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key39 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key39;
       public            postgres    false    216                       2606    48778    users users_email_key4 
   CONSTRAINT     R   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key4 UNIQUE (email);
 @   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key4;
       public            postgres    false    216                       2606    48898    users users_email_key40 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key40 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key40;
       public            postgres    false    216                       2606    48854    users users_email_key41 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key41 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key41;
       public            postgres    false    216                       2606    49006    users users_email_key42 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key42 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key42;
       public            postgres    false    216            	           2606    48856    users users_email_key43 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key43 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key43;
       public            postgres    false    216                       2606    48858    users users_email_key44 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key44 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key44;
       public            postgres    false    216                       2606    49004    users users_email_key45 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key45 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key45;
       public            postgres    false    216                       2606    48986    users users_email_key46 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key46 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key46;
       public            postgres    false    216                       2606    48860    users users_email_key47 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key47 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key47;
       public            postgres    false    216                       2606    48862    users users_email_key48 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key48 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key48;
       public            postgres    false    216                       2606    48984    users users_email_key49 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key49 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key49;
       public            postgres    false    216                       2606    48780    users users_email_key5 
   CONSTRAINT     R   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key5 UNIQUE (email);
 @   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key5;
       public            postgres    false    216                       2606    48982    users users_email_key50 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key50 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key50;
       public            postgres    false    216                       2606    48864    users users_email_key51 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key51 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key51;
       public            postgres    false    216                       2606    48866    users users_email_key52 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key52 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key52;
       public            postgres    false    216                       2606    48868    users users_email_key53 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key53 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key53;
       public            postgres    false    216            !           2606    48980    users users_email_key54 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key54 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key54;
       public            postgres    false    216            #           2606    48870    users users_email_key55 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key55 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key55;
       public            postgres    false    216            %           2606    48976    users users_email_key56 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key56 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key56;
       public            postgres    false    216            '           2606    48978    users users_email_key57 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key57 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key57;
       public            postgres    false    216            )           2606    48838    users users_email_key58 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key58 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key58;
       public            postgres    false    216            +           2606    48786    users users_email_key59 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key59 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key59;
       public            postgres    false    216            -           2606    48872    users users_email_key6 
   CONSTRAINT     R   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key6 UNIQUE (email);
 @   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key6;
       public            postgres    false    216            /           2606    48788    users users_email_key60 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key60 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key60;
       public            postgres    false    216            1           2606    48836    users users_email_key61 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key61 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key61;
       public            postgres    false    216            3           2606    48790    users users_email_key62 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key62 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key62;
       public            postgres    false    216            5           2606    48834    users users_email_key63 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key63 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key63;
       public            postgres    false    216            7           2606    48832    users users_email_key64 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key64 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key64;
       public            postgres    false    216            9           2606    48792    users users_email_key65 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key65 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key65;
       public            postgres    false    216            ;           2606    48830    users users_email_key66 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key66 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key66;
       public            postgres    false    216            =           2606    48956    users users_email_key67 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key67 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key67;
       public            postgres    false    216            ?           2606    48796    users users_email_key68 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key68 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key68;
       public            postgres    false    216            A           2606    48942    users users_email_key69 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key69 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key69;
       public            postgres    false    216            C           2606    48794    users users_email_key7 
   CONSTRAINT     R   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key7 UNIQUE (email);
 @   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key7;
       public            postgres    false    216            E           2606    48940    users users_email_key70 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key70 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key70;
       public            postgres    false    216            G           2606    48798    users users_email_key71 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key71 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key71;
       public            postgres    false    216            I           2606    48938    users users_email_key72 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key72 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key72;
       public            postgres    false    216            K           2606    48936    users users_email_key73 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key73 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key73;
       public            postgres    false    216            M           2606    48800    users users_email_key74 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key74 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key74;
       public            postgres    false    216            O           2606    48934    users users_email_key75 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key75 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key75;
       public            postgres    false    216            Q           2606    48930    users users_email_key76 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key76 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key76;
       public            postgres    false    216            S           2606    48806    users users_email_key77 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key77 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key77;
       public            postgres    false    216            U           2606    48808    users users_email_key78 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key78 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key78;
       public            postgres    false    216            W           2606    48928    users users_email_key79 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key79 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key79;
       public            postgres    false    216            Y           2606    48958    users users_email_key8 
   CONSTRAINT     R   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key8 UNIQUE (email);
 @   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key8;
       public            postgres    false    216            [           2606    48810    users users_email_key80 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key80 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key80;
       public            postgres    false    216            ]           2606    48918    users users_email_key81 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key81 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key81;
       public            postgres    false    216            _           2606    48828    users users_email_key82 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key82 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key82;
       public            postgres    false    216            a           2606    48812    users users_email_key83 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key83 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key83;
       public            postgres    false    216            c           2606    48826    users users_email_key84 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key84 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key84;
       public            postgres    false    216            e           2606    48824    users users_email_key85 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key85 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key85;
       public            postgres    false    216            g           2606    48814    users users_email_key86 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key86 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key86;
       public            postgres    false    216            i           2606    48822    users users_email_key87 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key87 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key87;
       public            postgres    false    216            k           2606    48820    users users_email_key88 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key88 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key88;
       public            postgres    false    216            m           2606    48816    users users_email_key89 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key89 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key89;
       public            postgres    false    216            o           2606    48762    users users_email_key9 
   CONSTRAINT     R   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key9 UNIQUE (email);
 @   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key9;
       public            postgres    false    216            q           2606    48818    users users_email_key90 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key90 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key90;
       public            postgres    false    216            s           2606    49002    users users_email_key91 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key91 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key91;
       public            postgres    false    216            u           2606    48988    users users_email_key92 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key92 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key92;
       public            postgres    false    216            w           2606    49000    users users_email_key93 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key93 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key93;
       public            postgres    false    216            y           2606    48990    users users_email_key94 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key94 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key94;
       public            postgres    false    216            {           2606    48998    users users_email_key95 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key95 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key95;
       public            postgres    false    216            }           2606    48992    users users_email_key96 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key96 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key96;
       public            postgres    false    216                       2606    48996    users users_email_key97 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key97 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key97;
       public            postgres    false    216            �           2606    48994    users users_email_key98 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key98 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key98;
       public            postgres    false    216            �           2606    48926    users users_email_key99 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key99 UNIQUE (email);
 A   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key99;
       public            postgres    false    216            �           2606    16406    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    216            �           2606    48749    users users_username_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (name);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_username_key;
       public            postgres    false    216            �           1259    48734    idx_products_name    INDEX     F   CREATE INDEX idx_products_name ON public.products USING btree (name);
 %   DROP INDEX public.idx_products_name;
       public            postgres    false    220            ~           1259    49011    idx_users_email    INDEX     B   CREATE INDEX idx_users_email ON public.users USING btree (email);
 #   DROP INDEX public.idx_users_email;
       public            postgres    false    216                       1259    48750    idx_users_username    INDEX     D   CREATE INDEX idx_users_username ON public.users USING btree (name);
 &   DROP INDEX public.idx_users_username;
       public            postgres    false    216            �           2606    16534 "   cart_items cart_items_cart_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_cart_id_fkey FOREIGN KEY (cart_id) REFERENCES public.carts(cart_id) ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.cart_items DROP CONSTRAINT cart_items_cart_id_fkey;
       public          postgres    false    5006    222    224            �           2606    16539 %   cart_items cart_items_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.cart_items DROP CONSTRAINT cart_items_product_id_fkey;
       public          postgres    false    5004    220    224            �           2606    16520    carts carts_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.carts DROP CONSTRAINT carts_user_id_fkey;
       public          postgres    false    4997    216    222            �           2606    49021 %   order_items order_items_order_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON UPDATE CASCADE ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.order_items DROP CONSTRAINT order_items_order_id_fkey;
       public          postgres    false    226    228    5010            �           2606    49026 '   order_items order_items_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);
 Q   ALTER TABLE ONLY public.order_items DROP CONSTRAINT order_items_product_id_fkey;
       public          postgres    false    5004    220    228            �           2606    49014    orders orders_user_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 D   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_user_id_fkey;
       public          postgres    false    226    4997    216            �           2606    48737 "   products products_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(category_id);
 L   ALTER TABLE ONLY public.products DROP CONSTRAINT products_category_id_fkey;
       public          postgres    false    220    218    5001            4      x������ � �      2      x������ � �      .   �   x�m�=N1�k�> b�?-�[B��h<�w��īx��kq.���#$*�=�{'�#�ϑ�(lỷ����(-��
���B�$�nv2�v��[�Onbb���3X�\�DP���^,�Ѿ���p�m溸������$�s}��uiƌ_w����@#Y�Lp�$����,�{!�℄+Z�/��Uþ�K<P#�Ru�%\Ýeևc�{ʯ�T4<�>x�      8      x������ � �      6      x������ � �      0      x��}ɒ�ƕ�9�И�5e,��*�U\��f�2k��3�3,Y˩��47�u�����鋮�'�%�6w�;٣6��͊��x�����-i6�PǪV[��T�*T�|2����V�z��v���PT���U7t��]��M�������_��k�MU�&�c�u��V�U%��9���Up��G�$eO&�Q��?Z������|�v��-�u(w�J�Y�kU�t���dp�T� �����O�@pSw1�n7U�\�"�A�N~w�����R70f��-���c�>$��ںJt�� P`�&���;�g�� �^Ý� ��WtS;TO\��/<����x�T���]�-0Ǻ:�U @��6|z[%{��W;�89��V�=��ַ�ލ�ê ,�ɾB�+a���<�3}���״�9,#�|�K/��) � .>���Wab�b�|/��*�y 3p��J7��U�����|U��Uq��6��&)T�޴
�k��*o����'�Vl�[�����\�wx�<�St:���FmԻ�^V�-��u@�J���>}��	�w��U����Y�5��>0�����W5�������Q�#��p�p'��Anw� ��<���?�����(�ѧ� �VH��J>�'��@��t9z��\ �8��ۺ f@ᇑI�� ���&�y�U0�����.�� �l������m�����`���z�-nW�5,ή���50��;,`w���ץ��FF�?(D�/���yL�)��VD������j�}_�UIF�|������{]�-�Ų=��1���k7ɦ�U	��$ j����dI�h�s���QV.l����9�q��?��;Hy�O'L��7�Puܓ`�C9z�$��DE�Q�Z�ɜq��a�}��00��-&2��Ȑ>���q�\���W�W�i�
Y��c-�޴_X�hy�/��E��^�B��j�R5u_{3�צ��+ r���k��G�����mP��7y��˶�ˋ���J�|����|�j�%����v��(%_z�O������x���>V��#�7����%�9L*k��F|V��xQT7@�UY��1����s�G����cd�G/�͛��5��7:��˪(޿���o���|���u��p���������	}����]rY�7��8{zp��k��"�S�<���b��s��Dg�o@'�����?�V�2z�_�q�PO&:��e�7�w���9��'��;3����{��KT�v����;�{�iJc�V>NE�-F�
�yc�࿜���ۼM���y��`��r:��RN�]	�V�΅�W��U�go��V����Jt!���$�tYW�%tc��b��b�7GMʚ������[���ٺ�؂�s�-N6aq�M ��N%_�u{���3NH��Q����#a&�6� �Q� �boU���I��7��+�0Y�� v���I����@E�8*2Mr�-�<kS�6� )�{>�&}+]0dY�����3f���fѿ6-)z��U�t��Cfp�peiQ�SgJ˦qp^1�n������H��&��b�C���^� ��B�8$���8 %���o�\mUW��O�|S,��o%�z>�/Ygs��BP�ڛ!�?����`w�f5�P��6�撅x��Cfp��;.q��:,�3�8�R��k0��;�L͓>��r7[v�\W-W*��8:��DLpxϏ��k��R%LE9�Lh���7�j���O"五=�����8��� ���2cĹWy�4�-R:y*��H=�"�ֳ���"P0^i4�r� ���_��9�}����=�x4o�2�8١�����k�UEU�T�k��j\lf,{V�'��u-z�zn!}�����k�'z�>D׭nR��#'�{%��7�Fy.U�]qV=ʅ�˪>�����2��~]����"fy���0���cbƑa������Uh�F�:|4�K�WD8:��x 
@������uVD���	{a�iҽ>u>�j��*�&����ϟ���+� DXTq�t������\?��Ѐ�C�+�P��6�6_Y_�^�^vǰ���F#�D��5�}�wcz���Y1�H���7��}��e|̲�@X���F���$��qy�E\�6� p����n��=NcP��,_9��aϱ:�����S�գW5�d��z����0] :�m��]��������c�ȣ��44y�A� ۮ���]�P�x��\J����E�0����p���Sa$%Bz��,h�:.�^�2�����T0O~���a=u�Q�h��P��8�:X���Ai���)�fh<["����yb��7��l~N�8��ۿ�t��.7}nO �-�e��	��Y��f1|��O�8L_m���G�8�8@c�}�_}��4� �|�N�7�1�+�-�bO�(�ZY��-27:UR�y�7-[����Z�N��
P��W�����Fqu`�K\�؞c���T���{�7����Z��s�k'yZܪ[��ۈ�4�XA����Ekh.s�C�&_Ābg�� �U^��i�Ԇ>&���1��c��˖< g}wJ��S���z_���]�ޖ�7��:��¡�.���<�5�2~e��@�����g? ;hm?p�����@�n�3���������0I���|���*��خi�J�A�A�)^VB��r�Zu~2M�"�L�f��D���y��>0���9K��x��]50���(��3�>����2:G`�E��4���8Yaѭϔn-��i ��ȥ���h����١�_�#�Aʣ��T��A[�Kp>���;4��k\Ư+���Ԫ��0��l=N�G�/a������)s֌߅ˏ�k�6Y��`��S��^ӋPV��C:�9m�rz��|��T��l����w�Z`N��s��0J�ʪ���x��FKH�#ۍ��>�E[��`?�Ɲ��g��6���40�U�XW�Z�l�u^�	�Fk�-���/[vS�Bg���y�j�v:I-�b� ,Zt�bEl �uC��M�}�uh~ތɊ�%!C�"�x����y`��;;M��e�Z�V�W�>�l�g9��K���8��tsS�H�:���|2֭ޣ�b<��ek:�+ݣ*]����.��6o�#��b1��m^`$���NGS�!����������}q	B��0=��5W�k�v��yU�ӏ�Z����B�O�u�eXV�6��	n0��-b�q��.�*$Q� ���\����>�l~��oT�]]�-N~U��fz�t�=ҀUjp=���#^�
�%�e5t.��������<6�4O��`b4A\��.�E�ȁ�?�L��,��]��Ȯo=���r]�\)n�N#wN�-��C80-�f$Ж�J����#��)z��[�F�o��;��h�p����9#63ς�8�if2ͧ7MU�G�u���������#x�K�YYf
�A��#�U(@+��6'6�iᚂ�:�:�_ۨ�I�T��D�	MjC�ܧ��\���6�;��K�H�1���9p�����,Ȓ�������3ޖ���Q�c��d���ؑ�ԓ�w@� ˖Α��g��9}:�Ľ=4&Z�9�-���y��@p���L�/�{Y!���'˹��kEg7Ǳ�3z���(&o�R�[E��u�ybT�_��<��x�7��U�Gߪ�Ԟ���ބ�#�{!��$��(D`=���}�^���j�e"p�Xmհ�LVy#�
ʼ$/qd��[�l��.�<I�'W��萅E�9��v�.�"�� �LV��*}���p6M>� IC��=�7��)�0��8�t�@@IcC�P�+��I�ϰ� L�wܭk��Z��F�V��f���+@g]*�5�䰦�=�o<$���'����^�Z_m��S��
vڿ�-vw ;��s�ʁy#�Α%c��?�UGa胫�|<������K0���^�e��FY�c=�T^���L
�y�?���w� �Ng�����#�rdR���N�'N�acu�-ng0y���#�+b��    g���}���4y9.Z;�縿���.n��$a�|����}_I{�ή��~S��z����B�7|zM�'����B% ���e?��+@I�Sl�/A9C�3�8鼉�5M_�S&١2OC���4X7v��6�)��<3�g��Gf(7�A���
p�¸��P(`{��|���t��ǜ�  �8`����0����E�,���u��I:��g��O{�r㞯��"?�#�;��ޖ1�Ew#����zSPX��þ�(�����,}���>��S�Ў'{u�����yg�d���Ld!�L�\����;� �<���wj��g����E�m�Dg�#( �wfVI�T}���av�$dB�/G�(�q�\��O�$J�vQ���E�	Q>�Z�����~0Q�A�A�ӊ��|%ѓO�v�T��Ijߨ���S,��>v�PW��t���dܖ��5�'aY�b�� aZյ� ��A�����>ri�`~�"�,��V�,� R�G'jD!���az�2�Z� ٢^�P�����O���yG��Y�p�ٱ��&�A�c
\,G�@�W5*S���:rɲ��|�u.mƉ@tpך�����?�� S��q�.;��v`�חO���X��W�	����oO?�:n���w�XwA(�ՎlJ�i��[\��(D��6�*�/�3HS�%^���TE�L�#���-�`�\v�?�D{�Qu&��ˉ�����1��3N�[.S�eq�6�sZɆ�(��z�^�{$�.&~�����MCc�}��cd�����Czmi����4O8��.��c��j�c�ܨ�%�VP��rL��T�k]��p�ɢ���ݍ:�}�.��d�a&��	�?V�?�2�"�5FO�m�bTm	w ���=�`���;%�09���q*&=hp��L�!�
�&�4	���n&.�Q���?��s�c��N�l�֬�d<�*?�2M��U� 4�Ӑ`�&{1��S�E�;�<��Wڸf��q�	<B M��<��@���@�|�Ys�³E�w��@[� �&���B�_�qDkļ�����(���~_5ڱ�)$w���a?:@���7�.�tuS�7({P�]����!���{���:�[�'D�����&�&�$W����&�]��g�2������g梌e+_ӕ��E�����G
�_?�����
S���"����.�<��^47���4ę�t��I��|a�{�����A#�]$�N�M�^u�#��}G��K�ؚ	&j"f��I�z��ADrUm��#n�C���OO2z�Ad��&�g*��JyNq��3�+¬��V��y�ހ�}����]X���s�$7�&G޾�x�ݜ;�Xqƣ�;qP�֒z�ss�>3p�׬)j5j�F|���bbĽ�(�Wo<���X�'|e ���$�1_����o��� ���EY���S���(��L�0֒�k�鏍=Ŝ�3v��t �Y¾�CƂ��>�����cI�ٌ��:3�%��l@6�I���*�?5� �: k��,e3b �{��\�����?˳�L�Q��0��� ��X|�t��b����NiS����z!6�k${���r��<�l�r���M�"�5iBO�C,���w�<��ٜ�;��"!�l���@)oo@�{o��.��g��ǎ�{ŉ'�#J��-?��w?fOFj�Z��B�;�g�\�G_���y�o��!b���I����ixL�l4X��րMgb�X��lhb:d��arM̸Oe-�%UW���9|�K�"�N�K����:�Q]���H�s��!��&���FH�T�YNAo�-Q(x�vt�#�ж���Bˀ�)���v9~�������P��PҢ����:��}����t9�rm�Wy�f�?	.п�.��8?��a���*mU6n헕L�,؂�I
�n�>�@-t�:�����;�g%���H����ګ��AK��${�B�������^=?�z6�q����*\���=��Z�K��V��"4��ΐ$�W~h���&�m/��7r瑃�������G�����sao���#����mU'o���#��ׅ��!�k�p��ϔ��{��X�����m���Cn�g>�J�LY\-�צD���!0s�,z*���BB|!{��0	��x;���z9��L���if��a��dXRkc�Q�����zO���)S�m�Dy�K����\��Ֆ.��;�">@�Tb�m�g`M�r,��ӼI�}�D��>�kϟ�1���l�&]�`�Aj��������q�7檛�P���3*���8�U���|�ɧ]��H׀P@�s<>�Y�Q�1X��Ps�ωY~�b�@ܹ���^׸����X���CP2��6���g|K]��ܞ���w�.�Z��;D���8ȴ��v�A�s�b�}l� V��ɈcUT��������Z�Z�ǔ�g失F�J���=��'��٫GE&"@����4Q+�w�k��1�ܦĽ��UD;J`�|F�݆�UsƵQ�2�g:��9ߢ|�MI��\4���6� a��B�c��������b����w��:��Ӷs%a�6�6Q7�ޫ�}��K'��s��3�d��*��M�I� phuK�	�$p�4�Q���
j����T*MV��C�:'�֋t��U��k2t��I�_&o�`9N?�Z��� �R���zs�V�����°\M{���szz���SX�� �o6퍜���!T���8X��#~E#
̷I��	z7)���G!~��i�������Bv�NF/Z$R�J�����r�2���j1��ck�Zh�1+DYJ�J��Y��l�NF����s��XQP�<ݫ���+ǉ����2�4:��`���t�w�-嶖�!+�%Z��[[@{��p~�?�����Ԃ�+rPR�����MQ$�����3�����NKi��ᬡ-gBh��W_R0�K�F�'^�'�\�h���Ξ�l���ۯdt9
G�/�2gA��Օ3�Џ������*pY���]@xZ{���(�\�c�wz%�Z�<��'�:���ݬ��dޝ{��rl؟��~�|f&����|���&��A�	/���Th�fWT欤Z8� �����Z�b�[�G�� ���GN��S�EGH��)^}�Z���M3��Y�b�'�n��1Hae�tcw��\�R�����;�Ŝ�a�:ĝ�_�95�y{���Z�m����2�̼������kg�cg-Wy���m��\93�8	���ˬ���8/P����z���̾���X�R�b��������]DLs�}x4�T� �B�\�`�K���$��`S��uf�X�� �Ru�rd���ݳ�Sd��1]��\�?���>����s[xe��rJ+"����T�j~��e�n��9�}/󧟓踇�k�Q�d-�U����t����$Q�ܐ�	G�T�WX�}���	HϹ��f�Eނ����ijY�����SQ�f���%���VT�H�;�`r��_����r�(��̧쩩yL>��}WQ1�~\�H.��c�~�Jx���H!e�?�q��-��� ,aa�=��x g�6[��|* S�@��0�4��SԽ@�,ؓK�AY�`�#��n�����|fȎ�ϥ����$�����P'9�1���[�t;W���ٖ��׽dk ��@I�H���<���Σ�I(&����Ŀ�5N���p��רIm�ܘ��Z�����d�.fgh�s��M�פ0Q�Lu��VG�gI\u��a����s~�� �1R�Y�`�✜�8:���1y�#�;U��5@���vn�V�������cN9�
�$5�༒~�(K��u4%2��� V\��K��=}�%�|�r�"EeBo�d9<����Ϥ��������t J�^U�&�ܳ�4 Ȝ�e���UR>�ٴ��ąX��O�9��$l�*��$�_��"t(1�Ffӈ��[�4Q-#�δF�aZUT�+p/���t#�y���{<�$N��S"纇�i�    @�UxF����o��A��[��:P��Jgs�S*�A�j�׌�C[n�<x���E�Ӎ�x�����=)FbF=�l�������~��1?��*�+Y�d��7����S��o T�AKZ�HD?2����Z���0��.7dS��C]�(��k��L�߸\{o��0*�����<{T�Ϥ�)K�K��0\#4�Yo��h깝�:��!�ywd��N�dM�oE
h���:\N$��tfA$�.-��(�-��P�_]5\�F�
_�Z���ӯY!q��t�^W�8�����Aʏ�䳡���:Ԑ��[L!1��[��W/��I�M����$L5�.��^D�W�-<%�ײK�2��;.(�6����xξ�z+k���'��z��������l�1�_���W�e?�S�uc�
�G\�6�w���p����&�`�����6ra��_3����t��E7�J�+,���.�SZ�p�T0�	�z��!CN����I��9�.���gV!��Fa��~�ke�9��<@c]�j�n�6��ۄ9=�{�{2�g :-�̓7�j��8dҾ���rŽ�^��l[���s�}��Xw�r��K�q����<5��
�K�&���W��HȎ)��u"v6\� ������y�/9`%�ڢq����U���R������u��/}Њ>�0�^�^���7>p�ӧ���mA5��$���SRԵ�" ��έ��h|��baϧ��[�B�y?����H�Q��T������;	\ߖ���)<T��e�/�������������Þ���$J��z��]��0�G�f��M<(��zr�MdM�A�ܑ��5�l�H�1ܝ5E\	qhEM�IzUsy=�DI䢤5�����S���Ƕt�o�|�دں���H�������U�쉂���KMl��ca{��FE��-�%�J�b� 
)*h���%V��a8�pV�O2���k�)�[}��9}��;�� Ivu^���ƴ��!�.�/�KK��\U�����ӌM`�Ua�qbW��g�͖�{�Ѐ]Љ.�)�@@�RZ��!�q�;ŕGU� h�@"�ػq�g�5;n������>X����o��]�z�*�B�D9��x]��ez$.���k`!o@��m=G�+�X�SG�=��u�%��I0*PtJ�t0��JB���{�T�[Ы:�+������z\:��V7���A�;J�����wِC��9�P'o�-��85��)2������"b�.L�ڪ:��>ƫ�:}����@ƨ��T���ҋ�َ�e�;1�¶&`�O��^����Q^O���a�֙�x�H�͎�w�� ��)�`F��d�y�h��m��z$���4<�k��4+�{��c���B~��2m�0S�~%���0���?h@��B\ �K)�K~���zB�c�+So�w$��C�L&'��?!ɕ��h6�+�SU�����sVc�Wc����d�ʐ3�����l����>������&y��d��d�C� �*�Z�u F^�7�2���}�P�/;�|�%����<4���xr���3I<��T��5�Ċ�X�5X'4ln�Ӌ=V�l��f�Z����Yٴ�O����)��=<��#P��V�t�|�(lf�l��ekW�!���3�~Ӱ.H��H�J!��\P�%�]������v��m� "�h6��������*D��YQu�Xa;����/�Q�]/��O�ŗ7�qs��v����'��h��CS�p������*�xl��ڹE�ձ�T]��a�r�|`�[wID^�>�!����·J�Z���z>'��Hl�5�97�h��^��~c���]�C���e�:��y��N:
oB5t|`��i׈TV8��L�,o!Y�D�k�'[g|E{RfP������Sc���K3[���*Қ�I��\�+ƋL���wy��=1��Sv=V����Td�@��B��s"��S%��� Aq3.�4����l��%��T7ګ�M����]Y�:��*@�O��(��+�O�J�&�K��r�}��-SM�R5T��+FK>�QWv�t��D�%�׫ �ǴX\���ۥ�)�ZN��v[X,pg�|R���w��.K8e�C�s<�D������ΥYâl�{ɶ�ԯ����� ��^�?��nӣ�h��p�	9�&�`�X%���ݶ��t��/��!��1.g}&��D)��VH�X�]T|��!�T�Stl�!���~��2������`�_V��:.�e*��7D�����T^?��Z\�=��20�Œ�m�&���II�4&�� b'�*��|��T�cQ0�n��)cN\����;J�낚�.�����*�P����_�-�k�VS�h�)�.�2]x�y�Tq����m�}M�� nlJ�ɬ�ԡ_�$94K�[e�(��:,x����A��3������/�e
D���9��cnq�r�FS���t�Lg𞉔Μ�F�[�AM:��;�of���8�7�L��s�)ϱ~�թ�M׼�ӽ�Ll�'8����eP9���(��ÙKc�tF^�c�������#�T�������^�&�󛧹wm����fJ�W�v����6�t�'�<Y���@�y����5M�g�ɳ�D]�L�qr�e6����vAġ��R':qE�p�Ό�lH)�h�R����@+��*)9/�#o�K6�f��EIJ�����0��uO�	���`��s]\ۥ�F�C��]9��`\c��̇�6�!�:'�����柞��N��t�E�p ��o�TaS)��f�8�~Y��k��=bN{�.��6�ߚ+�v�u4�v5���7���s���,7B�f����S0+�=��T��n���&:���lHD��:�9�;���,��W��S%I�"Hn7�ޫ^79��^hQ�CB%GV����f"�M6�3����k�3C�;�D:�<��[la�Y���2K����n��GnOBUm+s�����(t�|���N�kv�c�J��,������K�k.�0%��'�V�lsr�S)nӡ�k1��&{��/�#��:Nmk4'�� \��
WD{d.};83�[�2�0؊J�R�>D��s���~n�$4�cUR�u2Z�\��&m�z_:b[�F��U��h*��Ju4��*h�(Nq)���Ω,U���p��+U��M�ٵ�T��&u�{���\d����Y�ltٖwxD}��p������"G��(��%x�I���߁��M�ZS�~��l�S�=�z�؇п\�$-��>l��wSYh�J�%eZnH���d�2Qh���j��_ �).~�q�-��^i��������⾣S?@z�L��%����T�ޔ_�ܯ�r?up��of1��:��U�P�>�4�;!a���й)k����y,K��.��̏^&߷ghBBg��p<�L��.p��4 ]9�`9wƏ9��"����� $M�	�� 9���� �V���Uf�5*�tIۓ^3�V��w��c��3��K ��/�:kE�t�r*���IVg�{����o����0��%F�\~���M�*�m�w�q}�1xY2̥��7�q��G9i��űD���><H�6�x����)���1����]�|�y+ͳ�eLF���M}�����|�Wl�:ȏ{��Vwͫ��Bni�:GU�+�N1�R��Vm�Hϭ,2��Χg���ύ�C�u�[CW�T8�Y��B���s��3��Υ�Ƶ�2EW�������]�m�3�p�DZ��Ýq�؅\:��x�����o�nkL�\���U?������[�J2щ�ՙ�+x����䍶��09���e{����Q�������%��l*tG�χ�vv'Z1I�'Jd�ld"���3��yׄ=���t;؝�GD-U)�@�1�#-��d��`�|�}�s4̙��H�++�/����u|um5l��E����i�����y��蛸�]�@q���ƃK�	�y�UB�K��gR�7�C6�7�0����8�ION_�
J�;ǂ]�ڿ�z�YL}Af�9��0G7��/b)�'OY��k�#4��7����M��r��c�/� 3  ��jSԺ+@�-f>�TFM�
�J�Tё�ԃ���"�L����̧�2>�f�A�:[�1 �ч��1�,��h65�k=z�ǘ� U|q���-S�:��D�ɖ:&a(��<�|ď��#A`��b��d�K_�m���	-X1���icb4�e2/�|�L���!�1�Voޘ=�o(9��7b����#�j�K�d�/2�p����s\�T�w���<�7��&�s~E ����,�m�u�T�>����Q�3"�9h��oՑuWv�y�"���Cch�]9J�~hi�tF_�`���bSU&0<ˋ��tޱ����c����-{Q4��b�L�t��|6e�Y/�k�x�^=��X�_p�#?r��C���.v�e�/wW��<�	w_8���9 �:���C��<�Ğ_��/#i��$]al֕�u������'���k��C���{������]?���>�q�}�΂2e�>/�}`~����a{��P��x�.1�������C��o�E�,g2��hst�_R~�%i�Cy�Ʋ5���O~��_�_�Q��      ,   I  x�u�Ks�0��s����O�	�U(�N/A�h�V?}��t:����v��`��T��q�vc��9Ns�j��QRk-�Y|G�̜,2Mt{N�(��e���0��=���8��\�w��e�[�0�����T�H���Ձ��jj�0lP����ɨ	�T г�j��iQ�j2]s���[F�e9W�m'b8:�$�=�Qڧv��	�Sqi��k�Q&�\�C�vRaR�ZSכ���ۤ1��y�c���̫�ʝyn�d��~�y0�&~��i��c�,�rc��WW���ac��Qx�'rO��?ߩ@iR�����V>��(�r�'     