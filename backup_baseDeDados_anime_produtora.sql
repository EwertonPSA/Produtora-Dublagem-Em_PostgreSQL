toc.dat                                                                                             0000600 0004000 0002000 00000061336 13711337743 0014461 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP       7                    x            anime_produtora "   10.13 (Ubuntu 10.13-1.pgdg18.04+1)     12.3 (Ubuntu 12.3-1.pgdg18.04+1) E    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false         �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false         �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false         �           1262    16392    anime_produtora    DATABASE     �   CREATE DATABASE anime_produtora WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE anime_produtora;
                postgres    false         �            1255    16655    n_digit(integer, integer)    FUNCTION     �   CREATE FUNCTION public.n_digit(n_digitos integer, valor integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$BEGIN
	RETURN length(valor::text) <= n_digitos;
END;
$$;
 @   DROP FUNCTION public.n_digit(n_digitos integer, valor integer);
       public          postgres    false         �            1255    16677    n_digit(integer, bigint)    FUNCTION     �   CREATE FUNCTION public.n_digit(n_digitos integer, valor bigint) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN length(valor::text) <= n_digitos;
END;
$$;
 ?   DROP FUNCTION public.n_digit(n_digitos integer, valor bigint);
       public          postgres    false         �            1259    16678    agenciadedublagem    TABLE     @  CREATE TABLE public.agenciadedublagem (
    cnpj bigint NOT NULL,
    nome character varying(100),
    cep integer,
    logradouro character varying(100),
    complemento character varying(150),
    numero integer,
    email character varying(100),
    telefone1 bigint,
    telefone2 bigint,
    CONSTRAINT agenciadedublagem_cnpj_check CHECK ((public.n_digit(14, cnpj) = true)),
    CONSTRAINT agenciadedublagem_telefone1_check CHECK ((public.n_digit(11, telefone1) = true)),
    CONSTRAINT agenciadedublagem_telefone2_check CHECK ((public.n_digit(11, telefone2) = true))
);
 %   DROP TABLE public.agenciadedublagem;
       public            postgres    false    211    211    211         �            1259    16721    anime    TABLE     �   CREATE TABLE public.anime (
    nome character varying(100) NOT NULL,
    ano integer,
    autor character varying(100),
    numerodetemporadas integer DEFAULT 1,
    CONSTRAINT anime_ano_check CHECK ((public.n_digit(4, ano) = true))
);
    DROP TABLE public.anime;
       public            postgres    false    212         �            1259    16771    cena    TABLE     �  CREATE TABLE public.cena (
    episodio integer NOT NULL,
    numero integer NOT NULL,
    duracao time without time zone DEFAULT '00:00:00'::time without time zone,
    script bytea,
    estado character varying(23) DEFAULT 'NAO GRAVADO'::character varying,
    audio bytea,
    CONSTRAINT dom_cena_estado CHECK ((upper((estado)::text) = ANY (ARRAY['GRAVADO'::text, 'NAO GRAVADO'::text, 'NECESSITA DE REGRAVACAO'::text])))
);
    DROP TABLE public.cena;
       public            postgres    false         �            1259    16699    diretor    TABLE       CREATE TABLE public.diretor (
    cpf bigint NOT NULL,
    nome character varying(100),
    cep integer,
    logradouro character varying(100),
    complemento character varying(150),
    numero integer,
    email character varying(100),
    telefone1 bigint,
    telefone2 bigint,
    CONSTRAINT diretor_cpf_check CHECK ((public.n_digit(11, cpf) = true)),
    CONSTRAINT diretor_telefone1_check CHECK ((public.n_digit(11, telefone1) = true)),
    CONSTRAINT diretor_telefone2_check CHECK ((public.n_digit(11, telefone2) = true))
);
    DROP TABLE public.diretor;
       public            postgres    false    211    211    211         �            1259    16804    dubla    TABLE     �  CREATE TABLE public.dubla (
    episodio integer NOT NULL,
    anime character varying(100) NOT NULL,
    personagem character varying(100) NOT NULL,
    dublador bigint NOT NULL,
    avaliacaoparcial integer,
    CONSTRAINT dom_dubla_avaliacao CHECK (((avaliacaoparcial >= 1) AND (avaliacaoparcial <= 10))),
    CONSTRAINT dubla_dublador_check CHECK ((public.n_digit(11, dublador) = true))
);
    DROP TABLE public.dubla;
       public            postgres    false    211         �            1259    16686    dublador    TABLE     V  CREATE TABLE public.dublador (
    cpf bigint NOT NULL,
    nome character varying(100),
    sexo character(1),
    datanascimento date,
    tipodevoz character varying(20),
    agenciadedublagem integer NOT NULL,
    CONSTRAINT dom_dublador_sexo CHECK ((upper((sexo)::text) = ANY (ARRAY['M'::text, 'F'::text, 'N'::text]))),
    CONSTRAINT dom_dublador_tipodevoz CHECK ((upper((tipodevoz)::text) = ANY (ARRAY['SOPRANO'::text, 'MEZZO_SOPRANO'::text, 'CONTRALTO'::text, 'TENOR'::text, 'BARITONO'::text, 'BAIXO'::text]))),
    CONSTRAINT dublador_cpf_check CHECK ((public.n_digit(11, cpf) = true))
);
    DROP TABLE public.dublador;
       public            postgres    false    211         �            1259    16758    episodio    TABLE       CREATE TABLE public.episodio (
    anime character varying(100) NOT NULL,
    temporada integer NOT NULL,
    numero integer NOT NULL,
    id_episodio integer NOT NULL,
    titulo character varying(100),
    duracao time without time zone DEFAULT '00:00:00'::time without time zone
);
    DROP TABLE public.episodio;
       public            postgres    false         �            1259    16787 
   interpreta    TABLE     �  CREATE TABLE public.interpreta (
    anime character varying(100) NOT NULL,
    personagem character varying(100) NOT NULL,
    dublador bigint NOT NULL,
    avaliacaototal integer,
    nro_avaliacoes integer,
    CONSTRAINT dom_interp_avaliacao CHECK (((avaliacaototal >= 1) AND (avaliacaototal <= 10))),
    CONSTRAINT interpreta_dublador_check CHECK ((public.n_digit(11, dublador) = true))
);
    DROP TABLE public.interpreta;
       public            postgres    false    211         �            1259    16854 	   participa    TABLE     �   CREATE TABLE public.participa (
    anime character varying(100) NOT NULL,
    personagem character varying(100) NOT NULL,
    episodio integer NOT NULL,
    cena integer NOT NULL
);
    DROP TABLE public.participa;
       public            postgres    false         �            1259    16728 
   personagem    TABLE     �  CREATE TABLE public.personagem (
    anime character varying(100) NOT NULL,
    nome character varying(100) NOT NULL,
    descricao character varying(500),
    tipodevoz character varying(20),
    CONSTRAINT dom_personagem_tipodevoz CHECK ((upper((tipodevoz)::text) = ANY (ARRAY['SOPRANO'::text, 'MEZZO_SOPRANO'::text, 'CONTRALTO'::text, 'TENOR'::text, 'BARITONO'::text, 'BAIXO'::text])))
);
    DROP TABLE public.personagem;
       public            postgres    false         �            1259    16839    produz    TABLE     �   CREATE TABLE public.produz (
    sala integer NOT NULL,
    data_hora timestamp without time zone NOT NULL,
    episodio integer NOT NULL,
    cena integer NOT NULL
);
    DROP TABLE public.produz;
       public            postgres    false         �            1259    16715    saladegravacao    TABLE     �   CREATE TABLE public.saladegravacao (
    numero integer NOT NULL,
    numerokits integer,
    CONSTRAINT saladegravacao_numerokits_check CHECK ((public.n_digit(2, numerokits) = true))
);
 "   DROP TABLE public.saladegravacao;
       public            postgres    false    212         �            1259    16821    sessaodegravacao    TABLE       CREATE TABLE public.sessaodegravacao (
    sala integer NOT NULL,
    data_hora timestamp without time zone NOT NULL,
    tecnico bigint NOT NULL,
    horariofinal timestamp without time zone,
    CONSTRAINT sessaodegravacao_tecnico_check CHECK ((public.n_digit(11, tecnico) = true))
);
 $   DROP TABLE public.sessaodegravacao;
       public            postgres    false    211         �            1259    16707    tecnicodeaudio    TABLE     K  CREATE TABLE public.tecnicodeaudio (
    cpf bigint NOT NULL,
    nome character varying(100),
    datanascimento date,
    cep integer,
    logradouro character varying(100),
    complemento character varying(150),
    numero integer,
    email character varying(100),
    telefone1 bigint,
    telefone2 bigint,
    CONSTRAINT tecnicodeaudio_cpf_check CHECK ((public.n_digit(11, cpf) = true)),
    CONSTRAINT tecnicodeaudio_telefone1_check CHECK ((public.n_digit(11, telefone1) = true)),
    CONSTRAINT tecnicodeaudio_telefone1_check1 CHECK ((public.n_digit(11, telefone1) = true))
);
 "   DROP TABLE public.tecnicodeaudio;
       public            postgres    false    211    211    211         �            1259    16742 	   temporada    TABLE     �   CREATE TABLE public.temporada (
    anime character varying(100) NOT NULL,
    numero integer NOT NULL,
    datainicial date,
    datafinal date,
    diretor bigint,
    CONSTRAINT ch_temporada_data CHECK (((datafinal - datainicial) > 0))
);
    DROP TABLE public.temporada;
       public            postgres    false         �          0    16678    agenciadedublagem 
   TABLE DATA           z   COPY public.agenciadedublagem (cnpj, nome, cep, logradouro, complemento, numero, email, telefone1, telefone2) FROM stdin;
    public          postgres    false    196       3041.dat �          0    16721    anime 
   TABLE DATA           E   COPY public.anime (nome, ano, autor, numerodetemporadas) FROM stdin;
    public          postgres    false    201       3046.dat �          0    16771    cena 
   TABLE DATA           P   COPY public.cena (episodio, numero, duracao, script, estado, audio) FROM stdin;
    public          postgres    false    205       3050.dat �          0    16699    diretor 
   TABLE DATA           o   COPY public.diretor (cpf, nome, cep, logradouro, complemento, numero, email, telefone1, telefone2) FROM stdin;
    public          postgres    false    198       3043.dat �          0    16804    dubla 
   TABLE DATA           X   COPY public.dubla (episodio, anime, personagem, dublador, avaliacaoparcial) FROM stdin;
    public          postgres    false    207       3052.dat �          0    16686    dublador 
   TABLE DATA           a   COPY public.dublador (cpf, nome, sexo, datanascimento, tipodevoz, agenciadedublagem) FROM stdin;
    public          postgres    false    197       3042.dat �          0    16758    episodio 
   TABLE DATA           Z   COPY public.episodio (anime, temporada, numero, id_episodio, titulo, duracao) FROM stdin;
    public          postgres    false    204       3049.dat �          0    16787 
   interpreta 
   TABLE DATA           a   COPY public.interpreta (anime, personagem, dublador, avaliacaototal, nro_avaliacoes) FROM stdin;
    public          postgres    false    206       3051.dat �          0    16854 	   participa 
   TABLE DATA           F   COPY public.participa (anime, personagem, episodio, cena) FROM stdin;
    public          postgres    false    210       3055.dat �          0    16728 
   personagem 
   TABLE DATA           G   COPY public.personagem (anime, nome, descricao, tipodevoz) FROM stdin;
    public          postgres    false    202       3047.dat �          0    16839    produz 
   TABLE DATA           A   COPY public.produz (sala, data_hora, episodio, cena) FROM stdin;
    public          postgres    false    209       3054.dat �          0    16715    saladegravacao 
   TABLE DATA           <   COPY public.saladegravacao (numero, numerokits) FROM stdin;
    public          postgres    false    200       3045.dat �          0    16821    sessaodegravacao 
   TABLE DATA           R   COPY public.sessaodegravacao (sala, data_hora, tecnico, horariofinal) FROM stdin;
    public          postgres    false    208       3053.dat �          0    16707    tecnicodeaudio 
   TABLE DATA           �   COPY public.tecnicodeaudio (cpf, nome, datanascimento, cep, logradouro, complemento, numero, email, telefone1, telefone2) FROM stdin;
    public          postgres    false    199       3044.dat �          0    16742 	   temporada 
   TABLE DATA           S   COPY public.temporada (anime, numero, datainicial, datafinal, diretor) FROM stdin;
    public          postgres    false    203       3048.dat 7           2606    16685 &   agenciadedublagem pk_agenciadedublagem 
   CONSTRAINT     f   ALTER TABLE ONLY public.agenciadedublagem
    ADD CONSTRAINT pk_agenciadedublagem PRIMARY KEY (cnpj);
 P   ALTER TABLE ONLY public.agenciadedublagem DROP CONSTRAINT pk_agenciadedublagem;
       public            postgres    false    196         A           2606    16727    anime pk_anime 
   CONSTRAINT     N   ALTER TABLE ONLY public.anime
    ADD CONSTRAINT pk_anime PRIMARY KEY (nome);
 8   ALTER TABLE ONLY public.anime DROP CONSTRAINT pk_anime;
       public            postgres    false    201         K           2606    16781    cena pk_cena 
   CONSTRAINT     X   ALTER TABLE ONLY public.cena
    ADD CONSTRAINT pk_cena PRIMARY KEY (episodio, numero);
 6   ALTER TABLE ONLY public.cena DROP CONSTRAINT pk_cena;
       public            postgres    false    205    205         ;           2606    16706    diretor pk_diretor 
   CONSTRAINT     Q   ALTER TABLE ONLY public.diretor
    ADD CONSTRAINT pk_diretor PRIMARY KEY (cpf);
 <   ALTER TABLE ONLY public.diretor DROP CONSTRAINT pk_diretor;
       public            postgres    false    198         O           2606    16810    dubla pk_dubla 
   CONSTRAINT     e   ALTER TABLE ONLY public.dubla
    ADD CONSTRAINT pk_dubla PRIMARY KEY (episodio, anime, personagem);
 8   ALTER TABLE ONLY public.dubla DROP CONSTRAINT pk_dubla;
       public            postgres    false    207    207    207         9           2606    16693    dublador pk_dublador 
   CONSTRAINT     S   ALTER TABLE ONLY public.dublador
    ADD CONSTRAINT pk_dublador PRIMARY KEY (cpf);
 >   ALTER TABLE ONLY public.dublador DROP CONSTRAINT pk_dublador;
       public            postgres    false    197         G           2606    16763    episodio pk_episodio 
   CONSTRAINT     [   ALTER TABLE ONLY public.episodio
    ADD CONSTRAINT pk_episodio PRIMARY KEY (id_episodio);
 >   ALTER TABLE ONLY public.episodio DROP CONSTRAINT pk_episodio;
       public            postgres    false    204         M           2606    16793    interpreta pk_interpreta 
   CONSTRAINT     o   ALTER TABLE ONLY public.interpreta
    ADD CONSTRAINT pk_interpreta PRIMARY KEY (anime, personagem, dublador);
 B   ALTER TABLE ONLY public.interpreta DROP CONSTRAINT pk_interpreta;
       public            postgres    false    206    206    206         W           2606    16858    participa pk_participa 
   CONSTRAINT     s   ALTER TABLE ONLY public.participa
    ADD CONSTRAINT pk_participa PRIMARY KEY (anime, personagem, episodio, cena);
 @   ALTER TABLE ONLY public.participa DROP CONSTRAINT pk_participa;
       public            postgres    false    210    210    210    210         C           2606    16736    personagem pk_personagem 
   CONSTRAINT     _   ALTER TABLE ONLY public.personagem
    ADD CONSTRAINT pk_personagem PRIMARY KEY (anime, nome);
 B   ALTER TABLE ONLY public.personagem DROP CONSTRAINT pk_personagem;
       public            postgres    false    202    202         U           2606    16843    produz pk_produz 
   CONSTRAINT     k   ALTER TABLE ONLY public.produz
    ADD CONSTRAINT pk_produz PRIMARY KEY (sala, data_hora, episodio, cena);
 :   ALTER TABLE ONLY public.produz DROP CONSTRAINT pk_produz;
       public            postgres    false    209    209    209    209         ?           2606    16720     saladegravacao pk_saladegravacao 
   CONSTRAINT     b   ALTER TABLE ONLY public.saladegravacao
    ADD CONSTRAINT pk_saladegravacao PRIMARY KEY (numero);
 J   ALTER TABLE ONLY public.saladegravacao DROP CONSTRAINT pk_saladegravacao;
       public            postgres    false    200         Q           2606    16826 $   sessaodegravacao pk_sessaodegravacao 
   CONSTRAINT     o   ALTER TABLE ONLY public.sessaodegravacao
    ADD CONSTRAINT pk_sessaodegravacao PRIMARY KEY (sala, data_hora);
 N   ALTER TABLE ONLY public.sessaodegravacao DROP CONSTRAINT pk_sessaodegravacao;
       public            postgres    false    208    208         =           2606    16714     tecnicodeaudio pk_tecnicodeaudio 
   CONSTRAINT     _   ALTER TABLE ONLY public.tecnicodeaudio
    ADD CONSTRAINT pk_tecnicodeaudio PRIMARY KEY (cpf);
 J   ALTER TABLE ONLY public.tecnicodeaudio DROP CONSTRAINT pk_tecnicodeaudio;
       public            postgres    false    199         E           2606    16747    temporada pk_temporada 
   CONSTRAINT     _   ALTER TABLE ONLY public.temporada
    ADD CONSTRAINT pk_temporada PRIMARY KEY (anime, numero);
 @   ALTER TABLE ONLY public.temporada DROP CONSTRAINT pk_temporada;
       public            postgres    false    203    203         I           2606    16765    episodio sk_episodio 
   CONSTRAINT     c   ALTER TABLE ONLY public.episodio
    ADD CONSTRAINT sk_episodio UNIQUE (anime, temporada, numero);
 >   ALTER TABLE ONLY public.episodio DROP CONSTRAINT sk_episodio;
       public            postgres    false    204    204    204         S           2606    16828 $   sessaodegravacao sk_sessaodegravacao 
   CONSTRAINT     m   ALTER TABLE ONLY public.sessaodegravacao
    ADD CONSTRAINT sk_sessaodegravacao UNIQUE (data_hora, tecnico);
 N   ALTER TABLE ONLY public.sessaodegravacao DROP CONSTRAINT sk_sessaodegravacao;
       public            postgres    false    208    208         ]           2606    16782    cena fk_cena_episodio    FK CONSTRAINT     �   ALTER TABLE ONLY public.cena
    ADD CONSTRAINT fk_cena_episodio FOREIGN KEY (episodio) REFERENCES public.episodio(id_episodio) ON DELETE CASCADE;
 ?   ALTER TABLE ONLY public.cena DROP CONSTRAINT fk_cena_episodio;
       public          postgres    false    205    204    2887         `           2606    16811    dubla fk_dubla_episodio    FK CONSTRAINT     �   ALTER TABLE ONLY public.dubla
    ADD CONSTRAINT fk_dubla_episodio FOREIGN KEY (episodio) REFERENCES public.episodio(id_episodio) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.dubla DROP CONSTRAINT fk_dubla_episodio;
       public          postgres    false    2887    207    204         a           2606    16816    dubla fk_dubla_personagem    FK CONSTRAINT     �   ALTER TABLE ONLY public.dubla
    ADD CONSTRAINT fk_dubla_personagem FOREIGN KEY (anime, personagem) REFERENCES public.personagem(anime, nome) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.dubla DROP CONSTRAINT fk_dubla_personagem;
       public          postgres    false    202    207    207    2883    202         X           2606    16694    dublador fk_dublador_agencia    FK CONSTRAINT     �   ALTER TABLE ONLY public.dublador
    ADD CONSTRAINT fk_dublador_agencia FOREIGN KEY (agenciadedublagem) REFERENCES public.agenciadedublagem(cnpj) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.dublador DROP CONSTRAINT fk_dublador_agencia;
       public          postgres    false    196    197    2871         \           2606    16766    episodio fk_episodio_temporada    FK CONSTRAINT     �   ALTER TABLE ONLY public.episodio
    ADD CONSTRAINT fk_episodio_temporada FOREIGN KEY (anime, temporada) REFERENCES public.temporada(anime, numero) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.episodio DROP CONSTRAINT fk_episodio_temporada;
       public          postgres    false    203    2885    204    204    203         _           2606    16799 !   interpreta fk_interpreta_dublador    FK CONSTRAINT     �   ALTER TABLE ONLY public.interpreta
    ADD CONSTRAINT fk_interpreta_dublador FOREIGN KEY (dublador) REFERENCES public.dublador(cpf) ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.interpreta DROP CONSTRAINT fk_interpreta_dublador;
       public          postgres    false    197    206    2873         ^           2606    16794 #   interpreta fk_interpreta_personagem    FK CONSTRAINT     �   ALTER TABLE ONLY public.interpreta
    ADD CONSTRAINT fk_interpreta_personagem FOREIGN KEY (anime, personagem) REFERENCES public.personagem(anime, nome) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.interpreta DROP CONSTRAINT fk_interpreta_personagem;
       public          postgres    false    2883    206    206    202    202         g           2606    16864    participa fk_participa_cena    FK CONSTRAINT     �   ALTER TABLE ONLY public.participa
    ADD CONSTRAINT fk_participa_cena FOREIGN KEY (episodio, cena) REFERENCES public.cena(episodio, numero) ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.participa DROP CONSTRAINT fk_participa_cena;
       public          postgres    false    2891    210    210    205    205         f           2606    16859 !   participa fk_participa_personagem    FK CONSTRAINT     �   ALTER TABLE ONLY public.participa
    ADD CONSTRAINT fk_participa_personagem FOREIGN KEY (anime, personagem) REFERENCES public.personagem(anime, nome) ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.participa DROP CONSTRAINT fk_participa_personagem;
       public          postgres    false    210    202    210    2883    202         Y           2606    16737    personagem fk_personagem    FK CONSTRAINT     �   ALTER TABLE ONLY public.personagem
    ADD CONSTRAINT fk_personagem FOREIGN KEY (anime) REFERENCES public.anime(nome) ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.personagem DROP CONSTRAINT fk_personagem;
       public          postgres    false    201    202    2881         d           2606    16844    produz fk_produz_cena    FK CONSTRAINT     �   ALTER TABLE ONLY public.produz
    ADD CONSTRAINT fk_produz_cena FOREIGN KEY (episodio, cena) REFERENCES public.cena(episodio, numero) ON DELETE CASCADE;
 ?   ALTER TABLE ONLY public.produz DROP CONSTRAINT fk_produz_cena;
       public          postgres    false    205    205    209    209    2891         e           2606    16849    produz fk_produz_sessao    FK CONSTRAINT     �   ALTER TABLE ONLY public.produz
    ADD CONSTRAINT fk_produz_sessao FOREIGN KEY (sala, data_hora) REFERENCES public.sessaodegravacao(sala, data_hora) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.produz DROP CONSTRAINT fk_produz_sessao;
       public          postgres    false    208    208    209    209    2897         b           2606    16829 )   sessaodegravacao fk_sessaodegravacao_sala    FK CONSTRAINT     �   ALTER TABLE ONLY public.sessaodegravacao
    ADD CONSTRAINT fk_sessaodegravacao_sala FOREIGN KEY (sala) REFERENCES public.saladegravacao(numero) ON DELETE CASCADE;
 S   ALTER TABLE ONLY public.sessaodegravacao DROP CONSTRAINT fk_sessaodegravacao_sala;
       public          postgres    false    200    208    2879         c           2606    16834 ,   sessaodegravacao fk_sessaodegravacao_tecnico    FK CONSTRAINT     �   ALTER TABLE ONLY public.sessaodegravacao
    ADD CONSTRAINT fk_sessaodegravacao_tecnico FOREIGN KEY (tecnico) REFERENCES public.tecnicodeaudio(cpf) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.sessaodegravacao DROP CONSTRAINT fk_sessaodegravacao_tecnico;
       public          postgres    false    2877    208    199         Z           2606    16748    temporada fk_temporada_anime    FK CONSTRAINT     �   ALTER TABLE ONLY public.temporada
    ADD CONSTRAINT fk_temporada_anime FOREIGN KEY (anime) REFERENCES public.anime(nome) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.temporada DROP CONSTRAINT fk_temporada_anime;
       public          postgres    false    203    201    2881         [           2606    16753    temporada fk_temporada_diretor    FK CONSTRAINT     �   ALTER TABLE ONLY public.temporada
    ADD CONSTRAINT fk_temporada_diretor FOREIGN KEY (diretor) REFERENCES public.diretor(cpf) ON DELETE SET NULL;
 H   ALTER TABLE ONLY public.temporada DROP CONSTRAINT fk_temporada_diretor;
       public          postgres    false    2875    203    198                                                                                                                                                                                                                                                                                                          3041.dat                                                                                            0000600 0004000 0002000 00000000370 13711337743 0014252 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1000	Arigatou	1	logradouro1	complemento1	1	arigatou@gmail.br	40028922	\N
1001	Sayonara	2	logradouro2	complemento2	2	sayonara@gmail.br	800666	8007777000
1002	Sushi	3	\N	\N	2	sushi@gmail.br	123456	\N
1003	Temaki	3	\N	\N	\N	temaki@gmail.br	\N	\N
\.


                                                                                                                                                                                                                                                                        3046.dat                                                                                            0000600 0004000 0002000 00000000300 13711337743 0014250 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        Boku no Hero College	2016	Marcelo	2
Baitekita - Computer Science Adventure	2019	Rodrigo	1
Binary Art Online	2019	Marcelo	1
Dragon Ball	2001	Akira Toriyama	1
Pokemon	2001	Satoshi Tagiri	1
\.


                                                                                                                                                                                                                                                                                                                                3050.dat                                                                                            0000600 0004000 0002000 00000003064 13711337743 0014255 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        10005	1	00:07:00	\\x416cf42c2067616c65726120646520636f77626f792120416cf42c2067616c657261206465207065e36f21	GRAVADO	\\x524946461870060057415645666d7420100000000100020044ac000010b102000400100064617461f46f0600fffff9fffafffefffafff9fffafffafff6fff7fffcfffcff
10005	2	00:07:00	\\x4520656e74e36f20746f646f73207669766572616d2066656c697a657320706172612073656d7072652e	GRAVADO	\\x0aee0eeed5eed0eea5efabef8ff089f0c5f1c6f11bf317f398f496f441f639f6baf7c2f733f928f9a4faaafa1cfc15fc
10005	3	00:07:00	\N	GRAVADO	\N
10006	1	00:07:00	\N	GRAVADO	\N
10006	2	00:07:00	\N	GRAVADO	\N
10006	3	00:07:00	\N	GRAVADO	\N
10007	1	00:07:00	\N	GRAVADO	\N
10007	2	00:07:00	\N	GRAVADO	\N
10007	3	00:07:00	\N	GRAVADO	\N
10008	1	00:07:00	\N	GRAVADO	\N
10008	2	00:07:00	\N	GRAVADO	\N
10008	3	00:07:00	\N	GRAVADO	\N
10009	1	00:07:00	\N	GRAVADO	\N
10009	2	00:07:00	\N	GRAVADO	\N
10009	3	00:07:00	\N	GRAVADO	\N
10010	1	00:07:00	\N	GRAVADO	\N
10010	2	00:07:00	\N	GRAVADO	\N
10010	3	00:07:00	\N	GRAVADO	\N
10011	1	00:07:00	\N	GRAVADO	\N
10011	2	00:07:00	\N	GRAVADO	\N
10011	3	00:07:00	\N	GRAVADO	\N
10012	1	00:07:00	\N	GRAVADO	\N
10012	2	00:07:00	\N	GRAVADO	\N
10012	3	00:07:00	\N	GRAVADO	\N
10013	1	00:07:00	\N	NECESSITA DE REGRAVACAO	\N
10013	2	00:07:00	\N	NECESSITA DE REGRAVACAO	\N
10013	3	00:07:00	\N	NAO GRAVADO	\N
10014	1	00:07:00	\N	NAO GRAVADO	\N
10014	2	00:07:00	\N	NAO GRAVADO	\N
10014	3	00:07:00	\N	NAO GRAVADO	\N
10000	1	00:03:02	\N	NAO GRAVADO	\N
10001	1	00:03:03	\N	NAO GRAVADO	\N
10002	1	00:01:04	\N	NECESSITA DE REGRAVACAO	\N
10003	1	00:05:00	\N	NAO GRAVADO	\N
10004	1	00:01:00	\N	NECESSITA DE REGRAVACAO	\N
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                            3043.dat                                                                                            0000600 0004000 0002000 00000000323 13711337743 0014252 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        8	Elaine	3000	\N	\N	\N	emaildaelaine@gmail.com	\N	\N
9	Denis	3001	\N	\N	\N	emaildodenis@gmail.com	\N	\N
10	Joao	3002	\N	\N	\N	emaildojoao@gmail.com	\N	\N
11	Maria	3003	\N	\N	\N	emaildamaria@gmail.com	\N	\N
\.


                                                                                                                                                                                                                                                                                                             3052.dat                                                                                            0000600 0004000 0002000 00000004206 13711337743 0014256 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        10005	Boku no Hero College	Nobuyuki Takahashi	1	10
10005	Boku no Hero College	Kiyoshi Hatanaka	7	10
10005	Boku no Hero College	Mendesu Andorade	2	10
10005	Boku no Hero College	Shiruba do Amararu	3	10
10005	Boku no Hero College	Di Mano Saraiba	5	10
10005	Boku no Hero College	Camposu Barubosa	4	10
10005	Boku no Hero College	Faineru Oribera	6	10
10006	Boku no Hero College	Mendesu Andorade	2	10
10006	Boku no Hero College	Di Mano Saraiba	5	10
10007	Boku no Hero College	Nobuyuki Takahashi	1	10
10007	Boku no Hero College	Kiyoshi Hatanaka	7	10
10008	Boku no Hero College	Shiruba do Amararu	3	10
10008	Boku no Hero College	Faineru Oribera	6	10
10009	Boku no Hero College	Nobuyuki Takahashi	1	10
10009	Boku no Hero College	Kiyoshi Hatanaka	7	10
10009	Boku no Hero College	Mendesu Andorade	2	10
10009	Boku no Hero College	Shiruba do Amararu	3	10
10009	Boku no Hero College	Di Mano Saraiba	5	10
10009	Boku no Hero College	Camposu Barubosa	4	10
10009	Boku no Hero College	Faineru Oribera	6	10
10010	Boku no Hero College	Nobuyuki Takahashi	1	10
10010	Boku no Hero College	Kiyoshi Hatanaka	7	10
10010	Boku no Hero College	Mendesu Andorade	2	10
10010	Boku no Hero College	Shiruba do Amararu	3	10
10010	Boku no Hero College	Di Mano Saraiba	5	10
10010	Boku no Hero College	Camposu Barubosa	4	10
10010	Boku no Hero College	Faineru Oribera	6	10
10011	Boku no Hero College	Kiyoshi Hatanaka	7	10
10011	Boku no Hero College	Nobuyuki Takahashi	1	10
10012	Boku no Hero College	Kiyoshi Hatanaka	7	10
10012	Boku no Hero College	Mendesu Andorade	2	10
10013	Boku no Hero College	Camposu Barubosa	14	9
10013	Boku no Hero College	Shiruba do Amararu	3	10
10014	Boku no Hero College	Nobuyuki Takahashi	1	10
10014	Boku no Hero College	Kiyoshi Hatanaka	7	10
10014	Boku no Hero College	Mendesu Andorade	2	10
10014	Boku no Hero College	Shiruba do Amararu	3	10
10014	Boku no Hero College	Di Mano Saraiba	5	10
10014	Boku no Hero College	Camposu Barubosa	4	10
10014	Boku no Hero College	Faineru Oribera	6	10
10000	Baitekita - Computer Science Adventure	Sushi	5	\N
10001	Baitekita - Computer Science Adventure	Sushi	5	\N
10002	Binary Art Online	Temaki	7	\N
10003	Dragon Ball	Goku	4	\N
10004	Pokemon	Pikachu	6	\N
\.


                                                                                                                                                                                                                                                                                                                                                                                          3042.dat                                                                                            0000600 0004000 0002000 00000000472 13711337743 0014256 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Lucas	M	1000-01-02	BAIXO	1000
2	Rodrigo	M	0001-01-01	BARITONO	1000
3	Ewerton Patrick	M	0001-01-02	BAIXO	1001
4	Paulo Renato	M	1003-01-01	TENOR	1001
5	Luiz Miguel	M	1003-01-01	CONTRALTO	1002
6	Ana Carolina	F	1500-01-01	SOPRANO	1002
7	Marcelo	N	1000-01-01	TENOR	1003
14	Marcelo Isaias	M	1000-01-02	TENOR	1003
\.


                                                                                                                                                                                                      3049.dat                                                                                            0000600 0004000 0002000 00000001620 13711337743 0014261 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        Boku no Hero College	1	1	10005	Apocalipse: Back to College	00:24:00
Boku no Hero College	1	2	10006	Catundas Nightmare	00:24:00
Boku no Hero College	1	3	10007	Mellos Surprise	00:24:00
Boku no Hero College	1	4	10008	Sasha no Tsukuyomi	00:24:00
Boku no Hero College	1	5	10009	Its finally over... or is it?	00:24:00
Boku no Hero College	2	1	10010	Summer is over!	00:24:00
Boku no Hero College	2	2	10011	A New Enemy Appears: Peter Rivers!	00:48:00
Boku no Hero College	2	3	10012	Kiyoshis Heartbreaking Smile!	00:24:00
Boku no Hero College	2	4	10013	Crowded Bus! We hate going to Campus 2!	00:24:00
Boku no Hero College	2	5	10014	Winter	00:24:00
Baitekita - Computer Science Adventure	1	10	10000	Sushis Insight	00:24:00
Baitekita - Computer Science Adventure	1	2	10001	The Real Prank - Calculus Test	00:24:00
Binary Art Online	1	1	10002	\N	00:24:00
Dragon Ball	1	1	10003	\N	00:24:00
Pokemon	1	1	10004	\N	00:24:00
\.


                                                                                                                3051.dat                                                                                            0000600 0004000 0002000 00000000766 13711337743 0014264 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        Boku no Hero College	Kiyoshi Hatanaka	7	10	7
Boku no Hero College	Nobuyuki Takahashi	1	10	6
Boku no Hero College	Mendesu Andorade	2	10	6
Boku no Hero College	Shiruba do Amararu	3	10	6
Boku no Hero College	Di Mano Saraiba	5	10	5
Boku no Hero College	Camposu Barubosa	4	10	4
Boku no Hero College	Faineru Oribera	6	10	5
Boku no Hero College	Camposu Barubosa	14	8	1
Baitekita - Computer Science Adventure	Sushi	5	\N	\N
Binary Art Online	Temaki	7	\N	\N
Dragon Ball	Goku	4	\N	\N
Pokemon	Pikachu	6	\N	\N
\.


          3055.dat                                                                                            0000600 0004000 0002000 00000005055 13711337743 0014264 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        Boku no Hero College	Nobuyuki Takahashi	10005	1
Boku no Hero College	Kiyoshi Hatanaka	10005	1
Boku no Hero College	Mendesu Andorade	10005	2
Boku no Hero College	Shiruba do Amararu	10005	2
Boku no Hero College	Di Mano Saraiba	10005	3
Boku no Hero College	Camposu Barubosa	10005	3
Boku no Hero College	Faineru Oribera	10005	3
Boku no Hero College	Mendesu Andorade	10006	1
Boku no Hero College	Di Mano Saraiba	10006	2
Boku no Hero College	Mendesu Andorade	10006	3
Boku no Hero College	Di Mano Saraiba	10006	3
Boku no Hero College	Nobuyuki Takahashi	10007	1
Boku no Hero College	Kiyoshi Hatanaka	10007	1
Boku no Hero College	Nobuyuki Takahashi	10007	2
Boku no Hero College	Kiyoshi Hatanaka	10007	3
Boku no Hero College	Shiruba do Amararu	10008	1
Boku no Hero College	Faineru Oribera	10008	2
Boku no Hero College	Shiruba do Amararu	10008	2
Boku no Hero College	Faineru Oribera	10008	3
Boku no Hero College	Nobuyuki Takahashi	10009	1
Boku no Hero College	Kiyoshi Hatanaka	10009	1
Boku no Hero College	Mendesu Andorade	10009	2
Boku no Hero College	Shiruba do Amararu	10009	2
Boku no Hero College	Di Mano Saraiba	10009	3
Boku no Hero College	Camposu Barubosa	10009	3
Boku no Hero College	Faineru Oribera	10009	3
Boku no Hero College	Nobuyuki Takahashi	10010	1
Boku no Hero College	Kiyoshi Hatanaka	10010	1
Boku no Hero College	Mendesu Andorade	10010	2
Boku no Hero College	Shiruba do Amararu	10010	2
Boku no Hero College	Di Mano Saraiba	10010	3
Boku no Hero College	Camposu Barubosa	10010	3
Boku no Hero College	Faineru Oribera	10010	3
Boku no Hero College	Nobuyuki Takahashi	10011	1
Boku no Hero College	Kiyoshi Hatanaka	10011	1
Boku no Hero College	Nobuyuki Takahashi	10011	2
Boku no Hero College	Kiyoshi Hatanaka	10011	3
Boku no Hero College	Kiyoshi Hatanaka	10012	1
Boku no Hero College	Mendesu Andorade	10012	1
Boku no Hero College	Mendesu Andorade	10012	2
Boku no Hero College	Kiyoshi Hatanaka	10012	3
Boku no Hero College	Camposu Barubosa	10013	1
Boku no Hero College	Shiruba do Amararu	10013	2
Boku no Hero College	Camposu Barubosa	10013	3
Boku no Hero College	Shiruba do Amararu	10013	3
Boku no Hero College	Nobuyuki Takahashi	10014	1
Boku no Hero College	Kiyoshi Hatanaka	10014	1
Boku no Hero College	Mendesu Andorade	10014	2
Boku no Hero College	Shiruba do Amararu	10014	2
Boku no Hero College	Di Mano Saraiba	10014	3
Boku no Hero College	Camposu Barubosa	10014	3
Boku no Hero College	Faineru Oribera	10014	3
Baitekita - Computer Science Adventure	Sushi	10000	1
Baitekita - Computer Science Adventure	Sushi	10001	1
Binary Art Online	Temaki	10002	1
Dragon Ball	Goku	10003	1
Pokemon	Pikachu	10004	1
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   3047.dat                                                                                            0000600 0004000 0002000 00000001625 13711337743 0014264 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        Boku no Hero College	Kiyoshi Hatanaka	Um transformer ford Ka	TENOR
Boku no Hero College	Nobuyuki Takahashi	Um cara bacana	BAIXO
Boku no Hero College	Shiruba do Amararu	Mais legal que Mendesu e Faineru, mais bacana que Nobuyuki e mais divertido que Di Mano Saraiba	BAIXO
Boku no Hero College	Mendesu Andorade	Um cara legal	BARITONO
Boku no Hero College	Di Mano Saraiba	Um cara divertido	CONTRALTO
Boku no Hero College	Camposu Barubosa	Um trem	TENOR
Boku no Hero College	Faineru Oribera	Uma moça legal	SOPRANO
Baitekita - Computer Science Adventure	Sushi	Arroz, peixe cru, algas e verduras	CONTRALTO
Binary Art Online	Temaki	Sushi em formato de sorvete casquinha	TENOR
Binary Art Online	Shoyu	Molho preto e salgado	BARITONO
Binary Art Online	Arigatou	Muito agradecido	BAIXO
Binary Art Online	Sayonara	Adeus	BARITONO
Dragon Ball	Goku	Seu poder eh de mais de 8 mil	TENOR
Pokemon	Pikachu	Personagem chocante	SOPRANO
\.


                                                                                                           3054.dat                                                                                            0000600 0004000 0002000 00000002037 13711337743 0014260 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	2017-02-01 15:00:00	10005	1
1	2017-02-01 15:00:00	10005	2
1	2017-02-01 15:00:00	10005	3
2	2017-02-08 15:00:00	10006	1
2	2017-02-08 15:00:00	10006	2
2	2017-02-08 15:00:00	10006	3
1	2017-02-15 15:00:00	10007	1
1	2017-02-15 15:00:00	10007	2
1	2017-02-15 15:00:00	10007	3
2	2017-02-22 15:00:00	10008	1
2	2017-02-22 15:00:00	10008	2
2	2017-02-22 15:00:00	10008	3
1	2017-03-01 15:00:00	10009	1
1	2017-03-01 15:00:00	10009	2
1	2017-03-01 15:00:00	10009	3
2	2017-08-01 15:00:00	10010	1
2	2017-08-01 15:00:00	10010	2
2	2017-08-01 15:00:00	10010	3
1	2017-08-08 15:00:00	10011	1
1	2017-08-08 15:00:00	10011	2
1	2017-08-08 15:00:00	10011	3
2	2017-08-15 15:00:00	10012	1
2	2017-08-15 15:00:00	10012	2
2	2017-08-15 15:00:00	10012	3
1	2017-08-22 15:00:00	10013	1
1	2017-08-22 15:00:00	10013	2
1	2017-08-22 15:00:00	10013	3
2	2017-08-29 15:00:00	10014	1
2	2017-08-29 15:00:00	10014	2
2	2017-08-29 15:00:00	10014	3
1	2016-10-20 15:00:00	10000	1
2	2016-10-22 16:00:00	10001	1
1	2016-10-21 16:00:00	10002	1
2	2001-01-20 16:00:00	10003	1
1	2001-01-21 16:00:00	10004	1
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 3045.dat                                                                                            0000600 0004000 0002000 00000000016 13711337743 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	8
2	10
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  3053.dat                                                                                            0000600 0004000 0002000 00000001250 13711337743 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	2017-02-01 15:00:00	12	2017-02-01 18:00:00
2	2017-02-08 15:00:00	12	2017-02-08 18:00:00
1	2017-02-15 15:00:00	12	2017-02-15 18:00:00
2	2017-02-22 15:00:00	12	2017-02-22 18:00:00
1	2017-03-01 15:00:00	12	2017-03-01 18:00:00
2	2017-08-01 15:00:00	12	2017-08-01 18:00:00
1	2017-08-08 15:00:00	13	2017-08-08 18:00:00
2	2017-08-15 15:00:00	13	2017-08-15 18:00:00
1	2017-08-22 15:00:00	13	2017-08-22 18:00:00
2	2017-08-29 15:00:00	13	2017-08-29 18:00:00
1	2016-10-20 15:00:00	13	2016-10-20 16:00:00
2	2016-10-22 16:00:00	13	2016-10-22 18:00:00
1	2016-10-21 16:00:00	13	2016-10-21 18:00:00
2	2001-01-20 16:00:00	13	2001-01-20 18:00:00
1	2001-01-21 16:00:00	12	2001-01-21 18:00:00
\.


                                                                                                                                                                                                                                                                                                                                                        3044.dat                                                                                            0000600 0004000 0002000 00000000140 13711337743 0014250 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        12	Audemir	1900-01-03	3004	\N	\N	\N	\N	\N	\N
13	Audissom	1930-01-03	3005	\N	\N	\N	\N	\N	\N
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                3048.dat                                                                                            0000600 0004000 0002000 00000000434 13711337743 0014262 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        Boku no Hero College	1	2017-08-01	2017-12-10	8
Boku no Hero College	2	2018-02-01	2018-05-10	9
Baitekita - Computer Science Adventure	1	2017-03-01	2017-06-30	10
Binary Art Online	1	2017-03-01	2017-06-30	11
Dragon Ball	1	2001-07-05	2001-12-10	10
Pokemon	1	2001-07-05	2001-12-10	11
\.


                                                                                                                                                                                                                                    restore.sql                                                                                         0000600 0004000 0002000 00000051056 13711337743 0015404 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 10.13 (Ubuntu 10.13-1.pgdg18.04+1)
-- Dumped by pg_dump version 12.3 (Ubuntu 12.3-1.pgdg18.04+1)

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

DROP DATABASE anime_produtora;
--
-- Name: anime_produtora; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE anime_produtora WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE anime_produtora OWNER TO postgres;

\connect anime_produtora

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
-- Name: n_digit(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.n_digit(n_digitos integer, valor integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$BEGIN
	RETURN length(valor::text) <= n_digitos;
END;
$$;


ALTER FUNCTION public.n_digit(n_digitos integer, valor integer) OWNER TO postgres;

--
-- Name: n_digit(integer, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.n_digit(n_digitos integer, valor bigint) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN length(valor::text) <= n_digitos;
END;
$$;


ALTER FUNCTION public.n_digit(n_digitos integer, valor bigint) OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: agenciadedublagem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agenciadedublagem (
    cnpj bigint NOT NULL,
    nome character varying(100),
    cep integer,
    logradouro character varying(100),
    complemento character varying(150),
    numero integer,
    email character varying(100),
    telefone1 bigint,
    telefone2 bigint,
    CONSTRAINT agenciadedublagem_cnpj_check CHECK ((public.n_digit(14, cnpj) = true)),
    CONSTRAINT agenciadedublagem_telefone1_check CHECK ((public.n_digit(11, telefone1) = true)),
    CONSTRAINT agenciadedublagem_telefone2_check CHECK ((public.n_digit(11, telefone2) = true))
);


ALTER TABLE public.agenciadedublagem OWNER TO postgres;

--
-- Name: anime; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.anime (
    nome character varying(100) NOT NULL,
    ano integer,
    autor character varying(100),
    numerodetemporadas integer DEFAULT 1,
    CONSTRAINT anime_ano_check CHECK ((public.n_digit(4, ano) = true))
);


ALTER TABLE public.anime OWNER TO postgres;

--
-- Name: cena; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cena (
    episodio integer NOT NULL,
    numero integer NOT NULL,
    duracao time without time zone DEFAULT '00:00:00'::time without time zone,
    script bytea,
    estado character varying(23) DEFAULT 'NAO GRAVADO'::character varying,
    audio bytea,
    CONSTRAINT dom_cena_estado CHECK ((upper((estado)::text) = ANY (ARRAY['GRAVADO'::text, 'NAO GRAVADO'::text, 'NECESSITA DE REGRAVACAO'::text])))
);


ALTER TABLE public.cena OWNER TO postgres;

--
-- Name: diretor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.diretor (
    cpf bigint NOT NULL,
    nome character varying(100),
    cep integer,
    logradouro character varying(100),
    complemento character varying(150),
    numero integer,
    email character varying(100),
    telefone1 bigint,
    telefone2 bigint,
    CONSTRAINT diretor_cpf_check CHECK ((public.n_digit(11, cpf) = true)),
    CONSTRAINT diretor_telefone1_check CHECK ((public.n_digit(11, telefone1) = true)),
    CONSTRAINT diretor_telefone2_check CHECK ((public.n_digit(11, telefone2) = true))
);


ALTER TABLE public.diretor OWNER TO postgres;

--
-- Name: dubla; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dubla (
    episodio integer NOT NULL,
    anime character varying(100) NOT NULL,
    personagem character varying(100) NOT NULL,
    dublador bigint NOT NULL,
    avaliacaoparcial integer,
    CONSTRAINT dom_dubla_avaliacao CHECK (((avaliacaoparcial >= 1) AND (avaliacaoparcial <= 10))),
    CONSTRAINT dubla_dublador_check CHECK ((public.n_digit(11, dublador) = true))
);


ALTER TABLE public.dubla OWNER TO postgres;

--
-- Name: dublador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dublador (
    cpf bigint NOT NULL,
    nome character varying(100),
    sexo character(1),
    datanascimento date,
    tipodevoz character varying(20),
    agenciadedublagem integer NOT NULL,
    CONSTRAINT dom_dublador_sexo CHECK ((upper((sexo)::text) = ANY (ARRAY['M'::text, 'F'::text, 'N'::text]))),
    CONSTRAINT dom_dublador_tipodevoz CHECK ((upper((tipodevoz)::text) = ANY (ARRAY['SOPRANO'::text, 'MEZZO_SOPRANO'::text, 'CONTRALTO'::text, 'TENOR'::text, 'BARITONO'::text, 'BAIXO'::text]))),
    CONSTRAINT dublador_cpf_check CHECK ((public.n_digit(11, cpf) = true))
);


ALTER TABLE public.dublador OWNER TO postgres;

--
-- Name: episodio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.episodio (
    anime character varying(100) NOT NULL,
    temporada integer NOT NULL,
    numero integer NOT NULL,
    id_episodio integer NOT NULL,
    titulo character varying(100),
    duracao time without time zone DEFAULT '00:00:00'::time without time zone
);


ALTER TABLE public.episodio OWNER TO postgres;

--
-- Name: interpreta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.interpreta (
    anime character varying(100) NOT NULL,
    personagem character varying(100) NOT NULL,
    dublador bigint NOT NULL,
    avaliacaototal integer,
    nro_avaliacoes integer,
    CONSTRAINT dom_interp_avaliacao CHECK (((avaliacaototal >= 1) AND (avaliacaototal <= 10))),
    CONSTRAINT interpreta_dublador_check CHECK ((public.n_digit(11, dublador) = true))
);


ALTER TABLE public.interpreta OWNER TO postgres;

--
-- Name: participa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.participa (
    anime character varying(100) NOT NULL,
    personagem character varying(100) NOT NULL,
    episodio integer NOT NULL,
    cena integer NOT NULL
);


ALTER TABLE public.participa OWNER TO postgres;

--
-- Name: personagem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personagem (
    anime character varying(100) NOT NULL,
    nome character varying(100) NOT NULL,
    descricao character varying(500),
    tipodevoz character varying(20),
    CONSTRAINT dom_personagem_tipodevoz CHECK ((upper((tipodevoz)::text) = ANY (ARRAY['SOPRANO'::text, 'MEZZO_SOPRANO'::text, 'CONTRALTO'::text, 'TENOR'::text, 'BARITONO'::text, 'BAIXO'::text])))
);


ALTER TABLE public.personagem OWNER TO postgres;

--
-- Name: produz; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produz (
    sala integer NOT NULL,
    data_hora timestamp without time zone NOT NULL,
    episodio integer NOT NULL,
    cena integer NOT NULL
);


ALTER TABLE public.produz OWNER TO postgres;

--
-- Name: saladegravacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.saladegravacao (
    numero integer NOT NULL,
    numerokits integer,
    CONSTRAINT saladegravacao_numerokits_check CHECK ((public.n_digit(2, numerokits) = true))
);


ALTER TABLE public.saladegravacao OWNER TO postgres;

--
-- Name: sessaodegravacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessaodegravacao (
    sala integer NOT NULL,
    data_hora timestamp without time zone NOT NULL,
    tecnico bigint NOT NULL,
    horariofinal timestamp without time zone,
    CONSTRAINT sessaodegravacao_tecnico_check CHECK ((public.n_digit(11, tecnico) = true))
);


ALTER TABLE public.sessaodegravacao OWNER TO postgres;

--
-- Name: tecnicodeaudio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tecnicodeaudio (
    cpf bigint NOT NULL,
    nome character varying(100),
    datanascimento date,
    cep integer,
    logradouro character varying(100),
    complemento character varying(150),
    numero integer,
    email character varying(100),
    telefone1 bigint,
    telefone2 bigint,
    CONSTRAINT tecnicodeaudio_cpf_check CHECK ((public.n_digit(11, cpf) = true)),
    CONSTRAINT tecnicodeaudio_telefone1_check CHECK ((public.n_digit(11, telefone1) = true)),
    CONSTRAINT tecnicodeaudio_telefone1_check1 CHECK ((public.n_digit(11, telefone1) = true))
);


ALTER TABLE public.tecnicodeaudio OWNER TO postgres;

--
-- Name: temporada; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.temporada (
    anime character varying(100) NOT NULL,
    numero integer NOT NULL,
    datainicial date,
    datafinal date,
    diretor bigint,
    CONSTRAINT ch_temporada_data CHECK (((datafinal - datainicial) > 0))
);


ALTER TABLE public.temporada OWNER TO postgres;

--
-- Data for Name: agenciadedublagem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.agenciadedublagem (cnpj, nome, cep, logradouro, complemento, numero, email, telefone1, telefone2) FROM stdin;
\.
COPY public.agenciadedublagem (cnpj, nome, cep, logradouro, complemento, numero, email, telefone1, telefone2) FROM '$$PATH$$/3041.dat';

--
-- Data for Name: anime; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.anime (nome, ano, autor, numerodetemporadas) FROM stdin;
\.
COPY public.anime (nome, ano, autor, numerodetemporadas) FROM '$$PATH$$/3046.dat';

--
-- Data for Name: cena; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cena (episodio, numero, duracao, script, estado, audio) FROM stdin;
\.
COPY public.cena (episodio, numero, duracao, script, estado, audio) FROM '$$PATH$$/3050.dat';

--
-- Data for Name: diretor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.diretor (cpf, nome, cep, logradouro, complemento, numero, email, telefone1, telefone2) FROM stdin;
\.
COPY public.diretor (cpf, nome, cep, logradouro, complemento, numero, email, telefone1, telefone2) FROM '$$PATH$$/3043.dat';

--
-- Data for Name: dubla; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dubla (episodio, anime, personagem, dublador, avaliacaoparcial) FROM stdin;
\.
COPY public.dubla (episodio, anime, personagem, dublador, avaliacaoparcial) FROM '$$PATH$$/3052.dat';

--
-- Data for Name: dublador; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dublador (cpf, nome, sexo, datanascimento, tipodevoz, agenciadedublagem) FROM stdin;
\.
COPY public.dublador (cpf, nome, sexo, datanascimento, tipodevoz, agenciadedublagem) FROM '$$PATH$$/3042.dat';

--
-- Data for Name: episodio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.episodio (anime, temporada, numero, id_episodio, titulo, duracao) FROM stdin;
\.
COPY public.episodio (anime, temporada, numero, id_episodio, titulo, duracao) FROM '$$PATH$$/3049.dat';

--
-- Data for Name: interpreta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.interpreta (anime, personagem, dublador, avaliacaototal, nro_avaliacoes) FROM stdin;
\.
COPY public.interpreta (anime, personagem, dublador, avaliacaototal, nro_avaliacoes) FROM '$$PATH$$/3051.dat';

--
-- Data for Name: participa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.participa (anime, personagem, episodio, cena) FROM stdin;
\.
COPY public.participa (anime, personagem, episodio, cena) FROM '$$PATH$$/3055.dat';

--
-- Data for Name: personagem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personagem (anime, nome, descricao, tipodevoz) FROM stdin;
\.
COPY public.personagem (anime, nome, descricao, tipodevoz) FROM '$$PATH$$/3047.dat';

--
-- Data for Name: produz; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produz (sala, data_hora, episodio, cena) FROM stdin;
\.
COPY public.produz (sala, data_hora, episodio, cena) FROM '$$PATH$$/3054.dat';

--
-- Data for Name: saladegravacao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.saladegravacao (numero, numerokits) FROM stdin;
\.
COPY public.saladegravacao (numero, numerokits) FROM '$$PATH$$/3045.dat';

--
-- Data for Name: sessaodegravacao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessaodegravacao (sala, data_hora, tecnico, horariofinal) FROM stdin;
\.
COPY public.sessaodegravacao (sala, data_hora, tecnico, horariofinal) FROM '$$PATH$$/3053.dat';

--
-- Data for Name: tecnicodeaudio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tecnicodeaudio (cpf, nome, datanascimento, cep, logradouro, complemento, numero, email, telefone1, telefone2) FROM stdin;
\.
COPY public.tecnicodeaudio (cpf, nome, datanascimento, cep, logradouro, complemento, numero, email, telefone1, telefone2) FROM '$$PATH$$/3044.dat';

--
-- Data for Name: temporada; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.temporada (anime, numero, datainicial, datafinal, diretor) FROM stdin;
\.
COPY public.temporada (anime, numero, datainicial, datafinal, diretor) FROM '$$PATH$$/3048.dat';

--
-- Name: agenciadedublagem pk_agenciadedublagem; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agenciadedublagem
    ADD CONSTRAINT pk_agenciadedublagem PRIMARY KEY (cnpj);


--
-- Name: anime pk_anime; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anime
    ADD CONSTRAINT pk_anime PRIMARY KEY (nome);


--
-- Name: cena pk_cena; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cena
    ADD CONSTRAINT pk_cena PRIMARY KEY (episodio, numero);


--
-- Name: diretor pk_diretor; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diretor
    ADD CONSTRAINT pk_diretor PRIMARY KEY (cpf);


--
-- Name: dubla pk_dubla; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dubla
    ADD CONSTRAINT pk_dubla PRIMARY KEY (episodio, anime, personagem);


--
-- Name: dublador pk_dublador; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dublador
    ADD CONSTRAINT pk_dublador PRIMARY KEY (cpf);


--
-- Name: episodio pk_episodio; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.episodio
    ADD CONSTRAINT pk_episodio PRIMARY KEY (id_episodio);


--
-- Name: interpreta pk_interpreta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interpreta
    ADD CONSTRAINT pk_interpreta PRIMARY KEY (anime, personagem, dublador);


--
-- Name: participa pk_participa; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participa
    ADD CONSTRAINT pk_participa PRIMARY KEY (anime, personagem, episodio, cena);


--
-- Name: personagem pk_personagem; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personagem
    ADD CONSTRAINT pk_personagem PRIMARY KEY (anime, nome);


--
-- Name: produz pk_produz; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produz
    ADD CONSTRAINT pk_produz PRIMARY KEY (sala, data_hora, episodio, cena);


--
-- Name: saladegravacao pk_saladegravacao; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saladegravacao
    ADD CONSTRAINT pk_saladegravacao PRIMARY KEY (numero);


--
-- Name: sessaodegravacao pk_sessaodegravacao; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessaodegravacao
    ADD CONSTRAINT pk_sessaodegravacao PRIMARY KEY (sala, data_hora);


--
-- Name: tecnicodeaudio pk_tecnicodeaudio; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tecnicodeaudio
    ADD CONSTRAINT pk_tecnicodeaudio PRIMARY KEY (cpf);


--
-- Name: temporada pk_temporada; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.temporada
    ADD CONSTRAINT pk_temporada PRIMARY KEY (anime, numero);


--
-- Name: episodio sk_episodio; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.episodio
    ADD CONSTRAINT sk_episodio UNIQUE (anime, temporada, numero);


--
-- Name: sessaodegravacao sk_sessaodegravacao; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessaodegravacao
    ADD CONSTRAINT sk_sessaodegravacao UNIQUE (data_hora, tecnico);


--
-- Name: cena fk_cena_episodio; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cena
    ADD CONSTRAINT fk_cena_episodio FOREIGN KEY (episodio) REFERENCES public.episodio(id_episodio) ON DELETE CASCADE;


--
-- Name: dubla fk_dubla_episodio; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dubla
    ADD CONSTRAINT fk_dubla_episodio FOREIGN KEY (episodio) REFERENCES public.episodio(id_episodio) ON DELETE CASCADE;


--
-- Name: dubla fk_dubla_personagem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dubla
    ADD CONSTRAINT fk_dubla_personagem FOREIGN KEY (anime, personagem) REFERENCES public.personagem(anime, nome) ON DELETE CASCADE;


--
-- Name: dublador fk_dublador_agencia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dublador
    ADD CONSTRAINT fk_dublador_agencia FOREIGN KEY (agenciadedublagem) REFERENCES public.agenciadedublagem(cnpj) ON DELETE CASCADE;


--
-- Name: episodio fk_episodio_temporada; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.episodio
    ADD CONSTRAINT fk_episodio_temporada FOREIGN KEY (anime, temporada) REFERENCES public.temporada(anime, numero) ON DELETE CASCADE;


--
-- Name: interpreta fk_interpreta_dublador; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interpreta
    ADD CONSTRAINT fk_interpreta_dublador FOREIGN KEY (dublador) REFERENCES public.dublador(cpf) ON DELETE CASCADE;


--
-- Name: interpreta fk_interpreta_personagem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interpreta
    ADD CONSTRAINT fk_interpreta_personagem FOREIGN KEY (anime, personagem) REFERENCES public.personagem(anime, nome) ON DELETE CASCADE;


--
-- Name: participa fk_participa_cena; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participa
    ADD CONSTRAINT fk_participa_cena FOREIGN KEY (episodio, cena) REFERENCES public.cena(episodio, numero) ON DELETE CASCADE;


--
-- Name: participa fk_participa_personagem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participa
    ADD CONSTRAINT fk_participa_personagem FOREIGN KEY (anime, personagem) REFERENCES public.personagem(anime, nome) ON DELETE CASCADE;


--
-- Name: personagem fk_personagem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personagem
    ADD CONSTRAINT fk_personagem FOREIGN KEY (anime) REFERENCES public.anime(nome) ON DELETE CASCADE;


--
-- Name: produz fk_produz_cena; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produz
    ADD CONSTRAINT fk_produz_cena FOREIGN KEY (episodio, cena) REFERENCES public.cena(episodio, numero) ON DELETE CASCADE;


--
-- Name: produz fk_produz_sessao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produz
    ADD CONSTRAINT fk_produz_sessao FOREIGN KEY (sala, data_hora) REFERENCES public.sessaodegravacao(sala, data_hora) ON DELETE CASCADE;


--
-- Name: sessaodegravacao fk_sessaodegravacao_sala; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessaodegravacao
    ADD CONSTRAINT fk_sessaodegravacao_sala FOREIGN KEY (sala) REFERENCES public.saladegravacao(numero) ON DELETE CASCADE;


--
-- Name: sessaodegravacao fk_sessaodegravacao_tecnico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessaodegravacao
    ADD CONSTRAINT fk_sessaodegravacao_tecnico FOREIGN KEY (tecnico) REFERENCES public.tecnicodeaudio(cpf) ON DELETE CASCADE;


--
-- Name: temporada fk_temporada_anime; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.temporada
    ADD CONSTRAINT fk_temporada_anime FOREIGN KEY (anime) REFERENCES public.anime(nome) ON DELETE CASCADE;


--
-- Name: temporada fk_temporada_diretor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.temporada
    ADD CONSTRAINT fk_temporada_diretor FOREIGN KEY (diretor) REFERENCES public.diretor(cpf) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  