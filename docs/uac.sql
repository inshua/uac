--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uac; Type: SCHEMA; Schema: -; Owner: uac
--

CREATE SCHEMA uac;


ALTER SCHEMA uac OWNER TO uac;

--
-- Name: SCHEMA uac; Type: COMMENT; Schema: -; Owner: uac
--

COMMENT ON SCHEMA uac IS 'standard public schema';


SET search_path = uac, pg_catalog;

--
-- Name: channel_price_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE channel_price_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE channel_price_seq OWNER TO uac;

--
-- Name: channel_subscription_sources_id_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE channel_subscription_sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE channel_subscription_sources_id_seq OWNER TO uac;

--
-- Name: code_log_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE code_log_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE code_log_seq OWNER TO uac;

--
-- Name: employee_id_seq1; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE employee_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE employee_id_seq1 OWNER TO uac;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: employee; Type: TABLE; Schema: uac; Owner: uac
--

CREATE TABLE employee (
    id integer DEFAULT nextval('employee_id_seq1'::regclass) NOT NULL,
    employee_no character varying(128),
    person integer NOT NULL,
    state character(1) NOT NULL,
    nodes integer[],
    sys_stations integer[],
    CONSTRAINT ckc_state_employee CHECK ((state = ANY (ARRAY['A'::bpchar, 'D'::bpchar, 'P'::bpchar, 'N'::bpchar])))
);


ALTER TABLE employee OWNER TO uac;

--
-- Name: person; Type: TABLE; Schema: uac; Owner: uac
--

CREATE TABLE person (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    photo text,
    address character varying(200),
    tel character varying(20),
    mobile character varying(40),
    wechat character varying(40),
    username character varying(40),
    password character varying(40),
    email character varying(60),
    nationality character varying(20)[],
    birth date,
    gender character(1),
    id_card character(30),
    tag jsonb,
    unionid character varying(255),
    brief character varying(200) DEFAULT ''::character varying,
    weibo character varying(128) DEFAULT ''::character varying,
    qq character varying(128) DEFAULT ''::character varying,
    weixin character varying(128) DEFAULT ''::character varying,
    qq_name character varying(200) DEFAULT ''::character varying,
    weibo_name character varying(200) DEFAULT ''::character varying,
    weixin_name character varying(200) DEFAULT ''::character varying,
    state bigint DEFAULT 0,
    create_time bigint DEFAULT 0
);


ALTER TABLE person OWNER TO uac;

--
-- Name: TABLE person; Type: COMMENT; Schema: uac; Owner: uac
--

COMMENT ON TABLE person IS '个人在整个平台是一个超越性的独立存在，其资料可通过维护人员创建，但不能删除。其可在全平台有一个统一登录方式。';


--
-- Name: COLUMN person.photo; Type: COMMENT; Schema: uac; Owner: uac
--

COMMENT ON COLUMN person.photo IS '存储html5 data url';


--
-- Name: employee_id_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE employee_id_seq OWNER TO uac;

--
-- Name: employee_id_seq; Type: SEQUENCE OWNED BY; Schema: uac; Owner: uac
--

ALTER SEQUENCE employee_id_seq OWNED BY person.id;


--
-- Name: employee_station_id_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE employee_station_id_seq
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE employee_station_id_seq OWNER TO uac;

--
-- Name: employee_station; Type: TABLE; Schema: uac; Owner: uac
--

CREATE TABLE employee_station (
    id integer DEFAULT nextval('employee_station_id_seq'::regclass) NOT NULL,
    employee integer NOT NULL,
    station integer NOT NULL,
    kind character(1) DEFAULT 'B'::bpchar,
    is_member "char",
    CONSTRAINT ckc_kind_employee CHECK (((kind IS NULL) OR (kind = ANY (ARRAY['B'::bpchar, 'T'::bpchar, 'P'::bpchar, 'L'::bpchar, 'G'::bpchar]))))
);


ALTER TABLE employee_station OWNER TO uac;

--
-- Name: COLUMN employee_station.kind; Type: COMMENT; Schema: uac; Owner: uac
--

COMMENT ON COLUMN employee_station.kind IS '对于岗位性质为正式的，支持任职性质为正式流动兼职等所有选项
对于岗位性质为流动的，仅支持流动
对于岗位性质为实习的，支持正式、流动、兼职等所有选项
该项法则在运行中再细化。';


--
-- Name: event_id_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE event_id_seq OWNER TO uac;

--
-- Name: exam_plan_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE exam_plan_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exam_plan_seq OWNER TO uac;

--
-- Name: exam_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE exam_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exam_seq OWNER TO uac;

--
-- Name: gf_channel_id_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE gf_channel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE gf_channel_id_seq OWNER TO uac;

--
-- Name: gf_code_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE gf_code_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE gf_code_seq OWNER TO uac;

--
-- Name: gf_privilege_id_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE gf_privilege_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE gf_privilege_id_seq OWNER TO uac;

--
-- Name: group_id_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE group_id_seq OWNER TO uac;

--
-- Name: image_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE image_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE image_seq OWNER TO uac;

--
-- Name: login_log; Type: TABLE; Schema: uac; Owner: uac
--

CREATE TABLE login_log (
    id integer NOT NULL,
    person integer,
    login_d timestamp(6) without time zone,
    action character(1),
    description text,
    address character varying(60),
    session_id character varying(100),
    result character(1),
    result_desc text,
    login_mode character(1),
    device_id character varying(400),
    CONSTRAINT ckc_action_login_lo CHECK (((action IS NULL) OR (action = ANY (ARRAY['L'::bpchar, 'R'::bpchar, 'O'::bpchar])))),
    CONSTRAINT ckc_login_mode_login_lo CHECK (((login_mode IS NULL) OR (login_mode = ANY (ARRAY['B'::bpchar, 'S'::bpchar, 'M'::bpchar])))),
    CONSTRAINT ckc_result_login_lo CHECK (((result IS NULL) OR (result = ANY (ARRAY['S'::bpchar, 'F'::bpchar, 'E'::bpchar]))))
);


