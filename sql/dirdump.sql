--
-- PostgreSQL database dump
--

-- Dumped from database version 13.8 (Debian 13.8-1.pgdg110+1)
-- Dumped by pg_dump version 13.8 (Debian 13.8-1.pgdg110+1)

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
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: directus
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO directus;

--
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: directus
--

CREATE SCHEMA tiger_data;


ALTER SCHEMA tiger_data OWNER TO directus;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: directus
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO directus;

--
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: directus
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: directus_access; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_access (
    id uuid NOT NULL,
    role uuid,
    "user" uuid,
    policy uuid NOT NULL,
    sort integer
);


ALTER TABLE public.directus_access OWNER TO directus;

--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50),
    user_agent text,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    origin character varying(255)
);


ALTER TABLE public.directus_activity OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_activity_id_seq OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(64),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255),
    item_duplication_fields json,
    sort integer,
    "group" character varying(64),
    collapse character varying(255) DEFAULT 'open'::character varying NOT NULL,
    preview_url character varying(255),
    versioning boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_collections OWNER TO directus;

--
-- Name: directus_comments; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_comments (
    id uuid NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid
);


ALTER TABLE public.directus_comments OWNER TO directus;

--
-- Name: directus_dashboards; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_dashboards (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64) DEFAULT 'dashboard'::character varying NOT NULL,
    note text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    color character varying(255)
);


ALTER TABLE public.directus_dashboards OWNER TO directus;

--
-- Name: directus_extensions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_extensions (
    enabled boolean DEFAULT true NOT NULL,
    id uuid NOT NULL,
    folder character varying(255) NOT NULL,
    source character varying(255) NOT NULL,
    bundle uuid
);


ALTER TABLE public.directus_extensions OWNER TO directus;

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    translations json,
    note text,
    conditions json,
    required boolean DEFAULT false,
    "group" character varying(64),
    validation json,
    validation_message text
);


ALTER TABLE public.directus_fields OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_fields_id_seq OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize bigint,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json,
    focal_point_x integer,
    focal_point_y integer,
    tus_id character varying(64),
    tus_data json,
    uploaded_on timestamp with time zone
);


ALTER TABLE public.directus_files OWNER TO directus;

--
-- Name: directus_flows; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_flows (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64),
    color character varying(255),
    description text,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    trigger character varying(255),
    accountability character varying(255) DEFAULT 'all'::character varying,
    options json,
    operation uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_flows OWNER TO directus;

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO directus;

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO directus;

--
-- Name: directus_notifications; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_notifications (
    id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(255) DEFAULT 'inbox'::character varying,
    recipient uuid NOT NULL,
    sender uuid,
    subject character varying(255) NOT NULL,
    message text,
    collection character varying(64),
    item character varying(255)
);


ALTER TABLE public.directus_notifications OWNER TO directus;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_notifications_id_seq OWNER TO directus;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_notifications_id_seq OWNED BY public.directus_notifications.id;


--
-- Name: directus_operations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_operations (
    id uuid NOT NULL,
    name character varying(255),
    key character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    options json,
    resolve uuid,
    reject uuid,
    flow uuid NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_operations OWNER TO directus;

--
-- Name: directus_panels; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_panels (
    id uuid NOT NULL,
    dashboard uuid NOT NULL,
    name character varying(255),
    icon character varying(64) DEFAULT NULL::character varying,
    color character varying(10),
    show_header boolean DEFAULT false NOT NULL,
    note text,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    options json,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_panels OWNER TO directus;

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text,
    policy uuid NOT NULL
);


ALTER TABLE public.directus_permissions OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_permissions_id_seq OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_policies; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_policies (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'badge'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_policies OWNER TO directus;

--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer,
    filter json,
    icon character varying(64) DEFAULT 'bookmark'::character varying,
    color character varying(255)
);


ALTER TABLE public.directus_presets OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_presets_id_seq OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(64),
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE public.directus_relations OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_relations_id_seq OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer,
    version uuid
);


ALTER TABLE public.directus_revisions OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_revisions_id_seq OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    parent uuid
);


ALTER TABLE public.directus_roles OWNER TO directus;

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent text,
    share uuid,
    origin character varying(255),
    next_token character varying(64)
);


ALTER TABLE public.directus_sessions OWNER TO directus;

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(255) DEFAULT '#6644FF'::character varying NOT NULL,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text,
    storage_default_folder uuid,
    basemaps json,
    mapbox_key character varying(255),
    module_bar json,
    project_descriptor character varying(100),
    default_language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_aspect_ratios json,
    public_favicon uuid,
    default_appearance character varying(255) DEFAULT 'auto'::character varying NOT NULL,
    default_theme_light character varying(255),
    theme_light_overrides json,
    default_theme_dark character varying(255),
    theme_dark_overrides json,
    report_error_url character varying(255),
    report_bug_url character varying(255),
    report_feature_url character varying(255),
    public_registration boolean DEFAULT false NOT NULL,
    public_registration_verify_email boolean DEFAULT true NOT NULL,
    public_registration_role uuid,
    public_registration_email_filter json
);


ALTER TABLE public.directus_settings OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_settings_id_seq OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_shares; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_shares (
    id uuid NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    role uuid,
    password character varying(255),
    user_created uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    times_used integer DEFAULT 0,
    max_uses integer
);


ALTER TABLE public.directus_shares OWNER TO directus;

--
-- Name: directus_translations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_translations (
    id uuid NOT NULL,
    language character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.directus_translations OWNER TO directus;

--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128),
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(255) DEFAULT NULL::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255),
    provider character varying(128) DEFAULT 'default'::character varying NOT NULL,
    external_identifier character varying(255),
    auth_data json,
    email_notifications boolean DEFAULT true,
    appearance character varying(255),
    theme_dark character varying(255),
    theme_light character varying(255),
    theme_light_overrides json,
    theme_dark_overrides json
);


ALTER TABLE public.directus_users OWNER TO directus;

--
-- Name: directus_versions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_versions (
    id uuid NOT NULL,
    key character varying(64) NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    hash character varying(255),
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid,
    delta json
);


ALTER TABLE public.directus_versions OWNER TO directus;

--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url character varying(255) NOT NULL,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections character varying(255) NOT NULL,
    headers json,
    was_active_before_deprecation boolean DEFAULT false NOT NULL,
    migrated_flow uuid
);


ALTER TABLE public.directus_webhooks OWNER TO directus;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_webhooks_id_seq OWNER TO directus;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: groupement; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.groupement (
    id uuid NOT NULL,
    nom character varying(255),
    adresse character varying(255) DEFAULT NULL::character varying,
    ville character varying(255) DEFAULT NULL::character varying,
    type_id integer
);


ALTER TABLE public.groupement OWNER TO directus;

--
-- Name: personnel; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.personnel (
    id uuid NOT NULL,
    nom character varying(255),
    prenom character varying(255) DEFAULT NULL::character varying,
    mail character varying(255) DEFAULT NULL::character varying,
    telephone character varying(255) DEFAULT NULL::character varying,
    groupe_id uuid
);


ALTER TABLE public.personnel OWNER TO directus;

--
-- Name: praticiens; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.praticiens (
    id uuid NOT NULL,
    nom character varying(255),
    prenom character varying(255) DEFAULT NULL::character varying,
    ville character varying(255) DEFAULT NULL::character varying,
    email character varying(255) DEFAULT NULL::character varying,
    telephone character varying(255) DEFAULT NULL::character varying,
    groupe_id uuid,
    specialite_id integer
);


ALTER TABLE public.praticiens OWNER TO directus;

--
-- Name: specialite; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.specialite (
    id integer NOT NULL,
    libelle character varying(255),
    description character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.specialite OWNER TO directus;

--
-- Name: specialite_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.specialite_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.specialite_id_seq OWNER TO directus;

--
-- Name: specialite_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.specialite_id_seq OWNED BY public.specialite.id;


--
-- Name: type_groupement; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.type_groupement (
    id integer NOT NULL,
    type_libelle character varying(255),
    type_description character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.type_groupement OWNER TO directus;

--
-- Name: type_groupement_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.type_groupement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.type_groupement_id_seq OWNER TO directus;

--
-- Name: type_groupement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.type_groupement_id_seq OWNED BY public.type_groupement.id;


--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_notifications id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications ALTER COLUMN id SET DEFAULT nextval('public.directus_notifications_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Name: specialite id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.specialite ALTER COLUMN id SET DEFAULT nextval('public.specialite_id_seq'::regclass);


--
-- Name: type_groupement id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.type_groupement ALTER COLUMN id SET DEFAULT nextval('public.type_groupement_id_seq'::regclass);


--
-- Data for Name: directus_access; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_access (id, role, "user", policy, sort) FROM stdin;
1ea7b8c6-d6d7-418d-93ef-3e58c6d59bfa	\N	\N	abf8a154-5b1c-4a46-ac9c-7300570f4f17	1
2f623539-93a1-41bf-8a4a-456265276250	cb08a347-e5ba-4510-b7d3-df40c85ed186	\N	da8d8a38-3535-49c2-98dc-4f9621c595d7	\N
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, origin) FROM stdin;
1	login	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 13:01:18.283+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	6208cdc2-d6b3-46b8-afef-afa7af926ef1	http://localhost:8055
2	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:20:07.52+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	1	http://localhost:8055
3	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:20:07.526+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_collections	praticiens	http://localhost:8055
4	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:20:27.976+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	2	http://localhost:8055
5	update	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:31:15.498+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	1	http://localhost:8055
6	update	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:31:24.327+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	1	http://localhost:8055
7	delete	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:31:37.277+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_collections	praticiens	http://localhost:8055
8	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:31:49.464+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	3	http://localhost:8055
9	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:31:49.468+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_collections	praticiens	http://localhost:8055
10	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:32:01.932+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	4	http://localhost:8055
11	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:32:10.942+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	5	http://localhost:8055
12	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:32:18.285+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	6	http://localhost:8055
13	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:32:25.131+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	7	http://localhost:8055
14	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:32:31.421+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	8	http://localhost:8055
15	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:33:36.075+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	9	http://localhost:8055
16	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:33:36.078+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_collections	type_groupement	http://localhost:8055
17	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:33:47.412+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	10	http://localhost:8055
18	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:34:05.029+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	11	http://localhost:8055
19	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:34:38.215+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	12	http://localhost:8055
20	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:34:38.219+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_collections	specialite	http://localhost:8055
21	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:34:48.735+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	13	http://localhost:8055
22	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:34:54.942+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	14	http://localhost:8055
23	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:35:34.718+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	15	http://localhost:8055
24	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:35:34.721+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_collections	personnel	http://localhost:8055
25	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:35:45.705+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	16	http://localhost:8055
26	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:35:50.479+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	17	http://localhost:8055
27	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:35:59.405+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	18	http://localhost:8055
28	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:36:05.285+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	19	http://localhost:8055
29	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:36:43.865+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	20	http://localhost:8055
30	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:36:43.868+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_collections	groupement	http://localhost:8055
31	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:36:52.191+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	21	http://localhost:8055
32	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:37:04.877+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	22	http://localhost:8055
33	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:37:09.406+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	23	http://localhost:8055
34	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:37:40.37+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	24	http://localhost:8055
35	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:38:27.538+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	25	http://localhost:8055
36	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:39:01.965+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	26	http://localhost:8055
37	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:39:20.369+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	27	http://localhost:8055
38	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:40:21.811+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	type_groupement	1	http://localhost:8055
39	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:40:21.815+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	type_groupement	2	http://localhost:8055
40	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:40:21.817+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	type_groupement	3	http://localhost:8055
41	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:17.075+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	groupement	3444bdd2-8783-3aed-9a5e-4d298d2a2d7c	http://localhost:8055
42	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:17.077+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	groupement	372c1de7-4d31-3d01-9c92-77e69467d4e3	http://localhost:8055
43	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:17.08+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	groupement	255ecef6-14b9-3b5c-a40e-901665f4ed28	http://localhost:8055
44	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:17.082+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	groupement	80756589-93f3-3ab7-92dd-377dbea5ea4d	http://localhost:8055
45	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:17.084+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	groupement	5f7d3d80-3c4b-386a-a23e-74de4a1e0b19	http://localhost:8055
46	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:17.087+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	groupement	c302d11b-d5b8-310a-bbc5-9dd4400eb2c9	http://localhost:8055
47	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:17.088+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	groupement	b636c1fd-c61c-306b-9d4f-25cf3bfd9f66	http://localhost:8055
48	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:17.091+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	groupement	7db214d9-f415-3110-991b-ec5f9774b685	http://localhost:8055
49	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:17.093+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	groupement	a51a0543-ee80-3515-81ab-2504ec194c09	http://localhost:8055
50	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:17.095+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	groupement	fe6e7644-9e58-3b57-9734-f201766d4d75	http://localhost:8055
51	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:17.097+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	groupement	9117850b-3116-3d4f-b346-1dfc23c26787	http://localhost:8055
52	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:17.099+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	groupement	bee7989a-c204-3cf7-bbfc-42a9ce8456ea	http://localhost:8055
53	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:17.101+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	groupement	55ee31cb-9fb6-3513-b209-e2804d02c11e	http://localhost:8055
54	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:30.468+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	specialite	1	http://localhost:8055
55	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:30.47+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	specialite	2	http://localhost:8055
56	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:30.473+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	specialite	3	http://localhost:8055
57	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:30.476+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	specialite	4	http://localhost:8055
58	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:30.479+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	specialite	5	http://localhost:8055
59	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.127+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	a7683bcd-30b1-3455-93a8-db072ab97b27	http://localhost:8055
60	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.129+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	475e2bef-afe8-3eb1-8b70-bccb6000cbcd	http://localhost:8055
61	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.131+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	1738d920-4d0b-38a3-9108-1edae406e5a6	http://localhost:8055
62	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.133+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	59e37ba0-f491-3a7d-9360-1ec7d1410c74	http://localhost:8055
63	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.135+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	c87526f4-464d-3086-86f3-61436cc33f4c	http://localhost:8055
64	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.137+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	056bd724-a3ac-309f-9d05-03dd298dc530	http://localhost:8055
65	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.139+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	240a1331-06cf-3e77-8b7e-bf0d2f9f874a	http://localhost:8055
66	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.141+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	4fd0d68d-195a-30ad-a5b6-148a663a56ed	http://localhost:8055
67	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.142+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	5de41221-6098-3895-90c3-17152d523204	http://localhost:8055
68	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.144+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	2905a6b3-937b-3332-b02f-f0a298f70374	http://localhost:8055
69	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.146+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	14b52ece-d0bf-3162-979b-f356f3833605	http://localhost:8055
70	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.148+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	fd2acfa0-b429-3449-822b-6a6733465a16	http://localhost:8055
71	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.151+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	325aac63-9c6f-3d08-983c-67edd0361500	http://localhost:8055
72	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.152+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	72a80ee4-aad1-3189-bb58-dfa638ff2af3	http://localhost:8055
73	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.154+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	b9bedd1c-f8a8-3c65-b9ad-850b551cbecf	http://localhost:8055
74	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.156+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	8fb66ad8-992b-3e5c-a98f-47eba3b7a62a	http://localhost:8055
75	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.158+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	0e6d3926-be87-332c-94e0-cca0bdcfa3d6	http://localhost:8055
76	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.159+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	57a31547-2e5a-3ab8-bf3e-97e5ecba6c88	http://localhost:8055
77	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.161+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	a027a4d8-bf57-30d9-afd2-79bcfda90de2	http://localhost:8055
78	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.163+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	ec62b359-705d-3717-82f3-561b2a4dda4d	http://localhost:8055
79	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.166+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	ec79ebae-3041-3182-9ac7-676fac0a6419	http://localhost:8055
80	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.168+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	e2b0ec67-79ed-3e0c-b73c-b43e615b0b8d	http://localhost:8055
81	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.17+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	712eb55d-7b17-3a6e-8c50-44b6bc37959c	http://localhost:8055
82	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.172+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	ade0a833-70b4-36f2-b938-22857e7da4c7	http://localhost:8055
83	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.174+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	024e14c7-2f6b-3566-87e9-84f01d252bb1	http://localhost:8055
84	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.176+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	fda644e6-62ed-3971-b5a7-44146b808a82	http://localhost:8055
85	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.178+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	75d3e34b-e9a6-3494-bf39-d3e45f6c3653	http://localhost:8055
86	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:41.179+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	personnel	ffc24e94-8981-3ed9-8019-fa8bd2e16001	http://localhost:8055
87	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:47.981+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	af7bb2f1-cc52-3388-b9bc-c0b89e7f4c5b	http://localhost:8055
88	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:47.983+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	b994a36f-794f-3ddc-b267-99673661466d	http://localhost:8055
89	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:47.986+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	8236bcbf-4c06-3d0e-8ab0-c4964e02c4ea	http://localhost:8055
90	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:47.988+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	8ae1400f-d46d-3b50-b356-269f776be532	http://localhost:8055
91	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:47.991+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	085c44e7-6245-3b10-9c1a-92f09524ef2a	http://localhost:8055
92	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:47.993+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	dada1285-f235-3ad2-bd7d-f58d68c30a73	http://localhost:8055
93	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:47.995+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	51c6c5a5-0815-3ff1-b0e4-ac216319e526	http://localhost:8055
94	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:47.997+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	592692c8-4a8c-3f91-967b-fde67ebea54d	http://localhost:8055
95	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	0768e78b-12c8-3694-b89b-d0a7451a8fb1	http://localhost:8055
96	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.002+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	f9bd589a-99ef-39f7-9984-af26e95c7150	http://localhost:8055
97	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.004+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	bdd2672d-f4e6-3fd1-88db-d27e97b4d1e0	http://localhost:8055
98	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.005+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	7c76c93d-1b70-35eb-96d5-34c2d9d741c4	http://localhost:8055
99	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.007+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	656c9034-bf19-33a0-beec-9a959ee83cd7	http://localhost:8055
100	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.009+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	2ae94f01-8332-3c16-bf4c-eb1d64929253	http://localhost:8055
101	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.011+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	68202db3-920d-35dc-b547-e52c53ec5885	http://localhost:8055
102	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.013+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	3eeec083-d6fe-3cf7-b0da-e2b09a261db9	http://localhost:8055
103	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.014+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	529fa71e-5a6c-3360-9579-81abc41e865f	http://localhost:8055
104	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.017+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	e6f97aad-b672-3407-92ac-54b26d95d628	http://localhost:8055
105	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.019+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	05644ac0-c4cb-36bf-a0cf-409075eb20c4	http://localhost:8055
106	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.021+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	c7c71a7a-d6e1-3aa3-8aa8-987cbef516b0	http://localhost:8055
107	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.025+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	d7e254f4-7e01-395a-b668-6f86e3444906	http://localhost:8055
108	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.027+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	41ac1467-4874-3e88-a636-444eae7dc457	http://localhost:8055
109	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.029+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	15d3e128-b47c-3030-a1c8-cfb09942054a	http://localhost:8055
110	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.031+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	9b4aa9d2-fb6a-3e07-9b5a-a792ffb4b3f3	http://localhost:8055
111	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.034+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	905735e4-bd41-3991-8462-0b21a962ecc9	http://localhost:8055
112	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.035+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	03f24d7b-efda-3fbe-ae53-0c0c0edef089	http://localhost:8055
113	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.038+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	8b34ba8b-5775-31a9-9ca6-1cf955c9ab84	http://localhost:8055
114	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.04+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	b0458f20-e264-3ab4-8153-47268dd936bc	http://localhost:8055
115	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.041+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	3688814f-1b08-313b-8287-18febcc544d6	http://localhost:8055
116	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.043+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	b05657bc-ecf5-3a76-960a-c20e41af60a0	http://localhost:8055
117	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.045+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	2192c51f-1d1f-3d76-88ed-6a25abed0faf	http://localhost:8055
118	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.046+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	3dc3ed9e-b07e-3cb7-81c4-6607d11f20ca	http://localhost:8055
119	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.048+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	a63afd36-5682-3ad1-971f-447c6fd45180	http://localhost:8055
120	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.05+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	4d4680e8-b362-3ccc-93f0-69ba51d40e67	http://localhost:8055
121	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.052+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	da903aa3-21c2-3631-a08b-d8d054cccb48	http://localhost:8055
122	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.054+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	c29223af-0dbe-3bba-8069-65743a4ae8b4	http://localhost:8055
123	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.056+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	a960bb57-cf39-3636-9f6d-3ef52834ecfc	http://localhost:8055
124	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.058+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	f524d70d-0f02-3747-a6fb-8d6db043210e	http://localhost:8055
125	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.06+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	98cf3e54-0cb8-33f0-beae-2fad5ff62bdf	http://localhost:8055
126	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.064+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	794f6ea3-9801-334b-ba82-4ac71f70f6d2	http://localhost:8055
127	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.068+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	e274a3f8-50b3-37c7-a061-333110a1560b	http://localhost:8055
128	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.071+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	7edb1b5e-eeaa-358e-84c5-1b66fc2fec2d	http://localhost:8055
129	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.076+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	609bc828-4d34-3bb2-b527-93d80478d6b3	http://localhost:8055
130	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.079+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	341453e4-c122-3028-a712-af7ddad67975	http://localhost:8055
131	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.082+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	e3ba8e27-6ce8-38d8-bdbc-54c53259036f	http://localhost:8055
132	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.093+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	fd23b913-b526-3b02-bf44-0dd2b25796bb	http://localhost:8055
133	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.096+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	dfe8a45d-1122-361c-bf96-fffae0d385f2	http://localhost:8055
134	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.098+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	a7cc5d8f-360c-3334-a992-6e9008c07c47	http://localhost:8055
135	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.1+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	e5f6cdd3-e9de-3c30-84b9-2d431c0d853f	http://localhost:8055
136	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.102+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	623b83ab-46b9-3cf3-8e04-3bb514cb059f	http://localhost:8055
137	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.104+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	7c57a60f-936a-3b48-884b-dd00fa4f3e0f	http://localhost:8055
138	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.106+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	a5c30f27-6100-373f-b291-df93927b5899	http://localhost:8055
139	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.108+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	95b1d811-22c6-3c4e-94fb-69dc3bd0522a	http://localhost:8055
140	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.11+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	33448c5c-ba4f-366b-88f4-95aec59b982d	http://localhost:8055
141	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.112+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	c813bddb-147b-3579-820d-cd58b28adac0	http://localhost:8055
142	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.113+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	1d27091f-5a24-312c-a594-5102f5576306	http://localhost:8055
143	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.116+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	8fe808d9-6742-3942-acfc-b78e2dc0ead2	http://localhost:8055
144	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.118+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	5670356f-5750-3222-aa82-a7309199fe59	http://localhost:8055
145	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.12+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	bf5fdb24-f530-32a1-ba6c-3f09a6d25566	http://localhost:8055
146	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.121+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	c10622c7-ac83-38f5-939c-54a5ebcb7cb5	http://localhost:8055
147	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.124+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	2da9d1c6-a17c-31f2-95a7-4f2f191326dc	http://localhost:8055
148	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.127+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	ac91e524-3538-3a24-bda2-68a98288960e	http://localhost:8055
149	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.128+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	62097b60-2085-3619-a92b-a23add366c7b	http://localhost:8055
150	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.131+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	2a197d2d-6eee-3875-8e02-feb17faf62a0	http://localhost:8055
151	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.133+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	35b16c74-40ee-3fe5-bea2-b0f525b0f245	http://localhost:8055
152	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.135+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	f09cf264-8826-35b7-bbf3-af6561f3ba8f	http://localhost:8055
153	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.137+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	f3485799-f91d-35ef-9f76-6a02a041fefa	http://localhost:8055
154	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.138+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	23923a6b-909a-38e8-a7fe-50745ef4ac0f	http://localhost:8055
155	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.141+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	66faac60-5e42-313f-9d88-f4e16ddce694	http://localhost:8055
156	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.143+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	4b1f7ae9-f6d4-3dc2-9869-45b1f2849c49	http://localhost:8055
157	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.144+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	512e3f2d-b40f-336a-8bda-2b871d72691d	http://localhost:8055
158	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.147+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	d79364b7-87e2-3ad2-894e-fce97f7a1d83	http://localhost:8055
159	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.149+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	581b1a86-e5ac-3f81-9a98-f87aa0fbf718	http://localhost:8055
160	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.151+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	2e1c1158-c565-3780-aeed-2845063e415c	http://localhost:8055
161	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.152+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	d6021537-72b7-3289-bfe7-efa9b4281b73	http://localhost:8055
162	create	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:41:48.154+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	praticiens	1e67bfd0-fd1a-362a-be57-6b212c76cfb6	http://localhost:8055
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning) FROM stdin;
praticiens	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
type_groupement	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
specialite	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
personnel	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
groupement	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
\.


--
-- Data for Name: directus_comments; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_comments (id, collection, item, comment, date_created, date_updated, user_created, user_updated) FROM stdin;
\.


--
-- Data for Name: directus_dashboards; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_dashboards (id, name, icon, note, date_created, user_created, color) FROM stdin;
\.


--
-- Data for Name: directus_extensions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_extensions (enabled, id, folder, source, bundle) FROM stdin;
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, translations, note, conditions, required, "group", validation, validation_message) FROM stdin;
3	praticiens	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
4	praticiens	nom	\N	input	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
5	praticiens	prenom	\N	input	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
6	praticiens	ville	\N	input	\N	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
7	praticiens	email	\N	input	\N	\N	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N
8	praticiens	telephone	\N	input	\N	\N	\N	f	f	6	full	\N	\N	\N	f	\N	\N	\N
9	type_groupement	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
10	type_groupement	type_libelle	\N	input	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
11	type_groupement	type_description	\N	input	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
12	specialite	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
13	specialite	libelle	\N	input	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
14	specialite	description	\N	input	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
15	personnel	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
16	personnel	nom	\N	input	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
17	personnel	prenom	\N	input	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
18	personnel	mail	\N	input	\N	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
19	personnel	telephone	\N	input	\N	\N	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N
20	groupement	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
21	groupement	nom	\N	input	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
22	groupement	adresse	\N	input	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
23	groupement	ville	\N	input	\N	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
24	groupement	type_id	m2o	\N	\N	\N	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N
25	personnel	groupe_id	m2o	\N	\N	\N	\N	f	f	6	full	\N	\N	\N	f	\N	\N	\N
26	praticiens	groupe_id	m2o	\N	\N	\N	\N	f	f	7	full	\N	\N	\N	f	\N	\N	\N
27	praticiens	specialite_id	m2o	\N	\N	\N	\N	f	f	8	full	\N	\N	\N	f	\N	\N	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, created_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata, focal_point_x, focal_point_y, tus_id, tus_data, uploaded_on) FROM stdin;
\.


