--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Debian 17.2-1.pgdg120+1)
-- Dumped by pg_dump version 17.2 (Debian 17.2-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: type_plat; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.type_plat AS ENUM (
    'Entrée',
    'Plat',
    'Dessert',
    'Apéretif',
    'Accompagnement',
    'Ingredient'
);


ALTER TYPE public.type_plat OWNER TO "user";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: allergene; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.allergene (
    id integer NOT NULL,
    labelle character varying
);


ALTER TABLE public.allergene OWNER TO "user";

--
-- Name: allergene_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.allergene_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.allergene_id_seq OWNER TO "user";

--
-- Name: allergene_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.allergene_id_seq OWNED BY public.allergene.id;


--
-- Name: allergene_utilisateur; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.allergene_utilisateur (
    allergene_id integer NOT NULL,
    utilisateur_id uuid NOT NULL
);


ALTER TABLE public.allergene_utilisateur OWNER TO "user";

--
-- Name: allergene_utilisateur_allergene_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.allergene_utilisateur_allergene_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.allergene_utilisateur_allergene_id_seq OWNER TO "user";

--
-- Name: allergene_utilisateur_allergene_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.allergene_utilisateur_allergene_id_seq OWNED BY public.allergene_utilisateur.allergene_id;


--
-- Name: commentaire; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.commentaire (
    id integer NOT NULL,
    id_utilisateur uuid,
    id_recette integer,
    contenu text
);


ALTER TABLE public.commentaire OWNER TO "user";

--
-- Name: commentaire_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.commentaire_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.commentaire_id_seq OWNER TO "user";

--
-- Name: commentaire_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.commentaire_id_seq OWNED BY public.commentaire.id;


--
-- Name: favoris; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.favoris (
    id_utilisateur uuid NOT NULL,
    id_recette integer NOT NULL
);


ALTER TABLE public.favoris OWNER TO "user";

--
-- Name: frigo; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.frigo (
    id_utilisateur uuid NOT NULL,
    id_ingredient integer NOT NULL,
    date_ajout date NOT NULL,
    quantite character varying
);


ALTER TABLE public.frigo OWNER TO "user";

--
-- Name: ingredient; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.ingredient (
    id integer NOT NULL,
    nom character varying,
    debut_saison date,
    fin_saison date,
    url_photo character varying
);


ALTER TABLE public.ingredient OWNER TO "user";

--
-- Name: ingredient_allergene; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.ingredient_allergene (
    ingredient_id integer NOT NULL,
    allergene_id integer NOT NULL
);


ALTER TABLE public.ingredient_allergene OWNER TO "user";

--
-- Name: ingredient_allergene_allergene_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.ingredient_allergene_allergene_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ingredient_allergene_allergene_id_seq OWNER TO "user";

--
-- Name: ingredient_allergene_allergene_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.ingredient_allergene_allergene_id_seq OWNED BY public.ingredient_allergene.allergene_id;


--
-- Name: ingredient_allergene_ingredient_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.ingredient_allergene_ingredient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ingredient_allergene_ingredient_id_seq OWNER TO "user";

--
-- Name: ingredient_allergene_ingredient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.ingredient_allergene_ingredient_id_seq OWNED BY public.ingredient_allergene.ingredient_id;


--
-- Name: ingredient_exclu; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.ingredient_exclu (
    id_ingredient integer NOT NULL,
    id_utilisateur uuid NOT NULL
);


ALTER TABLE public.ingredient_exclu OWNER TO "user";

--
-- Name: ingredient_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.ingredient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ingredient_id_seq OWNER TO "user";

--
-- Name: ingredient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.ingredient_id_seq OWNED BY public.ingredient.id;


--
-- Name: ingredient_panier; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.ingredient_panier (
    id_panier integer NOT NULL,
    id_ingredient integer NOT NULL,
    quantite character varying
);


ALTER TABLE public.ingredient_panier OWNER TO "user";

--
-- Name: ingredient_produit; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.ingredient_produit (
    id_producteur uuid NOT NULL,
    id_ingredient integer NOT NULL
);


ALTER TABLE public.ingredient_produit OWNER TO "user";

--
-- Name: ingredient_recette; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.ingredient_recette (
    id_recette integer NOT NULL,
    id_ingredient integer NOT NULL,
    quantite character varying
);


ALTER TABLE public.ingredient_recette OWNER TO "user";

--
-- Name: note_recette; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.note_recette (
    id_utilisateur uuid NOT NULL,
    id_recette integer NOT NULL,
    note integer
);


ALTER TABLE public.note_recette OWNER TO "user";

--
-- Name: panier; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.panier (
    id integer NOT NULL,
    id_producteur uuid,
    date date
);


ALTER TABLE public.panier OWNER TO "user";

--
-- Name: panier_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.panier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.panier_id_seq OWNER TO "user";

--
-- Name: panier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.panier_id_seq OWNED BY public.panier.id;


--
-- Name: panier_utilisateur; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.panier_utilisateur (
    panier_id integer NOT NULL,
    utilisateur_id uuid NOT NULL
);


ALTER TABLE public.panier_utilisateur OWNER TO "user";

--
-- Name: panier_utilisateur_panier_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.panier_utilisateur_panier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.panier_utilisateur_panier_id_seq OWNER TO "user";

--
-- Name: panier_utilisateur_panier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.panier_utilisateur_panier_id_seq OWNED BY public.panier_utilisateur.panier_id;


--
-- Name: producteur_utilisateur; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.producteur_utilisateur (
    id_producteur uuid NOT NULL,
    id_utilisateur uuid NOT NULL
);


ALTER TABLE public.producteur_utilisateur OWNER TO "user";

--
-- Name: recette; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.recette (
    id integer NOT NULL,
    nom character varying,
    temps_preparation integer,
    complexite integer,
    id_createur uuid,
    description text,
    id_recette_parente integer,
    type public.type_plat,
    url_photo character varying
);


ALTER TABLE public.recette OWNER TO "user";

--
-- Name: recette_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.recette_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recette_id_seq OWNER TO "user";

--
-- Name: recette_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.recette_id_seq OWNED BY public.recette.id;


--
-- Name: recette_ustensile; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.recette_ustensile (
    recette_id integer NOT NULL,
    ustensile_id integer NOT NULL
);


ALTER TABLE public.recette_ustensile OWNER TO "user";

--
-- Name: recette_ustensile_recette_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.recette_ustensile_recette_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recette_ustensile_recette_id_seq OWNER TO "user";

--
-- Name: recette_ustensile_recette_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.recette_ustensile_recette_id_seq OWNED BY public.recette_ustensile.recette_id;


--
-- Name: recette_ustensile_ustensile_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.recette_ustensile_ustensile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recette_ustensile_ustensile_id_seq OWNER TO "user";

--
-- Name: recette_ustensile_ustensile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.recette_ustensile_ustensile_id_seq OWNED BY public.recette_ustensile.ustensile_id;


--
-- Name: tag; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.tag (
    id integer NOT NULL,
    labelle character varying
);


ALTER TABLE public.tag OWNER TO "user";

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tag_id_seq OWNER TO "user";

--
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;


--
-- Name: tag_recette; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.tag_recette (
    tag_id integer NOT NULL,
    recette_id integer NOT NULL
);


ALTER TABLE public.tag_recette OWNER TO "user";

--
-- Name: tag_recette_recette_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.tag_recette_recette_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tag_recette_recette_id_seq OWNER TO "user";

--
-- Name: tag_recette_recette_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.tag_recette_recette_id_seq OWNED BY public.tag_recette.recette_id;


--
-- Name: tag_recette_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.tag_recette_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tag_recette_tag_id_seq OWNER TO "user";

--
-- Name: tag_recette_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.tag_recette_tag_id_seq OWNED BY public.tag_recette.tag_id;


--
-- Name: ustensile; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.ustensile (
    id integer NOT NULL,
    nom character varying
);


ALTER TABLE public.ustensile OWNER TO "user";

--
-- Name: ustensile_exclu; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.ustensile_exclu (
    id_ustensile integer NOT NULL,
    id_utilisateur uuid NOT NULL
);


ALTER TABLE public.ustensile_exclu OWNER TO "user";

--
-- Name: ustensile_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.ustensile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ustensile_id_seq OWNER TO "user";

--
-- Name: ustensile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.ustensile_id_seq OWNED BY public.ustensile.id;


--
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.utilisateur (
    id uuid NOT NULL,
    nom_utilisateur character varying,
    role character varying,
    mot_de_passe character varying
);


ALTER TABLE public.utilisateur OWNER TO "user";

--
-- Name: allergene id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.allergene ALTER COLUMN id SET DEFAULT nextval('public.allergene_id_seq'::regclass);


--
-- Name: allergene_utilisateur allergene_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.allergene_utilisateur ALTER COLUMN allergene_id SET DEFAULT nextval('public.allergene_utilisateur_allergene_id_seq'::regclass);


--
-- Name: commentaire id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.commentaire ALTER COLUMN id SET DEFAULT nextval('public.commentaire_id_seq'::regclass);


--
-- Name: ingredient id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient ALTER COLUMN id SET DEFAULT nextval('public.ingredient_id_seq'::regclass);


--
-- Name: ingredient_allergene ingredient_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_allergene ALTER COLUMN ingredient_id SET DEFAULT nextval('public.ingredient_allergene_ingredient_id_seq'::regclass);


--
-- Name: ingredient_allergene allergene_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_allergene ALTER COLUMN allergene_id SET DEFAULT nextval('public.ingredient_allergene_allergene_id_seq'::regclass);


--
-- Name: panier id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.panier ALTER COLUMN id SET DEFAULT nextval('public.panier_id_seq'::regclass);


--
-- Name: panier_utilisateur panier_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.panier_utilisateur ALTER COLUMN panier_id SET DEFAULT nextval('public.panier_utilisateur_panier_id_seq'::regclass);


--
-- Name: recette id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.recette ALTER COLUMN id SET DEFAULT nextval('public.recette_id_seq'::regclass);


--
-- Name: recette_ustensile recette_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.recette_ustensile ALTER COLUMN recette_id SET DEFAULT nextval('public.recette_ustensile_recette_id_seq'::regclass);


--
-- Name: recette_ustensile ustensile_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.recette_ustensile ALTER COLUMN ustensile_id SET DEFAULT nextval('public.recette_ustensile_ustensile_id_seq'::regclass);


--
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- Name: tag_recette tag_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.tag_recette ALTER COLUMN tag_id SET DEFAULT nextval('public.tag_recette_tag_id_seq'::regclass);


--
-- Name: tag_recette recette_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.tag_recette ALTER COLUMN recette_id SET DEFAULT nextval('public.tag_recette_recette_id_seq'::regclass);


--
-- Name: ustensile id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ustensile ALTER COLUMN id SET DEFAULT nextval('public.ustensile_id_seq'::regclass);


--
-- Data for Name: allergene; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.allergene (id, labelle) FROM stdin;
\.


--
-- Data for Name: allergene_utilisateur; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.allergene_utilisateur (allergene_id, utilisateur_id) FROM stdin;
\.


--
-- Data for Name: commentaire; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.commentaire (id, id_utilisateur, id_recette, contenu) FROM stdin;
\.


--
-- Data for Name: favoris; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.favoris (id_utilisateur, id_recette) FROM stdin;
\.


--
-- Data for Name: frigo; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.frigo (id_utilisateur, id_ingredient, date_ajout, quantite) FROM stdin;
\.


--
-- Data for Name: ingredient; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.ingredient (id, nom, debut_saison, fin_saison, url_photo) FROM stdin;
\.


--
-- Data for Name: ingredient_allergene; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.ingredient_allergene (ingredient_id, allergene_id) FROM stdin;
\.


--
-- Data for Name: ingredient_exclu; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.ingredient_exclu (id_ingredient, id_utilisateur) FROM stdin;
\.


--
-- Data for Name: ingredient_panier; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.ingredient_panier (id_panier, id_ingredient, quantite) FROM stdin;
\.


--
-- Data for Name: ingredient_produit; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.ingredient_produit (id_producteur, id_ingredient) FROM stdin;
\.


--
-- Data for Name: ingredient_recette; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.ingredient_recette (id_recette, id_ingredient, quantite) FROM stdin;
\.


--
-- Data for Name: note_recette; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.note_recette (id_utilisateur, id_recette, note) FROM stdin;
\.


--
-- Data for Name: panier; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.panier (id, id_producteur, date) FROM stdin;
\.


--
-- Data for Name: panier_utilisateur; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.panier_utilisateur (panier_id, utilisateur_id) FROM stdin;
\.


--
-- Data for Name: producteur_utilisateur; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.producteur_utilisateur (id_producteur, id_utilisateur) FROM stdin;
\.


--
-- Data for Name: recette; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.recette (id, nom, temps_preparation, complexite, id_createur, description, id_recette_parente, type, url_photo) FROM stdin;
\.


--
-- Data for Name: recette_ustensile; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.recette_ustensile (recette_id, ustensile_id) FROM stdin;
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.tag (id, labelle) FROM stdin;
\.


--
-- Data for Name: tag_recette; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.tag_recette (tag_id, recette_id) FROM stdin;
\.


--
-- Data for Name: ustensile; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.ustensile (id, nom) FROM stdin;
\.


--
-- Data for Name: ustensile_exclu; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.ustensile_exclu (id_ustensile, id_utilisateur) FROM stdin;
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.utilisateur (id, nom_utilisateur, role, mot_de_passe) FROM stdin;
\.


--
-- Name: allergene_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.allergene_id_seq', 1, false);


--
-- Name: allergene_utilisateur_allergene_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.allergene_utilisateur_allergene_id_seq', 1, false);


--
-- Name: commentaire_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.commentaire_id_seq', 1, false);


--
-- Name: ingredient_allergene_allergene_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.ingredient_allergene_allergene_id_seq', 1, false);


--
-- Name: ingredient_allergene_ingredient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.ingredient_allergene_ingredient_id_seq', 1, false);


--
-- Name: ingredient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.ingredient_id_seq', 1, false);


--
-- Name: panier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.panier_id_seq', 1, false);


--
-- Name: panier_utilisateur_panier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.panier_utilisateur_panier_id_seq', 1, false);


--
-- Name: recette_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.recette_id_seq', 1, false);


--
-- Name: recette_ustensile_recette_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.recette_ustensile_recette_id_seq', 1, false);


--
-- Name: recette_ustensile_ustensile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.recette_ustensile_ustensile_id_seq', 1, false);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.tag_id_seq', 1, false);