ALTER TABLE login_log OWNER TO uac;

--
-- Name: TABLE login_log; Type: COMMENT; Schema: uac; Owner: uac
--

COMMENT ON TABLE login_log IS '登录（含切换角色）都做记录';


--
-- Name: COLUMN login_log.description; Type: COMMENT; Schema: uac; Owner: uac
--

COMMENT ON COLUMN login_log.description IS '登录时使用的用户名、密码、或记忆的鉴权码，单点登录的鉴权码。';


--
-- Name: COLUMN login_log.result_desc; Type: COMMENT; Schema: uac; Owner: uac
--

COMMENT ON COLUMN login_log.result_desc IS '如为切换角色，记录当时的角色信息等
普通登录可留空
如登录失败，应说明失败原因（密码错误、鉴权码过期等）';


--
-- Name: COLUMN login_log.device_id; Type: COMMENT; Schema: uac; Owner: uac
--

COMMENT ON COLUMN login_log.device_id IS '如为浏览器，提供 browser_浏览器agent名
如为iPhone，提供为 iPhone_型号_设备号
如为iPad，提供为 iPad_型号_设备号
如为android，提供为 android_品牌型号_设备号';


--
-- Name: login_log_id_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE login_log_id_seq
    START WITH 423
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE login_log_id_seq OWNER TO uac;

--
-- Name: login_log_id_seq; Type: SEQUENCE OWNED BY; Schema: uac; Owner: uac
--

ALTER SEQUENCE login_log_id_seq OWNED BY login_log.id;


--
-- Name: node_id_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE node_id_seq
    START WITH 8
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE node_id_seq OWNER TO uac;

--
-- Name: node; Type: TABLE; Schema: uac; Owner: uac
--

CREATE TABLE node (
    id numeric DEFAULT nextval('node_id_seq'::regclass) NOT NULL,
    parent_id numeric,
    name character varying(200),
    type character varying(50),
    def jsonb,
    path integer[]
);


ALTER TABLE node OWNER TO uac;

--
-- Name: COLUMN node.type; Type: COMMENT; Schema: uac; Owner: uac
--

COMMENT ON COLUMN node.type IS '直接和相关表表名对应，如 HOSPITAL';


--
-- Name: seq_nonentity; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE seq_nonentity
    START WITH 1651
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_nonentity OWNER TO uac;

--
-- Name: node_allowed_children_type; Type: TABLE; Schema: uac; Owner: uac
--

CREATE TABLE node_allowed_children_type (
    parent_type character varying(200),
    child_type character varying(200),
    id numeric DEFAULT nextval('seq_nonentity'::regclass) NOT NULL
);


ALTER TABLE node_allowed_children_type OWNER TO uac;

--
-- Name: notify_id_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE notify_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE notify_id_seq OWNER TO uac;

--
-- Name: operation_log; Type: TABLE; Schema: uac; Owner: uac
--

CREATE TABLE operation_log (
    id integer NOT NULL,
    person integer,
    address character varying(200),
    sessionid character varying(40),
    start_time bigint,
    end_time bigint,
    function_code character varying(200),
    apply_table character varying(200),
    row_id integer,
    op_desc character varying(4000),
    result character(1),
    result_desc text,
    CONSTRAINT ckc_result_operatio CHECK (((result IS NULL) OR (result = ANY (ARRAY['S'::bpchar, 'F'::bpchar, 'E'::bpchar, 'A'::bpchar]))))
);


ALTER TABLE operation_log OWNER TO uac;

--
-- Name: TABLE operation_log; Type: COMMENT; Schema: uac; Owner: uac
--

COMMENT ON TABLE operation_log IS '如果是表操作，应增加表操作变动记录。其它非表操作不需要。';


--
-- Name: person_station_id_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE person_station_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE person_station_id_seq OWNER TO uac;

--
-- Name: push_id_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE push_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999999
    CACHE 1;


ALTER TABLE push_id_seq OWNER TO uac;

--
-- Name: SEQUENCE push_id_seq; Type: COMMENT; Schema: uac; Owner: uac
--

COMMENT ON SEQUENCE push_id_seq IS 'push序列';


--
-- Name: seq_entity; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE seq_entity
    START WITH 776
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_entity OWNER TO uac;

--
-- Name: seq_operation_log; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE seq_operation_log
    START WITH 1259
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_operation_log OWNER TO uac;

--
-- Name: sub_function; Type: TABLE; Schema: uac; Owner: uac
--

CREATE TABLE sub_function (
    id numeric NOT NULL,
    name character varying(100),
    sys_function numeric,
    menu_index numeric,
    state character(1),
    code character varying(100),
    dependence character varying(500)
);


ALTER TABLE sub_function OWNER TO uac;

--
-- Name: TABLE sub_function; Type: COMMENT; Schema: uac; Owner: uac
--

COMMENT ON TABLE sub_function IS '子操作可以由系统功能URI提供。提供方式为：
当设定URI后，点击自动获取子操作按钮，此时向该URI发出带有 _m=listOp 的查询字符串，如果URI支持自说明，则根据URI返回的自说明自动生成子操作。
自说明格式如：
[
  {name : ''增加'', code : ''add'', state : ''N''} ,
  {name : ''修改'', code : ''edit'', state : ''N''} ,
]';


--
-- Name: COLUMN sub_function.dependence; Type: COMMENT; Schema: uac; Owner: uac
--