--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_flows (id, name, icon, color, description, status, trigger, accountability, options, operation, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_folders (id, name, parent) FROM stdin;
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2025-01-14 13:00:50.45552+00
20201029A	Remove System Relations	2025-01-14 13:00:50.459946+00
20201029B	Remove System Collections	2025-01-14 13:00:50.464218+00
20201029C	Remove System Fields	2025-01-14 13:00:50.471319+00
20201105A	Add Cascade System Relations	2025-01-14 13:00:50.493669+00
20201105B	Change Webhook URL Type	2025-01-14 13:00:50.4986+00
20210225A	Add Relations Sort Field	2025-01-14 13:00:50.503865+00
20210304A	Remove Locked Fields	2025-01-14 13:00:50.506209+00
20210312A	Webhooks Collections Text	2025-01-14 13:00:50.51014+00
20210331A	Add Refresh Interval	2025-01-14 13:00:50.512274+00
20210415A	Make Filesize Nullable	2025-01-14 13:00:50.516781+00
20210416A	Add Collections Accountability	2025-01-14 13:00:50.519678+00
20210422A	Remove Files Interface	2025-01-14 13:00:50.521416+00
20210506A	Rename Interfaces	2025-01-14 13:00:50.549506+00
20210510A	Restructure Relations	2025-01-14 13:00:50.564791+00
20210518A	Add Foreign Key Constraints	2025-01-14 13:00:50.570048+00
20210519A	Add System Fk Triggers	2025-01-14 13:00:50.591623+00
20210521A	Add Collections Icon Color	2025-01-14 13:00:50.594759+00
20210525A	Add Insights	2025-01-14 13:00:50.606246+00
20210608A	Add Deep Clone Config	2025-01-14 13:00:50.60925+00
20210626A	Change Filesize Bigint	2025-01-14 13:00:50.61817+00
20210716A	Add Conditions to Fields	2025-01-14 13:00:50.620548+00
20210721A	Add Default Folder	2025-01-14 13:00:50.62522+00
20210802A	Replace Groups	2025-01-14 13:00:50.629599+00
20210803A	Add Required to Fields	2025-01-14 13:00:50.631956+00
20210805A	Update Groups	2025-01-14 13:00:50.63535+00
20210805B	Change Image Metadata Structure	2025-01-14 13:00:50.638763+00
20210811A	Add Geometry Config	2025-01-14 13:00:50.642087+00
20210831A	Remove Limit Column	2025-01-14 13:00:50.644563+00
20210903A	Add Auth Provider	2025-01-14 13:00:50.654418+00
20210907A	Webhooks Collections Not Null	2025-01-14 13:00:50.661067+00
20210910A	Move Module Setup	2025-01-14 13:00:50.666547+00
20210920A	Webhooks URL Not Null	2025-01-14 13:00:50.674892+00
20210924A	Add Collection Organization	2025-01-14 13:00:50.680304+00
20210927A	Replace Fields Group	2025-01-14 13:00:50.690198+00
20210927B	Replace M2M Interface	2025-01-14 13:00:50.693977+00
20210929A	Rename Login Action	2025-01-14 13:00:50.697275+00
20211007A	Update Presets	2025-01-14 13:00:50.705363+00
20211009A	Add Auth Data	2025-01-14 13:00:50.709082+00
20211016A	Add Webhook Headers	2025-01-14 13:00:50.713122+00
20211103A	Set Unique to User Token	2025-01-14 13:00:50.717949+00
20211103B	Update Special Geometry	2025-01-14 13:00:50.720535+00
20211104A	Remove Collections Listing	2025-01-14 13:00:50.722798+00
20211118A	Add Notifications	2025-01-14 13:00:50.731671+00
20211211A	Add Shares	2025-01-14 13:00:50.750851+00
20211230A	Add Project Descriptor	2025-01-14 13:00:50.753766+00
20220303A	Remove Default Project Color	2025-01-14 13:00:50.759739+00
20220308A	Add Bookmark Icon and Color	2025-01-14 13:00:50.762703+00
20220314A	Add Translation Strings	2025-01-14 13:00:50.765287+00
20220322A	Rename Field Typecast Flags	2025-01-14 13:00:50.7695+00
20220323A	Add Field Validation	2025-01-14 13:00:50.772354+00
20220325A	Fix Typecast Flags	2025-01-14 13:00:50.777165+00
20220325B	Add Default Language	2025-01-14 13:00:50.784105+00
20220402A	Remove Default Value Panel Icon	2025-01-14 13:00:50.791161+00
20220429A	Add Flows	2025-01-14 13:00:50.812252+00
20220429B	Add Color to Insights Icon	2025-01-14 13:00:50.814402+00
20220429C	Drop Non Null From IP of Activity	2025-01-14 13:00:50.816116+00
20220429D	Drop Non Null From Sender of Notifications	2025-01-14 13:00:50.817674+00
20220614A	Rename Hook Trigger to Event	2025-01-14 13:00:50.819058+00
20220801A	Update Notifications Timestamp Column	2025-01-14 13:00:50.823138+00
20220802A	Add Custom Aspect Ratios	2025-01-14 13:00:50.825634+00
20220826A	Add Origin to Accountability	2025-01-14 13:00:50.82844+00
20230401A	Update Material Icons	2025-01-14 13:00:50.833366+00
20230525A	Add Preview Settings	2025-01-14 13:00:50.835096+00
20230526A	Migrate Translation Strings	2025-01-14 13:00:50.841201+00
20230721A	Require Shares Fields	2025-01-14 13:00:50.845117+00
20230823A	Add Content Versioning	2025-01-14 13:00:50.853885+00
20230927A	Themes	2025-01-14 13:00:50.863252+00
20231009A	Update CSV Fields to Text	2025-01-14 13:00:50.86625+00
20231009B	Update Panel Options	2025-01-14 13:00:50.867889+00
20231010A	Add Extensions	2025-01-14 13:00:50.870855+00
20231215A	Add Focalpoints	2025-01-14 13:00:50.872552+00
20240122A	Add Report URL Fields	2025-01-14 13:00:50.874297+00
20240204A	Marketplace	2025-01-14 13:00:50.887262+00
20240305A	Change Useragent Type	2025-01-14 13:00:50.893172+00
20240311A	Deprecate Webhooks	2025-01-14 13:00:50.899532+00
20240422A	Public Registration	2025-01-14 13:00:50.902654+00
20240515A	Add Session Window	2025-01-14 13:00:50.904443+00
20240701A	Add Tus Data	2025-01-14 13:00:50.906283+00
20240716A	Update Files Date Fields	2025-01-14 13:00:50.910556+00
20240806A	Permissions Policies	2025-01-14 13:00:50.934775+00
20240817A	Update Icon Fields Length	2025-01-14 13:00:50.950908+00
20240909A	Separate Comments	2025-01-14 13:00:50.957366+00
20240909B	Consolidate Content Versioning	2025-01-14 13:00:50.959433+00
20240924A	Migrate Legacy Comments	2025-01-14 13:00:50.962707+00
20240924B	Populate Versioning Deltas	2025-01-14 13:00:50.965828+00
\.


--
-- Data for Name: directus_notifications; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_notifications (id, "timestamp", status, recipient, sender, subject, message, collection, item) FROM stdin;
\.


--
-- Data for Name: directus_operations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_operations (id, name, key, type, position_x, position_y, options, resolve, reject, flow, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_panels (id, dashboard, name, icon, color, show_header, note, type, position_x, position_y, width, height, options, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_permissions (id, collection, action, permissions, validation, presets, fields, policy) FROM stdin;
\.


--
-- Data for Name: directus_policies; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_policies (id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access) FROM stdin;
abf8a154-5b1c-4a46-ac9c-7300570f4f17	$t:public_label	public	$t:public_description	\N	f	f	f
da8d8a38-3535-49c2-98dc-4f9621c595d7	Administrator	verified	$t:admin_description	\N	f	t	t
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter, icon, color) FROM stdin;
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
1	groupement	type_id	type_groupement	\N	\N	\N	\N	\N	nullify
2	personnel	groupe_id	groupement	\N	\N	\N	\N	\N	nullify
3	praticiens	groupe_id	groupement	\N	\N	\N	\N	\N	nullify
4	praticiens	specialite_id	specialite	\N	\N	\N	\N	\N	nullify
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent, version) FROM stdin;
1	2	directus_fields	1	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"praticiens"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"praticiens"}	\N	\N
2	3	directus_collections	praticiens	{"singleton":false,"collection":"praticiens"}	{"singleton":false,"collection":"praticiens"}	\N	\N
3	4	directus_fields	2	{"sort":2,"interface":"input","special":null,"collection":"praticiens","field":"name"}	{"sort":2,"interface":"input","special":null,"collection":"praticiens","field":"name"}	\N	\N
4	5	directus_fields	1	{"id":1,"collection":"praticiens","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"praticiens","field":"id","readonly":false}	\N	\N
5	6	directus_fields	1	{"id":1,"collection":"praticiens","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"praticiens","field":"id","readonly":true}	\N	\N
6	8	directus_fields	3	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"praticiens"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"praticiens"}	\N	\N
7	9	directus_collections	praticiens	{"singleton":false,"collection":"praticiens"}	{"singleton":false,"collection":"praticiens"}	\N	\N
8	10	directus_fields	4	{"sort":2,"interface":"input","special":null,"collection":"praticiens","field":"nom"}	{"sort":2,"interface":"input","special":null,"collection":"praticiens","field":"nom"}	\N	\N
9	11	directus_fields	5	{"sort":3,"collection":"praticiens","field":"prenom","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"validation":null,"validation_message":null}	{"sort":3,"collection":"praticiens","field":"prenom","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"validation":null,"validation_message":null}	\N	\N
10	12	directus_fields	6	{"sort":4,"collection":"praticiens","field":"ville","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"validation":null,"validation_message":null}	{"sort":4,"collection":"praticiens","field":"ville","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"validation":null,"validation_message":null}	\N	\N
11	13	directus_fields	7	{"sort":5,"collection":"praticiens","field":"email","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"validation":null,"validation_message":null}	{"sort":5,"collection":"praticiens","field":"email","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"validation":null,"validation_message":null}	\N	\N
12	14	directus_fields	8	{"sort":6,"collection":"praticiens","field":"telephone","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"validation":null,"validation_message":null}	{"sort":6,"collection":"praticiens","field":"telephone","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"validation":null,"validation_message":null}	\N	\N
13	15	directus_fields	9	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"type_groupement"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"type_groupement"}	\N	\N
14	16	directus_collections	type_groupement	{"singleton":false,"collection":"type_groupement"}	{"singleton":false,"collection":"type_groupement"}	\N	\N
15	17	directus_fields	10	{"sort":2,"interface":"input","special":null,"collection":"type_groupement","field":"type_libelle"}	{"sort":2,"interface":"input","special":null,"collection":"type_groupement","field":"type_libelle"}	\N	\N
16	18	directus_fields	11	{"sort":3,"collection":"type_groupement","field":"type_description","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"validation":null,"validation_message":null}	{"sort":3,"collection":"type_groupement","field":"type_description","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"validation":null,"validation_message":null}	\N	\N
17	19	directus_fields	12	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"specialite"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"specialite"}	\N	\N
18	20	directus_collections	specialite	{"singleton":false,"collection":"specialite"}	{"singleton":false,"collection":"specialite"}	\N	\N
19	21	directus_fields	13	{"sort":2,"interface":"input","special":null,"collection":"specialite","field":"libelle"}	{"sort":2,"interface":"input","special":null,"collection":"specialite","field":"libelle"}	\N	\N
20	22	directus_fields	14	{"sort":3,"collection":"specialite","field":"description","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"validation":null,"validation_message":null}	{"sort":3,"collection":"specialite","field":"description","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"validation":null,"validation_message":null}	\N	\N
21	23	directus_fields	15	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"personnel"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"personnel"}	\N	\N
22	24	directus_collections	personnel	{"singleton":false,"collection":"personnel"}	{"singleton":false,"collection":"personnel"}	\N	\N
23	25	directus_fields	16	{"sort":2,"interface":"input","special":null,"collection":"personnel","field":"nom"}	{"sort":2,"interface":"input","special":null,"collection":"personnel","field":"nom"}	\N	\N
24	26	directus_fields	17	{"sort":3,"collection":"personnel","field":"prenom","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"validation":null,"validation_message":null}	{"sort":3,"collection":"personnel","field":"prenom","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"validation":null,"validation_message":null}	\N	\N
25	27	directus_fields	18	{"sort":4,"collection":"personnel","field":"mail","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"validation":null,"validation_message":null}	{"sort":4,"collection":"personnel","field":"mail","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"validation":null,"validation_message":null}	\N	\N
26	28	directus_fields	19	{"sort":5,"collection":"personnel","field":"telephone","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"validation":null,"validation_message":null}	{"sort":5,"collection":"personnel","field":"telephone","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"validation":null,"validation_message":null}	\N	\N
27	29	directus_fields	20	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"groupement"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"groupement"}	\N	\N
28	30	directus_collections	groupement	{"singleton":false,"collection":"groupement"}	{"singleton":false,"collection":"groupement"}	\N	\N
29	31	directus_fields	21	{"sort":2,"interface":"input","special":null,"collection":"groupement","field":"nom"}	{"sort":2,"interface":"input","special":null,"collection":"groupement","field":"nom"}	\N	\N
30	32	directus_fields	22	{"sort":3,"collection":"groupement","field":"adresse","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"validation":null,"validation_message":null}	{"sort":3,"collection":"groupement","field":"adresse","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"validation":null,"validation_message":null}	\N	\N
31	33	directus_fields	23	{"sort":4,"collection":"groupement","field":"ville","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"validation":null,"validation_message":null}	{"sort":4,"collection":"groupement","field":"ville","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"validation":null,"validation_message":null}	\N	\N
32	34	directus_fields	24	{"sort":5,"special":["m2o"],"collection":"groupement","field":"type_id"}	{"sort":5,"special":["m2o"],"collection":"groupement","field":"type_id"}	\N	\N
33	35	directus_fields	25	{"sort":6,"special":["m2o"],"collection":"personnel","field":"groupe_id"}	{"sort":6,"special":["m2o"],"collection":"personnel","field":"groupe_id"}	\N	\N
34	36	directus_fields	26	{"sort":7,"special":["m2o"],"collection":"praticiens","field":"groupe_id"}	{"sort":7,"special":["m2o"],"collection":"praticiens","field":"groupe_id"}	\N	\N
35	37	directus_fields	27	{"sort":8,"special":["m2o"],"collection":"praticiens","field":"specialite_id"}	{"sort":8,"special":["m2o"],"collection":"praticiens","field":"specialite_id"}	\N	\N
36	38	type_groupement	1	{"id":"1","type_libelle":"Maison Médicale","type_description":"Maison de santé groupant des praticiens de diverses spécialités"}	{"id":"1","type_libelle":"Maison Médicale","type_description":"Maison de santé groupant des praticiens de diverses spécialités"}	\N	\N
37	39	type_groupement	2	{"id":"2","type_libelle":"Cabinet médical","type_description":"Cabinet regroupant un ou plusieurs praticiens de santé de même spécialité"}	{"id":"2","type_libelle":"Cabinet médical","type_description":"Cabinet regroupant un ou plusieurs praticiens de santé de même spécialité"}	\N	\N
38	40	type_groupement	3	{"id":"3","type_libelle":"secrétariat externalisé","type_description":"service externalisé de gestion administrative "}	{"id":"3","type_libelle":"secrétariat externalisé","type_description":"service externalisé de gestion administrative "}	\N	\N
39	41	groupement	3444bdd2-8783-3aed-9a5e-4d298d2a2d7c	{"id":"3444bdd2-8783-3aed-9a5e-4d298d2a2d7c","nom":"Bigot","type_id":"1","adresse":"63, rue de Mercier","ville":"Paris"}	{"id":"3444bdd2-8783-3aed-9a5e-4d298d2a2d7c","nom":"Bigot","type_id":"1","adresse":"63, rue de Mercier","ville":"Paris"}	\N	\N
40	42	groupement	372c1de7-4d31-3d01-9c92-77e69467d4e3	{"id":"372c1de7-4d31-3d01-9c92-77e69467d4e3","nom":"Toussaint Marechal SAS","type_id":"1","adresse":"290, rue Rossi","ville":"Joubert"}	{"id":"372c1de7-4d31-3d01-9c92-77e69467d4e3","nom":"Toussaint Marechal SAS","type_id":"1","adresse":"290, rue Rossi","ville":"Joubert"}	\N	\N
41	43	groupement	255ecef6-14b9-3b5c-a40e-901665f4ed28	{"id":"255ecef6-14b9-3b5c-a40e-901665f4ed28","nom":"Pichon S.A.","type_id":"1","adresse":"93, impasse Alain Baron","ville":"Diaz-sur-Boulanger"}	{"id":"255ecef6-14b9-3b5c-a40e-901665f4ed28","nom":"Pichon S.A.","type_id":"1","adresse":"93, impasse Alain Baron","ville":"Diaz-sur-Boulanger"}	\N	\N
42	44	groupement	80756589-93f3-3ab7-92dd-377dbea5ea4d	{"id":"80756589-93f3-3ab7-92dd-377dbea5ea4d","nom":"Parent SARL","type_id":"1","adresse":"4, impasse de Denis","ville":"Lucas"}	{"id":"80756589-93f3-3ab7-92dd-377dbea5ea4d","nom":"Parent SARL","type_id":"1","adresse":"4, impasse de Denis","ville":"Lucas"}	\N	\N
43	45	groupement	5f7d3d80-3c4b-386a-a23e-74de4a1e0b19	{"id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19","nom":"Goncalves Louis SARL","type_id":"1","adresse":"35, impasse Lebon","ville":"Carre-sur-Turpin"}	{"id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19","nom":"Goncalves Louis SARL","type_id":"1","adresse":"35, impasse Lebon","ville":"Carre-sur-Turpin"}	\N	\N
44	46	groupement	c302d11b-d5b8-310a-bbc5-9dd4400eb2c9	{"id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9","nom":"Antoine","type_id":"2","adresse":"97, avenue Raymond Gerard","ville":"Moreno"}	{"id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9","nom":"Antoine","type_id":"2","adresse":"97, avenue Raymond Gerard","ville":"Moreno"}	\N	\N
45	47	groupement	b636c1fd-c61c-306b-9d4f-25cf3bfd9f66	{"id":"b636c1fd-c61c-306b-9d4f-25cf3bfd9f66","nom":"Barbe","type_id":"2","adresse":"23, avenue Mercier","ville":"Lefevre"}	{"id":"b636c1fd-c61c-306b-9d4f-25cf3bfd9f66","nom":"Barbe","type_id":"2","adresse":"23, avenue Mercier","ville":"Lefevre"}	\N	\N
46	48	groupement	7db214d9-f415-3110-991b-ec5f9774b685	{"id":"7db214d9-f415-3110-991b-ec5f9774b685","nom":"Marin","type_id":"2","adresse":"96, rue Louis","ville":"Bourdon-les-Bains"}	{"id":"7db214d9-f415-3110-991b-ec5f9774b685","nom":"Marin","type_id":"2","adresse":"96, rue Louis","ville":"Bourdon-les-Bains"}	\N	\N
47	49	groupement	a51a0543-ee80-3515-81ab-2504ec194c09	{"id":"a51a0543-ee80-3515-81ab-2504ec194c09","nom":"Lombard","type_id":"3","adresse":"17, chemin de Bazin","ville":"Paris-la-Forêt"}	{"id":"a51a0543-ee80-3515-81ab-2504ec194c09","nom":"Lombard","type_id":"3","adresse":"17, chemin de Bazin","ville":"Paris-la-Forêt"}	\N	\N
48	50	groupement	fe6e7644-9e58-3b57-9734-f201766d4d75	{"id":"fe6e7644-9e58-3b57-9734-f201766d4d75","nom":"Diallo SAS","type_id":"3","adresse":"53, rue Toussaint","ville":"Bouchet"}	{"id":"fe6e7644-9e58-3b57-9734-f201766d4d75","nom":"Diallo SAS","type_id":"3","adresse":"53, rue Toussaint","ville":"Bouchet"}	\N	\N
49	51	groupement	9117850b-3116-3d4f-b346-1dfc23c26787	{"id":"9117850b-3116-3d4f-b346-1dfc23c26787","nom":"Vaillant S.A.S.","type_id":"3","adresse":"68, avenue Élise Dupre","ville":"LemonnierBourg"}	{"id":"9117850b-3116-3d4f-b346-1dfc23c26787","nom":"Vaillant S.A.S.","type_id":"3","adresse":"68, avenue Élise Dupre","ville":"LemonnierBourg"}	\N	\N
50	52	groupement	bee7989a-c204-3cf7-bbfc-42a9ce8456ea	{"id":"bee7989a-c204-3cf7-bbfc-42a9ce8456ea","nom":"Martineau","type_id":"3","adresse":"31, boulevard Éric Pierre","ville":"Royer"}	{"id":"bee7989a-c204-3cf7-bbfc-42a9ce8456ea","nom":"Martineau","type_id":"3","adresse":"31, boulevard Éric Pierre","ville":"Royer"}	\N	\N
51	53	groupement	55ee31cb-9fb6-3513-b209-e2804d02c11e	{"id":"55ee31cb-9fb6-3513-b209-e2804d02c11e","nom":"Fischer","type_id":"3","adresse":"83, place de Lefort","ville":"Ruiz"}	{"id":"55ee31cb-9fb6-3513-b209-e2804d02c11e","nom":"Fischer","type_id":"3","adresse":"83, place de Lefort","ville":"Ruiz"}	\N	\N
52	54	specialite	1	{"id":"1","libelle":"médecine générale","description":"Médecine Générale"}	{"id":"1","libelle":"médecine générale","description":"Médecine Générale"}	\N	\N
53	55	specialite	2	{"id":"2","libelle":"Médecine du sport","description":"Maladie et traumatismes de la pratique sportive"}	{"id":"2","libelle":"Médecine du sport","description":"Maladie et traumatismes de la pratique sportive"}	\N	\N
54	56	specialite	3	{"id":"3","libelle":"pédiatrie","description":"Maladies des enfants"}	{"id":"3","libelle":"pédiatrie","description":"Maladies des enfants"}	\N	\N
55	57	specialite	4	{"id":"4","libelle":"ophtalmologie","description":"Maladies des yeux"}	{"id":"4","libelle":"ophtalmologie","description":"Maladies des yeux"}	\N	\N
56	58	specialite	5	{"id":"5","libelle":"Dentiste","description":"Bouche et dents"}	{"id":"5","libelle":"Dentiste","description":"Bouche et dents"}	\N	\N
57	59	personnel	a7683bcd-30b1-3455-93a8-db072ab97b27	{"id":"a7683bcd-30b1-3455-93a8-db072ab97b27","nom":"Joubert","prenom":"Michèle","mail":"Michle.Joubert@dbmail.com","telephone":"0158189514","groupe_id":"3444bdd2-8783-3aed-9a5e-4d298d2a2d7c"}	{"id":"a7683bcd-30b1-3455-93a8-db072ab97b27","nom":"Joubert","prenom":"Michèle","mail":"Michle.Joubert@dbmail.com","telephone":"0158189514","groupe_id":"3444bdd2-8783-3aed-9a5e-4d298d2a2d7c"}	\N	\N
58	60	personnel	475e2bef-afe8-3eb1-8b70-bccb6000cbcd	{"id":"475e2bef-afe8-3eb1-8b70-bccb6000cbcd","nom":"Delaunay","prenom":"Dominique","mail":"Dominique.Delaunay@wanadoo.fr","telephone":"+33 9 26 07 04 72","groupe_id":"3444bdd2-8783-3aed-9a5e-4d298d2a2d7c"}	{"id":"475e2bef-afe8-3eb1-8b70-bccb6000cbcd","nom":"Delaunay","prenom":"Dominique","mail":"Dominique.Delaunay@wanadoo.fr","telephone":"+33 9 26 07 04 72","groupe_id":"3444bdd2-8783-3aed-9a5e-4d298d2a2d7c"}	\N	\N
59	61	personnel	1738d920-4d0b-38a3-9108-1edae406e5a6	{"id":"1738d920-4d0b-38a3-9108-1edae406e5a6","nom":"Boucher","prenom":"Jean","mail":"Jean.Boucher@free.fr","telephone":"0895587519","groupe_id":"372c1de7-4d31-3d01-9c92-77e69467d4e3"}	{"id":"1738d920-4d0b-38a3-9108-1edae406e5a6","nom":"Boucher","prenom":"Jean","mail":"Jean.Boucher@free.fr","telephone":"0895587519","groupe_id":"372c1de7-4d31-3d01-9c92-77e69467d4e3"}	\N	\N
60	62	personnel	59e37ba0-f491-3a7d-9360-1ec7d1410c74	{"id":"59e37ba0-f491-3a7d-9360-1ec7d1410c74","nom":"Dubois","prenom":"Olivier","mail":"Olivier.Dubois@wanadoo.fr","telephone":"07 96 98 25 78","groupe_id":"255ecef6-14b9-3b5c-a40e-901665f4ed28"}	{"id":"59e37ba0-f491-3a7d-9360-1ec7d1410c74","nom":"Dubois","prenom":"Olivier","mail":"Olivier.Dubois@wanadoo.fr","telephone":"07 96 98 25 78","groupe_id":"255ecef6-14b9-3b5c-a40e-901665f4ed28"}	\N	\N
61	63	personnel	c87526f4-464d-3086-86f3-61436cc33f4c	{"id":"c87526f4-464d-3086-86f3-61436cc33f4c","nom":"Guilbert","prenom":"Édith","mail":"dith.Guilbert@hotmail.fr","telephone":"+33 (0)3 83 98 66 51","groupe_id":"80756589-93f3-3ab7-92dd-377dbea5ea4d"}	{"id":"c87526f4-464d-3086-86f3-61436cc33f4c","nom":"Guilbert","prenom":"Édith","mail":"dith.Guilbert@hotmail.fr","telephone":"+33 (0)3 83 98 66 51","groupe_id":"80756589-93f3-3ab7-92dd-377dbea5ea4d"}	\N	\N
62	64	personnel	056bd724-a3ac-309f-9d05-03dd298dc530	{"id":"056bd724-a3ac-309f-9d05-03dd298dc530","nom":"Normand","prenom":"Théophile","mail":"Thophile.Normand@noos.fr","telephone":"06 97 20 54 55","groupe_id":"80756589-93f3-3ab7-92dd-377dbea5ea4d"}	{"id":"056bd724-a3ac-309f-9d05-03dd298dc530","nom":"Normand","prenom":"Théophile","mail":"Thophile.Normand@noos.fr","telephone":"06 97 20 54 55","groupe_id":"80756589-93f3-3ab7-92dd-377dbea5ea4d"}	\N	\N
63	65	personnel	240a1331-06cf-3e77-8b7e-bf0d2f9f874a	{"id":"240a1331-06cf-3e77-8b7e-bf0d2f9f874a","nom":"Guyon","prenom":"Timothée","mail":"Timothe.Guyon@free.fr","telephone":"+33 8 11 74 87 40","groupe_id":"80756589-93f3-3ab7-92dd-377dbea5ea4d"}	{"id":"240a1331-06cf-3e77-8b7e-bf0d2f9f874a","nom":"Guyon","prenom":"Timothée","mail":"Timothe.Guyon@free.fr","telephone":"+33 8 11 74 87 40","groupe_id":"80756589-93f3-3ab7-92dd-377dbea5ea4d"}	\N	\N
64	66	personnel	4fd0d68d-195a-30ad-a5b6-148a663a56ed	{"id":"4fd0d68d-195a-30ad-a5b6-148a663a56ed","nom":"Julien","prenom":"Grégoire","mail":"Grgoire.Julien@hotmail.fr","telephone":"01 78 87 87 84","groupe_id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19"}	{"id":"4fd0d68d-195a-30ad-a5b6-148a663a56ed","nom":"Julien","prenom":"Grégoire","mail":"Grgoire.Julien@hotmail.fr","telephone":"01 78 87 87 84","groupe_id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19"}	\N	\N
65	67	personnel	5de41221-6098-3895-90c3-17152d523204	{"id":"5de41221-6098-3895-90c3-17152d523204","nom":"Payet","prenom":"Capucine","mail":"Capucine.Payet@orange.fr","telephone":"+33 2 13 87 68 30","groupe_id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19"}	{"id":"5de41221-6098-3895-90c3-17152d523204","nom":"Payet","prenom":"Capucine","mail":"Capucine.Payet@orange.fr","telephone":"+33 2 13 87 68 30","groupe_id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19"}	\N	\N
66	68	personnel	2905a6b3-937b-3332-b02f-f0a298f70374	{"id":"2905a6b3-937b-3332-b02f-f0a298f70374","nom":"Auger","prenom":"Marguerite","mail":"Marguerite.Auger@laposte.net","telephone":"+33 2 59 70 11 81","groupe_id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9"}	{"id":"2905a6b3-937b-3332-b02f-f0a298f70374","nom":"Auger","prenom":"Marguerite","mail":"Marguerite.Auger@laposte.net","telephone":"+33 2 59 70 11 81","groupe_id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9"}	\N	\N
67	69	personnel	14b52ece-d0bf-3162-979b-f356f3833605	{"id":"14b52ece-d0bf-3162-979b-f356f3833605","nom":"Gay","prenom":"Guy","mail":"Guy.Gay@gmail.com","telephone":"+33 4 45 28 11 75","groupe_id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9"}	{"id":"14b52ece-d0bf-3162-979b-f356f3833605","nom":"Gay","prenom":"Guy","mail":"Guy.Gay@gmail.com","telephone":"+33 4 45 28 11 75","groupe_id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9"}	\N	\N
68	70	personnel	fd2acfa0-b429-3449-822b-6a6733465a16	{"id":"fd2acfa0-b429-3449-822b-6a6733465a16","nom":"Parent","prenom":"Honoré","mail":"Honor.Parent@tele2.fr","telephone":"0808625348","groupe_id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9"}	{"id":"fd2acfa0-b429-3449-822b-6a6733465a16","nom":"Parent","prenom":"Honoré","mail":"Honor.Parent@tele2.fr","telephone":"0808625348","groupe_id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9"}	\N	\N
69	71	personnel	325aac63-9c6f-3d08-983c-67edd0361500	{"id":"325aac63-9c6f-3d08-983c-67edd0361500","nom":"Joseph","prenom":"Jules","mail":"Jules.Joseph@live.com","telephone":"+33 (0)5 31 44 52 52","groupe_id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9"}	{"id":"325aac63-9c6f-3d08-983c-67edd0361500","nom":"Joseph","prenom":"Jules","mail":"Jules.Joseph@live.com","telephone":"+33 (0)5 31 44 52 52","groupe_id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9"}	\N	\N
70	72	personnel	72a80ee4-aad1-3189-bb58-dfa638ff2af3	{"id":"72a80ee4-aad1-3189-bb58-dfa638ff2af3","nom":"Adam","prenom":"Auguste","mail":"Auguste.Adam@yahoo.fr","telephone":"+33 9 25 37 42 02","groupe_id":"b636c1fd-c61c-306b-9d4f-25cf3bfd9f66"}	{"id":"72a80ee4-aad1-3189-bb58-dfa638ff2af3","nom":"Adam","prenom":"Auguste","mail":"Auguste.Adam@yahoo.fr","telephone":"+33 9 25 37 42 02","groupe_id":"b636c1fd-c61c-306b-9d4f-25cf3bfd9f66"}	\N	\N
71	73	personnel	b9bedd1c-f8a8-3c65-b9ad-850b551cbecf	{"id":"b9bedd1c-f8a8-3c65-b9ad-850b551cbecf","nom":"Le Gall","prenom":"Denise","mail":"Denise.LeGall@wanadoo.fr","telephone":"04 48 54 51 31","groupe_id":"7db214d9-f415-3110-991b-ec5f9774b685"}	{"id":"b9bedd1c-f8a8-3c65-b9ad-850b551cbecf","nom":"Le Gall","prenom":"Denise","mail":"Denise.LeGall@wanadoo.fr","telephone":"04 48 54 51 31","groupe_id":"7db214d9-f415-3110-991b-ec5f9774b685"}	\N	\N
72	74	personnel	8fb66ad8-992b-3e5c-a98f-47eba3b7a62a	{"id":"8fb66ad8-992b-3e5c-a98f-47eba3b7a62a","nom":"Letellier","prenom":"Anne","mail":"Anne.Letellier@free.fr","telephone":"0549905440","groupe_id":"a51a0543-ee80-3515-81ab-2504ec194c09"}	{"id":"8fb66ad8-992b-3e5c-a98f-47eba3b7a62a","nom":"Letellier","prenom":"Anne","mail":"Anne.Letellier@free.fr","telephone":"0549905440","groupe_id":"a51a0543-ee80-3515-81ab-2504ec194c09"}	\N	\N
73	75	personnel	0e6d3926-be87-332c-94e0-cca0bdcfa3d6	{"id":"0e6d3926-be87-332c-94e0-cca0bdcfa3d6","nom":"Perret","prenom":"Madeleine","mail":"Madeleine.Perret@gmail.com","telephone":"0933106983","groupe_id":"a51a0543-ee80-3515-81ab-2504ec194c09"}	{"id":"0e6d3926-be87-332c-94e0-cca0bdcfa3d6","nom":"Perret","prenom":"Madeleine","mail":"Madeleine.Perret@gmail.com","telephone":"0933106983","groupe_id":"a51a0543-ee80-3515-81ab-2504ec194c09"}	\N	\N
74	76	personnel	57a31547-2e5a-3ab8-bf3e-97e5ecba6c88	{"id":"57a31547-2e5a-3ab8-bf3e-97e5ecba6c88","nom":"Vaillant","prenom":"Alphonse","mail":"Alphonse.Vaillant@hotmail.fr","telephone":"+33 (0)8 99 50 21 82","groupe_id":"a51a0543-ee80-3515-81ab-2504ec194c09"}	{"id":"57a31547-2e5a-3ab8-bf3e-97e5ecba6c88","nom":"Vaillant","prenom":"Alphonse","mail":"Alphonse.Vaillant@hotmail.fr","telephone":"+33 (0)8 99 50 21 82","groupe_id":"a51a0543-ee80-3515-81ab-2504ec194c09"}	\N	\N
75	77	personnel	a027a4d8-bf57-30d9-afd2-79bcfda90de2	{"id":"a027a4d8-bf57-30d9-afd2-79bcfda90de2","nom":"Masson","prenom":"Augustin","mail":"Augustin.Masson@laposte.net","telephone":"0455003959","groupe_id":"fe6e7644-9e58-3b57-9734-f201766d4d75"}	{"id":"a027a4d8-bf57-30d9-afd2-79bcfda90de2","nom":"Masson","prenom":"Augustin","mail":"Augustin.Masson@laposte.net","telephone":"0455003959","groupe_id":"fe6e7644-9e58-3b57-9734-f201766d4d75"}	\N	\N
76	78	personnel	ec62b359-705d-3717-82f3-561b2a4dda4d	{"id":"ec62b359-705d-3717-82f3-561b2a4dda4d","nom":"Mendes","prenom":"Théodore","mail":"Thodore.Mendes@dbmail.com","telephone":"+33 1 90 35 31 25","groupe_id":"fe6e7644-9e58-3b57-9734-f201766d4d75"}	{"id":"ec62b359-705d-3717-82f3-561b2a4dda4d","nom":"Mendes","prenom":"Théodore","mail":"Thodore.Mendes@dbmail.com","telephone":"+33 1 90 35 31 25","groupe_id":"fe6e7644-9e58-3b57-9734-f201766d4d75"}	\N	\N
77	79	personnel	ec79ebae-3041-3182-9ac7-676fac0a6419	{"id":"ec79ebae-3041-3182-9ac7-676fac0a6419","nom":"Seguin","prenom":"Roger","mail":"Roger.Seguin@sfr.fr","telephone":"+33 (0)8 95 55 77 02","groupe_id":"fe6e7644-9e58-3b57-9734-f201766d4d75"}	{"id":"ec79ebae-3041-3182-9ac7-676fac0a6419","nom":"Seguin","prenom":"Roger","mail":"Roger.Seguin@sfr.fr","telephone":"+33 (0)8 95 55 77 02","groupe_id":"fe6e7644-9e58-3b57-9734-f201766d4d75"}	\N	\N
78	80	personnel	e2b0ec67-79ed-3e0c-b73c-b43e615b0b8d	{"id":"e2b0ec67-79ed-3e0c-b73c-b43e615b0b8d","nom":"Gosselin","prenom":"Maryse","mail":"Maryse.Gosselin@gmail.com","telephone":"0808487843","groupe_id":"9117850b-3116-3d4f-b346-1dfc23c26787"}	{"id":"e2b0ec67-79ed-3e0c-b73c-b43e615b0b8d","nom":"Gosselin","prenom":"Maryse","mail":"Maryse.Gosselin@gmail.com","telephone":"0808487843","groupe_id":"9117850b-3116-3d4f-b346-1dfc23c26787"}	\N	\N
79	81	personnel	712eb55d-7b17-3a6e-8c50-44b6bc37959c	{"id":"712eb55d-7b17-3a6e-8c50-44b6bc37959c","nom":"Launay","prenom":"Luc","mail":"Luc.Launay@noos.fr","telephone":"+33 5 85 26 58 79","groupe_id":"9117850b-3116-3d4f-b346-1dfc23c26787"}	{"id":"712eb55d-7b17-3a6e-8c50-44b6bc37959c","nom":"Launay","prenom":"Luc","mail":"Luc.Launay@noos.fr","telephone":"+33 5 85 26 58 79","groupe_id":"9117850b-3116-3d4f-b346-1dfc23c26787"}	\N	\N
80	82	personnel	ade0a833-70b4-36f2-b938-22857e7da4c7	{"id":"ade0a833-70b4-36f2-b938-22857e7da4c7","nom":"Bouvet","prenom":"Constance","mail":"Constance.Bouvet@laposte.net","telephone":"+33 (0)4 92 53 63 01","groupe_id":"bee7989a-c204-3cf7-bbfc-42a9ce8456ea"}	{"id":"ade0a833-70b4-36f2-b938-22857e7da4c7","nom":"Bouvet","prenom":"Constance","mail":"Constance.Bouvet@laposte.net","telephone":"+33 (0)4 92 53 63 01","groupe_id":"bee7989a-c204-3cf7-bbfc-42a9ce8456ea"}	\N	\N
81	83	personnel	024e14c7-2f6b-3566-87e9-84f01d252bb1	{"id":"024e14c7-2f6b-3566-87e9-84f01d252bb1","nom":"Bousquet","prenom":"Paulette","mail":"Paulette.Bousquet@laposte.net","telephone":"0585162734","groupe_id":"bee7989a-c204-3cf7-bbfc-42a9ce8456ea"}	{"id":"024e14c7-2f6b-3566-87e9-84f01d252bb1","nom":"Bousquet","prenom":"Paulette","mail":"Paulette.Bousquet@laposte.net","telephone":"0585162734","groupe_id":"bee7989a-c204-3cf7-bbfc-42a9ce8456ea"}	\N	\N
82	84	personnel	fda644e6-62ed-3971-b5a7-44146b808a82	{"id":"fda644e6-62ed-3971-b5a7-44146b808a82","nom":"Collin","prenom":"Zacharie","mail":"Zacharie.Collin@noos.fr","telephone":"01 24 12 80 73","groupe_id":"bee7989a-c204-3cf7-bbfc-42a9ce8456ea"}	{"id":"fda644e6-62ed-3971-b5a7-44146b808a82","nom":"Collin","prenom":"Zacharie","mail":"Zacharie.Collin@noos.fr","telephone":"01 24 12 80 73","groupe_id":"bee7989a-c204-3cf7-bbfc-42a9ce8456ea"}	\N	\N
83	85	personnel	75d3e34b-e9a6-3494-bf39-d3e45f6c3653	{"id":"75d3e34b-e9a6-3494-bf39-d3e45f6c3653","nom":"Renaud","prenom":"Marcel","mail":"Marcel.Renaud@dbmail.com","telephone":"+33 7 40 35 32 48","groupe_id":"bee7989a-c204-3cf7-bbfc-42a9ce8456ea"}	{"id":"75d3e34b-e9a6-3494-bf39-d3e45f6c3653","nom":"Renaud","prenom":"Marcel","mail":"Marcel.Renaud@dbmail.com","telephone":"+33 7 40 35 32 48","groupe_id":"bee7989a-c204-3cf7-bbfc-42a9ce8456ea"}	\N	\N
84	86	personnel	ffc24e94-8981-3ed9-8019-fa8bd2e16001	{"id":"ffc24e94-8981-3ed9-8019-fa8bd2e16001","nom":"Vincent","prenom":"Isaac","mail":"Isaac.Vincent@dbmail.com","telephone":"+33 8 04 19 03 86","groupe_id":"55ee31cb-9fb6-3513-b209-e2804d02c11e"}	{"id":"ffc24e94-8981-3ed9-8019-fa8bd2e16001","nom":"Vincent","prenom":"Isaac","mail":"Isaac.Vincent@dbmail.com","telephone":"+33 8 04 19 03 86","groupe_id":"55ee31cb-9fb6-3513-b209-e2804d02c11e"}	\N	\N
85	87	praticiens	af7bb2f1-cc52-3388-b9bc-c0b89e7f4c5b	{"id":"af7bb2f1-cc52-3388-b9bc-c0b89e7f4c5b","nom":"Paul","prenom":"Marine","ville":"Paris","email":"Marine.Paul@hotmail.fr","telephone":"02 36 11 25 88","specialite_id":"1","groupe_id":"3444bdd2-8783-3aed-9a5e-4d298d2a2d7c"}	{"id":"af7bb2f1-cc52-3388-b9bc-c0b89e7f4c5b","nom":"Paul","prenom":"Marine","ville":"Paris","email":"Marine.Paul@hotmail.fr","telephone":"02 36 11 25 88","specialite_id":"1","groupe_id":"3444bdd2-8783-3aed-9a5e-4d298d2a2d7c"}	\N	\N
86	88	praticiens	b994a36f-794f-3ddc-b267-99673661466d	{"id":"b994a36f-794f-3ddc-b267-99673661466d","nom":"Guichard","prenom":"Laurence","ville":"Paris","email":"Laurence.Guichard@club-internet.fr","telephone":"+33 8 99 14 03 98","specialite_id":"1","groupe_id":"3444bdd2-8783-3aed-9a5e-4d298d2a2d7c"}	{"id":"b994a36f-794f-3ddc-b267-99673661466d","nom":"Guichard","prenom":"Laurence","ville":"Paris","email":"Laurence.Guichard@club-internet.fr","telephone":"+33 8 99 14 03 98","specialite_id":"1","groupe_id":"3444bdd2-8783-3aed-9a5e-4d298d2a2d7c"}	\N	\N
87	89	praticiens	8236bcbf-4c06-3d0e-8ab0-c4964e02c4ea	{"id":"8236bcbf-4c06-3d0e-8ab0-c4964e02c4ea","nom":"Pichon","prenom":"Arnaude","ville":"Paris","email":"Arnaude.Pichon@yahoo.fr","telephone":"06 61 50 63 81","specialite_id":"4","groupe_id":"3444bdd2-8783-3aed-9a5e-4d298d2a2d7c"}	{"id":"8236bcbf-4c06-3d0e-8ab0-c4964e02c4ea","nom":"Pichon","prenom":"Arnaude","ville":"Paris","email":"Arnaude.Pichon@yahoo.fr","telephone":"06 61 50 63 81","specialite_id":"4","groupe_id":"3444bdd2-8783-3aed-9a5e-4d298d2a2d7c"}	\N	\N
88	90	praticiens	8ae1400f-d46d-3b50-b356-269f776be532	{"id":"8ae1400f-d46d-3b50-b356-269f776be532","nom":"Klein","prenom":"Gabrielle","ville":"Paris","email":"Gabrielle.Klein@live.com","telephone":"+33 (0)3 90 27 98 80","specialite_id":"1","groupe_id":"3444bdd2-8783-3aed-9a5e-4d298d2a2d7c"}	{"id":"8ae1400f-d46d-3b50-b356-269f776be532","nom":"Klein","prenom":"Gabrielle","ville":"Paris","email":"Gabrielle.Klein@live.com","telephone":"+33 (0)3 90 27 98 80","specialite_id":"1","groupe_id":"3444bdd2-8783-3aed-9a5e-4d298d2a2d7c"}	\N	\N
89	91	praticiens	085c44e7-6245-3b10-9c1a-92f09524ef2a	{"id":"085c44e7-6245-3b10-9c1a-92f09524ef2a","nom":"Gallet","prenom":"Valérie","ville":"Paris","email":"Valrie.Gallet@dbmail.com","telephone":"+33 (0)9 29 33 51 05","specialite_id":"2","groupe_id":"3444bdd2-8783-3aed-9a5e-4d298d2a2d7c"}	{"id":"085c44e7-6245-3b10-9c1a-92f09524ef2a","nom":"Gallet","prenom":"Valérie","ville":"Paris","email":"Valrie.Gallet@dbmail.com","telephone":"+33 (0)9 29 33 51 05","specialite_id":"2","groupe_id":"3444bdd2-8783-3aed-9a5e-4d298d2a2d7c"}	\N	\N
90	92	praticiens	dada1285-f235-3ad2-bd7d-f58d68c30a73	{"id":"dada1285-f235-3ad2-bd7d-f58d68c30a73","nom":"Goncalves","prenom":"Noël","ville":"Paris","email":"Nol.Goncalves@free.fr","telephone":"+33 5 82 74 18 66","specialite_id":"2","groupe_id":"3444bdd2-8783-3aed-9a5e-4d298d2a2d7c"}	{"id":"dada1285-f235-3ad2-bd7d-f58d68c30a73","nom":"Goncalves","prenom":"Noël","ville":"Paris","email":"Nol.Goncalves@free.fr","telephone":"+33 5 82 74 18 66","specialite_id":"2","groupe_id":"3444bdd2-8783-3aed-9a5e-4d298d2a2d7c"}	\N	\N
91	93	praticiens	51c6c5a5-0815-3ff1-b0e4-ac216319e526	{"id":"51c6c5a5-0815-3ff1-b0e4-ac216319e526","nom":"Besson","prenom":"Aurélie","ville":"Joubert","email":"Aurlie.Besson@gmail.com","telephone":"+33 (0)3 76 13 23 05","specialite_id":"3","groupe_id":"372c1de7-4d31-3d01-9c92-77e69467d4e3"}	{"id":"51c6c5a5-0815-3ff1-b0e4-ac216319e526","nom":"Besson","prenom":"Aurélie","ville":"Joubert","email":"Aurlie.Besson@gmail.com","telephone":"+33 (0)3 76 13 23 05","specialite_id":"3","groupe_id":"372c1de7-4d31-3d01-9c92-77e69467d4e3"}	\N	\N
92	94	praticiens	592692c8-4a8c-3f91-967b-fde67ebea54d	{"id":"592692c8-4a8c-3f91-967b-fde67ebea54d","nom":"Costa","prenom":"Marc","ville":"Joubert","email":"Marc.Costa@wanadoo.fr","telephone":"+33 1 42 89 11 30","specialite_id":"3","groupe_id":"372c1de7-4d31-3d01-9c92-77e69467d4e3"}	{"id":"592692c8-4a8c-3f91-967b-fde67ebea54d","nom":"Costa","prenom":"Marc","ville":"Joubert","email":"Marc.Costa@wanadoo.fr","telephone":"+33 1 42 89 11 30","specialite_id":"3","groupe_id":"372c1de7-4d31-3d01-9c92-77e69467d4e3"}	\N	\N
93	95	praticiens	0768e78b-12c8-3694-b89b-d0a7451a8fb1	{"id":"0768e78b-12c8-3694-b89b-d0a7451a8fb1","nom":"Descamps","prenom":"Alexandria","ville":"Joubert","email":"Alexandria.Descamps@club-internet.fr","telephone":"+33 (0)1 75 74 98 33","specialite_id":"4","groupe_id":"372c1de7-4d31-3d01-9c92-77e69467d4e3"}	{"id":"0768e78b-12c8-3694-b89b-d0a7451a8fb1","nom":"Descamps","prenom":"Alexandria","ville":"Joubert","email":"Alexandria.Descamps@club-internet.fr","telephone":"+33 (0)1 75 74 98 33","specialite_id":"4","groupe_id":"372c1de7-4d31-3d01-9c92-77e69467d4e3"}	\N	\N
94	96	praticiens	f9bd589a-99ef-39f7-9984-af26e95c7150	{"id":"f9bd589a-99ef-39f7-9984-af26e95c7150","nom":"Roger","prenom":"Philippine","ville":"Diaz-sur-Boulanger","email":"Philippine.Roger@hotmail.fr","telephone":"0815977032","specialite_id":"5","groupe_id":"255ecef6-14b9-3b5c-a40e-901665f4ed28"}	{"id":"f9bd589a-99ef-39f7-9984-af26e95c7150","nom":"Roger","prenom":"Philippine","ville":"Diaz-sur-Boulanger","email":"Philippine.Roger@hotmail.fr","telephone":"0815977032","specialite_id":"5","groupe_id":"255ecef6-14b9-3b5c-a40e-901665f4ed28"}	\N	\N
95	97	praticiens	bdd2672d-f4e6-3fd1-88db-d27e97b4d1e0	{"id":"bdd2672d-f4e6-3fd1-88db-d27e97b4d1e0","nom":"Martel","prenom":"Denise","ville":"Diaz-sur-Boulanger","email":"Denise.Martel@tele2.fr","telephone":"+33 1 57 80 28 75","specialite_id":"2","groupe_id":"255ecef6-14b9-3b5c-a40e-901665f4ed28"}	{"id":"bdd2672d-f4e6-3fd1-88db-d27e97b4d1e0","nom":"Martel","prenom":"Denise","ville":"Diaz-sur-Boulanger","email":"Denise.Martel@tele2.fr","telephone":"+33 1 57 80 28 75","specialite_id":"2","groupe_id":"255ecef6-14b9-3b5c-a40e-901665f4ed28"}	\N	\N
96	98	praticiens	7c76c93d-1b70-35eb-96d5-34c2d9d741c4	{"id":"7c76c93d-1b70-35eb-96d5-34c2d9d741c4","nom":"Marchand","prenom":"Suzanne","ville":"Diaz-sur-Boulanger","email":"Suzanne.Marchand@sfr.fr","telephone":"+33 (0)2 83 66 69 68","specialite_id":"4","groupe_id":"255ecef6-14b9-3b5c-a40e-901665f4ed28"}	{"id":"7c76c93d-1b70-35eb-96d5-34c2d9d741c4","nom":"Marchand","prenom":"Suzanne","ville":"Diaz-sur-Boulanger","email":"Suzanne.Marchand@sfr.fr","telephone":"+33 (0)2 83 66 69 68","specialite_id":"4","groupe_id":"255ecef6-14b9-3b5c-a40e-901665f4ed28"}	\N	\N
97	99	praticiens	656c9034-bf19-33a0-beec-9a959ee83cd7	{"id":"656c9034-bf19-33a0-beec-9a959ee83cd7","nom":"Parent","prenom":"Tristan","ville":"Lucas","email":"Tristan.Parent@laposte.net","telephone":"+33 (0)2 81 93 20 11","specialite_id":"5","groupe_id":"80756589-93f3-3ab7-92dd-377dbea5ea4d"}	{"id":"656c9034-bf19-33a0-beec-9a959ee83cd7","nom":"Parent","prenom":"Tristan","ville":"Lucas","email":"Tristan.Parent@laposte.net","telephone":"+33 (0)2 81 93 20 11","specialite_id":"5","groupe_id":"80756589-93f3-3ab7-92dd-377dbea5ea4d"}	\N	\N
98	100	praticiens	2ae94f01-8332-3c16-bf4c-eb1d64929253	{"id":"2ae94f01-8332-3c16-bf4c-eb1d64929253","nom":"Joly","prenom":"Patricia","ville":"Lucas","email":"Patricia.Joly@gmail.com","telephone":"+33 4 24 93 22 37","specialite_id":"5","groupe_id":"80756589-93f3-3ab7-92dd-377dbea5ea4d"}	{"id":"2ae94f01-8332-3c16-bf4c-eb1d64929253","nom":"Joly","prenom":"Patricia","ville":"Lucas","email":"Patricia.Joly@gmail.com","telephone":"+33 4 24 93 22 37","specialite_id":"5","groupe_id":"80756589-93f3-3ab7-92dd-377dbea5ea4d"}	\N	\N
99	101	praticiens	68202db3-920d-35dc-b547-e52c53ec5885	{"id":"68202db3-920d-35dc-b547-e52c53ec5885","nom":"Meunier","prenom":"Michelle","ville":"Lucas","email":"Michelle.Meunier@noos.fr","telephone":"08 97 18 92 13","specialite_id":"1","groupe_id":"80756589-93f3-3ab7-92dd-377dbea5ea4d"}	{"id":"68202db3-920d-35dc-b547-e52c53ec5885","nom":"Meunier","prenom":"Michelle","ville":"Lucas","email":"Michelle.Meunier@noos.fr","telephone":"08 97 18 92 13","specialite_id":"1","groupe_id":"80756589-93f3-3ab7-92dd-377dbea5ea4d"}	\N	\N
100	102	praticiens	3eeec083-d6fe-3cf7-b0da-e2b09a261db9	{"id":"3eeec083-d6fe-3cf7-b0da-e2b09a261db9","nom":"Barbier","prenom":"Claude","ville":"Carre-sur-Turpin","email":"Claude.Barbier@wanadoo.fr","telephone":"+33 (0)7 69 71 23 39","specialite_id":"1","groupe_id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19"}	{"id":"3eeec083-d6fe-3cf7-b0da-e2b09a261db9","nom":"Barbier","prenom":"Claude","ville":"Carre-sur-Turpin","email":"Claude.Barbier@wanadoo.fr","telephone":"+33 (0)7 69 71 23 39","specialite_id":"1","groupe_id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19"}	\N	\N
101	103	praticiens	529fa71e-5a6c-3360-9579-81abc41e865f	{"id":"529fa71e-5a6c-3360-9579-81abc41e865f","nom":"Aubert","prenom":"Louis","ville":"Carre-sur-Turpin","email":"Louis.Aubert@free.fr","telephone":"+33 7 68 13 29 54","specialite_id":"3","groupe_id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19"}	{"id":"529fa71e-5a6c-3360-9579-81abc41e865f","nom":"Aubert","prenom":"Louis","ville":"Carre-sur-Turpin","email":"Louis.Aubert@free.fr","telephone":"+33 7 68 13 29 54","specialite_id":"3","groupe_id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19"}	\N	\N
102	104	praticiens	e6f97aad-b672-3407-92ac-54b26d95d628	{"id":"e6f97aad-b672-3407-92ac-54b26d95d628","nom":"Berger","prenom":"Olivie","ville":"Carre-sur-Turpin","email":"Olivie.Berger@sfr.fr","telephone":"0421147513","specialite_id":"4","groupe_id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19"}	{"id":"e6f97aad-b672-3407-92ac-54b26d95d628","nom":"Berger","prenom":"Olivie","ville":"Carre-sur-Turpin","email":"Olivie.Berger@sfr.fr","telephone":"0421147513","specialite_id":"4","groupe_id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19"}	\N	\N
103	105	praticiens	05644ac0-c4cb-36bf-a0cf-409075eb20c4	{"id":"05644ac0-c4cb-36bf-a0cf-409075eb20c4","nom":"Leduc","prenom":"Aimée","ville":"Carre-sur-Turpin","email":"Aime.Leduc@laposte.net","telephone":"+33 (0)4 85 19 99 00","specialite_id":"4","groupe_id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19"}	{"id":"05644ac0-c4cb-36bf-a0cf-409075eb20c4","nom":"Leduc","prenom":"Aimée","ville":"Carre-sur-Turpin","email":"Aime.Leduc@laposte.net","telephone":"+33 (0)4 85 19 99 00","specialite_id":"4","groupe_id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19"}	\N	\N
104	106	praticiens	c7c71a7a-d6e1-3aa3-8aa8-987cbef516b0	{"id":"c7c71a7a-d6e1-3aa3-8aa8-987cbef516b0","nom":"Mendes","prenom":"Jean","ville":"Carre-sur-Turpin","email":"Jean.Mendes@wanadoo.fr","telephone":"0220429087","specialite_id":"1","groupe_id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19"}	{"id":"c7c71a7a-d6e1-3aa3-8aa8-987cbef516b0","nom":"Mendes","prenom":"Jean","ville":"Carre-sur-Turpin","email":"Jean.Mendes@wanadoo.fr","telephone":"0220429087","specialite_id":"1","groupe_id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19"}	\N	\N
105	107	praticiens	d7e254f4-7e01-395a-b668-6f86e3444906	{"id":"d7e254f4-7e01-395a-b668-6f86e3444906","nom":"Legros","prenom":"Louis","ville":"Carre-sur-Turpin","email":"Louis.Legros@club-internet.fr","telephone":"02 23 75 20 59","specialite_id":"5","groupe_id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19"}	{"id":"d7e254f4-7e01-395a-b668-6f86e3444906","nom":"Legros","prenom":"Louis","ville":"Carre-sur-Turpin","email":"Louis.Legros@club-internet.fr","telephone":"02 23 75 20 59","specialite_id":"5","groupe_id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19"}	\N	\N
106	108	praticiens	41ac1467-4874-3e88-a636-444eae7dc457	{"id":"41ac1467-4874-3e88-a636-444eae7dc457","nom":"Blanc","prenom":"Rémy","ville":"Carre-sur-Turpin","email":"Rmy.Blanc@sfr.fr","telephone":"+33 (0)6 34 60 92 42","specialite_id":"5","groupe_id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19"}	{"id":"41ac1467-4874-3e88-a636-444eae7dc457","nom":"Blanc","prenom":"Rémy","ville":"Carre-sur-Turpin","email":"Rmy.Blanc@sfr.fr","telephone":"+33 (0)6 34 60 92 42","specialite_id":"5","groupe_id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19"}	\N	\N
107	109	praticiens	15d3e128-b47c-3030-a1c8-cfb09942054a	{"id":"15d3e128-b47c-3030-a1c8-cfb09942054a","nom":"Pascal","prenom":"Gilles","ville":"Carre-sur-Turpin","email":"Gilles.Pascal@sfr.fr","telephone":"08 12 96 04 73","specialite_id":"5","groupe_id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19"}	{"id":"15d3e128-b47c-3030-a1c8-cfb09942054a","nom":"Pascal","prenom":"Gilles","ville":"Carre-sur-Turpin","email":"Gilles.Pascal@sfr.fr","telephone":"08 12 96 04 73","specialite_id":"5","groupe_id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19"}	\N	\N
108	110	praticiens	9b4aa9d2-fb6a-3e07-9b5a-a792ffb4b3f3	{"id":"9b4aa9d2-fb6a-3e07-9b5a-a792ffb4b3f3","nom":"Huet","prenom":"Jacqueline","ville":"Carre-sur-Turpin","email":"Jacqueline.Huet@tele2.fr","telephone":"01 58 91 85 40","specialite_id":"1","groupe_id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19"}	{"id":"9b4aa9d2-fb6a-3e07-9b5a-a792ffb4b3f3","nom":"Huet","prenom":"Jacqueline","ville":"Carre-sur-Turpin","email":"Jacqueline.Huet@tele2.fr","telephone":"01 58 91 85 40","specialite_id":"1","groupe_id":"5f7d3d80-3c4b-386a-a23e-74de4a1e0b19"}	\N	\N
109	111	praticiens	905735e4-bd41-3991-8462-0b21a962ecc9	{"id":"905735e4-bd41-3991-8462-0b21a962ecc9","nom":"Seguin","prenom":"Audrey","ville":"Moreno","email":"Audrey.Seguin@laposte.net","telephone":"0184365032","specialite_id":"2","groupe_id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9"}	{"id":"905735e4-bd41-3991-8462-0b21a962ecc9","nom":"Seguin","prenom":"Audrey","ville":"Moreno","email":"Audrey.Seguin@laposte.net","telephone":"0184365032","specialite_id":"2","groupe_id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9"}	\N	\N
110	112	praticiens	03f24d7b-efda-3fbe-ae53-0c0c0edef089	{"id":"03f24d7b-efda-3fbe-ae53-0c0c0edef089","nom":"Grenier","prenom":"Josette","ville":"Moreno","email":"Josette.Grenier@wanadoo.fr","telephone":"06 43 92 58 43","specialite_id":"2","groupe_id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9"}	{"id":"03f24d7b-efda-3fbe-ae53-0c0c0edef089","nom":"Grenier","prenom":"Josette","ville":"Moreno","email":"Josette.Grenier@wanadoo.fr","telephone":"06 43 92 58 43","specialite_id":"2","groupe_id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9"}	\N	\N
111	113	praticiens	8b34ba8b-5775-31a9-9ca6-1cf955c9ab84	{"id":"8b34ba8b-5775-31a9-9ca6-1cf955c9ab84","nom":"Le Roux","prenom":"Bernadette","ville":"Moreno","email":"Bernadette.LeRoux@laposte.net","telephone":"02 01 42 83 17","specialite_id":"2","groupe_id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9"}	{"id":"8b34ba8b-5775-31a9-9ca6-1cf955c9ab84","nom":"Le Roux","prenom":"Bernadette","ville":"Moreno","email":"Bernadette.LeRoux@laposte.net","telephone":"02 01 42 83 17","specialite_id":"2","groupe_id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9"}	\N	\N
112	114	praticiens	b0458f20-e264-3ab4-8153-47268dd936bc	{"id":"b0458f20-e264-3ab4-8153-47268dd936bc","nom":"Delattre","prenom":"Andrée","ville":"Moreno","email":"Andre.Delattre@dbmail.com","telephone":"+33 6 03 08 18 43","specialite_id":"2","groupe_id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9"}	{"id":"b0458f20-e264-3ab4-8153-47268dd936bc","nom":"Delattre","prenom":"Andrée","ville":"Moreno","email":"Andre.Delattre@dbmail.com","telephone":"+33 6 03 08 18 43","specialite_id":"2","groupe_id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9"}	\N	\N
113	115	praticiens	3688814f-1b08-313b-8287-18febcc544d6	{"id":"3688814f-1b08-313b-8287-18febcc544d6","nom":"Leleu","prenom":"Josette","ville":"Moreno","email":"Josette.Leleu@sfr.fr","telephone":"+33 (0)1 48 67 86 03","specialite_id":"2","groupe_id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9"}	{"id":"3688814f-1b08-313b-8287-18febcc544d6","nom":"Leleu","prenom":"Josette","ville":"Moreno","email":"Josette.Leleu@sfr.fr","telephone":"+33 (0)1 48 67 86 03","specialite_id":"2","groupe_id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9"}	\N	\N
114	116	praticiens	b05657bc-ecf5-3a76-960a-c20e41af60a0	{"id":"b05657bc-ecf5-3a76-960a-c20e41af60a0","nom":"Vasseur","prenom":"Corinne","ville":"Moreno","email":"Corinne.Vasseur@sfr.fr","telephone":"0977376152","specialite_id":"2","groupe_id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9"}	{"id":"b05657bc-ecf5-3a76-960a-c20e41af60a0","nom":"Vasseur","prenom":"Corinne","ville":"Moreno","email":"Corinne.Vasseur@sfr.fr","telephone":"0977376152","specialite_id":"2","groupe_id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9"}	\N	\N
115	117	praticiens	2192c51f-1d1f-3d76-88ed-6a25abed0faf	{"id":"2192c51f-1d1f-3d76-88ed-6a25abed0faf","nom":"Pelletier","prenom":"Alexandrie","ville":"Moreno","email":"Alexandrie.Pelletier@live.com","telephone":"+33 (0)6 73 60 47 41","specialite_id":"2","groupe_id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9"}	{"id":"2192c51f-1d1f-3d76-88ed-6a25abed0faf","nom":"Pelletier","prenom":"Alexandrie","ville":"Moreno","email":"Alexandrie.Pelletier@live.com","telephone":"+33 (0)6 73 60 47 41","specialite_id":"2","groupe_id":"c302d11b-d5b8-310a-bbc5-9dd4400eb2c9"}	\N	\N
116	118	praticiens	3dc3ed9e-b07e-3cb7-81c4-6607d11f20ca	{"id":"3dc3ed9e-b07e-3cb7-81c4-6607d11f20ca","nom":"Dufour","prenom":"Thibaut","ville":"Lefevre","email":"Thibaut.Dufour@club-internet.fr","telephone":"01 70 44 52 00","specialite_id":"2","groupe_id":"b636c1fd-c61c-306b-9d4f-25cf3bfd9f66"}	{"id":"3dc3ed9e-b07e-3cb7-81c4-6607d11f20ca","nom":"Dufour","prenom":"Thibaut","ville":"Lefevre","email":"Thibaut.Dufour@club-internet.fr","telephone":"01 70 44 52 00","specialite_id":"2","groupe_id":"b636c1fd-c61c-306b-9d4f-25cf3bfd9f66"}	\N	\N
117	119	praticiens	a63afd36-5682-3ad1-971f-447c6fd45180	{"id":"a63afd36-5682-3ad1-971f-447c6fd45180","nom":"Denis","prenom":"Adèle","ville":"Lefevre","email":"Adle.Denis@laposte.net","telephone":"+33 2 53 67 28 62","specialite_id":"2","groupe_id":"b636c1fd-c61c-306b-9d4f-25cf3bfd9f66"}	{"id":"a63afd36-5682-3ad1-971f-447c6fd45180","nom":"Denis","prenom":"Adèle","ville":"Lefevre","email":"Adle.Denis@laposte.net","telephone":"+33 2 53 67 28 62","specialite_id":"2","groupe_id":"b636c1fd-c61c-306b-9d4f-25cf3bfd9f66"}	\N	\N
118	120	praticiens	4d4680e8-b362-3ccc-93f0-69ba51d40e67	{"id":"4d4680e8-b362-3ccc-93f0-69ba51d40e67","nom":"Foucher","prenom":"Anne","ville":"Lefevre","email":"Anne.Foucher@club-internet.fr","telephone":"+33 5 53 70 29 91","specialite_id":"2","groupe_id":"b636c1fd-c61c-306b-9d4f-25cf3bfd9f66"}	{"id":"4d4680e8-b362-3ccc-93f0-69ba51d40e67","nom":"Foucher","prenom":"Anne","ville":"Lefevre","email":"Anne.Foucher@club-internet.fr","telephone":"+33 5 53 70 29 91","specialite_id":"2","groupe_id":"b636c1fd-c61c-306b-9d4f-25cf3bfd9f66"}	\N	\N
119	121	praticiens	da903aa3-21c2-3631-a08b-d8d054cccb48	{"id":"da903aa3-21c2-3631-a08b-d8d054cccb48","nom":"David","prenom":"Susanne","ville":"Lefevre","email":"Susanne.David@hotmail.fr","telephone":"+33 (0)1 52 84 03 11","specialite_id":"2","groupe_id":"b636c1fd-c61c-306b-9d4f-25cf3bfd9f66"}	{"id":"da903aa3-21c2-3631-a08b-d8d054cccb48","nom":"David","prenom":"Susanne","ville":"Lefevre","email":"Susanne.David@hotmail.fr","telephone":"+33 (0)1 52 84 03 11","specialite_id":"2","groupe_id":"b636c1fd-c61c-306b-9d4f-25cf3bfd9f66"}	\N	\N
120	122	praticiens	c29223af-0dbe-3bba-8069-65743a4ae8b4	{"id":"c29223af-0dbe-3bba-8069-65743a4ae8b4","nom":"Faivre","prenom":"Laure","ville":"Lefevre","email":"Laure.Faivre@sfr.fr","telephone":"+33 2 50 47 37 95","specialite_id":"2","groupe_id":"b636c1fd-c61c-306b-9d4f-25cf3bfd9f66"}	{"id":"c29223af-0dbe-3bba-8069-65743a4ae8b4","nom":"Faivre","prenom":"Laure","ville":"Lefevre","email":"Laure.Faivre@sfr.fr","telephone":"+33 2 50 47 37 95","specialite_id":"2","groupe_id":"b636c1fd-c61c-306b-9d4f-25cf3bfd9f66"}	\N	\N
121	123	praticiens	a960bb57-cf39-3636-9f6d-3ef52834ecfc	{"id":"a960bb57-cf39-3636-9f6d-3ef52834ecfc","nom":"Parent","prenom":"Marc","ville":"Lefevre","email":"Marc.Parent@dbmail.com","telephone":"08 92 01 83 29","specialite_id":"2","groupe_id":"b636c1fd-c61c-306b-9d4f-25cf3bfd9f66"}	{"id":"a960bb57-cf39-3636-9f6d-3ef52834ecfc","nom":"Parent","prenom":"Marc","ville":"Lefevre","email":"Marc.Parent@dbmail.com","telephone":"08 92 01 83 29","specialite_id":"2","groupe_id":"b636c1fd-c61c-306b-9d4f-25cf3bfd9f66"}	\N	\N
122	124	praticiens	f524d70d-0f02-3747-a6fb-8d6db043210e	{"id":"f524d70d-0f02-3747-a6fb-8d6db043210e","nom":"Valette","prenom":"René","ville":"Lefevre","email":"Ren.Valette@orange.fr","telephone":"0784754050","specialite_id":"2","groupe_id":"b636c1fd-c61c-306b-9d4f-25cf3bfd9f66"}	{"id":"f524d70d-0f02-3747-a6fb-8d6db043210e","nom":"Valette","prenom":"René","ville":"Lefevre","email":"Ren.Valette@orange.fr","telephone":"0784754050","specialite_id":"2","groupe_id":"b636c1fd-c61c-306b-9d4f-25cf3bfd9f66"}	\N	\N
123	125	praticiens	98cf3e54-0cb8-33f0-beae-2fad5ff62bdf	{"id":"98cf3e54-0cb8-33f0-beae-2fad5ff62bdf","nom":"Le Gall","prenom":"Michelle","ville":"Lefevre","email":"Michelle.LeGall@free.fr","telephone":"0293390604","specialite_id":"2","groupe_id":"b636c1fd-c61c-306b-9d4f-25cf3bfd9f66"}	{"id":"98cf3e54-0cb8-33f0-beae-2fad5ff62bdf","nom":"Le Gall","prenom":"Michelle","ville":"Lefevre","email":"Michelle.LeGall@free.fr","telephone":"0293390604","specialite_id":"2","groupe_id":"b636c1fd-c61c-306b-9d4f-25cf3bfd9f66"}	\N	\N
124	126	praticiens	794f6ea3-9801-334b-ba82-4ac71f70f6d2	{"id":"794f6ea3-9801-334b-ba82-4ac71f70f6d2","nom":"Marechal","prenom":"Inès","ville":"Bourdon-les-Bains","email":"Ins.Marechal@wanadoo.fr","telephone":"0469478837","specialite_id":"2","groupe_id":"7db214d9-f415-3110-991b-ec5f9774b685"}	{"id":"794f6ea3-9801-334b-ba82-4ac71f70f6d2","nom":"Marechal","prenom":"Inès","ville":"Bourdon-les-Bains","email":"Ins.Marechal@wanadoo.fr","telephone":"0469478837","specialite_id":"2","groupe_id":"7db214d9-f415-3110-991b-ec5f9774b685"}	\N	\N
125	127	praticiens	e274a3f8-50b3-37c7-a061-333110a1560b	{"id":"e274a3f8-50b3-37c7-a061-333110a1560b","nom":"Imbert","prenom":"Nicolas","ville":"Bourdon-les-Bains","email":"Nicolas.Imbert@orange.fr","telephone":"0947411224","specialite_id":"2","groupe_id":"7db214d9-f415-3110-991b-ec5f9774b685"}	{"id":"e274a3f8-50b3-37c7-a061-333110a1560b","nom":"Imbert","prenom":"Nicolas","ville":"Bourdon-les-Bains","email":"Nicolas.Imbert@orange.fr","telephone":"0947411224","specialite_id":"2","groupe_id":"7db214d9-f415-3110-991b-ec5f9774b685"}	\N	\N
126	128	praticiens	7edb1b5e-eeaa-358e-84c5-1b66fc2fec2d	{"id":"7edb1b5e-eeaa-358e-84c5-1b66fc2fec2d","nom":"Thierry","prenom":"Matthieu","ville":"Bourdon-les-Bains","email":"Matthieu.Thierry@orange.fr","telephone":"03 87 04 84 55","specialite_id":"2","groupe_id":"7db214d9-f415-3110-991b-ec5f9774b685"}	{"id":"7edb1b5e-eeaa-358e-84c5-1b66fc2fec2d","nom":"Thierry","prenom":"Matthieu","ville":"Bourdon-les-Bains","email":"Matthieu.Thierry@orange.fr","telephone":"03 87 04 84 55","specialite_id":"2","groupe_id":"7db214d9-f415-3110-991b-ec5f9774b685"}	\N	\N
127	129	praticiens	609bc828-4d34-3bb2-b527-93d80478d6b3	{"id":"609bc828-4d34-3bb2-b527-93d80478d6b3","nom":"Gilbert","prenom":"Adrien","ville":"Bourdon-les-Bains","email":"Adrien.Gilbert@live.com","telephone":"0897878909","specialite_id":"2","groupe_id":"7db214d9-f415-3110-991b-ec5f9774b685"}	{"id":"609bc828-4d34-3bb2-b527-93d80478d6b3","nom":"Gilbert","prenom":"Adrien","ville":"Bourdon-les-Bains","email":"Adrien.Gilbert@live.com","telephone":"0897878909","specialite_id":"2","groupe_id":"7db214d9-f415-3110-991b-ec5f9774b685"}	\N	\N
128	130	praticiens	341453e4-c122-3028-a712-af7ddad67975	{"id":"341453e4-c122-3028-a712-af7ddad67975","nom":"Marin","prenom":"Isaac","ville":"Bourdon-les-Bains","email":"Isaac.Marin@live.com","telephone":"0136647915","specialite_id":"2","groupe_id":"7db214d9-f415-3110-991b-ec5f9774b685"}	{"id":"341453e4-c122-3028-a712-af7ddad67975","nom":"Marin","prenom":"Isaac","ville":"Bourdon-les-Bains","email":"Isaac.Marin@live.com","telephone":"0136647915","specialite_id":"2","groupe_id":"7db214d9-f415-3110-991b-ec5f9774b685"}	\N	\N
129	131	praticiens	e3ba8e27-6ce8-38d8-bdbc-54c53259036f	{"id":"e3ba8e27-6ce8-38d8-bdbc-54c53259036f","nom":"Leduc","prenom":"Caroline","ville":"Bourdon-les-Bains","email":"Caroline.Leduc@noos.fr","telephone":"04 17 24 73 44","specialite_id":"2","groupe_id":"7db214d9-f415-3110-991b-ec5f9774b685"}	{"id":"e3ba8e27-6ce8-38d8-bdbc-54c53259036f","nom":"Leduc","prenom":"Caroline","ville":"Bourdon-les-Bains","email":"Caroline.Leduc@noos.fr","telephone":"04 17 24 73 44","specialite_id":"2","groupe_id":"7db214d9-f415-3110-991b-ec5f9774b685"}	\N	\N
130	132	praticiens	fd23b913-b526-3b02-bf44-0dd2b25796bb	{"id":"fd23b913-b526-3b02-bf44-0dd2b25796bb","nom":"Langlois","prenom":"Stéphanie","ville":"Bourdon-les-Bains","email":"Stphanie.Langlois@tele2.fr","telephone":"07 31 50 72 40","specialite_id":"2","groupe_id":"7db214d9-f415-3110-991b-ec5f9774b685"}	{"id":"fd23b913-b526-3b02-bf44-0dd2b25796bb","nom":"Langlois","prenom":"Stéphanie","ville":"Bourdon-les-Bains","email":"Stphanie.Langlois@tele2.fr","telephone":"07 31 50 72 40","specialite_id":"2","groupe_id":"7db214d9-f415-3110-991b-ec5f9774b685"}	\N	\N
131	133	praticiens	dfe8a45d-1122-361c-bf96-fffae0d385f2	{"id":"dfe8a45d-1122-361c-bf96-fffae0d385f2","nom":"Fournier","prenom":"Bernard","ville":"Thierry-les-Bains","email":"Bernard.Fournier@hotmail.fr","telephone":"+33 8 02 69 97 34","specialite_id":"5","groupe_id":"a51a0543-ee80-3515-81ab-2504ec194c09"}	{"id":"dfe8a45d-1122-361c-bf96-fffae0d385f2","nom":"Fournier","prenom":"Bernard","ville":"Thierry-les-Bains","email":"Bernard.Fournier@hotmail.fr","telephone":"+33 8 02 69 97 34","specialite_id":"5","groupe_id":"a51a0543-ee80-3515-81ab-2504ec194c09"}	\N	\N
132	134	praticiens	a7cc5d8f-360c-3334-a992-6e9008c07c47	{"id":"a7cc5d8f-360c-3334-a992-6e9008c07c47","nom":"Gautier","prenom":"Adrien","ville":"Etienne","email":"Adrien.Gautier@orange.fr","telephone":"+33 (0)5 44 24 38 22","specialite_id":"5","groupe_id":"a51a0543-ee80-3515-81ab-2504ec194c09"}	{"id":"a7cc5d8f-360c-3334-a992-6e9008c07c47","nom":"Gautier","prenom":"Adrien","ville":"Etienne","email":"Adrien.Gautier@orange.fr","telephone":"+33 (0)5 44 24 38 22","specialite_id":"5","groupe_id":"a51a0543-ee80-3515-81ab-2504ec194c09"}	\N	\N
133	135	praticiens	e5f6cdd3-e9de-3c30-84b9-2d431c0d853f	{"id":"e5f6cdd3-e9de-3c30-84b9-2d431c0d853f","nom":"Pelletier","prenom":"Michelle","ville":"Boutin-les-Bains","email":"Michelle.Pelletier@wanadoo.fr","telephone":"01 57 96 73 69","specialite_id":"3","groupe_id":"a51a0543-ee80-3515-81ab-2504ec194c09"}	{"id":"e5f6cdd3-e9de-3c30-84b9-2d431c0d853f","nom":"Pelletier","prenom":"Michelle","ville":"Boutin-les-Bains","email":"Michelle.Pelletier@wanadoo.fr","telephone":"01 57 96 73 69","specialite_id":"3","groupe_id":"a51a0543-ee80-3515-81ab-2504ec194c09"}	\N	\N
134	136	praticiens	623b83ab-46b9-3cf3-8e04-3bb514cb059f	{"id":"623b83ab-46b9-3cf3-8e04-3bb514cb059f","nom":"Lucas","prenom":"Gilbert","ville":"Leconte-la-Forêt","email":"Gilbert.Lucas@live.com","telephone":"+33 (0)9 31 70 40 84","specialite_id":"1","groupe_id":"a51a0543-ee80-3515-81ab-2504ec194c09"}	{"id":"623b83ab-46b9-3cf3-8e04-3bb514cb059f","nom":"Lucas","prenom":"Gilbert","ville":"Leconte-la-Forêt","email":"Gilbert.Lucas@live.com","telephone":"+33 (0)9 31 70 40 84","specialite_id":"1","groupe_id":"a51a0543-ee80-3515-81ab-2504ec194c09"}	\N	\N
135	137	praticiens	7c57a60f-936a-3b48-884b-dd00fa4f3e0f	{"id":"7c57a60f-936a-3b48-884b-dd00fa4f3e0f","nom":"Perrier","prenom":"Anouk","ville":"Bernard","email":"Anouk.Perrier@dbmail.com","telephone":"0929092296","specialite_id":"5","groupe_id":"a51a0543-ee80-3515-81ab-2504ec194c09"}	{"id":"7c57a60f-936a-3b48-884b-dd00fa4f3e0f","nom":"Perrier","prenom":"Anouk","ville":"Bernard","email":"Anouk.Perrier@dbmail.com","telephone":"0929092296","specialite_id":"5","groupe_id":"a51a0543-ee80-3515-81ab-2504ec194c09"}	\N	\N
136	138	praticiens	a5c30f27-6100-373f-b291-df93927b5899	{"id":"a5c30f27-6100-373f-b291-df93927b5899","nom":"Besson","prenom":"Susan","ville":"Gillet-la-Forêt","email":"Susan.Besson@sfr.fr","telephone":"01 05 65 13 02","specialite_id":"1","groupe_id":"fe6e7644-9e58-3b57-9734-f201766d4d75"}	{"id":"a5c30f27-6100-373f-b291-df93927b5899","nom":"Besson","prenom":"Susan","ville":"Gillet-la-Forêt","email":"Susan.Besson@sfr.fr","telephone":"01 05 65 13 02","specialite_id":"1","groupe_id":"fe6e7644-9e58-3b57-9734-f201766d4d75"}	\N	\N
137	139	praticiens	95b1d811-22c6-3c4e-94fb-69dc3bd0522a	{"id":"95b1d811-22c6-3c4e-94fb-69dc3bd0522a","nom":"Hamel","prenom":"Paulette","ville":"BriandBourg","email":"Paulette.Hamel@free.fr","telephone":"0115534998","specialite_id":"2","groupe_id":"fe6e7644-9e58-3b57-9734-f201766d4d75"}	{"id":"95b1d811-22c6-3c4e-94fb-69dc3bd0522a","nom":"Hamel","prenom":"Paulette","ville":"BriandBourg","email":"Paulette.Hamel@free.fr","telephone":"0115534998","specialite_id":"2","groupe_id":"fe6e7644-9e58-3b57-9734-f201766d4d75"}	\N	\N
138	140	praticiens	33448c5c-ba4f-366b-88f4-95aec59b982d	{"id":"33448c5c-ba4f-366b-88f4-95aec59b982d","nom":"Leclerc","prenom":"Louis","ville":"Francois","email":"Louis.Leclerc@noos.fr","telephone":"0653433149","specialite_id":"5","groupe_id":"fe6e7644-9e58-3b57-9734-f201766d4d75"}	{"id":"33448c5c-ba4f-366b-88f4-95aec59b982d","nom":"Leclerc","prenom":"Louis","ville":"Francois","email":"Louis.Leclerc@noos.fr","telephone":"0653433149","specialite_id":"5","groupe_id":"fe6e7644-9e58-3b57-9734-f201766d4d75"}	\N	\N
139	141	praticiens	c813bddb-147b-3579-820d-cd58b28adac0	{"id":"c813bddb-147b-3579-820d-cd58b28adac0","nom":"Fabre","prenom":"Anouk","ville":"Delmas","email":"Anouk.Fabre@live.com","telephone":"+33 (0)5 98 57 53 80","specialite_id":"4","groupe_id":"fe6e7644-9e58-3b57-9734-f201766d4d75"}	{"id":"c813bddb-147b-3579-820d-cd58b28adac0","nom":"Fabre","prenom":"Anouk","ville":"Delmas","email":"Anouk.Fabre@live.com","telephone":"+33 (0)5 98 57 53 80","specialite_id":"4","groupe_id":"fe6e7644-9e58-3b57-9734-f201766d4d75"}	\N	\N
140	142	praticiens	1d27091f-5a24-312c-a594-5102f5576306	{"id":"1d27091f-5a24-312c-a594-5102f5576306","nom":"Leleu","prenom":"Isaac","ville":"CharpentierVille","email":"Isaac.Leleu@tele2.fr","telephone":"02 94 90 32 21","specialite_id":"4","groupe_id":"fe6e7644-9e58-3b57-9734-f201766d4d75"}	{"id":"1d27091f-5a24-312c-a594-5102f5576306","nom":"Leleu","prenom":"Isaac","ville":"CharpentierVille","email":"Isaac.Leleu@tele2.fr","telephone":"02 94 90 32 21","specialite_id":"4","groupe_id":"fe6e7644-9e58-3b57-9734-f201766d4d75"}	\N	\N
141	143	praticiens	8fe808d9-6742-3942-acfc-b78e2dc0ead2	{"id":"8fe808d9-6742-3942-acfc-b78e2dc0ead2","nom":"Renard","prenom":"Philippe","ville":"Lombardnec","email":"Philippe.Renard@free.fr","telephone":"03 68 45 64 25","specialite_id":"5","groupe_id":"fe6e7644-9e58-3b57-9734-f201766d4d75"}	{"id":"8fe808d9-6742-3942-acfc-b78e2dc0ead2","nom":"Renard","prenom":"Philippe","ville":"Lombardnec","email":"Philippe.Renard@free.fr","telephone":"03 68 45 64 25","specialite_id":"5","groupe_id":"fe6e7644-9e58-3b57-9734-f201766d4d75"}	\N	\N
142	144	praticiens	5670356f-5750-3222-aa82-a7309199fe59	{"id":"5670356f-5750-3222-aa82-a7309199fe59","nom":"Lefevre","prenom":"Thierry","ville":"Aubertnec","email":"Thierry.Lefevre@dbmail.com","telephone":"+33 (0)8 99 88 16 51","specialite_id":"3","groupe_id":"fe6e7644-9e58-3b57-9734-f201766d4d75"}	{"id":"5670356f-5750-3222-aa82-a7309199fe59","nom":"Lefevre","prenom":"Thierry","ville":"Aubertnec","email":"Thierry.Lefevre@dbmail.com","telephone":"+33 (0)8 99 88 16 51","specialite_id":"3","groupe_id":"fe6e7644-9e58-3b57-9734-f201766d4d75"}	\N	\N
143	145	praticiens	bf5fdb24-f530-32a1-ba6c-3f09a6d25566	{"id":"bf5fdb24-f530-32a1-ba6c-3f09a6d25566","nom":"Boulay","prenom":"Gilles","ville":"Grondin","email":"Gilles.Boulay@live.com","telephone":"+33 (0)1 07 18 13 70","specialite_id":"4","groupe_id":"fe6e7644-9e58-3b57-9734-f201766d4d75"}	{"id":"bf5fdb24-f530-32a1-ba6c-3f09a6d25566","nom":"Boulay","prenom":"Gilles","ville":"Grondin","email":"Gilles.Boulay@live.com","telephone":"+33 (0)1 07 18 13 70","specialite_id":"4","groupe_id":"fe6e7644-9e58-3b57-9734-f201766d4d75"}	\N	\N
144	146	praticiens	c10622c7-ac83-38f5-939c-54a5ebcb7cb5	{"id":"c10622c7-ac83-38f5-939c-54a5ebcb7cb5","nom":"Texier","prenom":"Dominique","ville":"Allain","email":"Dominique.Texier@gmail.com","telephone":"07 63 13 89 05","specialite_id":"2","groupe_id":"9117850b-3116-3d4f-b346-1dfc23c26787"}	{"id":"c10622c7-ac83-38f5-939c-54a5ebcb7cb5","nom":"Texier","prenom":"Dominique","ville":"Allain","email":"Dominique.Texier@gmail.com","telephone":"07 63 13 89 05","specialite_id":"2","groupe_id":"9117850b-3116-3d4f-b346-1dfc23c26787"}	\N	\N
145	147	praticiens	2da9d1c6-a17c-31f2-95a7-4f2f191326dc	{"id":"2da9d1c6-a17c-31f2-95a7-4f2f191326dc","nom":"Fouquet","prenom":"Benoît","ville":"Diallo","email":"Benot.Fouquet@yahoo.fr","telephone":"+33 (0)7 72 16 32 79","specialite_id":"3","groupe_id":"9117850b-3116-3d4f-b346-1dfc23c26787"}	{"id":"2da9d1c6-a17c-31f2-95a7-4f2f191326dc","nom":"Fouquet","prenom":"Benoît","ville":"Diallo","email":"Benot.Fouquet@yahoo.fr","telephone":"+33 (0)7 72 16 32 79","specialite_id":"3","groupe_id":"9117850b-3116-3d4f-b346-1dfc23c26787"}	\N	\N
146	148	praticiens	ac91e524-3538-3a24-bda2-68a98288960e	{"id":"ac91e524-3538-3a24-bda2-68a98288960e","nom":"Perrin","prenom":"Gérard","ville":"Guyon","email":"Grard.Perrin@free.fr","telephone":"+33 1 59 86 51 70","specialite_id":"1","groupe_id":"9117850b-3116-3d4f-b346-1dfc23c26787"}	{"id":"ac91e524-3538-3a24-bda2-68a98288960e","nom":"Perrin","prenom":"Gérard","ville":"Guyon","email":"Grard.Perrin@free.fr","telephone":"+33 1 59 86 51 70","specialite_id":"1","groupe_id":"9117850b-3116-3d4f-b346-1dfc23c26787"}	\N	\N
147	149	praticiens	62097b60-2085-3619-a92b-a23add366c7b	{"id":"62097b60-2085-3619-a92b-a23add366c7b","nom":"Joseph","prenom":"Odette","ville":"Daniel-sur-Berger","email":"Odette.Joseph@club-internet.fr","telephone":"+33 6 62 80 46 16","specialite_id":"3","groupe_id":"9117850b-3116-3d4f-b346-1dfc23c26787"}	{"id":"62097b60-2085-3619-a92b-a23add366c7b","nom":"Joseph","prenom":"Odette","ville":"Daniel-sur-Berger","email":"Odette.Joseph@club-internet.fr","telephone":"+33 6 62 80 46 16","specialite_id":"3","groupe_id":"9117850b-3116-3d4f-b346-1dfc23c26787"}	\N	\N
148	150	praticiens	2a197d2d-6eee-3875-8e02-feb17faf62a0	{"id":"2a197d2d-6eee-3875-8e02-feb17faf62a0","nom":"Laroche","prenom":"Thibaut","ville":"Pruvost-sur-Pierre","email":"Thibaut.Laroche@dbmail.com","telephone":"01 44 39 87 82","specialite_id":"3","groupe_id":"9117850b-3116-3d4f-b346-1dfc23c26787"}	{"id":"2a197d2d-6eee-3875-8e02-feb17faf62a0","nom":"Laroche","prenom":"Thibaut","ville":"Pruvost-sur-Pierre","email":"Thibaut.Laroche@dbmail.com","telephone":"01 44 39 87 82","specialite_id":"3","groupe_id":"9117850b-3116-3d4f-b346-1dfc23c26787"}	\N	\N
149	151	praticiens	35b16c74-40ee-3fe5-bea2-b0f525b0f245	{"id":"35b16c74-40ee-3fe5-bea2-b0f525b0f245","nom":"Petit","prenom":"Marcelle","ville":"Bouvetnec","email":"Marcelle.Petit@sfr.fr","telephone":"+33 (0)6 32 21 15 75","specialite_id":"2","groupe_id":"bee7989a-c204-3cf7-bbfc-42a9ce8456ea"}	{"id":"35b16c74-40ee-3fe5-bea2-b0f525b0f245","nom":"Petit","prenom":"Marcelle","ville":"Bouvetnec","email":"Marcelle.Petit@sfr.fr","telephone":"+33 (0)6 32 21 15 75","specialite_id":"2","groupe_id":"bee7989a-c204-3cf7-bbfc-42a9ce8456ea"}	\N	\N
150	152	praticiens	f09cf264-8826-35b7-bbf3-af6561f3ba8f	{"id":"f09cf264-8826-35b7-bbf3-af6561f3ba8f","nom":"Lenoir","prenom":"Geneviève","ville":"Maillet","email":"Genevive.Lenoir@noos.fr","telephone":"06 94 39 69 52","specialite_id":"2","groupe_id":"bee7989a-c204-3cf7-bbfc-42a9ce8456ea"}	{"id":"f09cf264-8826-35b7-bbf3-af6561f3ba8f","nom":"Lenoir","prenom":"Geneviève","ville":"Maillet","email":"Genevive.Lenoir@noos.fr","telephone":"06 94 39 69 52","specialite_id":"2","groupe_id":"bee7989a-c204-3cf7-bbfc-42a9ce8456ea"}	\N	\N
151	153	praticiens	f3485799-f91d-35ef-9f76-6a02a041fefa	{"id":"f3485799-f91d-35ef-9f76-6a02a041fefa","nom":"Faivre","prenom":"Vincent","ville":"Begue","email":"Vincent.Faivre@gmail.com","telephone":"07 59 38 94 56","specialite_id":"2","groupe_id":"bee7989a-c204-3cf7-bbfc-42a9ce8456ea"}	{"id":"f3485799-f91d-35ef-9f76-6a02a041fefa","nom":"Faivre","prenom":"Vincent","ville":"Begue","email":"Vincent.Faivre@gmail.com","telephone":"07 59 38 94 56","specialite_id":"2","groupe_id":"bee7989a-c204-3cf7-bbfc-42a9ce8456ea"}	\N	\N
152	154	praticiens	23923a6b-909a-38e8-a7fe-50745ef4ac0f	{"id":"23923a6b-909a-38e8-a7fe-50745ef4ac0f","nom":"Garcia","prenom":"Emmanuel","ville":"Deschampsboeuf","email":"Emmanuel.Garcia@sfr.fr","telephone":"0964992966","specialite_id":"3","groupe_id":"bee7989a-c204-3cf7-bbfc-42a9ce8456ea"}	{"id":"23923a6b-909a-38e8-a7fe-50745ef4ac0f","nom":"Garcia","prenom":"Emmanuel","ville":"Deschampsboeuf","email":"Emmanuel.Garcia@sfr.fr","telephone":"0964992966","specialite_id":"3","groupe_id":"bee7989a-c204-3cf7-bbfc-42a9ce8456ea"}	\N	\N
153	155	praticiens	66faac60-5e42-313f-9d88-f4e16ddce694	{"id":"66faac60-5e42-313f-9d88-f4e16ddce694","nom":"Gimenez","prenom":"Lorraine","ville":"Humbert-la-Forêt","email":"Lorraine.Gimenez@sfr.fr","telephone":"+33 4 17 88 99 57","specialite_id":"2","groupe_id":"bee7989a-c204-3cf7-bbfc-42a9ce8456ea"}	{"id":"66faac60-5e42-313f-9d88-f4e16ddce694","nom":"Gimenez","prenom":"Lorraine","ville":"Humbert-la-Forêt","email":"Lorraine.Gimenez@sfr.fr","telephone":"+33 4 17 88 99 57","specialite_id":"2","groupe_id":"bee7989a-c204-3cf7-bbfc-42a9ce8456ea"}	\N	\N
154	156	praticiens	4b1f7ae9-f6d4-3dc2-9869-45b1f2849c49	{"id":"4b1f7ae9-f6d4-3dc2-9869-45b1f2849c49","nom":"Dupuy","prenom":"Victor","ville":"ChartierBourg","email":"Victor.Dupuy@tele2.fr","telephone":"0581938382","specialite_id":"4","groupe_id":"bee7989a-c204-3cf7-bbfc-42a9ce8456ea"}	{"id":"4b1f7ae9-f6d4-3dc2-9869-45b1f2849c49","nom":"Dupuy","prenom":"Victor","ville":"ChartierBourg","email":"Victor.Dupuy@tele2.fr","telephone":"0581938382","specialite_id":"4","groupe_id":"bee7989a-c204-3cf7-bbfc-42a9ce8456ea"}	\N	\N
155	157	praticiens	512e3f2d-b40f-336a-8bda-2b871d72691d	{"id":"512e3f2d-b40f-336a-8bda-2b871d72691d","nom":"Coulon","prenom":"Odette","ville":"Fischer","email":"Odette.Coulon@gmail.com","telephone":"0948740257","specialite_id":"2","groupe_id":"55ee31cb-9fb6-3513-b209-e2804d02c11e"}	{"id":"512e3f2d-b40f-336a-8bda-2b871d72691d","nom":"Coulon","prenom":"Odette","ville":"Fischer","email":"Odette.Coulon@gmail.com","telephone":"0948740257","specialite_id":"2","groupe_id":"55ee31cb-9fb6-3513-b209-e2804d02c11e"}	\N	\N
156	158	praticiens	d79364b7-87e2-3ad2-894e-fce97f7a1d83	{"id":"d79364b7-87e2-3ad2-894e-fce97f7a1d83","nom":"Delannoy","prenom":"Patrick","ville":"Marion","email":"Patrick.Delannoy@gmail.com","telephone":"04 24 84 91 18","specialite_id":"2","groupe_id":"55ee31cb-9fb6-3513-b209-e2804d02c11e"}	{"id":"d79364b7-87e2-3ad2-894e-fce97f7a1d83","nom":"Delannoy","prenom":"Patrick","ville":"Marion","email":"Patrick.Delannoy@gmail.com","telephone":"04 24 84 91 18","specialite_id":"2","groupe_id":"55ee31cb-9fb6-3513-b209-e2804d02c11e"}	\N	\N
157	159	praticiens	581b1a86-e5ac-3f81-9a98-f87aa0fbf718	{"id":"581b1a86-e5ac-3f81-9a98-f87aa0fbf718","nom":"Fabre","prenom":"David","ville":"Thierry-sur-Breton","email":"David.Fabre@laposte.net","telephone":"+33 (0)1 85 87 66 91","specialite_id":"5","groupe_id":"55ee31cb-9fb6-3513-b209-e2804d02c11e"}	{"id":"581b1a86-e5ac-3f81-9a98-f87aa0fbf718","nom":"Fabre","prenom":"David","ville":"Thierry-sur-Breton","email":"David.Fabre@laposte.net","telephone":"+33 (0)1 85 87 66 91","specialite_id":"5","groupe_id":"55ee31cb-9fb6-3513-b209-e2804d02c11e"}	\N	\N
158	160	praticiens	2e1c1158-c565-3780-aeed-2845063e415c	{"id":"2e1c1158-c565-3780-aeed-2845063e415c","nom":"Dias","prenom":"Noël","ville":"Le Goff","email":"Nol.Dias@free.fr","telephone":"+33 1 38 22 72 90","specialite_id":"5","groupe_id":"55ee31cb-9fb6-3513-b209-e2804d02c11e"}	{"id":"2e1c1158-c565-3780-aeed-2845063e415c","nom":"Dias","prenom":"Noël","ville":"Le Goff","email":"Nol.Dias@free.fr","telephone":"+33 1 38 22 72 90","specialite_id":"5","groupe_id":"55ee31cb-9fb6-3513-b209-e2804d02c11e"}	\N	\N
159	161	praticiens	d6021537-72b7-3289-bfe7-efa9b4281b73	{"id":"d6021537-72b7-3289-bfe7-efa9b4281b73","nom":"Bertrand","prenom":"Gilbert","ville":"Langloisboeuf","email":"Gilbert.Bertrand@club-internet.fr","telephone":"0169855824","specialite_id":"2","groupe_id":"55ee31cb-9fb6-3513-b209-e2804d02c11e"}	{"id":"d6021537-72b7-3289-bfe7-efa9b4281b73","nom":"Bertrand","prenom":"Gilbert","ville":"Langloisboeuf","email":"Gilbert.Bertrand@club-internet.fr","telephone":"0169855824","specialite_id":"2","groupe_id":"55ee31cb-9fb6-3513-b209-e2804d02c11e"}	\N	\N
160	162	praticiens	1e67bfd0-fd1a-362a-be57-6b212c76cfb6	{"id":"1e67bfd0-fd1a-362a-be57-6b212c76cfb6","nom":"Didier","prenom":"Édith","ville":"Gregoire-sur-Gautier","email":"dith.Didier@club-internet.fr","telephone":"09 55 59 50 47","specialite_id":"3","groupe_id":"55ee31cb-9fb6-3513-b209-e2804d02c11e"}	{"id":"1e67bfd0-fd1a-362a-be57-6b212c76cfb6","nom":"Didier","prenom":"Édith","ville":"Gregoire-sur-Gautier","email":"dith.Didier@club-internet.fr","telephone":"09 55 59 50 47","specialite_id":"3","groupe_id":"55ee31cb-9fb6-3513-b209-e2804d02c11e"}	\N	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_roles (id, name, icon, description, parent) FROM stdin;
cb08a347-e5ba-4510-b7d3-df40c85ed186	Administrator	verified	$t:admin_description	\N
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent, share, origin, next_token) FROM stdin;
G-IaSOJxeQPWW2txOqMS5YgPSnQnixmEFuwovjeQWPzO2uMPaKrHIf64sN2QWDjr	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-14 14:23:34.935+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:8055	pKHWCsv72krTXo4bASqYGd2WKMDVatiUjF9AZJRhNx0j-zvLhdYcZpaecAH92uoT
pKHWCsv72krTXo4bASqYGd2WKMDVatiUjF9AZJRhNx0j-zvLhdYcZpaecAH92uoT	6208cdc2-d6b3-46b8-afef-afa7af926ef1	2025-01-15 14:23:24.935+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:8055	\N
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, default_language, custom_aspect_ratios, public_favicon, default_appearance, default_theme_light, theme_light_overrides, default_theme_dark, theme_dark_overrides, report_error_url, report_bug_url, report_feature_url, public_registration, public_registration_verify_email, public_registration_role, public_registration_email_filter) FROM stdin;
\.