--
-- Name: tag_recette_recette_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.tag_recette_recette_id_seq', 1, false);


--
-- Name: tag_recette_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.tag_recette_tag_id_seq', 1, false);


--
-- Name: ustensile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.ustensile_id_seq', 1, false);


--
-- Name: allergene allergene_labelle_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.allergene
    ADD CONSTRAINT allergene_labelle_key UNIQUE (labelle);


--
-- Name: allergene allergene_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.allergene
    ADD CONSTRAINT allergene_pkey PRIMARY KEY (id);


--
-- Name: allergene_utilisateur allergene_utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.allergene_utilisateur
    ADD CONSTRAINT allergene_utilisateur_pkey PRIMARY KEY (allergene_id, utilisateur_id);


--
-- Name: commentaire commentaire_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.commentaire
    ADD CONSTRAINT commentaire_pkey PRIMARY KEY (id);


--
-- Name: favoris favoris_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.favoris
    ADD CONSTRAINT favoris_pkey PRIMARY KEY (id_utilisateur, id_recette);


--
-- Name: frigo frigo_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.frigo
    ADD CONSTRAINT frigo_pkey PRIMARY KEY (id_utilisateur, id_ingredient, date_ajout);


--
-- Name: ingredient_allergene ingredient_allergene_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_allergene
    ADD CONSTRAINT ingredient_allergene_pkey PRIMARY KEY (ingredient_id, allergene_id);