COMMENT ON COLUMN sub_function.dependence IS '依赖操作无权时,操作也无权';


--
-- Name: sys_function; Type: TABLE; Schema: uac; Owner: uac
--

CREATE TABLE sys_function (
    id numeric NOT NULL,
    name character varying(100) NOT NULL,
    parent_id numeric,
    menu_index numeric,
    state character(1) NOT NULL,
    developer numeric,
    code character varying(200) NOT NULL,
    uri character varying(200),
    open_mode character(1),
    icon_url character varying(1024),
    remarks character varying(500)
);


ALTER TABLE sys_function OWNER TO uac;

--
-- Name: TABLE sys_function; Type: COMMENT; Schema: uac; Owner: uac
--

COMMENT ON TABLE sys_function IS '可多重嵌套。唯最后一级才具有 URI。';


--
-- Name: COLUMN sys_function.uri; Type: COMMENT; Schema: uac; Owner: uac
--

COMMENT ON COLUMN sys_function.uri IS '打开功能对应的URI';


--
-- Name: sys_role; Type: TABLE; Schema: uac; Owner: uac
--

CREATE TABLE sys_role (
    id numeric NOT NULL,
    node numeric NOT NULL,
    name character varying(100) NOT NULL,
    state character(1) NOT NULL,
    role_level numeric(5,0),
    node_scope character(1) NOT NULL,
    remarks character varying(2000),
    code character varying(100)
);


ALTER TABLE sys_role OWNER TO uac;

--
-- Name: sys_role_code; Type: TABLE; Schema: uac; Owner: uac
--

CREATE TABLE sys_role_code (
    id integer NOT NULL,
    code character varying(40) NOT NULL,
    meaning character varying(40),
    allow_node_types character varying(20)[]
);


ALTER TABLE sys_role_code OWNER TO uac;

--
-- Name: TABLE sys_role_code; Type: COMMENT; Schema: uac; Owner: uac
--

COMMENT ON TABLE sys_role_code IS '系统角色代码表存储哪些类型的机构运行存在哪些角色代码，角色代码相当于职业。';


--
-- Name: COLUMN sys_role_code.allow_node_types; Type: COMMENT; Schema: uac; Owner: uac
--

COMMENT ON COLUMN sys_role_code.allow_node_types IS '表名，如 AIRLINE, CONSULINT_COMPANY，数组';


--
-- Name: sys_role_code_id_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE sys_role_code_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sys_role_code_id_seq OWNER TO uac;

--
-- Name: sys_role_code_id_seq; Type: SEQUENCE OWNED BY; Schema: uac; Owner: uac
--

ALTER SEQUENCE sys_role_code_id_seq OWNED BY sys_role_code.id;


--
-- Name: sys_role_function; Type: TABLE; Schema: uac; Owner: uac
--

CREATE TABLE sys_role_function (
    id numeric NOT NULL,
    sys_role numeric NOT NULL,
    sys_function numeric NOT NULL,
    dispatch_mode character(1)
);


ALTER TABLE sys_role_function OWNER TO uac;

--
-- Name: sys_role_sub_function; Type: TABLE; Schema: uac; Owner: uac
--

CREATE TABLE sys_role_sub_function (
    id numeric NOT NULL,
    sys_role numeric NOT NULL,
    sub_function numeric NOT NULL,
    dispatch_mode character(1) NOT NULL
);


ALTER TABLE sys_role_sub_function OWNER TO uac;

--
-- Name: COLUMN sys_role_sub_function.dispatch_mode; Type: COMMENT; Schema: uac; Owner: uac
--

COMMENT ON COLUMN sys_role_sub_function.dispatch_mode IS '为了防止增加子功能带来大量对角色赋权的动作，除非明确拒绝，角色自动具有对功能下所有子操作的权限。
当角色创建其它角色时，自动将不可转授的子操作标记为 D 并转入所建角色。';


--
-- Name: sys_station; Type: TABLE; Schema: uac; Owner: uac
--

CREATE TABLE sys_station (
    id integer NOT NULL,
    node integer,
    state character(1),
    remarks character varying(4000),
    visibility character(1) DEFAULT 'V'::bpchar,
    name character varying(100),
    kind character(1),
    CONSTRAINT ckc_status_sys_stat CHECK (((state IS NULL) OR (state = ANY (ARRAY['N'::bpchar, 'D'::bpchar])))),
    CONSTRAINT ckc_visibility_sys_stat CHECK (((visibility IS NULL) OR (visibility = ANY (ARRAY['V'::bpchar, 'H'::bpchar]))))
);


ALTER TABLE sys_station OWNER TO uac;

--
-- Name: COLUMN sys_station.visibility; Type: COMMENT; Schema: uac; Owner: uac
--

COMMENT ON COLUMN sys_station.visibility IS '不可见是指赋予该岗位的人不可见';


--
-- Name: sys_station_id_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE sys_station_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sys_station_id_seq OWNER TO uac;

--
-- Name: sys_station_id_seq; Type: SEQUENCE OWNED BY; Schema: uac; Owner: uac
--

ALTER SEQUENCE sys_station_id_seq OWNED BY sys_station.id;


--
-- Name: sys_station_role_dispatch; Type: TABLE; Schema: uac; Owner: uac
--

CREATE TABLE sys_station_role_dispatch (
    id integer NOT NULL,
    sys_station integer,
    sys_role integer,
    bind_node integer
);


ALTER TABLE sys_station_role_dispatch OWNER TO uac;

--
-- Name: COLUMN sys_station_role_dispatch.bind_node; Type: COMMENT; Schema: uac; Owner: uac
--

COMMENT ON COLUMN sys_station_role_dispatch.bind_node IS '取值为null时使用岗位默认视野，岗位默认视野即岗位本身所属的单位的出发的视野范围。