--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_shares (id, name, collection, item, role, password, user_created, date_created, date_start, date_end, times_used, max_uses) FROM stdin;
\.


--
-- Data for Name: directus_translations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_translations (id, language, key, value) FROM stdin;
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, tfa_secret, status, role, token, last_access, last_page, provider, external_identifier, auth_data, email_notifications, appearance, theme_dark, theme_light, theme_light_overrides, theme_dark_overrides) FROM stdin;
6208cdc2-d6b3-46b8-afef-afa7af926ef1	Admin	User	user@mail.com	$argon2id$v=19$m=65536,t=3,p=4$rRPUrHR2UGrOGDxn9o6Kuw$fu6a/EGqDSpCnwu36Cdn6OHONxgyOPovZaAJUC6ZeGA	\N	\N	\N	\N	\N	\N	\N	active	cb08a347-e5ba-4510-b7d3-df40c85ed186	\N	2025-01-14 14:23:24.939+00	/content/praticiens	default	\N	\N	t	\N	\N	\N	\N	\N
\.


--
-- Data for Name: directus_versions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_versions (id, key, name, collection, item, hash, date_created, date_updated, user_created, user_updated, delta) FROM stdin;
\.


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections, headers, was_active_before_deprecation, migrated_flow) FROM stdin;
\.