--
-- Name: ingredient_exclu ingredient_exclu_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_exclu
    ADD CONSTRAINT ingredient_exclu_pkey PRIMARY KEY (id_ingredient, id_utilisateur);


--
-- Name: ingredient ingredient_nom_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient
    ADD CONSTRAINT ingredient_nom_key UNIQUE (nom);


--
-- Name: ingredient_panier ingredient_panier_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_panier
    ADD CONSTRAINT ingredient_panier_pkey PRIMARY KEY (id_panier, id_ingredient);


--
-- Name: ingredient ingredient_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient
    ADD CONSTRAINT ingredient_pkey PRIMARY KEY (id);


--
-- Name: ingredient_produit ingredient_produit_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_produit
    ADD CONSTRAINT ingredient_produit_pkey PRIMARY KEY (id_producteur, id_ingredient);


--
-- Name: ingredient_recette ingredient_recette_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_recette
    ADD CONSTRAINT ingredient_recette_pkey PRIMARY KEY (id_recette, id_ingredient);


--
-- Name: note_recette note_recette_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.note_recette
    ADD CONSTRAINT note_recette_pkey PRIMARY KEY (id_utilisateur, id_recette);


--
-- Name: panier panier_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.panier
    ADD CONSTRAINT panier_pkey PRIMARY KEY (id);