当取值不为 null 时，视野从该单位出发。

例如，有的岗位属于人事部，但是可以观看全公司信息。
';


--
-- Name: sys_station_role_dispatch_id_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE sys_station_role_dispatch_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sys_station_role_dispatch_id_seq OWNER TO uac;

--
-- Name: sys_station_role_dispatch_id_seq; Type: SEQUENCE OWNED BY; Schema: uac; Owner: uac
--

ALTER SEQUENCE sys_station_role_dispatch_id_seq OWNED BY sys_station_role_dispatch.id;


--
-- Name: system_parameter_id_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE system_parameter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE system_parameter_id_seq OWNER TO uac;

--
-- Name: train_course_id_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE train_course_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE train_course_id_seq OWNER TO uac;

--
-- Name: train_lesson_id_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE train_lesson_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE train_lesson_id_seq OWNER TO uac;

--
-- Name: train_student_learn_course_id_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE train_student_learn_course_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE train_student_learn_course_id_seq OWNER TO uac;

--
-- Name: train_student_progress_id_seq; Type: SEQUENCE; Schema: uac; Owner: uac
--

CREATE SEQUENCE train_student_progress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE train_student_progress_id_seq OWNER TO uac;

--
-- Name: vw_employee; Type: VIEW; Schema: uac; Owner: uac
--

CREATE VIEW vw_employee AS
 SELECT p.id,
    p.name,
    p.photo,
    p.address,
    p.tel,
    p.mobile,
    p.wechat,
    p.username,
    p.password,
    p.email,
    p.nationality,
    p.birth,
    p.gender,
    p.id_card,
    p.tag,
    e.employee_no,
    e.state,
    e.nodes,
    e.sys_stations,
    e.id AS employee
   FROM (person p
     LEFT JOIN employee e ON (((e.person = p.id) AND (e.state <> 'D'::bpchar))));


ALTER TABLE vw_employee OWNER TO uac;

--
-- Name: login_log id; Type: DEFAULT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY login_log ALTER COLUMN id SET DEFAULT nextval('login_log_id_seq'::regclass);


--
-- Name: person id; Type: DEFAULT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY person ALTER COLUMN id SET DEFAULT nextval('employee_id_seq'::regclass);


--
-- Name: sys_role_code id; Type: DEFAULT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY sys_role_code ALTER COLUMN id SET DEFAULT nextval('sys_role_code_id_seq'::regclass);


--
-- Name: sys_station id; Type: DEFAULT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY sys_station ALTER COLUMN id SET DEFAULT nextval('sys_station_id_seq'::regclass);


--
-- Name: sys_station_role_dispatch id; Type: DEFAULT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY sys_station_role_dispatch ALTER COLUMN id SET DEFAULT nextval('sys_station_role_dispatch_id_seq'::regclass);


--
-- Name: channel_price_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('channel_price_seq', 248, true);


--
-- Name: channel_subscription_sources_id_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('channel_subscription_sources_id_seq', 2215, true);


--
-- Name: code_log_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('code_log_seq', 203, true);


--
-- Data for Name: employee; Type: TABLE DATA; Schema: uac; Owner: uac
--

COPY employee (id, employee_no, person, state, nodes, sys_stations) FROM stdin;
1	1	0	A	{0}	{1405}
5	22	10170	A	\N	\N
3	4	10168	A	\N	\N
2	3	10167	A	\N	\N
6	332	10171	A	{535}	{1407}
10166	2	10166	A	{533,535}	{1405,1407}
\.


--
-- Name: employee_id_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('employee_id_seq', 34740, true);


--
-- Name: employee_id_seq1; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('employee_id_seq1', 6, true);


--
-- Data for Name: employee_station; Type: TABLE DATA; Schema: uac; Owner: uac
--

COPY employee_station (id, employee, station, kind, is_member) FROM stdin;
6	10166	1405	B	Y
22	10166	1407	B	Y
28	6	1407	T	Y
\.


--
-- Name: employee_station_id_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('employee_station_id_seq', 28, true);


--
-- Name: event_id_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('event_id_seq', 1, false);


--
-- Name: exam_plan_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('exam_plan_seq', 52, true);


--
-- Name: exam_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('exam_seq', 34, true);


--
-- Name: gf_channel_id_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('gf_channel_id_seq', 13, true);


--
-- Name: gf_code_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('gf_code_seq', 2045, true);


--
-- Name: gf_privilege_id_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('gf_privilege_id_seq', 22, true);


--
-- Name: group_id_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('group_id_seq', 3, true);


--
-- Name: image_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('image_seq', 38, true);


--
-- Data for Name: login_log; Type: TABLE DATA; Schema: uac; Owner: uac
--