--
-- Data for Name: groupement; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.groupement (id, nom, adresse, ville, type_id) FROM stdin;
3444bdd2-8783-3aed-9a5e-4d298d2a2d7c	Bigot	63, rue de Mercier	Paris	1
372c1de7-4d31-3d01-9c92-77e69467d4e3	Toussaint Marechal SAS	290, rue Rossi	Joubert	1
255ecef6-14b9-3b5c-a40e-901665f4ed28	Pichon S.A.	93, impasse Alain Baron	Diaz-sur-Boulanger	1
80756589-93f3-3ab7-92dd-377dbea5ea4d	Parent SARL	4, impasse de Denis	Lucas	1
5f7d3d80-3c4b-386a-a23e-74de4a1e0b19	Goncalves Louis SARL	35, impasse Lebon	Carre-sur-Turpin	1
c302d11b-d5b8-310a-bbc5-9dd4400eb2c9	Antoine	97, avenue Raymond Gerard	Moreno	2
b636c1fd-c61c-306b-9d4f-25cf3bfd9f66	Barbe	23, avenue Mercier	Lefevre	2
7db214d9-f415-3110-991b-ec5f9774b685	Marin	96, rue Louis	Bourdon-les-Bains	2
a51a0543-ee80-3515-81ab-2504ec194c09	Lombard	17, chemin de Bazin	Paris-la-Forêt	3
fe6e7644-9e58-3b57-9734-f201766d4d75	Diallo SAS	53, rue Toussaint	Bouchet	3
9117850b-3116-3d4f-b346-1dfc23c26787	Vaillant S.A.S.	68, avenue Élise Dupre	LemonnierBourg	3
bee7989a-c204-3cf7-bbfc-42a9ce8456ea	Martineau	31, boulevard Éric Pierre	Royer	3
55ee31cb-9fb6-3513-b209-e2804d02c11e	Fischer	83, place de Lefort	Ruiz	3
\.