--
-- Name: panier_utilisateur panier_utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.panier_utilisateur
    ADD CONSTRAINT panier_utilisateur_pkey PRIMARY KEY (panier_id, utilisateur_id);


--
-- Name: producteur_utilisateur producteur_utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.producteur_utilisateur
    ADD CONSTRAINT producteur_utilisateur_pkey PRIMARY KEY (id_producteur, id_utilisateur);


--
-- Name: recette recette_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.recette
    ADD CONSTRAINT recette_pkey PRIMARY KEY (id);


--
-- Name: recette_ustensile recette_ustensile_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.recette_ustensile
    ADD CONSTRAINT recette_ustensile_pkey PRIMARY KEY (recette_id, ustensile_id);


--
-- Name: tag tag_labelle_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_labelle_key UNIQUE (labelle);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: tag_recette tag_recette_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.tag_recette
    ADD CONSTRAINT tag_recette_pkey PRIMARY KEY (tag_id, recette_id);


--
-- Name: ustensile_exclu ustensile_exclu_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ustensile_exclu
    ADD CONSTRAINT ustensile_exclu_pkey PRIMARY KEY (id_ustensile, id_utilisateur);


--
-- Name: ustensile ustensile_nom_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ustensile
    ADD CONSTRAINT ustensile_nom_key UNIQUE (nom);