COPY login_log (id, person, login_d, action, description, address, session_id, result, result_desc, login_mode, device_id) FROM stdin;
3919	0	\N	L	登录名为root,登录类型为用户名登录	localhost	50C408DF0A985A976B41B610C90721A2	S	root登录系统	B	\N
3920	0	\N	L	登录名为root,登录类型为用户名登录	localhost	8D951C4956F93838DD0B361246C11C4E	S	root登录系统	B	\N
3921	0	\N	L	登录名为root,登录类型为用户名登录	localhost	B17CCED8064BC8F6A99CD0EC18E52CE8	S	root登录系统	B	\N
3922	0	\N	L	登录名为root,登录类型为用户名登录	localhost	B17CCED8064BC8F6A99CD0EC18E52CE8	S	root登录系统	B	\N
3923	0	\N	L	登录名为root,登录类型为用户名登录	localhost	B17CCED8064BC8F6A99CD0EC18E52CE8	S	root登录系统	B	\N
3924	0	\N	L	登录名为root,登录类型为用户名登录	localhost	B17CCED8064BC8F6A99CD0EC18E52CE8	S	root登录系统	B	\N
3925	0	\N	L	登录名为root,登录类型为用户名登录	localhost	B17CCED8064BC8F6A99CD0EC18E52CE8	S	root登录系统	B	\N
3926	0	\N	L	登录名为root,登录类型为用户名登录	localhost	B17CCED8064BC8F6A99CD0EC18E52CE8	S	root登录系统	B	\N
3927	0	\N	L	登录名为root,登录类型为用户名登录	localhost	B17CCED8064BC8F6A99CD0EC18E52CE8	S	root登录系统	B	\N
3928	0	\N	L	登录名为root,登录类型为用户名登录	localhost	B17CCED8064BC8F6A99CD0EC18E52CE8	S	root登录系统	B	\N
3929	0	\N	L	登录名为root,登录类型为用户名登录	localhost	B17CCED8064BC8F6A99CD0EC18E52CE8	S	root登录系统	B	\N
3930	0	\N	L	登录名为root,登录类型为用户名登录	localhost	B17CCED8064BC8F6A99CD0EC18E52CE8	S	root登录系统	B	\N
3931	0	\N	L	登录名为root,登录类型为用户名登录	localhost	B17CCED8064BC8F6A99CD0EC18E52CE8	S	root登录系统	B	\N
3932	0	\N	L	登录名为root,登录类型为用户名登录	localhost	B17CCED8064BC8F6A99CD0EC18E52CE8	S	root登录系统	B	\N
3933	0	\N	L	登录名为root,登录类型为用户名登录	localhost	B17CCED8064BC8F6A99CD0EC18E52CE8	S	root登录系统	B	\N
3934	0	\N	L	登录名为root,登录类型为用户名登录	localhost	9D2B91C7056A1CA53A897A17D6F249D1	S	root登录系统	B	\N
3935	0	\N	L	登录名为root,登录类型为用户名登录	localhost	9D2B91C7056A1CA53A897A17D6F249D1	S	root登录系统	B	\N
\.


--
-- Name: login_log_id_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('login_log_id_seq', 3935, true);


--
-- Data for Name: node; Type: TABLE DATA; Schema: uac; Owner: uac
--

COPY node (id, parent_id, name, type, def, path) FROM stdin;
543	533	IBM Asia	COMPANY	{"tel": "2232", "remark": null, "address": "dae", "contactMan": "qqq"}	{0,533}
542	543	IBM India	COMPANY	{"tel": "dd", "remark": null, "address": "tt", "contactMan": "aa"}	{0,533,543}
533	0	IBM	COMPANY	{"tel": "222333dd", "remark": null, "address": "dddf", "contactMan": "22"}	{0}
536	543	IBM Japan	COMPANY	{"tel": "f", "remark": null, "address": "d", "contactMan": "e"}	{0,533,543}
538	535	保卫部	DEPT	{"tel": "d", "remark": null, "address": "adsf", "contactMan": "d"}	{0,533,543,535}
535	543	IBM China	COMPANY	{"tel": "cd", "remark": null, "address": "aa", "contactMan": "ba"}	{0,533,543}
544	535	IBM Beijing	COMPANY	{"tel": "23123", "remark": null, "address": "dd", "contactMan": "aq"}	{0,533,543,535}
0	\N	所有公司	ROOT	\N	{}
547	533	财务部	DEPT	{"tel": "22", "remark": null, "address": "daf", "contactMan": "2321"}	{0,533}
\.


--
-- Data for Name: node_allowed_children_type; Type: TABLE DATA; Schema: uac; Owner: uac
--

COPY node_allowed_children_type (parent_type, child_type, id) FROM stdin;
ROOT	SYS_USER	365
ROOT	SYS_ROLE	366
ROOT	GOVERNMENT	372
GOVERNMENT	GOVERNMENT	373
GOVERNMENT	SYS_USER	374
GOVERNMENT	SYS_ROLE	375
ROOT	COMPANY	1690
COMPANY	COMPANY	1691
COMPANY	SYS_ROLE	1692
COMPANY	DEPT	1708
DEPT	SYS_ROLE	1709
DEPT	SYS_STATION	1710
COMPANY	SYS_STATION	1711
DEPT	EMPLOYEE	3234
ROOT	EMPLOYEE	3236
COMPANY	EMPLOYEE	3235
\.


--
-- Name: node_id_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('node_id_seq', 547, true);


--
-- Name: notify_id_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('notify_id_seq', 24, true);


--
-- Data for Name: operation_log; Type: TABLE DATA; Schema: uac; Owner: uac
--

COPY operation_log (id, person, address, sessionid, start_time, end_time, function_code, apply_table, row_id, op_desc, result, result_desc) FROM stdin;
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: uac; Owner: uac
--

COPY person (id, name, photo, address, tel, mobile, wechat, username, password, email, nationality, birth, gender, id_card, tag, unionid, brief, weibo, qq, weixin, qq_name, weibo_name, weixin_name, state, create_time) FROM stdin;
10168	li	\N	aaa	\N	\N	\N	4	c984aed014aec7623a54f0591da07a85fd4b762d	\N	\N	\N	M	\N	{"Manager": "false"}	\N								0	0
10167	zhang	\N	ddd	\N	\N	\N	3	c984aed014aec7623a54f0591da07a85fd4b762d	\N	\N	\N	M	\N	{"Manager": "false"}	\N								0	0
10170	dd	\N	dd	\N	\N	\N	22	c984aed014aec7623a54f0591da07a85fd4b762d	\N	\N	\N	M	\N	{"Manager": "false"}	\N								0	0
0	root	http://121.40.216.238/Service/Attrachment/test.png	\N	\N	15980080080	\N	root	7c4a8d09ca3762af61e59520943dc26494f8941b	\N	\N	\N	M	510108166602021111            	{"intentDepatment": "gaaasdfasd"}	\N								0	0
10171	John	\N	xxz	\N	\N	\N	332	c984aed014aec7623a54f0591da07a85fd4b762d	\N	\N	2017-09-13	M	\N	{"Manager": "false"}	\N								0	0
10166	zhang	\N	ddddd	\N	2222	\N	2	c984aed014aec7623a54f0591da07a85fd4b762d	\N	\N	\N	M	\N	\N	\N								0	0
\.