--
-- Data for Name: personnel; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.personnel (id, nom, prenom, mail, telephone, groupe_id) FROM stdin;
a7683bcd-30b1-3455-93a8-db072ab97b27	Joubert	Michèle	Michle.Joubert@dbmail.com	0158189514	3444bdd2-8783-3aed-9a5e-4d298d2a2d7c
475e2bef-afe8-3eb1-8b70-bccb6000cbcd	Delaunay	Dominique	Dominique.Delaunay@wanadoo.fr	+33 9 26 07 04 72	3444bdd2-8783-3aed-9a5e-4d298d2a2d7c
1738d920-4d0b-38a3-9108-1edae406e5a6	Boucher	Jean	Jean.Boucher@free.fr	0895587519	372c1de7-4d31-3d01-9c92-77e69467d4e3
59e37ba0-f491-3a7d-9360-1ec7d1410c74	Dubois	Olivier	Olivier.Dubois@wanadoo.fr	07 96 98 25 78	255ecef6-14b9-3b5c-a40e-901665f4ed28
c87526f4-464d-3086-86f3-61436cc33f4c	Guilbert	Édith	dith.Guilbert@hotmail.fr	+33 (0)3 83 98 66 51	80756589-93f3-3ab7-92dd-377dbea5ea4d
056bd724-a3ac-309f-9d05-03dd298dc530	Normand	Théophile	Thophile.Normand@noos.fr	06 97 20 54 55	80756589-93f3-3ab7-92dd-377dbea5ea4d
240a1331-06cf-3e77-8b7e-bf0d2f9f874a	Guyon	Timothée	Timothe.Guyon@free.fr	+33 8 11 74 87 40	80756589-93f3-3ab7-92dd-377dbea5ea4d
4fd0d68d-195a-30ad-a5b6-148a663a56ed	Julien	Grégoire	Grgoire.Julien@hotmail.fr	01 78 87 87 84	5f7d3d80-3c4b-386a-a23e-74de4a1e0b19
5de41221-6098-3895-90c3-17152d523204	Payet	Capucine	Capucine.Payet@orange.fr	+33 2 13 87 68 30	5f7d3d80-3c4b-386a-a23e-74de4a1e0b19
2905a6b3-937b-3332-b02f-f0a298f70374	Auger	Marguerite	Marguerite.Auger@laposte.net	+33 2 59 70 11 81	c302d11b-d5b8-310a-bbc5-9dd4400eb2c9
14b52ece-d0bf-3162-979b-f356f3833605	Gay	Guy	Guy.Gay@gmail.com	+33 4 45 28 11 75	c302d11b-d5b8-310a-bbc5-9dd4400eb2c9
fd2acfa0-b429-3449-822b-6a6733465a16	Parent	Honoré	Honor.Parent@tele2.fr	0808625348	c302d11b-d5b8-310a-bbc5-9dd4400eb2c9
325aac63-9c6f-3d08-983c-67edd0361500	Joseph	Jules	Jules.Joseph@live.com	+33 (0)5 31 44 52 52	c302d11b-d5b8-310a-bbc5-9dd4400eb2c9
72a80ee4-aad1-3189-bb58-dfa638ff2af3	Adam	Auguste	Auguste.Adam@yahoo.fr	+33 9 25 37 42 02	b636c1fd-c61c-306b-9d4f-25cf3bfd9f66
b9bedd1c-f8a8-3c65-b9ad-850b551cbecf	Le Gall	Denise	Denise.LeGall@wanadoo.fr	04 48 54 51 31	7db214d9-f415-3110-991b-ec5f9774b685
8fb66ad8-992b-3e5c-a98f-47eba3b7a62a	Letellier	Anne	Anne.Letellier@free.fr	0549905440	a51a0543-ee80-3515-81ab-2504ec194c09
0e6d3926-be87-332c-94e0-cca0bdcfa3d6	Perret	Madeleine	Madeleine.Perret@gmail.com	0933106983	a51a0543-ee80-3515-81ab-2504ec194c09
57a31547-2e5a-3ab8-bf3e-97e5ecba6c88	Vaillant	Alphonse	Alphonse.Vaillant@hotmail.fr	+33 (0)8 99 50 21 82	a51a0543-ee80-3515-81ab-2504ec194c09
a027a4d8-bf57-30d9-afd2-79bcfda90de2	Masson	Augustin	Augustin.Masson@laposte.net	0455003959	fe6e7644-9e58-3b57-9734-f201766d4d75
ec62b359-705d-3717-82f3-561b2a4dda4d	Mendes	Théodore	Thodore.Mendes@dbmail.com	+33 1 90 35 31 25	fe6e7644-9e58-3b57-9734-f201766d4d75
ec79ebae-3041-3182-9ac7-676fac0a6419	Seguin	Roger	Roger.Seguin@sfr.fr	+33 (0)8 95 55 77 02	fe6e7644-9e58-3b57-9734-f201766d4d75
e2b0ec67-79ed-3e0c-b73c-b43e615b0b8d	Gosselin	Maryse	Maryse.Gosselin@gmail.com	0808487843	9117850b-3116-3d4f-b346-1dfc23c26787
712eb55d-7b17-3a6e-8c50-44b6bc37959c	Launay	Luc	Luc.Launay@noos.fr	+33 5 85 26 58 79	9117850b-3116-3d4f-b346-1dfc23c26787
ade0a833-70b4-36f2-b938-22857e7da4c7	Bouvet	Constance	Constance.Bouvet@laposte.net	+33 (0)4 92 53 63 01	bee7989a-c204-3cf7-bbfc-42a9ce8456ea
024e14c7-2f6b-3566-87e9-84f01d252bb1	Bousquet	Paulette	Paulette.Bousquet@laposte.net	0585162734	bee7989a-c204-3cf7-bbfc-42a9ce8456ea
fda644e6-62ed-3971-b5a7-44146b808a82	Collin	Zacharie	Zacharie.Collin@noos.fr	01 24 12 80 73	bee7989a-c204-3cf7-bbfc-42a9ce8456ea
75d3e34b-e9a6-3494-bf39-d3e45f6c3653	Renaud	Marcel	Marcel.Renaud@dbmail.com	+33 7 40 35 32 48	bee7989a-c204-3cf7-bbfc-42a9ce8456ea
ffc24e94-8981-3ed9-8019-fa8bd2e16001	Vincent	Isaac	Isaac.Vincent@dbmail.com	+33 8 04 19 03 86	55ee31cb-9fb6-3513-b209-e2804d02c11e
\.