--
-- Name: ustensile ustensile_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ustensile
    ADD CONSTRAINT ustensile_pkey PRIMARY KEY (id);


--
-- Name: utilisateur utilisateur_nom_utilisateur_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_nom_utilisateur_key UNIQUE (nom_utilisateur);


--
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id);


--
-- Name: allergene_utilisateur allergene_utilisateur_allergene_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.allergene_utilisateur
    ADD CONSTRAINT allergene_utilisateur_allergene_id_fkey FOREIGN KEY (allergene_id) REFERENCES public.allergene(id);


--
-- Name: allergene_utilisateur allergene_utilisateur_allergene_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.allergene_utilisateur
    ADD CONSTRAINT allergene_utilisateur_allergene_id_fkey1 FOREIGN KEY (allergene_id) REFERENCES public.allergene(id);


--
-- Name: allergene_utilisateur allergene_utilisateur_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.allergene_utilisateur
    ADD CONSTRAINT allergene_utilisateur_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateur(id);


--
-- Name: allergene_utilisateur allergene_utilisateur_utilisateur_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.allergene_utilisateur
    ADD CONSTRAINT allergene_utilisateur_utilisateur_id_fkey1 FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateur(id);


--
-- Name: commentaire commentaire_id_recette_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.commentaire
    ADD CONSTRAINT commentaire_id_recette_fkey FOREIGN KEY (id_recette) REFERENCES public.recette(id);


--
-- Name: commentaire commentaire_id_recette_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.commentaire
    ADD CONSTRAINT commentaire_id_recette_fkey1 FOREIGN KEY (id_recette) REFERENCES public.recette(id);


--
-- Name: commentaire commentaire_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.commentaire
    ADD CONSTRAINT commentaire_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id);


--
-- Name: commentaire commentaire_id_utilisateur_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.commentaire
    ADD CONSTRAINT commentaire_id_utilisateur_fkey1 FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id);


