--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE active_admin_comments (
    id integer NOT NULL,
    namespace character varying,
    body text,
    resource_id character varying NOT NULL,
    resource_type character varying NOT NULL,
    author_id integer,
    author_type character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE active_admin_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE active_admin_comments_id_seq OWNED BY active_admin_comments.id;


--
-- Name: caps_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE caps_transactions (
    id integer NOT NULL,
    source_id integer NOT NULL,
    source_type character varying NOT NULL,
    destination_id integer NOT NULL,
    destination_type character varying NOT NULL,
    caps_cents integer DEFAULT 0 NOT NULL,
    message_from_source text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT check_caps_cents CHECK ((caps_cents >= 0))
);


--
-- Name: caps_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE caps_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: caps_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE caps_transactions_id_seq OWNED BY caps_transactions.id;


--
-- Name: community_offer_details; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE community_offer_details (
    id integer NOT NULL,
    event_id integer,
    value_to_society text,
    producer_qualifications text,
    estimated_hours_of_work integer,
    requirements_provided text,
    requirements_requested text,
    requests text,
    question_or_comment text
);


--
-- Name: community_offer_details_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE community_offer_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: community_offer_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE community_offer_details_id_seq OWNED BY community_offer_details.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    name character varying,
    description text,
    starts_at timestamp without time zone,
    ends_at timestamp without time zone,
    pod_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    address_json json,
    created_by_user_id integer,
    organization_id integer,
    latlng geometry(Point),
    status character varying DEFAULT 'approved'::character varying NOT NULL,
    capacity integer DEFAULT 0
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: mailboxer_conversation_opt_outs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mailboxer_conversation_opt_outs (
    id integer NOT NULL,
    unsubscriber_id integer,
    unsubscriber_type character varying,
    conversation_id integer
);


--
-- Name: mailboxer_conversation_opt_outs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mailboxer_conversation_opt_outs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mailboxer_conversation_opt_outs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mailboxer_conversation_opt_outs_id_seq OWNED BY mailboxer_conversation_opt_outs.id;


--
-- Name: mailboxer_conversations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mailboxer_conversations (
    id integer NOT NULL,
    subject character varying DEFAULT ''::character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: mailboxer_conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mailboxer_conversations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mailboxer_conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mailboxer_conversations_id_seq OWNED BY mailboxer_conversations.id;


--
-- Name: mailboxer_notifications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mailboxer_notifications (
    id integer NOT NULL,
    type character varying,
    body text,
    subject character varying DEFAULT ''::character varying,
    sender_id integer,
    sender_type character varying,
    conversation_id integer,
    draft boolean DEFAULT false,
    notification_code character varying,
    notified_object_id integer,
    notified_object_type character varying,
    attachment character varying,
    updated_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone NOT NULL,
    global boolean DEFAULT false,
    expires timestamp without time zone
);


--
-- Name: mailboxer_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mailboxer_notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mailboxer_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mailboxer_notifications_id_seq OWNED BY mailboxer_notifications.id;


--
-- Name: mailboxer_receipts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mailboxer_receipts (
    id integer NOT NULL,
    receiver_id integer,
    receiver_type character varying,
    notification_id integer NOT NULL,
    is_read boolean DEFAULT false,
    trashed boolean DEFAULT false,
    deleted boolean DEFAULT false,
    mailbox_type character varying(25),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: mailboxer_receipts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mailboxer_receipts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mailboxer_receipts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mailboxer_receipts_id_seq OWNED BY mailboxer_receipts.id;


--
-- Name: offers_and_requests; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE offers_and_requests (
    id integer NOT NULL,
    title character varying,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer NOT NULL,
    offer_or_request character varying,
    type character varying,
    pod_id integer
);


--
-- Name: offers_and_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE offers_and_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: offers_and_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE offers_and_requests_id_seq OWNED BY offers_and_requests.id;


--
-- Name: organization_memberships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE organization_memberships (
    id integer NOT NULL,
    organization_id integer NOT NULL,
    user_id integer NOT NULL,
    membership_types character varying[] DEFAULT '{}'::character varying[],
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: organization_memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE organization_memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organization_memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE organization_memberships_id_seq OWNED BY organization_memberships.id;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE organizations (
    id integer NOT NULL,
    name character varying NOT NULL,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    latlng geometry(Point),
    address_json json,
    caps_cents integer DEFAULT 0 NOT NULL,
    CONSTRAINT check_caps_cents CHECK ((caps_cents >= 0))
);


--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE organizations_id_seq OWNED BY organizations.id;


--
-- Name: pod_memberships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pod_memberships (
    id integer NOT NULL,
    pod_id integer NOT NULL,
    user_id integer NOT NULL,
    membership_types character varying[] DEFAULT '{}'::character varying[],
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pod_memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pod_memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pod_memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pod_memberships_id_seq OWNED BY pod_memberships.id;


--
-- Name: pod_organization_relations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pod_organization_relations (
    id integer NOT NULL,
    pod_id integer NOT NULL,
    organization_id integer NOT NULL,
    type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pod_organization_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pod_organization_relations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pod_organization_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pod_organization_relations_id_seq OWNED BY pod_organization_relations.id;


--
-- Name: pods; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pods (
    id integer NOT NULL,
    name character varying NOT NULL,
    description text,
    focus_area geometry(Polygon) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pods_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pods_id_seq OWNED BY pods.id;


--
-- Name: profiles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE profiles (
    id integer NOT NULL,
    given_name character varying,
    surname character varying,
    about_me text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer NOT NULL,
    accepted_currencies json,
    tagline character varying
);


--
-- Name: profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE profiles_id_seq OWNED BY profiles.id;


--
-- Name: references; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE "references" (
    id integer NOT NULL,
    from_user_id integer NOT NULL,
    to_user_id integer NOT NULL,
    reference text,
    rating integer,
    offer_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: references_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE references_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: references_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE references_id_seq OWNED BY "references".id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    invitation_token character varying,
    invitation_created_at timestamp without time zone,
    invitation_sent_at timestamp without time zone,
    invitation_accepted_at timestamp without time zone,
    invitation_limit integer,
    invited_by_id integer,
    invited_by_type character varying,
    invitations_count integer DEFAULT 0,
    is_admin boolean DEFAULT false NOT NULL,
    preferences_json json,
    postal_code character varying(32),
    home_location geometry(Point),
    caps_cents integer DEFAULT 0 NOT NULL,
    CONSTRAINT check_caps_cents CHECK ((caps_cents >= 0))
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY active_admin_comments ALTER COLUMN id SET DEFAULT nextval('active_admin_comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY caps_transactions ALTER COLUMN id SET DEFAULT nextval('caps_transactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY community_offer_details ALTER COLUMN id SET DEFAULT nextval('community_offer_details_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mailboxer_conversation_opt_outs ALTER COLUMN id SET DEFAULT nextval('mailboxer_conversation_opt_outs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mailboxer_conversations ALTER COLUMN id SET DEFAULT nextval('mailboxer_conversations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mailboxer_notifications ALTER COLUMN id SET DEFAULT nextval('mailboxer_notifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mailboxer_receipts ALTER COLUMN id SET DEFAULT nextval('mailboxer_receipts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY offers_and_requests ALTER COLUMN id SET DEFAULT nextval('offers_and_requests_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY organization_memberships ALTER COLUMN id SET DEFAULT nextval('organization_memberships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY organizations ALTER COLUMN id SET DEFAULT nextval('organizations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pod_memberships ALTER COLUMN id SET DEFAULT nextval('pod_memberships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pod_organization_relations ALTER COLUMN id SET DEFAULT nextval('pod_organization_relations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pods ALTER COLUMN id SET DEFAULT nextval('pods_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY profiles ALTER COLUMN id SET DEFAULT nextval('profiles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "references" ALTER COLUMN id SET DEFAULT nextval('references_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: active_admin_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY active_admin_comments
    ADD CONSTRAINT active_admin_comments_pkey PRIMARY KEY (id);


--
-- Name: caps_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY caps_transactions
    ADD CONSTRAINT caps_transactions_pkey PRIMARY KEY (id);


--
-- Name: community_offer_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY community_offer_details
    ADD CONSTRAINT community_offer_details_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: mailboxer_conversation_opt_outs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mailboxer_conversation_opt_outs
    ADD CONSTRAINT mailboxer_conversation_opt_outs_pkey PRIMARY KEY (id);


--
-- Name: mailboxer_conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mailboxer_conversations
    ADD CONSTRAINT mailboxer_conversations_pkey PRIMARY KEY (id);


--
-- Name: mailboxer_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mailboxer_notifications
    ADD CONSTRAINT mailboxer_notifications_pkey PRIMARY KEY (id);


--
-- Name: mailboxer_receipts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mailboxer_receipts
    ADD CONSTRAINT mailboxer_receipts_pkey PRIMARY KEY (id);


--
-- Name: offers_and_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY offers_and_requests
    ADD CONSTRAINT offers_and_requests_pkey PRIMARY KEY (id);


--
-- Name: organization_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY organization_memberships
    ADD CONSTRAINT organization_memberships_pkey PRIMARY KEY (id);


--
-- Name: organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: pod_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pod_memberships
    ADD CONSTRAINT pod_memberships_pkey PRIMARY KEY (id);


--
-- Name: pod_organization_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pod_organization_relations
    ADD CONSTRAINT pod_organization_relations_pkey PRIMARY KEY (id);


--
-- Name: pods_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pods
    ADD CONSTRAINT pods_pkey PRIMARY KEY (id);


--
-- Name: profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: references_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY "references"
    ADD CONSTRAINT references_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: collection_select_index; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX collection_select_index ON offers_and_requests USING btree (offer_or_request, pod_id, created_at);


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_namespace ON active_admin_comments USING btree (namespace);


--
-- Name: index_active_admin_comments_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_resource_type_and_resource_id ON active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_caps_transactions_on_destination_type_and_destination_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_caps_transactions_on_destination_type_and_destination_id ON caps_transactions USING btree (destination_type, destination_id);


--
-- Name: index_caps_transactions_on_source_type_and_source_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_caps_transactions_on_source_type_and_source_id ON caps_transactions USING btree (source_type, source_id);


--
-- Name: index_events_on_latlng; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_events_on_latlng ON events USING gist (latlng);


--
-- Name: index_mailboxer_conversation_opt_outs_on_conversation_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_mailboxer_conversation_opt_outs_on_conversation_id ON mailboxer_conversation_opt_outs USING btree (conversation_id);


--
-- Name: index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type ON mailboxer_conversation_opt_outs USING btree (unsubscriber_id, unsubscriber_type);


--
-- Name: index_mailboxer_notifications_on_conversation_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_mailboxer_notifications_on_conversation_id ON mailboxer_notifications USING btree (conversation_id);


--
-- Name: index_mailboxer_notifications_on_notified_object_id_and_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_mailboxer_notifications_on_notified_object_id_and_type ON mailboxer_notifications USING btree (notified_object_id, notified_object_type);


--
-- Name: index_mailboxer_notifications_on_sender_id_and_sender_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_mailboxer_notifications_on_sender_id_and_sender_type ON mailboxer_notifications USING btree (sender_id, sender_type);


--
-- Name: index_mailboxer_notifications_on_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_mailboxer_notifications_on_type ON mailboxer_notifications USING btree (type);


--
-- Name: index_mailboxer_receipts_on_notification_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_mailboxer_receipts_on_notification_id ON mailboxer_receipts USING btree (notification_id);


--
-- Name: index_mailboxer_receipts_on_receiver_id_and_receiver_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_mailboxer_receipts_on_receiver_id_and_receiver_type ON mailboxer_receipts USING btree (receiver_id, receiver_type);


--
-- Name: index_organization_memberships_on_membership_types; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_organization_memberships_on_membership_types ON organization_memberships USING gin (membership_types);


--
-- Name: index_organization_memberships_on_organization_id_and_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_organization_memberships_on_organization_id_and_user_id ON organization_memberships USING btree (organization_id, user_id);


--
-- Name: index_organizations_on_latlng; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_organizations_on_latlng ON organizations USING gist (latlng);


--
-- Name: index_pod_memberships_on_membership_types; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_pod_memberships_on_membership_types ON pod_memberships USING gin (membership_types);


--
-- Name: index_pod_memberships_on_pod_id_and_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_pod_memberships_on_pod_id_and_user_id ON pod_memberships USING btree (pod_id, user_id);


--
-- Name: index_pods_on_focus_area; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_pods_on_focus_area ON pods USING gist (focus_area);


--
-- Name: index_references_on_offer_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_references_on_offer_id ON "references" USING btree (offer_id);


--
-- Name: index_references_on_to_user_id_and_from_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_references_on_to_user_id_and_from_user_id ON "references" USING btree (to_user_id, from_user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_home_location; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_home_location ON users USING gist (home_location);


--
-- Name: index_users_on_invitation_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_invitation_token ON users USING btree (invitation_token);


--
-- Name: index_users_on_invitations_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_invitations_count ON users USING btree (invitations_count);


--
-- Name: index_users_on_invited_by_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_invited_by_id ON users USING btree (invited_by_id);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: type_collection_select_index; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX type_collection_select_index ON offers_and_requests USING btree (type, pod_id, created_at);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: fk_rails_14c4175c9a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY events
    ADD CONSTRAINT fk_rails_14c4175c9a FOREIGN KEY (organization_id) REFERENCES organizations(id) ON DELETE SET NULL;


--
-- Name: fk_rails_1e460d0870; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY events
    ADD CONSTRAINT fk_rails_1e460d0870 FOREIGN KEY (created_by_user_id) REFERENCES users(id) ON DELETE SET NULL;


--
-- Name: fk_rails_2f7a21261b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pod_memberships
    ADD CONSTRAINT fk_rails_2f7a21261b FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;


--
-- Name: fk_rails_3ac22443e0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY organization_memberships
    ADD CONSTRAINT fk_rails_3ac22443e0 FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;


--
-- Name: fk_rails_3e29a51c14; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pod_organization_relations
    ADD CONSTRAINT fk_rails_3e29a51c14 FOREIGN KEY (pod_id) REFERENCES pods(id);


--
-- Name: fk_rails_4a66f25904; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pod_organization_relations
    ADD CONSTRAINT fk_rails_4a66f25904 FOREIGN KEY (organization_id) REFERENCES organizations(id);


--
-- Name: fk_rails_54d95b05c2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY offers_and_requests
    ADD CONSTRAINT fk_rails_54d95b05c2 FOREIGN KEY (pod_id) REFERENCES pods(id) ON DELETE SET NULL;


--
-- Name: fk_rails_8b205d6f94; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pod_memberships
    ADD CONSTRAINT fk_rails_8b205d6f94 FOREIGN KEY (pod_id) REFERENCES pods(id) ON DELETE CASCADE;


--
-- Name: fk_rails_b67ad19978; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY profiles
    ADD CONSTRAINT fk_rails_b67ad19978 FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;


--
-- Name: fk_rails_baa9388a8c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY events
    ADD CONSTRAINT fk_rails_baa9388a8c FOREIGN KEY (pod_id) REFERENCES pods(id) ON DELETE SET NULL;


--
-- Name: fk_rails_d30e756f11; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY offers_and_requests
    ADD CONSTRAINT fk_rails_d30e756f11 FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;


--
-- Name: fk_rails_e9619923bd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY organization_memberships
    ADD CONSTRAINT fk_rails_e9619923bd FOREIGN KEY (organization_id) REFERENCES organizations(id) ON DELETE CASCADE;


--
-- Name: fk_rails_f634527362; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY community_offer_details
    ADD CONSTRAINT fk_rails_f634527362 FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE;


--
-- Name: mb_opt_outs_on_conversations_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mailboxer_conversation_opt_outs
    ADD CONSTRAINT mb_opt_outs_on_conversations_id FOREIGN KEY (conversation_id) REFERENCES mailboxer_conversations(id);


--
-- Name: notifications_on_conversation_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mailboxer_notifications
    ADD CONSTRAINT notifications_on_conversation_id FOREIGN KEY (conversation_id) REFERENCES mailboxer_conversations(id);


--
-- Name: receipts_on_notification_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mailboxer_receipts
    ADD CONSTRAINT receipts_on_notification_id FOREIGN KEY (notification_id) REFERENCES mailboxer_notifications(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20150120025951');

INSERT INTO schema_migrations (version) VALUES ('20150120032130');

INSERT INTO schema_migrations (version) VALUES ('20150120034420');

INSERT INTO schema_migrations (version) VALUES ('20150120053346');

INSERT INTO schema_migrations (version) VALUES ('20150120054257');

INSERT INTO schema_migrations (version) VALUES ('20150122035449');

INSERT INTO schema_migrations (version) VALUES ('20150122035450');

INSERT INTO schema_migrations (version) VALUES ('20150122035451');

INSERT INTO schema_migrations (version) VALUES ('20150125025830');

INSERT INTO schema_migrations (version) VALUES ('20150127020303');

INSERT INTO schema_migrations (version) VALUES ('20150127022304');

INSERT INTO schema_migrations (version) VALUES ('20150130005733');

INSERT INTO schema_migrations (version) VALUES ('20150202200359');

INSERT INTO schema_migrations (version) VALUES ('20150203000522');

INSERT INTO schema_migrations (version) VALUES ('20150203010913');

INSERT INTO schema_migrations (version) VALUES ('20150206221709');

INSERT INTO schema_migrations (version) VALUES ('20150206230223');

INSERT INTO schema_migrations (version) VALUES ('20150206235701');

INSERT INTO schema_migrations (version) VALUES ('20150207200152');

INSERT INTO schema_migrations (version) VALUES ('20150208001946');

INSERT INTO schema_migrations (version) VALUES ('20150213202417');

INSERT INTO schema_migrations (version) VALUES ('20150213205005');

INSERT INTO schema_migrations (version) VALUES ('20150213210056');

INSERT INTO schema_migrations (version) VALUES ('20150214213729');

INSERT INTO schema_migrations (version) VALUES ('20150214213807');

INSERT INTO schema_migrations (version) VALUES ('20150216191218');

INSERT INTO schema_migrations (version) VALUES ('20150216230150');

INSERT INTO schema_migrations (version) VALUES ('20150221170752');

INSERT INTO schema_migrations (version) VALUES ('20150221170841');

INSERT INTO schema_migrations (version) VALUES ('20150221172449');

INSERT INTO schema_migrations (version) VALUES ('20150221191130');

INSERT INTO schema_migrations (version) VALUES ('20150221192849');

INSERT INTO schema_migrations (version) VALUES ('20150221193432');

INSERT INTO schema_migrations (version) VALUES ('20150223175807');

INSERT INTO schema_migrations (version) VALUES ('20150223233950');

INSERT INTO schema_migrations (version) VALUES ('20150302173356');

INSERT INTO schema_migrations (version) VALUES ('20150302181034');

INSERT INTO schema_migrations (version) VALUES ('20150302182226');

INSERT INTO schema_migrations (version) VALUES ('20150303014323');

INSERT INTO schema_migrations (version) VALUES ('20150309221553');

INSERT INTO schema_migrations (version) VALUES ('20150312035146');

INSERT INTO schema_migrations (version) VALUES ('20150322203034');

INSERT INTO schema_migrations (version) VALUES ('20150322213400');

INSERT INTO schema_migrations (version) VALUES ('20150322221028');

INSERT INTO schema_migrations (version) VALUES ('20150322233427');

INSERT INTO schema_migrations (version) VALUES ('20150403184634');

INSERT INTO schema_migrations (version) VALUES ('20150403233351');

INSERT INTO schema_migrations (version) VALUES ('20150411164831');

INSERT INTO schema_migrations (version) VALUES ('20150424210041');

INSERT INTO schema_migrations (version) VALUES ('20150509205154');

INSERT INTO schema_migrations (version) VALUES ('20150509205227');

INSERT INTO schema_migrations (version) VALUES ('20150513021218');