--
-- Name: person_station_id_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('person_station_id_seq', 6, true);


--
-- Name: push_id_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('push_id_seq', 383, true);


--
-- Name: seq_entity; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('seq_entity', 10186, true);


--
-- Name: seq_nonentity; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('seq_nonentity', 3236, true);


--
-- Name: seq_operation_log; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('seq_operation_log', 1638, true);


--
-- Data for Name: sub_function; Type: TABLE DATA; Schema: uac; Owner: uac
--

COPY sub_function (id, name, sys_function, menu_index, state, code, dependence) FROM stdin;
2352	删除部门	1928	3	N	department.delete	department.query
2351	编辑部门	1928	2	N	department.edit	department.query
2354	增加公司表	1685	1	N	company.add	company.query
2353	查询公司表	1685	0	N	company.query	\N
2356	删除公司表	1685	3	N	company.delete	company.query
2355	编辑公司表	1685	2	N	company.edit	company.query
2350	增加部门	1928	1	N	department.add	department.query
2349	查询部门	1928	0	N	department.query	\N
2344	增加系统角色	1744	1	N	person.add	person.query
2343	查询系统角色	1744	0	N	person.query	\N
2346	删除系统角色	1744	3	N	person.delete	person.query
2345	编辑系统角色	1744	2	N	person.edit	person.query
2341	查询岗位代码表	1739	0	N	uac.sys_station.query	\N
2366	删除系统功能	10	3	N	uac.sys_function.delete	uac.sys_function.query
2361	编辑系统功能	10	2	N	uac.sys_function.edit	uac.sys_function.query
2369	编辑可能下属节点类型	1971	2	N	uac.node_allowed_children_type.edit	uac.node_allowed_children_type.query
2342	增加岗位代码表	1739	1	N	uac.sys_station.add	uac.sys_station.query
2348	删除岗位代码表	1739	3	N	uac.sys_station.delete	uac.sys_station.query
2347	编辑岗位代码表	1739	2	N	uac.sys_station.edit	uac.sys_station.query
3160	查询日志管理表	1753	0	N	uac.operation_log.query	\N
3161	查询系统角色	1755	0	N	uac.sys_role.query	\N
3162	查询登录日志表	1847	0	N	uac.login_log.query	\N
3163	增加系统角色	1755	1	N	uac.sys_role.add	uac.sys_role.query
3164	编辑系统角色	1755	2	N	uac.sys_role.edit	uac.sys_role.query
3165	删除系统角色	1755	3	N	uac.sys_role.delete	uac.sys_role.query
2367	查询可能下属节点类型	1971	0	N	uac.node_allowed_children_type.query	\N
2359	查询系统功能	10	0	N	uac.sys_function.query	\N
2368	增加可能下属节点类型	1971	1	N	uac.node_allowed_children_type.add	uac.node_allowed_children_type.query
2360	增加系统功能	10	1	N	uac.sys_function.add	uac.sys_function.query
2370	删除可能下属节点类型	1971	3	N	uac.node_allowed_children_type.delete	uac.node_allowed_children_type.query
\.


--
-- Data for Name: sys_function; Type: TABLE DATA; Schema: uac; Owner: uac
--

COPY sys_function (id, name, parent_id, menu_index, state, developer, code, uri, open_mode, icon_url, remarks) FROM stdin;
0	所有功能	\N	0	N	\N	all	empty	N	\N	\N
9	系统管理	0	12	N	\N	sys	\N	N	icon-lock	\N
602	组织机构管理	0	13	N	\N	entity	\N	N	icon-group	\N
1685	公司管理	602	0	N	\N	CompanyManage	/entity/company.jssp	C	\N	\N
1739	岗位设置	602	1	N	\N	StationManage	/uac/sys_station.jssp	C	\N	\N
1744	员工管理	602	2	N	\N	Person	/entity/person.jssp	C	\N	\N
1928	部门管理	602	3	N	\N	DepartmentManage	/entity/department.jssp	C	\N	\N
10	系统功能设置	9	0	N	\N	SysFunction	/uac/sys_function.jssp	C	\N	\N
1755	角色管理	9	1	N	\N	SysRole	/uac/sys_role.jssp	C	\N	\N
1753	操作日志管理	9	2	N	\N	OperationLog	/uac/operation_log.jssp	C	\N	\N
1847	登录日志管理	9	3	N	\N	LoginLog	/uac/login_log.jssp	C	\N	\N
1971	子类型管辖关系	9	4	N	\N	NodeAllowedChildrenType	/uac/node_allowed_children_type.jssp	C	\N	\N
\.


--
-- Data for Name: sys_role; Type: TABLE DATA; Schema: uac; Owner: uac
--

COPY sys_role (id, node, name, state, role_level, node_scope, remarks, code) FROM stdin;
10157	533	OP	N	1	R	\N	OP
10186	538	保卫部主管	N	2	R	\N	guard_mgr
\.


--
-- Data for Name: sys_role_code; Type: TABLE DATA; Schema: uac; Owner: uac
--

COPY sys_role_code (id, code, meaning, allow_node_types) FROM stdin;
1	pilot	飞行员	{AIRLINE}
\.