--
-- Name: favoris favoris_id_recette_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.favoris
    ADD CONSTRAINT favoris_id_recette_fkey FOREIGN KEY (id_recette) REFERENCES public.recette(id);


--
-- Name: favoris favoris_id_recette_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.favoris
    ADD CONSTRAINT favoris_id_recette_fkey1 FOREIGN KEY (id_recette) REFERENCES public.recette(id);


--
-- Name: favoris favoris_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.favoris
    ADD CONSTRAINT favoris_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id);


--
-- Name: favoris favoris_id_utilisateur_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.favoris
    ADD CONSTRAINT favoris_id_utilisateur_fkey1 FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id);


--
-- Name: frigo frigo_id_ingredient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.frigo
    ADD CONSTRAINT frigo_id_ingredient_fkey FOREIGN KEY (id_ingredient) REFERENCES public.ingredient(id);


--
-- Name: frigo frigo_id_ingredient_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.frigo
    ADD CONSTRAINT frigo_id_ingredient_fkey1 FOREIGN KEY (id_ingredient) REFERENCES public.ingredient(id);


--
-- Name: frigo frigo_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.frigo
    ADD CONSTRAINT frigo_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id);


--
-- Name: frigo frigo_id_utilisateur_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.frigo
    ADD CONSTRAINT frigo_id_utilisateur_fkey1 FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id);


--
-- Name: ingredient_allergene ingredient_allergene_allergene_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_allergene
    ADD CONSTRAINT ingredient_allergene_allergene_id_fkey FOREIGN KEY (allergene_id) REFERENCES public.allergene(id);


--
-- Name: ingredient_allergene ingredient_allergene_allergene_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_allergene
    ADD CONSTRAINT ingredient_allergene_allergene_id_fkey1 FOREIGN KEY (allergene_id) REFERENCES public.allergene(id);


--
-- Name: ingredient_allergene ingredient_allergene_ingredient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_allergene
    ADD CONSTRAINT ingredient_allergene_ingredient_id_fkey FOREIGN KEY (ingredient_id) REFERENCES public.ingredient(id);


--
-- Name: ingredient_allergene ingredient_allergene_ingredient_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_allergene
    ADD CONSTRAINT ingredient_allergene_ingredient_id_fkey1 FOREIGN KEY (ingredient_id) REFERENCES public.ingredient(id);


--
-- Name: ingredient_exclu ingredient_exclu_id_ingredient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_exclu
    ADD CONSTRAINT ingredient_exclu_id_ingredient_fkey FOREIGN KEY (id_ingredient) REFERENCES public.ingredient(id);


--
-- Name: ingredient_exclu ingredient_exclu_id_ingredient_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_exclu
    ADD CONSTRAINT ingredient_exclu_id_ingredient_fkey1 FOREIGN KEY (id_ingredient) REFERENCES public.ingredient(id);


--
-- Name: ingredient_exclu ingredient_exclu_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_exclu
    ADD CONSTRAINT ingredient_exclu_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id);


--
-- Name: ingredient_exclu ingredient_exclu_id_utilisateur_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_exclu
    ADD CONSTRAINT ingredient_exclu_id_utilisateur_fkey1 FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id);


--
-- Name: ingredient_panier ingredient_panier_id_ingredient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_panier
    ADD CONSTRAINT ingredient_panier_id_ingredient_fkey FOREIGN KEY (id_ingredient) REFERENCES public.ingredient(id);


--
-- Name: ingredient_panier ingredient_panier_id_ingredient_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_panier
    ADD CONSTRAINT ingredient_panier_id_ingredient_fkey1 FOREIGN KEY (id_ingredient) REFERENCES public.ingredient(id);


--
-- Name: ingredient_panier ingredient_panier_id_panier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_panier
    ADD CONSTRAINT ingredient_panier_id_panier_fkey FOREIGN KEY (id_panier) REFERENCES public.panier(id);


--
-- Name: ingredient_panier ingredient_panier_id_panier_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_panier
    ADD CONSTRAINT ingredient_panier_id_panier_fkey1 FOREIGN KEY (id_panier) REFERENCES public.panier(id);