--
-- Data for Name: praticiens; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.praticiens (id, nom, prenom, ville, email, telephone, groupe_id, specialite_id) FROM stdin;
af7bb2f1-cc52-3388-b9bc-c0b89e7f4c5b	Paul	Marine	Paris	Marine.Paul@hotmail.fr	02 36 11 25 88	3444bdd2-8783-3aed-9a5e-4d298d2a2d7c	1
b994a36f-794f-3ddc-b267-99673661466d	Guichard	Laurence	Paris	Laurence.Guichard@club-internet.fr	+33 8 99 14 03 98	3444bdd2-8783-3aed-9a5e-4d298d2a2d7c	1
8236bcbf-4c06-3d0e-8ab0-c4964e02c4ea	Pichon	Arnaude	Paris	Arnaude.Pichon@yahoo.fr	06 61 50 63 81	3444bdd2-8783-3aed-9a5e-4d298d2a2d7c	4
8ae1400f-d46d-3b50-b356-269f776be532	Klein	Gabrielle	Paris	Gabrielle.Klein@live.com	+33 (0)3 90 27 98 80	3444bdd2-8783-3aed-9a5e-4d298d2a2d7c	1
085c44e7-6245-3b10-9c1a-92f09524ef2a	Gallet	Valérie	Paris	Valrie.Gallet@dbmail.com	+33 (0)9 29 33 51 05	3444bdd2-8783-3aed-9a5e-4d298d2a2d7c	2
dada1285-f235-3ad2-bd7d-f58d68c30a73	Goncalves	Noël	Paris	Nol.Goncalves@free.fr	+33 5 82 74 18 66	3444bdd2-8783-3aed-9a5e-4d298d2a2d7c	2
51c6c5a5-0815-3ff1-b0e4-ac216319e526	Besson	Aurélie	Joubert	Aurlie.Besson@gmail.com	+33 (0)3 76 13 23 05	372c1de7-4d31-3d01-9c92-77e69467d4e3	3
592692c8-4a8c-3f91-967b-fde67ebea54d	Costa	Marc	Joubert	Marc.Costa@wanadoo.fr	+33 1 42 89 11 30	372c1de7-4d31-3d01-9c92-77e69467d4e3	3
0768e78b-12c8-3694-b89b-d0a7451a8fb1	Descamps	Alexandria	Joubert	Alexandria.Descamps@club-internet.fr	+33 (0)1 75 74 98 33	372c1de7-4d31-3d01-9c92-77e69467d4e3	4
f9bd589a-99ef-39f7-9984-af26e95c7150	Roger	Philippine	Diaz-sur-Boulanger	Philippine.Roger@hotmail.fr	0815977032	255ecef6-14b9-3b5c-a40e-901665f4ed28	5
bdd2672d-f4e6-3fd1-88db-d27e97b4d1e0	Martel	Denise	Diaz-sur-Boulanger	Denise.Martel@tele2.fr	+33 1 57 80 28 75	255ecef6-14b9-3b5c-a40e-901665f4ed28	2
7c76c93d-1b70-35eb-96d5-34c2d9d741c4	Marchand	Suzanne	Diaz-sur-Boulanger	Suzanne.Marchand@sfr.fr	+33 (0)2 83 66 69 68	255ecef6-14b9-3b5c-a40e-901665f4ed28	4
656c9034-bf19-33a0-beec-9a959ee83cd7	Parent	Tristan	Lucas	Tristan.Parent@laposte.net	+33 (0)2 81 93 20 11	80756589-93f3-3ab7-92dd-377dbea5ea4d	5
2ae94f01-8332-3c16-bf4c-eb1d64929253	Joly	Patricia	Lucas	Patricia.Joly@gmail.com	+33 4 24 93 22 37	80756589-93f3-3ab7-92dd-377dbea5ea4d	5
68202db3-920d-35dc-b547-e52c53ec5885	Meunier	Michelle	Lucas	Michelle.Meunier@noos.fr	08 97 18 92 13	80756589-93f3-3ab7-92dd-377dbea5ea4d	1
3eeec083-d6fe-3cf7-b0da-e2b09a261db9	Barbier	Claude	Carre-sur-Turpin	Claude.Barbier@wanadoo.fr	+33 (0)7 69 71 23 39	5f7d3d80-3c4b-386a-a23e-74de4a1e0b19	1
529fa71e-5a6c-3360-9579-81abc41e865f	Aubert	Louis	Carre-sur-Turpin	Louis.Aubert@free.fr	+33 7 68 13 29 54	5f7d3d80-3c4b-386a-a23e-74de4a1e0b19	3
e6f97aad-b672-3407-92ac-54b26d95d628	Berger	Olivie	Carre-sur-Turpin	Olivie.Berger@sfr.fr	0421147513	5f7d3d80-3c4b-386a-a23e-74de4a1e0b19	4
05644ac0-c4cb-36bf-a0cf-409075eb20c4	Leduc	Aimée	Carre-sur-Turpin	Aime.Leduc@laposte.net	+33 (0)4 85 19 99 00	5f7d3d80-3c4b-386a-a23e-74de4a1e0b19	4
c7c71a7a-d6e1-3aa3-8aa8-987cbef516b0	Mendes	Jean	Carre-sur-Turpin	Jean.Mendes@wanadoo.fr	0220429087	5f7d3d80-3c4b-386a-a23e-74de4a1e0b19	1
d7e254f4-7e01-395a-b668-6f86e3444906	Legros	Louis	Carre-sur-Turpin	Louis.Legros@club-internet.fr	02 23 75 20 59	5f7d3d80-3c4b-386a-a23e-74de4a1e0b19	5
41ac1467-4874-3e88-a636-444eae7dc457	Blanc	Rémy	Carre-sur-Turpin	Rmy.Blanc@sfr.fr	+33 (0)6 34 60 92 42	5f7d3d80-3c4b-386a-a23e-74de4a1e0b19	5
15d3e128-b47c-3030-a1c8-cfb09942054a	Pascal	Gilles	Carre-sur-Turpin	Gilles.Pascal@sfr.fr	08 12 96 04 73	5f7d3d80-3c4b-386a-a23e-74de4a1e0b19	5
9b4aa9d2-fb6a-3e07-9b5a-a792ffb4b3f3	Huet	Jacqueline	Carre-sur-Turpin	Jacqueline.Huet@tele2.fr	01 58 91 85 40	5f7d3d80-3c4b-386a-a23e-74de4a1e0b19	1
905735e4-bd41-3991-8462-0b21a962ecc9	Seguin	Audrey	Moreno	Audrey.Seguin@laposte.net	0184365032	c302d11b-d5b8-310a-bbc5-9dd4400eb2c9	2
03f24d7b-efda-3fbe-ae53-0c0c0edef089	Grenier	Josette	Moreno	Josette.Grenier@wanadoo.fr	06 43 92 58 43	c302d11b-d5b8-310a-bbc5-9dd4400eb2c9	2
8b34ba8b-5775-31a9-9ca6-1cf955c9ab84	Le Roux	Bernadette	Moreno	Bernadette.LeRoux@laposte.net	02 01 42 83 17	c302d11b-d5b8-310a-bbc5-9dd4400eb2c9	2
b0458f20-e264-3ab4-8153-47268dd936bc	Delattre	Andrée	Moreno	Andre.Delattre@dbmail.com	+33 6 03 08 18 43	c302d11b-d5b8-310a-bbc5-9dd4400eb2c9	2
3688814f-1b08-313b-8287-18febcc544d6	Leleu	Josette	Moreno	Josette.Leleu@sfr.fr	+33 (0)1 48 67 86 03	c302d11b-d5b8-310a-bbc5-9dd4400eb2c9	2
b05657bc-ecf5-3a76-960a-c20e41af60a0	Vasseur	Corinne	Moreno	Corinne.Vasseur@sfr.fr	0977376152	c302d11b-d5b8-310a-bbc5-9dd4400eb2c9	2
2192c51f-1d1f-3d76-88ed-6a25abed0faf	Pelletier	Alexandrie	Moreno	Alexandrie.Pelletier@live.com	+33 (0)6 73 60 47 41	c302d11b-d5b8-310a-bbc5-9dd4400eb2c9	2
3dc3ed9e-b07e-3cb7-81c4-6607d11f20ca	Dufour	Thibaut	Lefevre	Thibaut.Dufour@club-internet.fr	01 70 44 52 00	b636c1fd-c61c-306b-9d4f-25cf3bfd9f66	2
a63afd36-5682-3ad1-971f-447c6fd45180	Denis	Adèle	Lefevre	Adle.Denis@laposte.net	+33 2 53 67 28 62	b636c1fd-c61c-306b-9d4f-25cf3bfd9f66	2
4d4680e8-b362-3ccc-93f0-69ba51d40e67	Foucher	Anne	Lefevre	Anne.Foucher@club-internet.fr	+33 5 53 70 29 91	b636c1fd-c61c-306b-9d4f-25cf3bfd9f66	2
da903aa3-21c2-3631-a08b-d8d054cccb48	David	Susanne	Lefevre	Susanne.David@hotmail.fr	+33 (0)1 52 84 03 11	b636c1fd-c61c-306b-9d4f-25cf3bfd9f66	2
c29223af-0dbe-3bba-8069-65743a4ae8b4	Faivre	Laure	Lefevre	Laure.Faivre@sfr.fr	+33 2 50 47 37 95	b636c1fd-c61c-306b-9d4f-25cf3bfd9f66	2
a960bb57-cf39-3636-9f6d-3ef52834ecfc	Parent	Marc	Lefevre	Marc.Parent@dbmail.com	08 92 01 83 29	b636c1fd-c61c-306b-9d4f-25cf3bfd9f66	2
f524d70d-0f02-3747-a6fb-8d6db043210e	Valette	René	Lefevre	Ren.Valette@orange.fr	0784754050	b636c1fd-c61c-306b-9d4f-25cf3bfd9f66	2
98cf3e54-0cb8-33f0-beae-2fad5ff62bdf	Le Gall	Michelle	Lefevre	Michelle.LeGall@free.fr	0293390604	b636c1fd-c61c-306b-9d4f-25cf3bfd9f66	2
794f6ea3-9801-334b-ba82-4ac71f70f6d2	Marechal	Inès	Bourdon-les-Bains	Ins.Marechal@wanadoo.fr	0469478837	7db214d9-f415-3110-991b-ec5f9774b685	2
e274a3f8-50b3-37c7-a061-333110a1560b	Imbert	Nicolas	Bourdon-les-Bains	Nicolas.Imbert@orange.fr	0947411224	7db214d9-f415-3110-991b-ec5f9774b685	2
7edb1b5e-eeaa-358e-84c5-1b66fc2fec2d	Thierry	Matthieu	Bourdon-les-Bains	Matthieu.Thierry@orange.fr	03 87 04 84 55	7db214d9-f415-3110-991b-ec5f9774b685	2
609bc828-4d34-3bb2-b527-93d80478d6b3	Gilbert	Adrien	Bourdon-les-Bains	Adrien.Gilbert@live.com	0897878909	7db214d9-f415-3110-991b-ec5f9774b685	2
341453e4-c122-3028-a712-af7ddad67975	Marin	Isaac	Bourdon-les-Bains	Isaac.Marin@live.com	0136647915	7db214d9-f415-3110-991b-ec5f9774b685	2
e3ba8e27-6ce8-38d8-bdbc-54c53259036f	Leduc	Caroline	Bourdon-les-Bains	Caroline.Leduc@noos.fr	04 17 24 73 44	7db214d9-f415-3110-991b-ec5f9774b685	2
fd23b913-b526-3b02-bf44-0dd2b25796bb	Langlois	Stéphanie	Bourdon-les-Bains	Stphanie.Langlois@tele2.fr	07 31 50 72 40	7db214d9-f415-3110-991b-ec5f9774b685	2
dfe8a45d-1122-361c-bf96-fffae0d385f2	Fournier	Bernard	Thierry-les-Bains	Bernard.Fournier@hotmail.fr	+33 8 02 69 97 34	a51a0543-ee80-3515-81ab-2504ec194c09	5
a7cc5d8f-360c-3334-a992-6e9008c07c47	Gautier	Adrien	Etienne	Adrien.Gautier@orange.fr	+33 (0)5 44 24 38 22	a51a0543-ee80-3515-81ab-2504ec194c09	5
e5f6cdd3-e9de-3c30-84b9-2d431c0d853f	Pelletier	Michelle	Boutin-les-Bains	Michelle.Pelletier@wanadoo.fr	01 57 96 73 69	a51a0543-ee80-3515-81ab-2504ec194c09	3
623b83ab-46b9-3cf3-8e04-3bb514cb059f	Lucas	Gilbert	Leconte-la-Forêt	Gilbert.Lucas@live.com	+33 (0)9 31 70 40 84	a51a0543-ee80-3515-81ab-2504ec194c09	1
7c57a60f-936a-3b48-884b-dd00fa4f3e0f	Perrier	Anouk	Bernard	Anouk.Perrier@dbmail.com	0929092296	a51a0543-ee80-3515-81ab-2504ec194c09	5
a5c30f27-6100-373f-b291-df93927b5899	Besson	Susan	Gillet-la-Forêt	Susan.Besson@sfr.fr	01 05 65 13 02	fe6e7644-9e58-3b57-9734-f201766d4d75	1
95b1d811-22c6-3c4e-94fb-69dc3bd0522a	Hamel	Paulette	BriandBourg	Paulette.Hamel@free.fr	0115534998	fe6e7644-9e58-3b57-9734-f201766d4d75	2
33448c5c-ba4f-366b-88f4-95aec59b982d	Leclerc	Louis	Francois	Louis.Leclerc@noos.fr	0653433149	fe6e7644-9e58-3b57-9734-f201766d4d75	5
c813bddb-147b-3579-820d-cd58b28adac0	Fabre	Anouk	Delmas	Anouk.Fabre@live.com	+33 (0)5 98 57 53 80	fe6e7644-9e58-3b57-9734-f201766d4d75	4
1d27091f-5a24-312c-a594-5102f5576306	Leleu	Isaac	CharpentierVille	Isaac.Leleu@tele2.fr	02 94 90 32 21	fe6e7644-9e58-3b57-9734-f201766d4d75	4
8fe808d9-6742-3942-acfc-b78e2dc0ead2	Renard	Philippe	Lombardnec	Philippe.Renard@free.fr	03 68 45 64 25	fe6e7644-9e58-3b57-9734-f201766d4d75	5
5670356f-5750-3222-aa82-a7309199fe59	Lefevre	Thierry	Aubertnec	Thierry.Lefevre@dbmail.com	+33 (0)8 99 88 16 51	fe6e7644-9e58-3b57-9734-f201766d4d75	3
bf5fdb24-f530-32a1-ba6c-3f09a6d25566	Boulay	Gilles	Grondin	Gilles.Boulay@live.com	+33 (0)1 07 18 13 70	fe6e7644-9e58-3b57-9734-f201766d4d75	4
c10622c7-ac83-38f5-939c-54a5ebcb7cb5	Texier	Dominique	Allain	Dominique.Texier@gmail.com	07 63 13 89 05	9117850b-3116-3d4f-b346-1dfc23c26787	2
2da9d1c6-a17c-31f2-95a7-4f2f191326dc	Fouquet	Benoît	Diallo	Benot.Fouquet@yahoo.fr	+33 (0)7 72 16 32 79	9117850b-3116-3d4f-b346-1dfc23c26787	3
ac91e524-3538-3a24-bda2-68a98288960e	Perrin	Gérard	Guyon	Grard.Perrin@free.fr	+33 1 59 86 51 70	9117850b-3116-3d4f-b346-1dfc23c26787	1
62097b60-2085-3619-a92b-a23add366c7b	Joseph	Odette	Daniel-sur-Berger	Odette.Joseph@club-internet.fr	+33 6 62 80 46 16	9117850b-3116-3d4f-b346-1dfc23c26787	3
2a197d2d-6eee-3875-8e02-feb17faf62a0	Laroche	Thibaut	Pruvost-sur-Pierre	Thibaut.Laroche@dbmail.com	01 44 39 87 82	9117850b-3116-3d4f-b346-1dfc23c26787	3
35b16c74-40ee-3fe5-bea2-b0f525b0f245	Petit	Marcelle	Bouvetnec	Marcelle.Petit@sfr.fr	+33 (0)6 32 21 15 75	bee7989a-c204-3cf7-bbfc-42a9ce8456ea	2
f09cf264-8826-35b7-bbf3-af6561f3ba8f	Lenoir	Geneviève	Maillet	Genevive.Lenoir@noos.fr	06 94 39 69 52	bee7989a-c204-3cf7-bbfc-42a9ce8456ea	2
f3485799-f91d-35ef-9f76-6a02a041fefa	Faivre	Vincent	Begue	Vincent.Faivre@gmail.com	07 59 38 94 56	bee7989a-c204-3cf7-bbfc-42a9ce8456ea	2
23923a6b-909a-38e8-a7fe-50745ef4ac0f	Garcia	Emmanuel	Deschampsboeuf	Emmanuel.Garcia@sfr.fr	0964992966	bee7989a-c204-3cf7-bbfc-42a9ce8456ea	3
66faac60-5e42-313f-9d88-f4e16ddce694	Gimenez	Lorraine	Humbert-la-Forêt	Lorraine.Gimenez@sfr.fr	+33 4 17 88 99 57	bee7989a-c204-3cf7-bbfc-42a9ce8456ea	2
4b1f7ae9-f6d4-3dc2-9869-45b1f2849c49	Dupuy	Victor	ChartierBourg	Victor.Dupuy@tele2.fr	0581938382	bee7989a-c204-3cf7-bbfc-42a9ce8456ea	4
512e3f2d-b40f-336a-8bda-2b871d72691d	Coulon	Odette	Fischer	Odette.Coulon@gmail.com	0948740257	55ee31cb-9fb6-3513-b209-e2804d02c11e	2
d79364b7-87e2-3ad2-894e-fce97f7a1d83	Delannoy	Patrick	Marion	Patrick.Delannoy@gmail.com	04 24 84 91 18	55ee31cb-9fb6-3513-b209-e2804d02c11e	2
581b1a86-e5ac-3f81-9a98-f87aa0fbf718	Fabre	David	Thierry-sur-Breton	David.Fabre@laposte.net	+33 (0)1 85 87 66 91	55ee31cb-9fb6-3513-b209-e2804d02c11e	5
2e1c1158-c565-3780-aeed-2845063e415c	Dias	Noël	Le Goff	Nol.Dias@free.fr	+33 1 38 22 72 90	55ee31cb-9fb6-3513-b209-e2804d02c11e	5
d6021537-72b7-3289-bfe7-efa9b4281b73	Bertrand	Gilbert	Langloisboeuf	Gilbert.Bertrand@club-internet.fr	0169855824	55ee31cb-9fb6-3513-b209-e2804d02c11e	2
1e67bfd0-fd1a-362a-be57-6b212c76cfb6	Didier	Édith	Gregoire-sur-Gautier	dith.Didier@club-internet.fr	09 55 59 50 47	55ee31cb-9fb6-3513-b209-e2804d02c11e	3
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: specialite; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.specialite (id, libelle, description) FROM stdin;
1	médecine générale	Médecine Générale
2	Médecine du sport	Maladie et traumatismes de la pratique sportive
3	pédiatrie	Maladies des enfants
4	ophtalmologie	Maladies des yeux
5	Dentiste	Bouche et dents
\.