--
-- Name: sys_role_code_id_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('sys_role_code_id_seq', 1, true);


--
-- Data for Name: sys_role_function; Type: TABLE DATA; Schema: uac; Owner: uac
--

COPY sys_role_function (id, sys_role, sys_function, dispatch_mode) FROM stdin;
3166	10157	0	I
3167	10157	9	I
3168	10157	1753	T
3169	10157	1847	T
3170	10157	602	I
3171	10157	1685	I
3172	10157	1739	I
3173	10157	1744	I
3174	10157	1928	O
3192	10186	0	I
3193	10186	9	I
3194	10186	10	R
3195	10186	1755	R
3196	10186	1753	O
3197	10186	1847	R
3198	10186	1971	R
3199	10186	602	R
3200	10186	1685	R
3201	10186	1739	R
3202	10186	1744	R
3203	10186	1928	R
\.


--
-- Data for Name: sys_role_sub_function; Type: TABLE DATA; Schema: uac; Owner: uac
--

COPY sys_role_sub_function (id, sys_role, sub_function, dispatch_mode) FROM stdin;
3175	10157	3160	T
3176	10157	3162	T
3177	10157	2353	T
3178	10157	2341	T
3179	10157	2343	T
3180	10157	2349	T
3181	10157	2350	O
3182	10157	2351	O
3183	10157	2352	O
3204	10186	2359	R
3205	10186	2360	R
3206	10186	2361	R
3207	10186	2366	R
3208	10186	3161	R
3209	10186	3163	R
3210	10186	3164	R
3211	10186	3165	R
3212	10186	3160	O
3213	10186	3162	R
3214	10186	2367	R
3215	10186	2368	R
3216	10186	2369	R
3217	10186	2370	R
3218	10186	2353	R
3219	10186	2354	R
3220	10186	2355	R
3221	10186	2356	R
3222	10186	2341	R
3223	10186	2342	R
3224	10186	2347	R
3225	10186	2348	R
3226	10186	2343	R
3227	10186	2344	R
3228	10186	2345	R
3229	10186	2346	R
3230	10186	2349	R
3231	10186	2350	R
3232	10186	2351	R
3233	10186	2352	R
\.


--
-- Data for Name: sys_station; Type: TABLE DATA; Schema: uac; Owner: uac
--

COPY sys_station (id, node, state, remarks, visibility, name, kind) FROM stdin;
1405	533	N	\N	V	OPS	B
1407	535	N	\N	V	China OP	B
\.


--
-- Name: sys_station_id_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('sys_station_id_seq', 1407, true);


--
-- Data for Name: sys_station_role_dispatch; Type: TABLE DATA; Schema: uac; Owner: uac
--

COPY sys_station_role_dispatch (id, sys_station, sys_role, bind_node) FROM stdin;
470	1405	10157	533
472	1407	10157	535
\.


--
-- Name: sys_station_role_dispatch_id_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('sys_station_role_dispatch_id_seq', 472, true);


--
-- Name: system_parameter_id_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('system_parameter_id_seq', 26, true);


--
-- Name: train_course_id_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('train_course_id_seq', 66, true);


--
-- Name: train_lesson_id_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('train_lesson_id_seq', 56, true);


--
-- Name: train_student_learn_course_id_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('train_student_learn_course_id_seq', 86, true);


--
-- Name: train_student_progress_id_seq; Type: SEQUENCE SET; Schema: uac; Owner: uac
--

SELECT pg_catalog.setval('train_student_progress_id_seq', 53, true);


--
-- Name: node_allowed_children_type node_allowed_children_type_pkey; Type: CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY node_allowed_children_type
    ADD CONSTRAINT node_allowed_children_type_pkey PRIMARY KEY (id);


--
-- Name: node node_pkey; Type: CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY node
    ADD CONSTRAINT node_pkey PRIMARY KEY (id);


--
-- Name: person pk_employee; Type: CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY person
    ADD CONSTRAINT pk_employee PRIMARY KEY (id);


--
-- Name: employee pk_employee2; Type: CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY employee
    ADD CONSTRAINT pk_employee2 PRIMARY KEY (id);


--
-- Name: employee_station pk_employee_station; Type: CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY employee_station
    ADD CONSTRAINT pk_employee_station PRIMARY KEY (id);


--
-- Name: login_log pk_login_log; Type: CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY login_log
    ADD CONSTRAINT pk_login_log PRIMARY KEY (id);


--
-- Name: operation_log pk_operation_log; Type: CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY operation_log
    ADD CONSTRAINT pk_operation_log PRIMARY KEY (id);


--
-- Name: sys_role_code pk_sys_role_code; Type: CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY sys_role_code
    ADD CONSTRAINT pk_sys_role_code PRIMARY KEY (id);


--
-- Name: sys_station pk_sys_station; Type: CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY sys_station
    ADD CONSTRAINT pk_sys_station PRIMARY KEY (id);


--
-- Name: sys_station_role_dispatch pk_sys_station_role_dispatch; Type: CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY sys_station_role_dispatch
    ADD CONSTRAINT pk_sys_station_role_dispatch PRIMARY KEY (id);


--
-- Name: sub_function sub_function_pkey; Type: CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY sub_function
    ADD CONSTRAINT sub_function_pkey PRIMARY KEY (id);


--
-- Name: sys_function sys_function_pkey; Type: CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY sys_function
    ADD CONSTRAINT sys_function_pkey PRIMARY KEY (id);


--
-- Name: sys_role_function sys_role_function_pkey; Type: CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY sys_role_function
    ADD CONSTRAINT sys_role_function_pkey PRIMARY KEY (id);