--
-- Name: ingredient_produit ingredient_produit_id_ingredient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_produit
    ADD CONSTRAINT ingredient_produit_id_ingredient_fkey FOREIGN KEY (id_ingredient) REFERENCES public.ingredient(id);


--
-- Name: ingredient_produit ingredient_produit_id_ingredient_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_produit
    ADD CONSTRAINT ingredient_produit_id_ingredient_fkey1 FOREIGN KEY (id_ingredient) REFERENCES public.ingredient(id);


--
-- Name: ingredient_produit ingredient_produit_id_producteur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_produit
    ADD CONSTRAINT ingredient_produit_id_producteur_fkey FOREIGN KEY (id_producteur) REFERENCES public.utilisateur(id);


--
-- Name: ingredient_produit ingredient_produit_id_producteur_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_produit
    ADD CONSTRAINT ingredient_produit_id_producteur_fkey1 FOREIGN KEY (id_producteur) REFERENCES public.utilisateur(id);


--
-- Name: ingredient_recette ingredient_recette_id_ingredient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_recette
    ADD CONSTRAINT ingredient_recette_id_ingredient_fkey FOREIGN KEY (id_ingredient) REFERENCES public.ingredient(id);


--
-- Name: ingredient_recette ingredient_recette_id_ingredient_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_recette
    ADD CONSTRAINT ingredient_recette_id_ingredient_fkey1 FOREIGN KEY (id_ingredient) REFERENCES public.ingredient(id);


--
-- Name: ingredient_recette ingredient_recette_id_recette_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_recette
    ADD CONSTRAINT ingredient_recette_id_recette_fkey FOREIGN KEY (id_recette) REFERENCES public.recette(id);


--
-- Name: ingredient_recette ingredient_recette_id_recette_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredient_recette
    ADD CONSTRAINT ingredient_recette_id_recette_fkey1 FOREIGN KEY (id_recette) REFERENCES public.recette(id);


--
-- Name: note_recette note_recette_id_recette_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.note_recette
    ADD CONSTRAINT note_recette_id_recette_fkey FOREIGN KEY (id_recette) REFERENCES public.recette(id);


--
-- Name: note_recette note_recette_id_recette_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.note_recette
    ADD CONSTRAINT note_recette_id_recette_fkey1 FOREIGN KEY (id_recette) REFERENCES public.recette(id);


--
-- Name: note_recette note_recette_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.note_recette
    ADD CONSTRAINT note_recette_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id);


--
-- Name: note_recette note_recette_id_utilisateur_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.note_recette
    ADD CONSTRAINT note_recette_id_utilisateur_fkey1 FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id);


--
-- Name: panier panier_id_producteur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.panier
    ADD CONSTRAINT panier_id_producteur_fkey FOREIGN KEY (id_producteur) REFERENCES public.utilisateur(id);


--
-- Name: panier panier_id_producteur_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.panier
    ADD CONSTRAINT panier_id_producteur_fkey1 FOREIGN KEY (id_producteur) REFERENCES public.utilisateur(id);


--
-- Name: panier_utilisateur panier_utilisateur_panier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.panier_utilisateur
    ADD CONSTRAINT panier_utilisateur_panier_id_fkey FOREIGN KEY (panier_id) REFERENCES public.panier(id);


--
-- Name: panier_utilisateur panier_utilisateur_panier_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.panier_utilisateur
    ADD CONSTRAINT panier_utilisateur_panier_id_fkey1 FOREIGN KEY (panier_id) REFERENCES public.panier(id);


--
-- Name: panier_utilisateur panier_utilisateur_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.panier_utilisateur
    ADD CONSTRAINT panier_utilisateur_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateur(id);


--
-- Name: panier_utilisateur panier_utilisateur_utilisateur_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.panier_utilisateur
    ADD CONSTRAINT panier_utilisateur_utilisateur_id_fkey1 FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateur(id);


--
-- Name: producteur_utilisateur producteur_utilisateur_id_producteur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.producteur_utilisateur
    ADD CONSTRAINT producteur_utilisateur_id_producteur_fkey FOREIGN KEY (id_producteur) REFERENCES public.utilisateur(id);