--
-- Data for Name: type_groupement; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.type_groupement (id, type_libelle, type_description) FROM stdin;
1	Maison Médicale	Maison de santé groupant des praticiens de diverses spécialités
2	Cabinet médical	Cabinet regroupant un ou plusieurs praticiens de santé de même spécialité
3	secrétariat externalisé	service externalisé de gestion administrative 
\.


--
-- Data for Name: geocode_settings; Type: TABLE DATA; Schema: tiger; Owner: directus
--

COPY tiger.geocode_settings (name, setting, unit, category, short_desc) FROM stdin;
\.


--
-- Data for Name: pagc_gaz; Type: TABLE DATA; Schema: tiger; Owner: directus
--

COPY tiger.pagc_gaz (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_lex; Type: TABLE DATA; Schema: tiger; Owner: directus
--

COPY tiger.pagc_lex (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_rules; Type: TABLE DATA; Schema: tiger; Owner: directus
--

COPY tiger.pagc_rules (id, rule, is_custom) FROM stdin;
\.


--
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: directus
--

COPY topology.topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: directus
--

COPY topology.layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 162, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 27, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 1, false);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 1, false);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 4, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 160, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, false);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: specialite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.specialite_id_seq', 5, true);


--
-- Name: type_groupement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.type_groupement_id_seq', 3, true);