--
-- Name: sys_role sys_role_pkey; Type: CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY sys_role
    ADD CONSTRAINT sys_role_pkey PRIMARY KEY (id);


--
-- Name: sys_role_sub_function sys_role_sub_function_pkey; Type: CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY sys_role_sub_function
    ADD CONSTRAINT sys_role_sub_function_pkey PRIMARY KEY (id);


--
-- Name: person_mobile; Type: INDEX; Schema: uac; Owner: uac
--

CREATE INDEX person_mobile ON person USING btree (mobile);


--
-- Name: person_qq; Type: INDEX; Schema: uac; Owner: uac
--

CREATE INDEX person_qq ON person USING btree (qq);


--
-- Name: person_unionid; Type: INDEX; Schema: uac; Owner: uac
--

CREATE INDEX person_unionid ON person USING btree (unionid);


--
-- Name: person_wechat; Type: INDEX; Schema: uac; Owner: uac
--

CREATE INDEX person_wechat ON person USING btree (wechat);


--
-- Name: person_weibo; Type: INDEX; Schema: uac; Owner: uac
--

CREATE INDEX person_weibo ON person USING btree (weibo);


--
-- Name: uq_sys_function_code; Type: INDEX; Schema: uac; Owner: uac
--

CREATE UNIQUE INDEX uq_sys_function_code ON sys_function USING btree (code);


--
-- Name: uq_sys_function_name; Type: INDEX; Schema: uac; Owner: uac
--

CREATE UNIQUE INDEX uq_sys_function_name ON sys_function USING btree (name);


--
-- Name: employee fk_employee_person_person_id; Type: FK CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY employee
    ADD CONSTRAINT fk_employee_person_person_id FOREIGN KEY (person) REFERENCES person(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: login_log fk_login_log_person_person_id; Type: FK CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY login_log
    ADD CONSTRAINT fk_login_log_person_person_id FOREIGN KEY (person) REFERENCES person(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: operation_log fk_operat_log_person_person_id; Type: FK CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY operation_log
    ADD CONSTRAINT fk_operat_log_person_person_id FOREIGN KEY (person) REFERENCES person(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: employee_station fk_prsn_sttn_emply_emply_id; Type: FK CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY employee_station
    ADD CONSTRAINT fk_prsn_sttn_emply_emply_id FOREIGN KEY (employee) REFERENCES employee(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: employee_station fk_prsn_sttn_sttn_sys_sttn_id; Type: FK CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY employee_station
    ADD CONSTRAINT fk_prsn_sttn_sttn_sys_sttn_id FOREIGN KEY (station) REFERENCES sys_station(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: sys_station_role_dispatch fk_sys_stat_fk_role_d_sys_role; Type: FK CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY sys_station_role_dispatch
    ADD CONSTRAINT fk_sys_stat_fk_role_d_sys_role FOREIGN KEY (sys_role) REFERENCES sys_role(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: sys_station_role_dispatch fk_sys_stat_fk_role_d_sys_stat; Type: FK CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY sys_station_role_dispatch
    ADD CONSTRAINT fk_sys_stat_fk_role_d_sys_stat FOREIGN KEY (sys_station) REFERENCES sys_station(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: sys_station_role_dispatch fk_sys_stt_rl_dsp_bnd_nd_nd_id; Type: FK CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY sys_station_role_dispatch
    ADD CONSTRAINT fk_sys_stt_rl_dsp_bnd_nd_nd_id FOREIGN KEY (bind_node) REFERENCES node(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: node node_parent_id_fkey; Type: FK CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY node
    ADD CONSTRAINT node_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES node(id) ON DELETE CASCADE;


--
-- Name: sub_function sub_function_sys_function_fkey; Type: FK CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY sub_function
    ADD CONSTRAINT sub_function_sys_function_fkey FOREIGN KEY (sys_function) REFERENCES sys_function(id) ON DELETE CASCADE;


--
-- Name: sys_function sys_function_parent_id_fkey; Type: FK CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY sys_function
    ADD CONSTRAINT sys_function_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES sys_function(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sys_role_function sys_role_function_sys_function_fkey; Type: FK CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY sys_role_function
    ADD CONSTRAINT sys_role_function_sys_function_fkey FOREIGN KEY (sys_function) REFERENCES sys_function(id) ON DELETE CASCADE;


--
-- Name: sys_role_function sys_role_function_sys_role_fkey; Type: FK CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY sys_role_function
    ADD CONSTRAINT sys_role_function_sys_role_fkey FOREIGN KEY (sys_role) REFERENCES sys_role(id) ON DELETE CASCADE;


--
-- Name: sys_role sys_role_node_fkey; Type: FK CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY sys_role
    ADD CONSTRAINT sys_role_node_fkey FOREIGN KEY (node) REFERENCES node(id) ON DELETE CASCADE;


--
-- Name: sys_role_sub_function sys_role_sub_function_sub_function_fkey; Type: FK CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY sys_role_sub_function
    ADD CONSTRAINT sys_role_sub_function_sub_function_fkey FOREIGN KEY (sub_function) REFERENCES sub_function(id) ON DELETE CASCADE;


--
-- Name: sys_role_sub_function sys_role_sub_function_sys_role_fkey; Type: FK CONSTRAINT; Schema: uac; Owner: uac
--

ALTER TABLE ONLY sys_role_sub_function
    ADD CONSTRAINT sys_role_sub_function_sys_role_fkey FOREIGN KEY (sys_role) REFERENCES sys_role(id) ON DELETE CASCADE;


--
-- Name: uac; Type: ACL; Schema: -; Owner: uac
--

GRANT ALL ON SCHEMA uac TO PUBLIC;


--
-- PostgreSQL database dump complete
--