--
-- Name: producteur_utilisateur producteur_utilisateur_id_producteur_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.producteur_utilisateur
    ADD CONSTRAINT producteur_utilisateur_id_producteur_fkey1 FOREIGN KEY (id_producteur) REFERENCES public.utilisateur(id);


--
-- Name: producteur_utilisateur producteur_utilisateur_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.producteur_utilisateur
    ADD CONSTRAINT producteur_utilisateur_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id);


--
-- Name: producteur_utilisateur producteur_utilisateur_id_utilisateur_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.producteur_utilisateur
    ADD CONSTRAINT producteur_utilisateur_id_utilisateur_fkey1 FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id);


--
-- Name: recette recette_id_createur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.recette
    ADD CONSTRAINT recette_id_createur_fkey FOREIGN KEY (id_createur) REFERENCES public.utilisateur(id);


--
-- Name: recette recette_id_createur_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.recette
    ADD CONSTRAINT recette_id_createur_fkey1 FOREIGN KEY (id_createur) REFERENCES public.utilisateur(id);


--
-- Name: recette recette_id_recette_parente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.recette
    ADD CONSTRAINT recette_id_recette_parente_fkey FOREIGN KEY (id_recette_parente) REFERENCES public.recette(id);


--
-- Name: recette recette_id_recette_parente_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.recette
    ADD CONSTRAINT recette_id_recette_parente_fkey1 FOREIGN KEY (id_recette_parente) REFERENCES public.recette(id);


--
-- Name: recette_ustensile recette_ustensile_recette_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.recette_ustensile
    ADD CONSTRAINT recette_ustensile_recette_id_fkey FOREIGN KEY (recette_id) REFERENCES public.recette(id);


--
-- Name: recette_ustensile recette_ustensile_recette_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.recette_ustensile
    ADD CONSTRAINT recette_ustensile_recette_id_fkey1 FOREIGN KEY (recette_id) REFERENCES public.recette(id);


--
-- Name: recette_ustensile recette_ustensile_ustensile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.recette_ustensile
    ADD CONSTRAINT recette_ustensile_ustensile_id_fkey FOREIGN KEY (ustensile_id) REFERENCES public.ustensile(id);


--
-- Name: recette_ustensile recette_ustensile_ustensile_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.recette_ustensile
    ADD CONSTRAINT recette_ustensile_ustensile_id_fkey1 FOREIGN KEY (ustensile_id) REFERENCES public.ustensile(id);


--
-- Name: tag_recette tag_recette_recette_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.tag_recette
    ADD CONSTRAINT tag_recette_recette_id_fkey FOREIGN KEY (recette_id) REFERENCES public.recette(id);


--
-- Name: tag_recette tag_recette_recette_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.tag_recette
    ADD CONSTRAINT tag_recette_recette_id_fkey1 FOREIGN KEY (recette_id) REFERENCES public.recette(id);


--
-- Name: tag_recette tag_recette_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.tag_recette
    ADD CONSTRAINT tag_recette_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tag(id);


--
-- Name: tag_recette tag_recette_tag_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.tag_recette
    ADD CONSTRAINT tag_recette_tag_id_fkey1 FOREIGN KEY (tag_id) REFERENCES public.tag(id);


--
-- Name: ustensile_exclu ustensile_exclu_id_ustensile_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ustensile_exclu
    ADD CONSTRAINT ustensile_exclu_id_ustensile_fkey FOREIGN KEY (id_ustensile) REFERENCES public.ustensile(id);


--
-- Name: ustensile_exclu ustensile_exclu_id_ustensile_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ustensile_exclu
    ADD CONSTRAINT ustensile_exclu_id_ustensile_fkey1 FOREIGN KEY (id_ustensile) REFERENCES public.ustensile(id);


--
-- Name: ustensile_exclu ustensile_exclu_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ustensile_exclu
    ADD CONSTRAINT ustensile_exclu_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id);


--
-- Name: ustensile_exclu ustensile_exclu_id_utilisateur_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ustensile_exclu
    ADD CONSTRAINT ustensile_exclu_id_utilisateur_fkey1 FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id);


--
-- PostgreSQL database dump complete
--