--
-- Name: directus_access directus_access_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_pkey PRIMARY KEY (id);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_comments directus_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_pkey PRIMARY KEY (id);


--
-- Name: directus_dashboards directus_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_pkey PRIMARY KEY (id);


--
-- Name: directus_extensions directus_extensions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_extensions
    ADD CONSTRAINT directus_extensions_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_flows directus_flows_operation_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_operation_unique UNIQUE (operation);


--
-- Name: directus_flows directus_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_notifications directus_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_reject_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_unique UNIQUE (reject);


--
-- Name: directus_operations directus_operations_resolve_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_unique UNIQUE (resolve);


--
-- Name: directus_panels directus_panels_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_pkey PRIMARY KEY (id);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_policies directus_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_policies
    ADD CONSTRAINT directus_policies_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_shares directus_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_pkey PRIMARY KEY (id);


--
-- Name: directus_translations directus_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_translations
    ADD CONSTRAINT directus_translations_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_external_identifier_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_external_identifier_unique UNIQUE (external_identifier);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_token_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_token_unique UNIQUE (token);


--
-- Name: directus_versions directus_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_pkey PRIMARY KEY (id);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: groupement groupement_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.groupement
    ADD CONSTRAINT groupement_pkey PRIMARY KEY (id);


--
-- Name: personnel personnel_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.personnel
    ADD CONSTRAINT personnel_pkey PRIMARY KEY (id);


--
-- Name: praticiens praticiens_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.praticiens
    ADD CONSTRAINT praticiens_pkey PRIMARY KEY (id);


--
-- Name: specialite specialite_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.specialite
    ADD CONSTRAINT specialite_pkey PRIMARY KEY (id);


--
-- Name: type_groupement type_groupement_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.type_groupement
    ADD CONSTRAINT type_groupement_pkey PRIMARY KEY (id);


--
-- Name: directus_access directus_access_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_collections directus_collections_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_collections(collection);


--
-- Name: directus_comments directus_comments_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_comments directus_comments_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_dashboards directus_dashboards_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_flows directus_flows_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_notifications directus_notifications_recipient_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_recipient_foreign FOREIGN KEY (recipient) REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_notifications directus_notifications_sender_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_sender_foreign FOREIGN KEY (sender) REFERENCES public.directus_users(id);


--
-- Name: directus_operations directus_operations_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_flow_foreign FOREIGN KEY (flow) REFERENCES public.directus_flows(id) ON DELETE CASCADE;


--
-- Name: directus_operations directus_operations_reject_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_foreign FOREIGN KEY (reject) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_resolve_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_foreign FOREIGN KEY (resolve) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_panels directus_panels_dashboard_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_dashboard_foreign FOREIGN KEY (dashboard) REFERENCES public.directus_dashboards(id) ON DELETE CASCADE;


--
-- Name: directus_panels directus_panels_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_permissions directus_permissions_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_revisions directus_revisions_version_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_version_foreign FOREIGN KEY (version) REFERENCES public.directus_versions(id) ON DELETE CASCADE;


--
-- Name: directus_roles directus_roles_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_roles(id);


--
-- Name: directus_sessions directus_sessions_share_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_share_foreign FOREIGN KEY (share) REFERENCES public.directus_shares(id) ON DELETE CASCADE;


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_favicon_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_favicon_foreign FOREIGN KEY (public_favicon) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_registration_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_registration_role_foreign FOREIGN KEY (public_registration_role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_settings directus_settings_storage_default_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_storage_default_folder_foreign FOREIGN KEY (storage_default_folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_shares directus_shares_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_versions directus_versions_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_webhooks directus_webhooks_migrated_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_migrated_flow_foreign FOREIGN KEY (migrated_flow) REFERENCES public.directus_flows(id) ON DELETE SET NULL;


--
-- Name: groupement groupement_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.groupement
    ADD CONSTRAINT groupement_type_id_foreign FOREIGN KEY (type_id) REFERENCES public.type_groupement(id) ON DELETE SET NULL;


--
-- Name: personnel personnel_groupe_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.personnel
    ADD CONSTRAINT personnel_groupe_id_foreign FOREIGN KEY (groupe_id) REFERENCES public.groupement(id) ON DELETE SET NULL;


--
-- Name: praticiens praticiens_groupe_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.praticiens
    ADD CONSTRAINT praticiens_groupe_id_foreign FOREIGN KEY (groupe_id) REFERENCES public.groupement(id) ON DELETE SET NULL;


--
-- Name: praticiens praticiens_specialite_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.praticiens
    ADD CONSTRAINT praticiens_specialite_id_foreign FOREIGN KEY (specialite_id) REFERENCES public.specialite(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

