PGDMP  .                    |            nascar_stats    16.6    16.6 1    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    17709    nascar_stats    DATABASE     �   CREATE DATABASE nascar_stats WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE nascar_stats;
                postgres    false            �            1259    17733    driver    TABLE     �   CREATE TABLE public.driver (
    id character varying NOT NULL,
    name character varying,
    team character varying,
    birth_date date,
    country character varying,
    twitter character varying,
    manufacturer_id character varying
);
    DROP TABLE public.driver;
       public         heap    postgres    false            �            1259    17774    driver_championship_stats    TABLE     �   CREATE TABLE public.driver_championship_stats (
    driver_id character varying NOT NULL,
    points integer,
    playoff_eligible boolean,
    avg_start double precision,
    avg_finish double precision,
    wins integer,
    poles integer
);
 -   DROP TABLE public.driver_championship_stats;
       public         heap    postgres    false            �            1259    17786    driver_race_stats    TABLE        CREATE TABLE public.driver_race_stats (
    driver_id character varying NOT NULL,
    race_id character varying NOT NULL,
    start_position integer,
    finish_position integer,
    points integer,
    laps_completed integer,
    pit_stops integer,
    best_lap_time double precision
);
 %   DROP TABLE public.driver_race_stats;
       public         heap    postgres    false            �            1259    17803    driver_series    TABLE     p   CREATE TABLE public.driver_series (
    driver_id character varying NOT NULL,
    series_id integer NOT NULL
);
 !   DROP TABLE public.driver_series;
       public         heap    postgres    false            �            1259    17710    manufacturer    TABLE     �   CREATE TABLE public.manufacturer (
    id character varying NOT NULL,
    name character varying,
    points integer,
    wins integer
);
     DROP TABLE public.manufacturer;
       public         heap    postgres    false            �            1259    17757    manufacturer_series    TABLE     |   CREATE TABLE public.manufacturer_series (
    manufacturer_id character varying NOT NULL,
    series_id integer NOT NULL
);
 '   DROP TABLE public.manufacturer_series;
       public         heap    postgres    false            �            1259    17745    race    TABLE     �   CREATE TABLE public.race (
    id character varying NOT NULL,
    name character varying,
    status character varying,
    date timestamp without time zone,
    distance double precision,
    track_id character varying
);
    DROP TABLE public.race;
       public         heap    postgres    false            �            1259    17820    race_series    TABLE     l   CREATE TABLE public.race_series (
    race_id character varying NOT NULL,
    series_id integer NOT NULL
);
    DROP TABLE public.race_series;
       public         heap    postgres    false            �            1259    17725    racing_series    TABLE     [   CREATE TABLE public.racing_series (
    id integer NOT NULL,
    name character varying
);
 !   DROP TABLE public.racing_series;
       public         heap    postgres    false            �            1259    17724    racing_series_id_seq    SEQUENCE     �   CREATE SEQUENCE public.racing_series_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.racing_series_id_seq;
       public          postgres    false    218            �           0    0    racing_series_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.racing_series_id_seq OWNED BY public.racing_series.id;
          public          postgres    false    217            �            1259    17717    track    TABLE     �   CREATE TABLE public.track (
    id character varying NOT NULL,
    name character varying,
    location character varying,
    length double precision,
    shape character varying,
    type character varying
);
    DROP TABLE public.track;
       public         heap    postgres    false            >           2604    17728    racing_series id    DEFAULT     t   ALTER TABLE ONLY public.racing_series ALTER COLUMN id SET DEFAULT nextval('public.racing_series_id_seq'::regclass);
 ?   ALTER TABLE public.racing_series ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    218    218            �          0    17733    driver 
   TABLE DATA           _   COPY public.driver (id, name, team, birth_date, country, twitter, manufacturer_id) FROM stdin;
    public          postgres    false    219   2>       �          0    17774    driver_championship_stats 
   TABLE DATA           |   COPY public.driver_championship_stats (driver_id, points, playoff_eligible, avg_start, avg_finish, wins, poles) FROM stdin;
    public          postgres    false    222   �b       �          0    17786    driver_race_stats 
   TABLE DATA           �   COPY public.driver_race_stats (driver_id, race_id, start_position, finish_position, points, laps_completed, pit_stops, best_lap_time) FROM stdin;
    public          postgres    false    223   �z       �          0    17803    driver_series 
   TABLE DATA           =   COPY public.driver_series (driver_id, series_id) FROM stdin;
    public          postgres    false    224   �A      �          0    17710    manufacturer 
   TABLE DATA           >   COPY public.manufacturer (id, name, points, wins) FROM stdin;
    public          postgres    false    215   �T      �          0    17757    manufacturer_series 
   TABLE DATA           I   COPY public.manufacturer_series (manufacturer_id, series_id) FROM stdin;
    public          postgres    false    221   �U      �          0    17745    race 
   TABLE DATA           J   COPY public.race (id, name, status, date, distance, track_id) FROM stdin;
    public          postgres    false    220   V      �          0    17820    race_series 
   TABLE DATA           9   COPY public.race_series (race_id, series_id) FROM stdin;
    public          postgres    false    225   ek      �          0    17725    racing_series 
   TABLE DATA           1   COPY public.racing_series (id, name) FROM stdin;
    public          postgres    false    218   it      �          0    17717    track 
   TABLE DATA           H   COPY public.track (id, name, location, length, shape, type) FROM stdin;
    public          postgres    false    216   �t      �           0    0    racing_series_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.racing_series_id_seq', 1, false);
          public          postgres    false    217            L           2606    17780 8   driver_championship_stats driver_championship_stats_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY public.driver_championship_stats
    ADD CONSTRAINT driver_championship_stats_pkey PRIMARY KEY (driver_id);
 b   ALTER TABLE ONLY public.driver_championship_stats DROP CONSTRAINT driver_championship_stats_pkey;
       public            postgres    false    222            F           2606    17739    driver driver_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.driver
    ADD CONSTRAINT driver_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.driver DROP CONSTRAINT driver_pkey;
       public            postgres    false    219            N           2606    17792 (   driver_race_stats driver_race_stats_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.driver_race_stats
    ADD CONSTRAINT driver_race_stats_pkey PRIMARY KEY (driver_id, race_id);
 R   ALTER TABLE ONLY public.driver_race_stats DROP CONSTRAINT driver_race_stats_pkey;
       public            postgres    false    223    223            P           2606    17809     driver_series driver_series_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.driver_series
    ADD CONSTRAINT driver_series_pkey PRIMARY KEY (driver_id, series_id);
 J   ALTER TABLE ONLY public.driver_series DROP CONSTRAINT driver_series_pkey;
       public            postgres    false    224    224            @           2606    17716    manufacturer manufacturer_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.manufacturer
    ADD CONSTRAINT manufacturer_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.manufacturer DROP CONSTRAINT manufacturer_pkey;
       public            postgres    false    215            J           2606    17763 ,   manufacturer_series manufacturer_series_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.manufacturer_series
    ADD CONSTRAINT manufacturer_series_pkey PRIMARY KEY (manufacturer_id, series_id);
 V   ALTER TABLE ONLY public.manufacturer_series DROP CONSTRAINT manufacturer_series_pkey;
       public            postgres    false    221    221            H           2606    17751    race race_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.race
    ADD CONSTRAINT race_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.race DROP CONSTRAINT race_pkey;
       public            postgres    false    220            R           2606    17826    race_series race_series_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.race_series
    ADD CONSTRAINT race_series_pkey PRIMARY KEY (race_id, series_id);
 F   ALTER TABLE ONLY public.race_series DROP CONSTRAINT race_series_pkey;
       public            postgres    false    225    225            D           2606    17732     racing_series racing_series_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.racing_series
    ADD CONSTRAINT racing_series_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.racing_series DROP CONSTRAINT racing_series_pkey;
       public            postgres    false    218            B           2606    17723    track track_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.track
    ADD CONSTRAINT track_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.track DROP CONSTRAINT track_pkey;
       public            postgres    false    216            W           2606    17781 B   driver_championship_stats driver_championship_stats_driver_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.driver_championship_stats
    ADD CONSTRAINT driver_championship_stats_driver_id_fkey FOREIGN KEY (driver_id) REFERENCES public.driver(id);
 l   ALTER TABLE ONLY public.driver_championship_stats DROP CONSTRAINT driver_championship_stats_driver_id_fkey;
       public          postgres    false    4678    219    222            S           2606    17740 "   driver driver_manufacturer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.driver
    ADD CONSTRAINT driver_manufacturer_id_fkey FOREIGN KEY (manufacturer_id) REFERENCES public.manufacturer(id);
 L   ALTER TABLE ONLY public.driver DROP CONSTRAINT driver_manufacturer_id_fkey;
       public          postgres    false    215    219    4672            X           2606    17793 2   driver_race_stats driver_race_stats_driver_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.driver_race_stats
    ADD CONSTRAINT driver_race_stats_driver_id_fkey FOREIGN KEY (driver_id) REFERENCES public.driver(id);
 \   ALTER TABLE ONLY public.driver_race_stats DROP CONSTRAINT driver_race_stats_driver_id_fkey;
       public          postgres    false    223    219    4678            Y           2606    17798 0   driver_race_stats driver_race_stats_race_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.driver_race_stats
    ADD CONSTRAINT driver_race_stats_race_id_fkey FOREIGN KEY (race_id) REFERENCES public.race(id);
 Z   ALTER TABLE ONLY public.driver_race_stats DROP CONSTRAINT driver_race_stats_race_id_fkey;
       public          postgres    false    4680    223    220            Z           2606    17810 *   driver_series driver_series_driver_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.driver_series
    ADD CONSTRAINT driver_series_driver_id_fkey FOREIGN KEY (driver_id) REFERENCES public.driver(id);
 T   ALTER TABLE ONLY public.driver_series DROP CONSTRAINT driver_series_driver_id_fkey;
       public          postgres    false    219    4678    224            [           2606    17815 *   driver_series driver_series_series_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.driver_series
    ADD CONSTRAINT driver_series_series_id_fkey FOREIGN KEY (series_id) REFERENCES public.racing_series(id);
 T   ALTER TABLE ONLY public.driver_series DROP CONSTRAINT driver_series_series_id_fkey;
       public          postgres    false    218    224    4676            U           2606    17764 <   manufacturer_series manufacturer_series_manufacturer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.manufacturer_series
    ADD CONSTRAINT manufacturer_series_manufacturer_id_fkey FOREIGN KEY (manufacturer_id) REFERENCES public.manufacturer(id);
 f   ALTER TABLE ONLY public.manufacturer_series DROP CONSTRAINT manufacturer_series_manufacturer_id_fkey;
       public          postgres    false    4672    215    221            V           2606    17769 6   manufacturer_series manufacturer_series_series_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.manufacturer_series
    ADD CONSTRAINT manufacturer_series_series_id_fkey FOREIGN KEY (series_id) REFERENCES public.racing_series(id);
 `   ALTER TABLE ONLY public.manufacturer_series DROP CONSTRAINT manufacturer_series_series_id_fkey;
       public          postgres    false    221    4676    218            \           2606    17827 $   race_series race_series_race_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.race_series
    ADD CONSTRAINT race_series_race_id_fkey FOREIGN KEY (race_id) REFERENCES public.race(id);
 N   ALTER TABLE ONLY public.race_series DROP CONSTRAINT race_series_race_id_fkey;
       public          postgres    false    4680    225    220            ]           2606    17832 &   race_series race_series_series_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.race_series
    ADD CONSTRAINT race_series_series_id_fkey FOREIGN KEY (series_id) REFERENCES public.racing_series(id);
 P   ALTER TABLE ONLY public.race_series DROP CONSTRAINT race_series_series_id_fkey;
       public          postgres    false    4676    225    218            T           2606    17752    race race_track_id_fkey    FK CONSTRAINT     w   ALTER TABLE ONLY public.race
    ADD CONSTRAINT race_track_id_fkey FOREIGN KEY (track_id) REFERENCES public.track(id);
 A   ALTER TABLE ONLY public.race DROP CONSTRAINT race_track_id_fkey;
       public          postgres    false    220    216    4674            �      x��\�rYr}.~��⚸��&.�(Q�&9Ӟ��PܕD �2�o�-�1��@�(����%�-�%��9�yK� /�5J�V���Yk[��Rǹj�'o�1���E��\�4��4�1�r�2�������g������WͿ?5VJ�r�m`\��B��j��h���z[�g~�K��k�e�)цjLd���x͇p�0�|X��V�Sz=�δ�es~���'��:�Fy�2ku�X���>���d�Eq����t�^|�-��I���ƽW-��͋��:���F.Qh�0��\0��S�%���W�uQ�Y�m���o�|�<M/w�U����#Uc^�6j�ZSi�`��Ȩ�,���4�O~	�\���ژk�l��~u}y����f���B�"��3Ŵދ�V���N�ۖ��|�n��oa�\}�.��b�^,W_����B�����[E����SI*`�R���8�T���&�L�-3�u��c��6x^[��V������j=�ON�󼜦�`�?����Y/���ñ"ŔmCĹ)�~2�M�e���kL�H����u�[X��O�-b��`gT0�[���&��}I��������?�����"M˶̴������ݰ�V%K�9줏[�}r[$df�f$9k��eru?]��f�i6���9دQصd�µ�e����KϪ�i_>����%\�4W��5,דw!|�l�PD藻B#����'�D��jL��$�����&W�]�.,� 0Ⓡ�z1o~Y,��d�Xߒ��~�����Y�Rն���*�����+Y��!���_�1��/��_�o݃�sJ���e�5�R��*�1 [K���@V�raU&�g��b�nޕ���^ @f�Q_%\6cG�K9�K�"x��0b�j��VcB������2�]<`~�������,<�`�׏O6���w��X�&:��mr�*�bUPth5*'�v�_'���8h�}Pxi���)g�ɱ��4��B|�-��]��W ��qi�|����m�Ǎ�5�Y�J��*1��������YB���,��q�1�/��;?� ��l8!��ߔ}6U��B�_��m�Ȉ�ED����؇��t>�9N��,��6Y=%%@���a<ֶh^s�\�b1�e��|X�����lz�)�v������8�o|n#��̕�1o����X�_�����a��0�{Q�_KD
���O���$��!�"  '��в����Nޔ���8�PVe�����~s��/!�U��ϻ��4�`�)���1�A�y�h���I�><�
���A<-NK�!(�Gvi�U.s+UB�V�р�����es���-��Ñm�s߻�w��6aC�ٵ� .U�N���Ba��Ƚ^�o���<7o���zr�����l�_�6Yb��  �yb�D����(�t�9�����,�އ�g�� =�l�X?�$V�6��!$a��f�U��l	n	� ԋ��ے}
�+F��#��^��`���  ���JU�b���C��:�0%!���7�&�h�oݘ퐑��3� C�kAI�IU�&�"R���\L��lr��_I#�MgͤS�\�"}>[N��n��	���aqo�T����^N�&�yY�k�V���)���n��MrNC<a`��������1%iv
��L��-[����t��e�<b�Mۗ�
�r7^����S�xh3��Mbj�BA+�|� ��~�4� ��^�t�3�g.���+�8rJ ��GmZ+	�B.�P$�X���������?ˬ<6o�������\��]Y���Ɠ�����>�+�h����r�%OAҶ
�E�*�$">��ԯ�����C�EQ�6�����O��i��p��ߎ�'��r�K���� ą�a�J� ��^:Xc�^ ��#�o��G�2,;W��U�C���oA��y+�vOޕ{���N����=��6�F�Id��_`4̙�����T1�����5����e��%6�̾l��l��t�
��Z�E�9���hA���F�<��"?v$xC�:��6�����l=�5E��h+!k ��I�+c
�3�m��I�rAda��wOJ����`YX%�˹���� �;��] <�P%i���V�i�w��@�Z�+�p��ȈiP2 ���~�^<�~��"Xs��ǟ.N@^_���~�đʰ�*��MJd۠bRa^�DA$w��x�| � i9����yk?��#G��f�d�L1����8Z^`a<�#�v�q�?���w��e�O��8��	@r����誳�V�X}�O�.�,�9����}0ms0ɀ�8k͉�$����(�O����)���vNt~(����,��96��]ȕ��&X�FЀ0-C�Hꁗ2&+��/�a��rz���`G)[�g;K��d�j�'ة8"�Xs�4��
0s<�\k5�6���\!�{ 
�;)�\G_�L^_���S)xq������R@P�j]��lD�$%�3̴9{{�|���?���+��& TV�"Q%�IX-�%���ON
V������ �l"��?>�"E�6UXn�9H"�3o}�U'�R�l����/�� n4�l�Ph9&~�s�e��0+lS�P	�vR��+���:��_$Wl�(��Z'j*E��9��ǲ�O?}cǲ˕�yV��>��ucw�q��
8E20a��y�s�y��r���$��[�����˸c;3ޓ6�ֱv8��)�/H�x�&[iJ�����ْ���֝�|}_�3ڔ�����������v�����4C��ƪ**�.Z@��Q+^���|�̰��y.]v�7N�xO���՘���QUD�£��N�Jx��i&D�Es����U��M��_ְ�:a}���	��J1t��(s��Y����Mi�ő�%T	U�����;��?1Z�cT��Eu�*�ȼ��.b?Q%9`Hϟכ��WJp����	�j3�������,X��ܗ9������ܫ�o�|��rI��L5��ؤ*N0�	Tp��}��7�D�SȲ�b�\�I��3�T�3��/DPE�Lp3�&�Ь�u)�.b���g�֗f�MBSv��Mh�#�
Ĩ�
��XgY�:��l(�ӜC6NN*f�)��RRT��N.�=x�
�pA�9�#�_	av~��2$Taؐ�~�փ[�k1�aɡ$@P0E� E��*�3��o�Z1pDc�f+�S�0V���ZSX�0U�)������[��[�C�0ްVJ��ť�8�S�k�gZOV��{Ir=P������J^)	`��R��E��&h�xg�婴ڃ��$Þv����W� Pщ�l %e[�_[U��}���,xTj�r� pSY���t�;�{���t8�`)�4��ERa>�� ��ga����5�Ψ�5��Ah��I�j�PrP���%���E�j�A��}�H��駇�8 �3� ���/ lia�QF�Y�NcC�8WX.�z��>i���W��q��Q�.�tkBMIT&,2�f,���7a�D�p���nk<l�&H�(9,F��G��dQ^��w8�9�V�/V��tj�'�Dj�lqA�ȩ�z�� ��6e���).�<�t�O��b�PEl�C�sJ}��c��)fH9���Zn*o�gؼ�_��}|�<W<d��ݰqZ�)�v�E��c"���+�D�T�k���)��X�7�ė	#H'��|z���_��?:�"%�-0��A�yl/�,��%)3|-3b�e���n���%� �܄I�C�� O��0<�%/S�A65�!����t��������k/�0�s��Ƹ���pjtX�@����J� [�V�|�-|��6����a� ��[A��{T���,R�$�̡6׷���B�?���5�z���uZoo���j���L����M���jB�(����2����?[/�sQ��/��)RQ����!;_T��Ҽ��N��w�}e�Lj�9�� �(s�2f����6�hU$C�R&��rN��iE������=�=sTjPҀ    ���Ԧ'����H	]���b�\(��#|��QE�
Ҍ�!#N�B}��N�EU2&(݌�^eW�C�]�k��66���P�}-Ts�2���0�L�:;���t�n�����8?�H#'e����[���1����^y�D����$r��`J�Z�Nǩv!�&��kN�[��6�{<�݄)�ԞЦ�I��_�ލ���X�����Cl���`�Ҳ>f�R5UQ��y��R�~��f�X���T��e���[W��a�D���Ȅ�0���4�����Z����dW�FT`ƴE� �o���πg�jG��yuy����E��1�Oo�'�$�M ����x��J�rJ���Fm{I�RAc�*�+�m��^RY�IX�M5��TT�	h?���YIw[�Է*��mP���1P*V"�࿢&��l��R�sJ�/�2�R�$9��d�~�F�\i�!:멻6bN������Q��Jᖒm7$��|ץ�K=K�S��G!đ֠���m��
�ŷ ���xD�+*�i��b,O��(�|z���lۺ��#"QR!�uG��D�~�k=�V��x��]���uY���a9Pڑ�u�?aD�xq��*��z����P@!g#�e~��\L�[��n��C���(� P.��u��j���Zɢ�,���C)y�=ے[���'�����8����3I��Za� J"ޅi�eӖ���=D'�sN�[#�����X�e|J,	�)�����@�h�����?��,|���-Q�X�~"�����K�&�����(�fC�1�p���X��X���5��̗��V����
���[�lw�5;���-y��B
�ҝ (Z�c�e�˸������j������vr^j�|,5-���ѪA�8:�{8{���o5X6v�5��9l�c�0}�m����"r��:�h���R�$�vƶ8A�)�����3D�K"���z�;=�Ȗ�ht]��Te[��������;9�t�7בė�~�02u!�Fn��0
*�{�Ԉ�2S�� ��Y���BQ��4ܿ�����x0�*R�<� uF�� �Z��6����nˏ� }/�}��w�ǫ_���D;(0-Vx+S8I�5�9�����nH���+;�Q�}�yd�đ�B�X��K���By���|�>E3��4���@?�`�5c�=�A�,5H��3Es�h�b7@U�Q�y�ΐM!b��Mj��G
�b�����Pv>�1��`Q*4�VNށI<o���a~���,�[cd�$�(-M�.'$�0?��f�?�5z}�����u�����n7n,����G tl�@OR�m��g�0
i֜vUH��F�]��J�3�|b�SVo�\#�	#(t��ks�������K�[����.x�7���Ey����ZjMO�H�H)A�im�)����y��;������,Srn�Uے$"�j��3�1�ږj���	ċ5����4�zׂ9D�h'E�1SM�\`ʶuP�#c(��ʛOT$�X����2��:�L}�?����BR�]���EsV�g�]���g�
^S�b�0`����f�^�/r�������-Tz�9a�{9F>|e����0Ҡ�i�8��M���.9ை��F(\�����8�-?���6s����yz�l�8a��S�5�����	Ѧ����y�,7]��xF���l�y�H��'n���hx��(i�u��3O�wM*�q?���'��x�ȏU��Z��
������Ś7��<.�sK���l�c�V�1|`�5T����Q V�"�hK) *��sU���>�6���7$I��Vf�H�$ ��z��\� �k�K�^_;������O���?�$R�9�[�5��)v�|�b�0GZpsL�c�D�ve5���j��oD���m��G )Ygü��'�@��粼�"�r��M9c��:ҭ�B�tJ�H����T+�����/ַ��L˶
�7.�c���y�����U�,�&
�3U,�p��M�~;�M>��RB�����WW�?M޼>{}y|������: �6R�:''ѹ���м�+t=a�VЃ"T��o^�?r?11jr���M�Z����F&3W�b�6罟�m���t]�Hl�}��6�_Aׄ��m"����*N(;�j��Y�Ɨy�-�7���53�k9��QX]@���ɩIФ+T����pW���.�������1�R|��v� �3\_`K��@
	�JsB-tg�wǛ�O�|�xݵ(Q���J�zٙ#�WU�=�@�f���H�}sM��E�Ӿ.����X����@����S��Cq�(d�(�t� j�,�t�w=.�nm��F�J�D�zt���*�S�ln/�+�������O�`��pS6��2�Q�@ˣs@��!���R�I����R?�E��Э�������J�o��+yDW�1+(J1��SĔRa�Sel>�G��ӛ����_b�f���p���xG�8`U��=�5^kh
!f��A�.����6�ѥ��a��9�51�Ax��T��<[G-�~j���t6��}�|���
?�w����RP�5B ��q@�#bJ��^,��q�܎^-�����퀂
R�܂(R���ױ�	R�2�*zy��֧�^�D�P�#�х��ԓ�"���<i%����
2h�=�2X�6,]JVp�0�ݤNp~�Ҷ��´��z�eIL�)�����m�\(�݌6SLV�� :%Cs&^X�F�W�:�<�1uQ\��p_v_�&�t�c�5j�3�]�z
FZ���U�� ��c�\��z�nI�����Yr=�p#�Xj_͵���ň���E]��r�>�����.�7��<{��m�^O��q8P-�`oT��[��&����x�G@ۗ]�����J��6֐Yr�w ���V9���qܝU~,_���m:f9�L$d,��F�w���"�>��"X�EX�Ťk�\����[��ӿUJʱ��v��uUn��(�y���ZV������P
����x{(�Z�EhsjT�t���;��'1�I��56^ǆ�k�+\n�;J<*A��Ϥ�<}�З
��K��o�9U\/��<�f�����`��g�!C���΀5*�S��U	4,T�:�P%����ծ���u��,=�y���d�2�.���8S��<���%{:�}i��d���GW.^%��y2��f�x���fJ����ƃJqoxT���'g};ݕ�:�t�"������ﶖ��ڛ�`������m�:y�x�t?MA~�0$�c�pB��ld��z�fɸ�β�0|���e��tAǴ������uY~A )��e��b���6Ã+e	�� �>^a�,�.u�ێ��%u�|����V߱ �.����	V�����S�Rg�P9nB�a_�h��S:���R,h��#�)���8� ��q��^�\�_���4,�e�=�:���Ԕ]AM��k��$O�M��.�w(��j��넛���a���$	_�(`{tN()�R@��H���kͶ����hMɅ�������e�M䮟��B�(��g���$o���6�I���S��n���F��F�K	��w���e����A���}ގ�8��f>GU��[�0�l !w������2����	kr�[�xPH���>�V�K��T�|���O�7!����2�K���x��aݭ,C9v]#�7%	���ԟ��t6[�o_�-�Є	��څ�؜��Bɠ]1z�Ud�UHw�&�����y8�y�`�Z�H�:�q�F_���������\�ٮ�K����ky��
}�I���S҄������7'Px`,�K���<�%�?�	���%R)�h�_��2LЉ)d����㷗`�����ɸ}��Z�HITF	nK7�!f^l8Wƚ�үD�v��#�,]�񹁯X�^�G+�$��n�-��K*�'�!��8��~�����t�`�]T�&��h�G ��4}�)��ܙ�Z���,���<M��;�Ü�F�l�J`�� �  ��٘���x����4�}�ۿ>�J��۬�Ƚz���֥^e�	�|Y/r6"GK�^f�r���F�T�ʇ��*��Q}�MIj�熒�1!Y����"b�Ux���w@.jwdi�u�w�+��+6o�^�p���H�	A8B��b+5Oe"{����y��T�nN/�~OYԏ�J����r<�c����eԓ 5D`����E�#�&8`f#�""�IcҒ�I��m�cP��PE��W��XcYR�`X�~�����,H��qQ�����P����k/+��C ߵg���zXj�����L\bR���$�x��ha*g�E77�.���n�]��A��o�C+8R���[��D��\K&�q�ϧ�=_LN1���7T�[�Lň�E7v,��Jz.�X�2j�����Ʉ�gɤlz�|�ޭ�b�������Oo���0�X	T�/�n�9C7:t#��19y���ˀ8�
���;Z1w?�tw���M`]�HNUr?+y��*�Z��r;]M�1�;g�fO�a�c]{�
��X���t#�����T�9 l�+�
&��^�����H���D2�-����CL�x�al5�W�g�:�;��x�oǓ�ڎ���D���x�j�T*|�C}��)��q�Kcm�6�ҁ���X�+�Ի�j"�*҇Q4� �Ί�UtI�d�
��4�Re��j2['��'<�����m;C��I�B������0�(�Tw����ʃ�����IWIr��I`ɴET�eW����]���+�}�:������ہcY�G���tW���ZS�s�q�H���y�t[�����_�˳�T�WDC�A��6{M֒�J�86��!���by?9!��/��/��d���h�h�ڢS3]W�X��VP�_�2�hY�Xe����!��?^��5y�l�bt/)A���k�GK7Jn�-� ��!١���#dÁX�n]�p�bKИ�4:�ܜ�]䡽���&]���'���j vsqp��� �\�NLT���5ݲ\m��CFJ�cI�kC�.� �X��y^
�hsi>��HoK9!��/�W�/��J�k��pU����6��R(,�����o��?o5�׳E�c��i95Q[}�������;�kˊ�x��Z��f��k����㱡��C��>Ⱥ���x���ߎ����|��      �      x�]�Y�$9�E�-�"�fQ{y?W���;��#����D����(˥F����j6q�nڪ��Jk�Zkۓlp�>��=.ݿ��~F�3�X��1�l2}�f����J~�����ُs���WD�~�i��L�c=��!Z3���5˖��T4�"�{\������yg_{2�ś8{6��m�����M��x��]���.��=�ǎ�ӄ8�D_X?'1�W_}��g ޞ��GB�;�9w�}͵L�.�(�sq-����1�jy��x�/g}~Ǧ|�]�!s%S]I&��Mm��&�:�*�wD���O������^�S�ȏD_��_ro�.���`���/��	��k�+�2MIyS��6s2���α��H9���zjn��o,�_1y�V0-���+�Z�4;�V�$�q<Y�n�~l�U�nY�����bf�B��0��ڲɍ�ӓ���8�s~��B�kޓ[*&�B��.���M�q����0����|"w��w�L�g[���ݱ����i���sn��S=���J屋{V_^Z����=��=��Y��>�V��O:�ׄ���o��j*b��8{1��j�s{�]��;W�?5:��W���l��^�sRw4��m��R<��ևAx���q�櫖���֬���<e3W3ݹlf�au�٢M�O�����5.���\z���bD���'i�!���қ��YY=}�.�niWovpǧL�����NSvIȰz��?9���x���o��7gMr��3{�>z1CV�94o�$�'�Z'�'Ҧ2[`�G$��sw�:ϳ���*O>��ݶF����^��M,�fq}���8]��&����n\���Sf�A���a�4����C�P��V�'��D�-ք�(�=�������L]
��Dֲ'fF;��\�\kV,�mӜ��zt�?r���D:�:W.�倯J"�l����zN�'�;���
���Rt ��ۗ��ˡ?��=ٻ��B�h�<�7p)ִ&� _N�#$�{��H1�Q���d����B�����j]ӗ�k:��?O�S��
�O�>�gۦA�6���I�,t���-D����89����h�� ����֫i	��K{^���	'^i.�I%Y��D8�A0+MSSs��4~5g*��rZ6��J�<<D�Ï2g��&��X8�av�9�P�Eoe��du�[y�#X�|�[�಩�y0K ��|n
�`$hy�(���WL\��O=pm�O��̽��Z?�8]���{?�p�+��h��8<�X���}�Ql����ˑ-a�
EC��Zʳ��U�&m}��7]�W]���tۍu������:F�R�5�����*LΕΪ�+�����ʲ��K�ȏ�|�O���ߖG�*�?�^���8�����xG����M�]�Կ�ʢaĐJ��h#:���$��m����ɚ܊?�X���-A�m��,��bY�̊�+�R�zx�$��+cH�5�8$��x-�X�.pˁI�V=�^?�`A�!g�@�bO�|vT,����}�	J�ɕ�/n��'O ��\hA��)t5]%�_j�`�p�/:E4��L�
�P��L8�|�5[4�4����~���������ؑԙ3�gy��zb>z(_� ��x���D�
���j����g�'�Gx�Ԝ��{����]3� ɐLb�J��2m����׏k4�_�yC�Lj/Z4Жixv�����N.��\t�+P!VRp��ߨ�[�ɻ.�R2Te�7g�0j�`� �@𘠒"nTMk]V;�Sڶ:8r�0u�\N�"se&�1�� �a2�D�z����g���!���2b��{/�΀�����K���U/J����,5�m����oT���:Tz�${�9���B�G�5v6��TP����R'H�f(k��J�r��h���:�"����t�pWC1ft+���t�RJQ]���
r+"|Z �ީ,S|N^a���r�Vu��ý�b�^$���}���K�xF�	���+�0�lT9JP�5�W�jt���̞	��趢��MV	4
��]V����d�n#�ɮ�1��Q��\����b��K+cS�fת�-���C[]�!~��=�����[�3{T�A��\�����%�9�W��s�sޓx�u��u'mB��iժ�����9��"���jо;Nm����3����Zâ���9�Js�>W���J�~�U*�O�D�S����Ƨ�Wb�o��f�EZlR%��K�ژ3�D)6�i���4;=-f�+t�(ÂGv�搘�����ZƒtPnVK�_9"؛�v��_��jL�g�S�3@��#�����h��R�۽��^�6�/��ũ�]T�ך�
�Sʢ�{��M�z����'z�������*�����ؔf:�[S@���Ł�H��Z�P�@����az;���n�F�uj�+�f��M�T�^�1 �^�QHz��Y�̖�Xx�+�#i��`�����9nF���0�\W����@\�)��. �=�R9��Ox7���K5�0)E\�D�>J#F�����s%E+���d�j���D W��t_	yD����6z.��^ck�c4sA����yn?����!\R�r0ڭ�*�Kf�d���N�m|��o�6�"���B�����*�8\FN��|��]WxT�����Ƃ%uD�$Ry2s�7P�Ӌ�N��ªh�ت��Sj�^RD���Ƌ��8T�u��;B� ���'�[������qX�Y�G�LY"��@�y�&������4ޞX�0����[@	�x�s�1$�c�V6�t�O��E)
�iC�����S���=�'����H��U�Tc7:tc�ܮ7�F�����]���D���
/�w��l�-h��E�(�S2�E��đ�ƦSq��Cɫ!�0㨞
:J�G���y���|NX�u����vf�v���u:&l��<�o
}��{ʭ�p=85��܀�L���ׇc{KtW�����[�������)��P�[4'] � jpz����4+���Y�t�C�j��a[��������_�'qj�M���D].&��;��q�^��h%l��01�5@�ֵz�B�R�!�ø+�#��*�x�����ʜ\�s��?\��L�X+)��D��u�!M��ǻ�k�qZ>,�~Ҟ��j�tx	ܶ�&)����o�zT���)���S?���

�ӽ��;q.ޘ�;P[��j�AF��@�o�=��P��/�k�.��b=J�>�7�:%P��p:eNG� L���
~��jQ���;w���҈��U�����B��Y���(�2^X}�O�)s�
���`P�+!w-
��1~M&�ȰXu�b�uO4�|�ť߂]}Z�4)�ǋ"����mm�B���{G6
�6uj
� G:��i01�����dP0 �	���3��QT�"0r �m���I@]$T<}����!��o�T7b�v��v�;y�7�|\�f}ڀ�=�m�J�}�jWIu~��u�D�܉���)�6k���ݾ���@V��(�R55RP��N�P!����OG�3�ڵ��
Öz�3�MW?�iD��m�FkG�3k�ģø �5�.= ~����^��aD��Q'G�;������DE���4�q�\S�}.�e'F^g��˟���	mo�4^��ei�U:��h#}yE���3�y�.�@r*�_Ԕi�Ȅ`mK�W�?��э}�'g��/�2�h�i�g�ZE����:�����G��=f'�}��l�C����C�'%8�z�Κ��7o�/oC6��-Iu�=9�F�r3�Ǔ�{�8lt7:C@ $	U��_�*8Q��0S���=<���σ��r�1,�v����]wFu��5h�zL�Q��06�uLy�9Q�M߃H]�QM�u��n���͝���1,n�#lV�P;��0R0L�q<��p�|�:%"�Vn:��\$��fw�L��/����s��/m+��2�|Q7)`��v7�=�G�=t�]\�o�a�]�53�o�u��A���jE!�,��x��<�_�vϏ��P鯌o��^"{a0��uP���ΰ�% F֤Z�AM��Aa!����,�e�;��	!v��0 �  ��ƨ���Vv��T-C�c���rɇh����\Q��,�Of}��g�֮��BW6}^n�*�%�H�B����|�DĀreZt�5��t9��.���'_��o���,y�0��RAW�^��(�خ�˵v���?]2�ՙ���ᾛ���['������S�5J��N"nR(C�J��:��"R��5^���~$�RFB��Kih[y̩?ij1��RaM���w��9��;�%�i�"��H�����0�rt�؆�I����C��6vV�"��33���$��U��m�ᔕ��Sǹ���qG�6haw���2QXF?�uA�	�����f��қ�����jU����j����+��3�ĝ��sf�A�l��$n����w��W�7FA����a�X���mx�2ɴ��< �x�����Du87�����|�w�^6	��dQR�s���X x�hS���<Q��y�X �_��t-ם&�;�=@֐�M��q�Ψ�%�q�a�a�;~_��!���
Og8�G�4��gjw�'��x�y��3���5gހys��H^Ē�]b�s���9�{?} ���q�4��Ӫ��u�㫡_��-�ע� }�k��ٲG����y ]�y�t���{5�:ʩz7ho221�\������jjύ��ͬ>t�i�W7qso�*B�(�����jd"�<U;Wߗ��>�Qk���y�� �י���3s��]!`v�%���z��H�z?��Gg���ԑ�[�G�e�@��)��후�����=\%:z��A�f�I\*���ٽE�,�i�գ>�� `8$�Pm�Ϝ�x���]B��� �O�ԍ�'��u�;[�X��rE3��$cp����>@�������Aǔ�
�o������T�������w�o�������өm�� ޜYa�s���܏b�]i��SgŜ���WRXY?�81jd�: oH�6�1:#8�NA��,��.qv�.�}��5�%��P'�H���Ix6�8�aOa(�W�1
�9���o�I<�n���s�R�i�g��s|ȍ_�n�V3!T-S� �v3��Ne`��:봡z:U��H`�tc����Ѡ���Z�V�v =��I�y��(����E��ظ�&�s�p�0��E����O��@��U�u%ŝ�Q��Z��l$�=cΣ�!�{2�wWC2��y�����U�R��pL�*����[�� N� 6mꐪQŎ?�7Ɵ����el���ҥ�  ��*��S�x���gȳ����jLV�Ņ� {R��mvR{������y4�݂���E?l�:���]J�~��F��_d<��ukE��V�v̎�����	_����4`eX���?�/�L����ꏭp���7jЃI�Dߧ�Q�2�|�:�/��˅P�}g@ʡ�h����=��{�n�w��������E�Җ~��&,~
��X�r{�|���+0�<~W;FT��T�~G�������
��B��Fm��A��\ͮ�'�!W�H�j'�m^�U?��[�H��;D<CՓ�B����U�W�{%�_��n�`�|gu�;���z.�˪�КE�+v�f1yj�o��!;}���ηr�����jy����Y\���Z��5GPB.]���o�<`���	,�1w!�[���BD�k
5{�����!˱Ļ��ܯN��
*T�qh���; �W�ۙՅ5�N`ݨ:A����6)��~0��`�u��0e�={��RqUH�?�]T^�woT���lCg]�*�6��X�U��:����ҡ��e�a�t��K��xZ�H��]��\;ba�S#��E��	rz@�vd��D���&������M�*����Rsc��}������(Y�N���Ί�S{���^-��=T�rGjc�Ӧ~X(�����1����M�6�}�O����yG��X?o�oՀg�_��XoH��^�!�lQ$�;��	��zJ�_rw�X��������7���      �      x���Y�캍��w�%r�o�#)"�?`#�y����v�=�� z\g�o�/�Rz��������;������_����y�󪯔c}5�.���ǧ+\�|���?�����7�����J/��w���~_��/�J�gK�x���)ԟR{j��W��?_ǧ^g��8zw�<������j���O}�R*׫�{���j�>�]��_����Qs�|�o�����^�)��3�|��f�M8�/�'~�Ϸ���)'���ow�ާ�!��0�������g|	X|�v���#�.�g��{�l����ۏ�>���~�t5!���Yr{ų�b{���1
k��9��wϟo<^r��p���������#'� z�ן�٥����܎�*�q|��:R��{�"������%�|B;J���UBx�h69�w걻o��C����ˏ@|JA�����:�%���1�oI�j��Pt�$���ӷ��a�?tA�[p�D\�\�w:�M�z�O��N���ߗ@}䪊8�o�"D�ٿ��r^��_x��=˕�� �|���|���x��1�*��k���?r�U�ܼzQ}�����r|N�� ��/��)��~ޯ�����u��^U���r��շ�>�s,?9��?"(B���F���ΘC��&���˕%�~7�H�U�T8E�y>ʙ>���w�PM
߽���'|�?�y��vQ�QZJ��R������;U��
_|�A�K/���	Y��x�ޗ�;uQ��u��ީ�+p^'�~��?�{�bze�\Yў�c|���!rDA�l]ė�s��﻽ޥ����k1�_�描�^ȧfA����+m,���.��u�&������rF���ǵK��S�ʟ�D�R�-0� �(�wW��Q=����'jc���G*�^�R�*��_t��7}Q�1��İ������X��;�CΪ�wa�+z��|k�I4<cy��<��u:��p������	�C~�+|�;�����)G���Yb\x����/���4�+�Yy�<EZ�Mx�j�}?�wM��G�z�}��P��5�	�1�<�7��x<[���Ï��}����Ѽ��Xg9���Y�G��ϧB��akzVt_*��z��fzL̀d��ah,��cO5C��Ʀ݉WB�g.�U��w[j�庯9���2Fm��Do�=�+c1&���Z��"���VǷ�����zu߷�����02�8:O1��%'�^�t�����(rGŇ|�D��#w%�a'�C/��ȦĄv1|��)�}E3~�0"�����������!�nF��u���"F��v�|��vW�~���|>W}Q�>����B#MN${}��z��Ss7��5���#m
�|K�g~�"R�ޢʎ��5�ov�`���#�E	\$��(�^��3����ο]L����"�z+���H�!����)�o썁��H�5J���r����j�bH�����x�ow*��JC��z�x��sg���+�E3"����H�冢�®�6�"f'� S�~��Ɋ�F�gg�i?Ӧ[����X8������ˁ��q~��:>����[s���^��{�K��^._�W�;�%�ȣѲ��Gb��/9�iw����֟||��v1�Zu�H�ǉw��U1_�[�~���]�Q��&�н�H�+}��@���v]��!�EMD{����������>�Y��\�P�L|����W�.��ӺHSn!�/����q�G�dz�t��Ȣ�P(���L/p9Py+�Н��xq����AL�&L�Px��^Ёx�O�b
S�E,��K_��C��**Z�!��;��1\#���Epv��<+�u~� x��3�3��'�x$��S��9�����1n��o)��_�����>����0����>�923�	���=أ��70|������W?6}���8��2�����T���U`�1�*_b~p���4&�PR����@e�$�?��q_`aP�,��>����y����鏈&枱�����N�E����~���Y��}����o��<5􁦟�D�Jc�{c�18�@��3�1!��/�N4�h�ffn2�/Ɲ�O|g�2F~�0��~��g��E�w�Դ��E���͎�LM�}8�!aQ�>Ր�(, �~AWM�j?oe? �3)���J��r��ʛY8]�0��`�A�XˮQ�@:�/F�7�XV��({�T���c�A}r��]z�2��!��a�qZ�o�'���ƌ�� Z�":bA _����uy�=.Ut[eqiF}�'^������#������P�C��Fv�A5��r�(����>�ޢ���`����J�w(����W��|��	>�Rw:�yB�-13���������7CO0��еfM����A�Z�E��na��@/�y��kٚ���y�G�����h��}c���$�ܨ?�r�S��]a�8B���-��Q�8�K0����ާ+�R8�;e��ca�÷�7- �*�œ���߽�Qk�����!�b�#��p37>E(��;�����d�݁�aē��ů���z�zd.;�	Ţ�SH��y]���9/��>�
�����x�/��?�Ҭ%�As��U�ݿQ�c�7��u���q:�!�eB���O�E����#��V~�N�h�š�]�>��"ԁ?^�Yf��@��r(/U�t�k<\^�����TXЁ��������#�\j�����-g�]lXď�j	!_����rd�m����Ԡ��K�}����ւVk^��J1��NՃթ	�;,�`�}x�5�w��PR�	NV����e�S�����c)��^���uf�i�v����Ē�
�*���YsL��4"�9���׿ĉ�_xx��]}��|��O|�a M{�R�Ω��K��UO�����[G~#�7O�?�{a�㎦�ͺ����V�#|����w>3�D�Q���?���_�&=7Ê2����u�s��=XLx����~�v3�O۷���j���#�vC:��r�2ׅ�����T|\`�
;߼����P33���zx}`\ �P�X0%3��SA���r��n�T~�H,*�a�+����Y���[�f�����K۹[Hf��/(۹�b2�������ʜG�����B�}������#��F�#��.�dEd� ,�n�� ���r<���`�˷�' ��O���\W~uQmb@ȟ��.{�������	�͟�:��3x�g>��.64���X��"?���("#?����x�NP�Ig�/(��R�2|����^dů���0�T��z����5�~�G��eEG�<2�I#�y�'�S���Hg-䷃��`���]��.�}�13������$�Ղn�9]��B�Y{#������U����	"t�)�?Z�C������h״��!|���e3x��H���9�>���D����]}0'��"x�ʜ��5fN!�6ܺ����B�^F��-�-��2�[9Rx���"~x���z1��Kʨ_ݭ�g�*�_g�N���V��s�Mn�kS%z��J�8����#�����m�$�B?��|�-Fo���t:��`��ӏ���%�J3|7�����3'�q�O7.z?�S�6��1����6�O�Ga�����Ѧ�~����e��O.��K|`��Y�����_�JF>
��>��$�<������m���3C���������m��b�ÅSx���<�"x���d���7��:�ލ����x���p�Ed�yԤ���O%�P9;�8t���HD1�Pt�����	��\�"B�Ɯ����ؾ>\�^�����Zj�O��;�*ZQ�8}������5Z=���3[�kXY�,��.��"6r��6I���G���"{v�j	��
�M�跎�����Ya��gN��h�P�l�a�F����
4��GK��c���θo2�z͆�Vگ��mΑ��{re�(�@�I�_�f50�Q�o�Ycd�.�/��J����DV!�?�����E�&�e�\�Q:R��P��[��r:�ص���t=8�;���Y�> �дb� ��S�`�    ;��z���Y?�M���6&#�}�����`�� �;g'���?�Ov���J�=.Yd�);�4}����@Pd�݁4�/yX�h�{�qhe��~\���/���R/�Ŗ~�)4÷�Fk�Q�����%<X�{�F���ȡ���=�b"�f�C5�����3�q�
��-ß5����/�A�=�߆�zXf�������aihɿ.Q��L�>���D�W|�V�Y����;�G�Zђ:��ߚ#,P%��J�F�b�6 ����h��j�b=��oę:�	�-���	�&���uu*&y�c��FO��D�E]/��=W�<��u43���ՈXSFsچ.��.?B�&�u0'�n$6y:^�|Z�x?
�r�2�T��_�i��4 �os˭�bM�HtV�k�)4��F��LsMx�>��5�e+���ϋ�G��C2S�%LtV���⊡��N'���/�
�Kq�t@��a�V�g[h<�ݬ�g��f䷙�ٓ
l�D�vO�s�_��ZV	~���}�`�"~TM��$C�=�4�_f��-�F~�^֭��fGw˜,�n�w1��]b�5���_ԉx:8�t�;������f��í�k#�Y�x�wHbW�z���j�Mw	�H"��bM�Y$�	��ܕ�=���a�}8X�N�k2�_D�V�k�K���va�G���ٳ$��X�"I�x�K�����Z�,�b��f���'Q��5���1L��,h�=��l$�q]�b-��*���}�(ƹ�������'�O��>"G�-�rtQ�{wb1|���_K@D)�@�����{��:��=�+\;��-�^�E�CV@��Yw�c~���
1_�ݢ3o�5}ƪ\�qf�n��`0�?i=I��\`��+�=>�hz} Z�X�����a&�u6�<���r�C�=���7,�A"�j.��eFG`��A�$XGN��tF";�+$����!��TD�	^ƞ���+@KՑ�����/X�09�>���ܛ�>P�D�}���U5��f�(~��V��g�ere����3DX�?W�����o[ɿ�������+�w� ˾�v������"sK����^gB__5��;�#���������@Y���#��vX9���������k;~��?������ᗙ�ŝj�WX���'�ԟ�S?��
�|���A�:0p:
�_�?���:X�������p�"lJ�9�=E��!J%��V�xi�S���W�c#�:`ނo��w ����	&��O�o�0R��m4e��5ɂlC��#cԷ۴�VC�B�c�P�}~��;Y�ߋЭ�2ܴ�k�X�S�c��W��pc%��ԟn�[��'���s�I7��(�����!�0`����mw�M��f����Z�pC�����:�9C?�Z��@��雕�K�mظ_����Ֆ|'�L5&�+���2`�p�OӚUx��M,�e�Y�(7�&�P���g�*��Oe1�ɫ��"?���L#F��q��8��������'G8҈���|�Ȍ����A�����i��gǻ���e���X���Ɲ�jN_f���CxZ����pƑ���k(9)�N'kQ_{ff>�O����ʜ¬|��0]��G�| �\����$DӦ����`� �w�����:wQ ����a�^ƭ�=����!��ۻv���++����#r�ħ���c ���u��&�ŵRE]_���'��"!������i
S�+Ŗ�st&R�>�o�����D���(����+�d~
�OV�6I�f�{���R�ck�3
����}���������[F��I=�܁��g��MΕ�?�^`�_4��e���?�;����rk�������e(ә۷�����)w�G�# ��v��Cg�;߾�O�2��ȫ���L>�؋{��N0E�"�7_n�/��ơo��_����m��Ι���rb�2��5xr�zF�M&?s0�-�6��؄�Aq���+�Cc��9�lr���:�?�Ce)��J�m��1���p��}���ɇ�A���������d�^�?' '�6��P�Z���op�5;�bn��ag$cP��'����DDI�̱�0̡��`{6·�9����#���9b��蒰�Fc��j�ih)��1��;�<�欖Ζ���0F}�����k=�oɉ�y�ʳ{�v�ב�j	5� ��x�Nߵ��V�U�U�P������+���]�ԡD,��~�bOB}kc~����s�<G](�Rm���u���I��*֓N4��#Ï��o�/쉁�c��^N���h���������[\��wF~sW��%1���ࣝnh�8d�)X����J�]�o����h\&0�}`m/0�0�v�1�Y���E3���p���}�0,b'��X��4�o��=�Q@���Zv�P?��5X��`�oii-�_���x w��>P��˥$�%fZ��>����'@�ň���"�����3�݁<g�..*��l�E\w�����K�I�}8E��/��"P��K<��Ai����k�����X6Jɞ����~[	v������h	o��I��I��f����0�a�v��T_(��G�Fz��:s_���[]*4í��=����Yq��ywL>���n�Y���r��׹����A��(���g��i�]8�2$�t�����}ɨ_���n���%���oeh֥=��2#_]ʯ�Z1�]oy}DU9�\�^���&�V��l5H���qD��*G��[Mvh�R	���'|� ���5����xdz2�t�ƾ���F�Z#�<�#ܬ�̪b�����L�uV�"�Q`r������N5���řZ������7��&��X���'�б��Uo�/
�2b��O�����Qoʎf������*��q0����n�[��^U��V���o�R ��-�n����g�_g���ip�#?��ڗb��pB9�]�t�BPƞ�X4��.=c��_3�֒;��T�R`ïk= ?�9"�l��H�s�X����*����&����?�T���#v�2�����Z���Z�6�S�8�d�u.G�ɪ����spL�V,�[`��Q?�b�VU��Y0���M�����b���AO�����,0�-�oxO�;�܎ǊDa�/,�ØSG�1����ݗ���v-/(�J%�f�ن�XtR�^+�:�9/u/��Y���V�7N�Wrή��lg��#w���T�,C��Tk��u=_�����ܱ���E�.�^D�L�~h6r!�$G�݃=Z�����*�v�<V�E���Fς�t��Ϧ�o� *����hk|��v���7����6UX�ͨ�e��͝�����w���9ъ{�W���Va�!���U����F"$�uo._?�48��� ?�������f�/.�B��?Ԏ��4���[�
�{�~��?T�o0X�N��N&�������k�'~ˍ�+�=��=_�.����^Z>������]:��+�XB�/{c��@.�f����2��z=���Y~�����pX;�7~��|�H�ttk8�e�ǵ�|�_Gá�kՍ�0P�^5�Ng_V��޸^�,d�[i�s�}sN�@��Ϫѽr]��Gx��Ԁ3E��z<AD������T6�q|F�~I�?���>�[G�u&��m/s��c��U��o�ǧ"~�'���LԠ�1/�߱�R��-L���ٶA��#t������M-�Yn^���-�oZ�W��E��-�<�]�Ql���8��,�D�y:�^;N4;|���gN)�N����f���$�͎C�.{c�##7�����#�������\~9���4��ވ�/�@�(�o�O�����G/��i�"�;����8�8�.g'1��Ǎ
fǎ -���3�+b�n&"�m��mgZ�:�Dߘq�d(��Ƈ��Pb�0��xx�(g�`,r�y\g�9�8ԗ����#]�����#1�����_Ɵ5Hf�'h� ��2��������[����^�|1�u�aŖ"�\0��t8�6T    Iw�d�	�wU-���z��;^cP�c,E�̷f���-���x:3ᗹ�'�0�z#<0��,-~x_�¹���fFh�k-������M��>�舄}�שu�b�g��p�d���5�C)��3����� ���@�z���	f�3�(˟��l��5�$�d� �0�68-{B�ڦ��rf2�kY���-C�J�?|)�e���3�Y��2sOy�j*b�3x3;�B3 |��7sbf����.O�����u$���U>�3i�t��[aO����'|���a�Vc���%JL��k��um��]���*�^�^���*4pI�e���UN/�"�&�';�b������z�75W�U�(�G�ۣ���Л�+dz�G5ls�W����Q6�@I/�Pb��^�M{�p�C���*��\�B�����'9�i~��lO�FO�T�w{P���(�v"2��xPo���1+�>O�b� ���t{�>����t�͖;�2^ѭWR�pkAO���R"ܫ�sF��u$F�q���4ֆ���7������p������V/	�F��|Eug�׉k�fQ�:��S�N:���*����U���:a��C�k��m'%U�ލ]�oa��3,s&�ʓ��W�A����>��vcx�}{:6��Nm֝��u��88M��1Nf�kH�����c��}��x�>��x9a�Q����f��̡?~AKp�'���� ���Š�jP�E~�$~Y���靖[��́A�������~����
J���>��b��A�.�c�yM�y| Cϛ����75�_���Gܞ�θ����"�4�z��vM���N�fM|�a%S�Uu��&Stk�߃E����D����)����쑤�&��#�h�oU�aܕ�.,M}5���fʰ_P�L���O5�^D���n��+����,-�'�=\����L�L�A0��]���k[q�y�o-���\F����K�s�����y�����g���k>�:��BcC��\8���Z��ƃ ��Kݬ^���A���>'�x~Ŀ��Q�C|��DD�ކ�o_H��Q���9�yp�K�u]o���	�F����Dq��=�c��:���3�.E躱=C�B��R��%�^mK��k�����"�<c�U�;d�#�1M�|1��ћ��ۿ�%vQ�h�&���xv�c���L$m�bx3��Ϣ�d߉V*�r��q��ӯ��O������#�R.|���	�oHx��%f������x5%��n�~�
b7Zb~)y��n�d�_��g4R�������m�w,E�c�����S�׻�N_`����.� �"W�m�w�G�1���x'���F�(c���:^Z���g���~�E���s�B��du�B2��a���/�\�'Ǹ��o�>�O�;iV�ꓭfC� F���]�:
�2���掳��ʼPF������G�9q��y:�>��Č��O1���~c��rF}�.n��^�w¢�~.T��kY���`�3*����ɠg^9Q�E���]�'Gl�z��}|���k�/i}�f����t?*|�WU�C{
�k�蟕b��(���ɠ~.<������,A����F�y�l�#�����"�0�@�-���*>K�c�j�S�tB���t��O8w��tG�����مt�����̒g��}�Y��0,�$g,�~�N�4'A�GGW���=l�E�V;�o���]D�wkK����'�`���l�{�S.��Z9�d�N5���f�p��;�֖�)��7T�c��5��`^Ϸ�nI&?m:X��w����ͩy� `�}`���ʧ�d��X����UI,��η�K~�>�~ �G��_�7؋��?},�5����TB��]�/bҒ3�?3��Y��*�������oҚh�֛��N����8?��sg�wu���`eI�;3���TrJ����:|�ֆ��}��G�3�X�|��w��ɹ����"-�D��8>E�?�S��)�R��hKѣK[���qes�q���tuU�A�=��H��U�� �p���1S�-6h����_>�s&W&y���d��m��b0TM��H�)z]KX ������)�A7_Y�^�,���9`��� e�鋑o�L˃;�W2�ulO6�9��}�2��G:8���Z��M}��V���pS�K�Y~Q_�0S�s�3������M��"|��e�o�u�?K�"��f�ͮ���.�aҹ�R�Y��;g)��b
��\�{��	��4�����5�L���G�X8ů������ͣ��k�6��#�47%�T�b��!���rX���6S��w+|a5;H~¬]��-�81���:KN�c3N���L@��M��В�F_�)�Z �`������b���P~1g.0\��l`�'C��s5E�K��Y(�����hu
K�"�LqS_:����osMw�%׿.�A4���k㊵C�G�p���h
:L�P"�Td��:Ӝ���
�YN��+]!�SS���˔���KE~��Z>��Q�� 4�x�82��a��_Wh��+��l~#��j��U.'F�r����6��z��B�aT<.��6E���w����v0���@���hh��5	���SxH�0�J��������`�~9]���,�t��\��8��~��j�k5�:���ݑ���vm��������t==��#h��ry��4��C?��Ĝ�X��iG0�c����9��.g?�/�k�Pybb�}HHg��᫝%�a�yc� �V:K�������Xs@�X�D�p�;��p�h��6#Y�_��[���d������Ot�:��z�F-h��C��I��%�֘͊'����n=�k1Q��?�H<�����f@�f/�n�e�K�?{������
'����Q����C��L������L�~�8�\�"������!��Y�m�5鏰���[��B��kf�'�[\W���U'j���Ve���Cl�|%�%�~����ap ���{�E;�1~+�o��r{��ym��C�VY�A���ӂ�G�Yz��vN0��D����	���NbLȯLq2٬�i1�� t�02�]�cw*,8ø?�>�_�vIF��{^.����e���	��%�T'�k���V���}�-l��;F��ٴ���)���fg��Y�m�c� �ΰ?:N;C��8�žA��2�r_�����C}�`��c��}v�~�`�E� |�l���@���Ac%I����l�<�k�M=��A�b&B�e�6����[�~���m`(��>����.3�� �&�M[q?����~��3���ŉ����+3�,�c��g��e�4�_���f
̥����O�X��?��Y��'M,�a41g��b���Jt.Rt."d�n�Zq~,�ё�����?�%o�A=iQ�Z�1��79ѧ��t��5��V:�L;���������Q��_/7=�ۦj�6ݷ=F�����i�>�D����:թ��>ɛ����=���G=81��v��G$���kE�ml~��):�x�>wYT=��gG1�8��͘�a1�z���n~d�������L�	1(�N�}�]����c�^甒!3Ѵ<��$�kq�`���
��	ͨ��7�7&8\����]Ռ����IM�}��ń�J���*���6���"�U�tM�p�;ٕ��I6��#��su�k�N"d�yf�L.Ur*m���t�E��#�5�di��g��>M�p��A&9�*�nmϿb���fD}��a�E"a�+�����Fk�gugȴq�)\�����	nz�v�*����C��HTN�T5���&y�v�ML����c��bMР;��C�瑐RY~�䅵�Hl��m��nEg��~9�O�6Z��83Z�o���	��r~Q����t��H��6I�A�5��`�ps�N�K����~��.��#�z��X�.����FEVŉh��LSj�&������d�q�\�l�/�c�fС$�:�*    7��u�?�V/Q-�S.������t�H}��]=y�� =��m	}2�����P���Ӎ.�enB׬�N����8	����\�54@��-�c��٫�xMy�T����B|�C`6z����~,�P�f�a:��M��>�X���m֜n��g�0�8KNo��.4�����~*��%g���p7�!df~0�6ٍ_LT1��5f�'�>H��Kl�B�2��9gs�(i,�#F=�k�����ݍL����n�t����ǎ����AI�qg9�7w��A�&=uM�)�(F@�,��������r��z�|��x�8ѐ�@^s`b�Hѳ�=;��ԎT��8�����Q��v4�@��+%&z"0�����R0� [���̅�~D3�;>��:�O#���^e~bI�?r�
o��8"���Q0��!:A�?����:#x����^�a�9��t<;�<g�h;�l��g�!��z��B���Y�_9}�9��>�I���_�ݯ��G��#fR1��|�A�U	ʣ����vM@���	������57|�8K���j�j�͜iF��6:^շ�[����y�!_�ň��*��c��S��Y��)������Y�2���n���Q�涄[v��$����Cx*��>�g��}��d�s{qS��"KX� �G��Cmj��#	�u{q���r#�)ۋ����'G���~@��y�%#D;ػ�����~���V���-��G� �T`V�| nW�2�Y{-�(s���R������OKF���t�:�\�R�����_}їLE�E�h"*�*��-yޱ���t �g��� -sM���;`�;�G�,�!�7W���2�)c���']ԧS����W������Ll9#cN�������#-[ �	ӗs}m�8�H��sq�Sה3�Z ��4e��.U�H$�y��tg;`�@Oj����鍒7m4dl���Q߯�#�`��X�4�+��c��r���}�N�-�U�"�����S�,*ֈE�����U�h�'�*���Xڷ�o��&Ao��O�{���(�]�Q�,�&��$}�{�}n���>Ot�>Z��C�����I�@�'�������%t�~N~| � �����<> W��������4���>��(G�+�?7�=�+m�@G���u��B��]�}&�6@.��~-��78��w�!N�Ghx�g��O�m�M��t�b�
d������t��<}Qŷ�ھ�z�+�����G@���U��#�PF���T��3����/�����X	�>V%����vց����(&W&�tv�~n���=��C쟻%n�\���3���<l�D�m2���6��U?�&���3xش�ЭT��X�`�9:��3�FO������E9��W�=�r�ħ���g�R��.A�ό���	�a�-B�k��	��!1g�����_I����Q�O׺�Ks�v��7�T��Sj�B��ǝ���h�!���܀�^�k��}=��vd�j�+���������<�*3t�S�e��9_Ln�p�_o�o�0���#�h�����1����&_,)�2x���;��xp8����}��:���>���y��R������������6���Wɣ�1���!����Fr1m!����񘌺�b���7�r�>����[A��(�L3����~Kh��`f��{h�u!�`!��2�޿ �==�Eemc�π6 ������h�����ag�f�����XD}`t��'~ѐ	#�Q&��1�1���'�O7ɷ;,F
�~���8�f#�[��'Ε�.�g�
�(���\�ǭ�-�Ed�,�u�'��VF���|�C��	c�!��b��A�oP�᧻P��YY��1g���M�Ey�d������|a�I;>b�f1C��W��VQ��*6��y�c��hܲ���,���h�������!�3굜S��E�V�g���L��5\U�3	9���2�h������x���E~���8D��|m@u��m����zu�����	�����67��u�������qn|��zm&�uw�Yۇ�n��`�1(��u �1ϝ��K:�/���MD(��sK�X��f`?����l�ȨbG�wg���
�d�$��:mO�| �X��)�����U��h��s�g�*���J�,�˩-��ѯK��D�{ �	n�B�}u����.(dJ���0o@�+�l&�f�O��D���诫7��)��I�a��Z�d3����^���/�M��,���� �<['wPH�qg��\����k�xm�*�<-'��e�=1z�~q&�vXÊ����ui,�����6��C63{2�<]��zZ����ad��岮Q3�;�P���Ȥ57xt�2	�2ə>W�'�cam�>[�n�S��l�����=[V���RY��Y��)�P�:���Z��	f�X陑
�|��쥙z��*/��׻���.�������$�ߔ�����l�<�U���A�9�mخ.�a���~r|�tc�~U��m��z[��nx�7{��%��������`��g-����p���P}�w��'�3���C��-��B�qk���	�Hc�au/���
�����ũte��ۺ�¬�?�HO����n�h4?�>`�!<�g����W�h�m�*,@�av0�R���[U�XIF�W ��`�U�eৱO��Hk�FY�c�i|����Ʋ�f�XF�^yX�F��`0�}`������a��*��#�c{s�QΎ ��ћC-�<8���yX��]]�0 �f\��Op��X�.)���ƍ��95Z�����*&?Vdb�zq-Nk�� ���t>N�ѝ��
ᯌ�ڼ<�-̄'�7ưv�*w����X��:G#��?�O��h�<aW;��]ţ����6gX߉���yuA��p�
��V5^hj-��Qqb�QܱK\T�x!�	]11���(�ױ�b��6���೎еlȊ;��{�)6���4�>Xӣ��̷��=���C%�:��JS��P�[�ȏc��}��K�Q?� o��<�n4�z�m��[1�����l�"A�#����-�7i�����%Ll�����B�[Mv�7~hNMC�k^����6�����f?ݟ�tf�yK�Oꁎ$D?����.�����n���,&Ak����}�c3��b�ƗwNUD'����At('�Ϫ��)�(쇨7�q�g�����&��f�e�-o��tl�1�_��Î5����ӏ����L]��fy�}{�h����}���y��7~������j͉����.� o�[O6-�l�}�q'���am�C�{�H�`kPly4\���c)"�#�f �D#�N'κ;g��R'�e&.���2l*g���������Q���� fإ�/��:�b�ʥ)�8�Qg��Ů��(�"�[��m�Z ���q�����#�~lL�l)�9������&���E�ʐ��������b{�<�����[���!���\E�ư\A7�0ƛ1t+ B��3��1�<7��H��-�b1��os�[׍�&�� �L��]�Q+|�Ih?�b������oHC���'qx�M�����m�GJ �d�7�9_]��mt��g�y�.cB?�m�qV	q~͂���]}ƛ�7�b��ě�7�����`�1gm3G�̰���3�7��t��sV{��g��*ªt�e������V, �g��b�X0�X_���&DZL�X���s��W�۳y�;!�Ϸ���'�_��u����+����Rq���~<#���e��)[K����0���n����SS� D�i�O��!��җu�tA�up�#j��>�������N�X"����1��Ӊ�Z{G��f�S�lbM���^�� vr��L����m��.�)��&��R�^����z(��|�_<�;B�m>h���M��*A/V�D�P^й�k��/7k���8����zZ�L���޼i�g����F�gFz��d6~K:��L�ޫ)̼K�_�`P    ���C�<�d����BgD�r7~�Y��O�����qM��:���A2^�H��3+x3��&Hx��
��#�����p�\�ps��vC�}���n�+�b�Y�[94<�񧏴�C����f��p2�q�����M���A����I��>61����΍�b��-D��SA{u����T����ĝ5tQ�:\"�5tS<�!�L��sX
���L��hw�;d�)E�O�GQ$?8/FO;�&*�����2�^{kL23!�4��dv�T�,�@��A��մo 9������m�3��+jZ 4~���կ�yew�}*�6��k<M��>Qׂ4f0 �2v<�q������zm�#��O�?���w�2G��ff�n�K�e���(�\�*8�}F�mw�Y���F����-�u�L�2��5t@Gs G��N�����.�@�E�u���"2���7�*3G~���"�H�3��]���}cQ&�uy���$ �N`5�=/Ac� Ƣ��<�ts62����������2��r�l �@����|X\
v ���!O�r��5t���a��@��a�_�dH,B���Z9fg����#˟I�]�8�@n#�m�zn%�H2��s�p��G�v���l�b�'f�3���=͈�V��Bb����y��P�F�>��q|����ZU�e?��;��Bg�!ǝ����������|W�^.����Zy�_��A?�I��d8!�o_����A���#+��ڑ.}�_��|S����,^26��؜����S"xǰ�אU�횝C~)�/�8�'���L�#�0�.���`��q����]'�
�VÎ\;V%�:\��r��/���B���Rm�yc��y�G�ߋM�<_�ߦ縹����L��5���p�X����a�ݬ���n|��b/.�+x3(8Ł����8�a��p\����S�=��)��� �'~[���H��	��F�QZ���t8ב��c�T�]B"�ת�-B�� �>`�C���gN��^��c*n�c�'�$�h�U@�%����^�Ƿ;��	
�
uܰW�0kQ}O��-����{Q}O�q�щ.��0ʠ82��1�L/c�M6��� 
\��n�hB�G�-W=�;�(k�i�S����An)�P��$Z[7X\�v!�Y��[��Eu��*�/s�i�C��<0,�D��m��;,?c�3�D7<�S3����W�i0\��G6p3>����}�n���Z�M#�Y.՛�R���&��D�=�FY��t�gMwd���_���Z��Gy��K�X��F�?�i�K���݇��:�]��h�5�ws�ǂ��*���9�v�W:,��1�]lAV�Dе��xU�������E��#�r�m��-�U��Gt�~�G-:`�ň/�,{�����oS��κ?E���q��~����gL3�?>�MG�m3��t]��X�Qn����e�im�X��g�������c�kėk!����.�fC�H0�?�2��1�t�(�/3��/���Cy��*~3��`H����~-3�Ç~����{XŌؿ�v,�]�u�=+'��g��}}~��n��4��r��n|�0�:4��-si����
�!����Wq��eD�l|�N+��;�|0�����O	~��	�ku��xxa2��_�_��x�����"�9�4�BpeM.����Yl�_NӒ�0 �?Ӡ���&VB���pku�K+��!��1u:�ہpp��ۉ���ėf�����8^���]����c��.ո�oK���_�Dw��k�R^��c��,B��'B�,�A|n�-�������%�c����!���k�_�|�%9:a��>�D��7�K�͘����b���Ȍp�f0��V��x������rMGh���<h&;cHj}�����[@���;S��r�ݪA�!?���Gm_Ӎ��N =
h_C�Ȓe�e.�{�g�;`�(�5��
���&��鰰��'��xV�K'Vi�~@�3RwB�����X>zϹ�+f~�ųe�8�b����9&u��5~�ճ{�h�տ��9'u�����} ?��Q��2���g��Y|�	h�����"s)~[����]��D�0F�[��q.Ԡc,|�b�}�GLL�Ͷ�0���@o�r�>EӅ�b�L4�}��:Ej9��b`�v���$8}���qw�>r,R*���w�Jw/כ��N�[���%o���j�N�u��|��BIP�l�E�mC�ϝA�i���>��67�:�����[��?�-�E�� I|�k�>+�C�cM�wOX��VW����e�$�%X����k��&�A���?�"���_��]��C�!����H�z�L@�>]����?=|���KEx:u���r��q���i�@C̬� �q{�E��8�|�͞���&8�����p��pp����?��A�=g���؍#��qa2������X��Ȟ|��$��Љ������밇}�=#���Gt��9d�Ό��h��F~��7��rwExQӬ���GO�1Gì~i���4�������=�?�{.��c��/�wXI���j����p�c��;0fTC�g�?��?���2�'G�ʖџfKd�K�����>��^bjɟ��]�%������ɉ>�����;B�Wb�X���-!�q��G.��G�j��K������"n[mb��5��۲�3�&k\>0	�k}[z�����m�Θ�ٌvyW�^f�'����p1���?�^D���^Ӂ޸�ٛ��FU��Ǉ�4����^��W�7~����6R�?�6�����;n��Vƛ�l��Y���[r�����J���l���F���[2m��q~?�e??�� �?=��ll�`�y:���M�ad0oN�m9�`�(�1�|NF,�pw<�_�7�ZTȠe��<&�E�d'0鸛~G��?n�u��<�kj�����G�t�7��1U5�=.(��过�.�G�\
&A�1�NXS]�%b�k:j]�iЧ`��5�.�d����/k>�����:�i*��5 5��ñ�L<���-~��c���aL�M������|�8�Ⱦ���U���I��T2�gӌ�<�D�{�ٝq�|�)�o���bZ���ϻ���^_o;.�橵-��ܡ����pÁ�o��vǯ"�6��6�:[��=�����=ޅ��}�7gZ�W�1�ٴ��g&��>J;o�["�U��ǹ��t=#>YT�>X����u�HZ��ꕝ�X��r١�ȸ�g0Zy��GC$������?�U{������8 �����56�^�ߧ7wKO��Rf���}�*����W�ߖ�`�]���MxQ��d�aM��~�/23�	�J�E+�P�l0����g�o�ko$�0��t�6�v��X�����v���u��y���a�b,}��-���B����?Ra��qѢ���?+�큷���L7�&?��U>/nS�3�����p�����9A��s�E��K؎�D������n�p>�_`�Ӆ�iܫ�"Ki1�����2�u��c�m,?���n�Px���z�	/G���UO�_Q;���ʣ�Ģ�rgK���e��7�}=�N`��If��'���|}`�_lR��j����^���X"��ݢ�/}���:���ᣧ���Đ��^��E�RL��MB��]��̻��h�\'�B�i�wo9��ٔ��`1\�����5��0x54mv˘ɣ^�ȍ8�-ʝ�|E�S�����:ycH~����9�&XdJ�o��s0}ſz���UU���-���W�K�7}�*^g��V�r���>�.��[�/��r"���y����ͩ��q�Z��-��簟^�D����k�+�7U�o�TQ��)A�m���P�x_>�n�5�56r~�J�.��}_EtZ��*���v���y[{���F�s&�����Wv�waD�e�##��&��B~�祪���ۡ~�    �.��sd��QW}�xVH~,k��L�X���5�F�O�o��?����cV�?Q\� ��#�z�f-ޟP2W��_lX/n`{g�,孝6��b�~��]\_�ʈ��j\���pL�ߦ���W��Q��m��5�������[u��u��W�޷���B����U�*���?@|�wԣ����<$Tgʟb!9�>Q�B�z.ʧ��⡋'u�����1�Q~��ɽb��)n\T��}51�^A�r��Xߝ�q����h�����OP}����[�w9�`�����ľ�k�JN��xN=]�U�������\S=O1I�ۈ�)BC�yq�E<��	�z��O�;�}�/����
�s��~\��?-�~~��9]�p�w=����G����K�*������C�Ba\���c*��-��m?GOܗS|�A6aUw�����~��n��q����q������u|�T�����߯���ާ(����m�"P]�7(AeNp�oQ~J�g��|�?H� ��S, Q�!���1�17P!�O�鮫�W{k�`����ݪ(l��\��kCt��Ϊ�Z=��P����{��&δ�"�$j(Q�֔�0�#N܏+�%_�^��|՛ @,Wq����;��ُ�G��b���֍��y�;g����zwc-����)��#v��r�n��	z�?�K�����,��j����@H��s���_�<K�kՆ�kCKL(�O���K��ީ|}�M���P�W��K�V}X�e�Y%go��N�uQt�o/�>�J��� UΚq��m�O��*V��)�Ũ�b����r�7rF��^<s��#�%&���2��Y�����Q�:,Z��j��K�-f�<!�n�O�?K+P\�S8|�nb�5���|\�'uQ���e..�|�^�F'�aGT�-P��7k�G�c9�.�O�����e�D�QU'@�_gIŉ!��>�v��+3�����g��%fB1֤�pK}ML�!�2����z%#��o�I�����l*/��.��9`Է�".���OP�ᏂV�TΥN>B��?*Z��:{K|]�ႏn�`�v�Q|;]�$�=�ϖ�K7�����D�{)�/un`�+�_)Ѝ/n���j���7��a�ym���?V��`�)k����˅�k�?-uȏ5���y��E�rrԢ�Dۿ���܌���g�^���)Jdg���� �A�<�:��f~_���N�/�smb�|E+�;%o���P�5��r��oȞ8]�RwJ�,8Ȥs�@7���B�!���1�c���ug�QSP��0��2���bU�2��f�d�a��Ð|��KT�!v�X�B����X=��|�N��8�^u��(iP/v����EO�׻�)�E_�[>6���%���U�
o����fvk�\��^�X2�1����T��+2��R�����w��x-ܒkѿ�k���O�/�0[�VL:7�ؙ����;�n���C�Bǫ.t��"�3B�s\�B�����3#6w���ed�#xkw7��i���5�Z[g�Bos��v�?0�ǑA��M���_���}��3�Ϲ#7|Or����y��D�i}������걸$�R��k=F�vA��=BY�ͷ�W�%��-�^ ^���)�KN��-�����������|�R�}��Nn��Y̅�_W��oߖ9���yN=��y�����^��	�~۟X��0;�o]���<�8�o�������v�M��!��{�c�ñ�=d�a��}�����)���w?���,����`��S�}2���c��}���C0|7�}�W)W�C0���<7'�|2��.�Z:s>�l���}{@���|��1��߂�(��b�I�=�����T�V���sJ��?{��ӿr���of�лd E)$��b��3wX5 �	��
�JK�7��Qg>����M�K/ZI�&�C��[�����>*L�Mԥ'ڏ�a�B���n��b�^F�p��X�o�н�M|�K����G�F�u�l�9:֙8��B�o�X�"s�|X��/�3����.�^�-|�{7(7�.HC&8�Ok����C~�V�ϟ�gOQݒ/�=�?�5Eu�k�\���������*�0~^#T{��y��{/��xG�1�Ӛ�:$��NAF?`����&D6�� U{͕�]Pv���R���SX�,q� � �Y ���O�㍳GSl|6��ǖR)|�G�E4E�6:ՔOMpbK!���(������ �����Q\�׷΢_����Z,_e?5f�3����M����
��"�l��p��z��d�ۘ2�k���fk{�So;�l�v���"�>���L��0�ɴr��a*S�4Ϝ&���I��8�6Y"��m:�)�G7��p_����K�?�,6O�r�!�.����Q\}�#]�"R�\g�p���:�$���GӋ�����!2�y���LW=uq��%/��c�b�Xc���ӸEL��@3���QY��N�ŭe
�kK� ^��H$�{"t]���bM��1��8���9�~Ĉ�|��������I�����*/��h.]�.��YX:�Z�
Z �4Vm��\<Re�7��f�Wy��y���Lnx�u�%�~�$_��7�ʼ[�W�p◙�&�?O�p����y�L4���u�s�����t�ͭ�4E^{ڞ�j�E���"�,Ml��I��I�4q�OsjXk����#������N˅9��i���t���0����"�M��,��>�|�*g|�&�����:��T:�t��,�|P��_f�p�G�:�2��.��7��D����[�'9]�G|�"�"�]�ttQk����r
r?��n�v5��E?�.q����Y�<�Y^�O�RFc�{���$Q_�oڭ.�8��߷�Qr[�O��r̭�j+��r���0Ȟ:��[6k�,����t����0`f�1ǯ�vs�o�u2���u��<�^Y��ϦC�i���Z($�x?w%�#�����:����v[�`����gW'V9�*w*��#��b�7\���[�#Q�w���N�!�$a����*�U�i���l�^_]*6�������Q>^�j��Q#�u�reA#�g�a�J'��@��[e�Ar@��#q}[����6�U�h�Q��k�K�uS:_��&2w����I����^�M%�[ɦ>��[��-�d�F(�е��x�-^���ÍD$�!�����l3y1��(�`���mhb-3�Xgq�'�a���W���}
�a��Xu��þ@�JK��Ф0���MR�|)0���m����SwU��Y�<�Le%~�!�m�~�T�7�rCaW#��+q8�/W�@댑V�p�3{��y���x�����K��z���N�u�c���91�b?����u^��n�$y������+m����`�y�~א�� ��%�?�y���ϻFїE�%���)�U��,*��U;a�jGv� �4]��F�+�Ŀ�����!��7T�̘R�a[&���v�0�O�mᇕ8��r���q�B�v������Q�͝�7�+l�G�4Vus��zn���?͕�i��oϜ5#����l��=]�e"�{�2d�˺J��j������d3@�nU�Nُ���Q?�K�*Y�+�2�G�P���U���%�n��z����|7�S��+_�=e9}�S>�W,�3j}�M/��\w��+�����7��i#���:�$)|Y��|���<ם"��-��;h�Z�1_���^�s��n�	/�%3�|�Í�g׉�F��`�<�k,G���m�Vi��͚ȜrF�����\El��ň���t���}��n|�^J�~�ߖ���X��9�n�h�0��ѥ�o��t�-2r�X��8]���^qvoݪ,]�S����`��tG��#�q�.1��%������xɯ��\T'�w���wV��+��V�pKg���թ�}B�Tθ�3��o���SM��֙ͤ?-q�/��<,v ~&�Ўv�"���"�hy&r��	��?4    |[c���Q������KGx�Y�6���j?��v�PόM&A�<b�G񡑙��_Fqs���"$�/�x� a�y$u��U��'	 ����GL��=p0���P�ka�m�S��e��5ϧ��	�L0m��Z�e�zgyF�sKu��0�+3��=��>tf���}�)=i={�B����q�B�A��>�%FUK:�@ky̥�X���F]���jqEo�SsN.��}�*���m�)��{�E�62!x[o��C�����g4���]zcK���(��u���4���I�x�>�7��u6����8Ɨ�1�OG�},�x�	�#��&�=&u8�����z��h��N���]��-&��1�fO#i�9���1�'�
{��q7��=Z �1�tȎ���F���Fğ���mi�j�ңm����f�m���v�#��n;����L|�d���m������u��>U�~f�kw�=uK����[7l�*b���?M�p�_�7±�L|F��s�Z�	>&�eO��cڡk��G`���U3����u�����-Ŭj�������#�"$���4c�/]��ζ��4s����̯e��5�f�4�:�ޯ�4m���b���7������4m�E�i�~�&�̉��A������^���q�;��T����a�?�}v�1�E���ы��Fm���_�|d�$ß�-|��R�d�U��7=ŧSˢ�z'��Q'���ހ�ū�ٚ��z��-���g%f�#t��cO^��vyp;S~�C��E����A��u-@��gjN1渹�b3'\��㾯��<�]�}���
��Ƿ<�o}����t×������ S����aK��Jfgk�7��`!1�����|0R����W-�F#������4�S�7q��dķ�&>x7�0x�7 Nꋃ#"�ٮč�it�I������ծg�3��F���56fJ1�p����a��1��.�� Jf�1�Խ�ЊUz`w/÷�T�: Z�VdQ��.��b�����-��mp�c��M����� &=e�/q�Gk������k|��/��C�#�$_<	�$��[���\2��	�b�wk~ip�ZÀ�Y��Pc�]���y�����6�a����;�d�vٶd���dG��� �EkY���υr�pp0��D/�G���h� 3>L�hå�f�<�ql�I�^��y�9'Z0��j=|�,i��M��)x6pZ�l�#.�̒1����a����ic�f��T���Ș�e�EO��O ?Y(L��[��W=BP��uWS���ka�'�����U$E�^/��h�)��i+÷�1��-��g���[,�$s���&a�~�O� x7�Y�o֬�Ԑ!�u)�Z��.-��@�e	�Nt�bf,h�*��yzM1��Yo�uN�b[W����D1�$��w"q��ȅ����0��)B�Q��w"�����\�Pw��@�w����U��oǾ�[�fn	J|kD\�f��Ӌ�h �݈��ׅ
%|���3��k�Jd1�Mbd���6��#L�n�y�:w��M���~��Db�^ޕ?_�1Y؃���^V�=���ԧ����/��-`Z|�- ����~\���"c�۶��lU�13����0-s�4���V7m��Ka��	S�8Y	+��Dj���NFoQ.���ӡ~�=��3!��	#���%X�ξ��������2��DJC��;y9E�}N�hqD=E�����0�L[6�c9u�B'��E}փ��C�Os���\7}c����8Hb�� k���|�qWs��:IDz	M�����?��0�EUu�}�UO$��}?�p�"A_��T�s�y�h�AW¯~_��O6e��F�o���C�~4!��j6���[�0-���!m�x�S����QE�D�wa#���O�H�gecc�����=\+�=��>�*����D�e%���E�5�po��3lq�~�̗���!��=\�Q�����������B������>��Ȭ�k���;���Y�W�p�g��d�;{��]�C�gv4�5�p��N�]ќd��3�g��(
&�{�B�v�����|�f.|�vX������~�i~Y�ÅOS�~ͶX��C}&�g�i�ъA�-(/�6O���TlRĻ����ܡM�����]E�������k����p���Ng��p���5#�fZ���}�������06������h���{�M#�λE��
5&������\�ϡ��#�`��ϭ�T��9>���Z�V�Ė+B���J�r6eC���	�(�����!m8B�]:'����ܡ,-÷���E���>N���o�m�����v�W��|ʁ_��^N�[b�~?��[�Ƚ�s`��lOF������v!�,�b�r���*�G"�����o�V%��!�ܩ�Y\�jQ~%+P���Kv7��Ə絮���u�_b�nF|f�P?��9,��i�ݸ�]��83?�� ���ǎ������}?��-3��� N���3��{���nK��m�}�C<���
Q~��h�	�z���ɇ�}�w����W�p6��;G>ß���)��ݿ�[|���3�`?����9�Z��ms���ɮ$F?�Ǜv��	�2�,	��g���"�d
�����5/�G�'��U^**�uQ~I6�S�'��fT�<���=5�6;��W����>1��Յ��~9�P��[�P�[��ri0��m���XVޚ���K�'�Sc�t���]%n�,z���2��C8_N� X���ل�x��k�e|
5���a}�C��6���辬�ڈ;k�EW6$O��NΉ��[Sʔ������d������h�����M�Ș9ڔ<��U{<CM�9\�X*�{7z7�g�\�u~�uD:h��H霘	��[��:�ņ6���ۛ�w���s`N�俦Kd�>R�>v�9F?&���5��Q&�6|������㫢��ً�-a��FsYs��lG.����N�d�e��bb�(�`�K�fY��g%�_|p�W�^	_c�~����V��U��ä�Z�l����(�`֯d�X�jC����U6�X/�Rrz���r��?�������n�CM��f�p�>�q�cJW�^r�?�qңL���#�����?�/-����l!�/�.�5Fohlۯ1���%3�ä����z~خ���с� �Go?I`M��I�2��A�����l]�M��<�˕�{�>kG�N���u��3AX���r����3?h����*���lOz���#>��,ѣ"C7�'�e�}9�[U7�˼�#,�a�����_S�S�9ߜ��q^J���#�>����(�p�>�Ō����������,�MLA�:wH�ɡ�K�����,�u۔�?"1��+j'��>v�!�6�F�Ծ�>�$~}�L�Jc t��hO���fĶ����g8/�m��G�T
+LB����N/�E|�YF���/]s��2�Q-Z'��=3����|}�]��`b#xh8�� OJ�1��L�[R�Zyb��#]�:���0�W����:l�nf�_����[�������L�GM�}C�;%W�6>6G��~�2�S}Kl��|[�oo�'b+������l{3��E���:��zf}X�����k
��$�'��99˒���+F�C>��A��J.x�`�Ĝ��[�	p�8�~� ��N"V���� ����1��UIahhs�Z#A���c}��+�G����r���y�O�����1BI�>s��("g�@�vn�=�I�����^7�3�h!J�0��"l��P���Bz��Kv�x_6|Hǫ7��(aO;%���^Feh��WtT���GǠc�;*�ĸ��/�C���1���K놂��Ά�	�s^
N9q^�s�aq\:ܚ��nħ�LdG�F���h2M}]�Gw��t�<��Rp4{XS�3�jIh���*����_�1�� p�˷�+�i���h?W����%��z�Կ�G���!\)K)�x���$A�#�vJ��    >����z?{����(آ�Y�ે�mI�GN�kU
����q�uбO��Knt;���b2�����y�5:��9hׄfk<��p&�ɶO�C�T��5e1|�jB7~i������u��,o�U��>/�RG���n�����nxG�FG��3������=���T�e���5�{�T���YE([�4*B}������1�����U5\�1�]2�ݒ�����V.P���爲1��3�pȽ��^F�1Bg3��l�rw�'4�;���S(�%����tP�:/�߻z����`3T�T�G��~�>ѻg��5q6�yiUʗٱGBP; �~�g�#�>Ha+cڼϰK�y��R�6ի|�=k��2Xa��s���^]��~�����I���娯�o��U"F��G�Y�[�?pQǰB+[B2�������+��e���]�(�Z%�;��,�B<���J���l�*�z����%�]�i�1(�>GfA��W�`MY�B��U�]'W��B�a�������d~T�X�]�Z/��!��tF�s:�}F�c �W1�
3H�Zn����~��ˣ��|*A�m���uN��0�A�Xg��^� ���{�gX��>�`�M�]W8&���ﶩ4󈾩�
צ��
�rO��:{gzG���Ha��<Uy	Jn"|�;���?8O�qO����m���o*��}���	�XF m�U���� ����.�xFYz��y��-�X����ShD�z?s�ʧ9� ���w��i��/�{\����e���{��V��Nk���,��dF�%H[h4��d6M�� n�ѹIs�,�d�yI�N��q(ۉ��goZ�֭ٔ&ozJ���������F�l6�f��nD�ݚ���N=��(k�y��?�t|�}��#�_��¶ܓ�����;�pjM5��G��S�����3�'O�-��mP툙?G{��[-AA�n1ŸԎ"{��ѥ���?kA���K߳ō�H�qZ�fB�F\��),�B�6�0��լ�ŝ=Z�h[���}f���sd�2^���B׾A��:Ŕp-n4�����p�B��aj_ۣ��#�2xⶽ
�C�]�wdvpJ
COs��ޒZL��?���ԯ��~C�ޭi���� �cg�����s ���E��d�[��¹^]�b:��\rK]���G�l�f�ۖ���ΨA�/�|�2L���Y��_����z8��=����D4��B��欰���I�܉=�7 ���d��:i�P�_����~�Ւl�ĥ'�/�k��j#�m�Rȝ��4���������z�m鍶��^��ï{$�B���~��_�Y35$�eև)'���|�d�鍶�4�`�Y?١oK-�w�h�|?kJ��dSKm0[Ü�&9lyI�&�ˬϓ�4�S:� 2�4��ϰ���ofz-Pŗ��9��1����0�9��k���a���p��rI��>�Wqw��]��ܣ�P��H�f�:�m	��X�j�����D!���H��:K��9��G�PDx�ܶ{���)��4�]� �m������H\��%�>U��?�|I������U���ZMd�x�V�����-����-���^"KqP�p�%!S���U)z���.wG��'�-&�Gẘ^;lAe��I��z�0&���{�^>A�!�,>8��lwP�Y�攤�m� �]��X�'����>'��������>��.뵓�Qq��a��_��3ZZ7�E���	f�U򆸿*砒s}�	���+!�B�uR�������͓	f�	�ɲ�,�G֯��V�ٳ8'�x����>�(&��M�vw\%��U&d��Nx}B��q��k�+G=�Sχ��gwr��sD��y���k��@�����,�d��z��Am��@(��<����x�/)��KV%�����/�a��z�.Wf�dQ��=hn�Ƚ�=3�d�A݌�ńO���Y=�8�nI�\Ō�[�Em/:�4��e�S�\� [��3'�ǰ�ڲ��j}���q��m[l�G"@�{�|%
��h����S��fĴd���9Y���L�U�T���͔���al���it����ڷ�����$��2�:7X���vCAt{�@	���[�G��ht���d���Uml>+A�Cfy���&�[�f8���Y�n��
_2��J��<�zz���@q�f1ز��K�9�z{�$X΀��2~wd�	�E���ߓ��I����Ws|��w=���2��Ƅٽ��I�ϵ�9�>N��"d�=�M����M�p�;���OJ��+
[Y?�޶���&'����F�3�5��kG��l�}%��iwd��,�I,��+�}���[O��������5���O�	��m_���r}ÚM�����n��b�Pa3ߧ���o��E��ҷ>��a� [��1��2��b��cP�lW�'�>3~5�m�⟝Y���GBK9z��&�=�	I��Q_lCH����+z{c�n���v48�m�9^P��rWI�Kd��"�j}�ř$)9,� �E�cT����_�G"
	}�u�69�JM�iIiB���]M���nr���v�z���`8��1�����)9("�<��i}�_��!�4�7|P-�9Ge�ݥ�+Ao�p�},��%��+�K��W���G'G�§ E���6�.lj�y�o��d��	�پ\��-ػ0)�� �{'�7	��X���n�����/����b$���A?��Z/�����o�}��_%x�^�%�l��I�������
=ԴRs��S-����_���ͨ[NtH���KGF�g``� �F�/I|&q=���r�t�O�P����U�&����,�B�i�.��*�Qb�y��The [��
�������/�t�/����t���^���7>rż$��(�J��^���|ݞq���.����+�5�H��0��c�X�F3~��:l��@�[��sR�<���_!f���<�A7�Lv?����<��d���ޡ`�?B��Ц��1Íf�v7�d��m�>^"��A
���*��D�3����oC�h7��*�:(�r>�q��&B,�b�z��$Qzٞ����눲Ik3#ԎA�CQԏiY
G pg)@?*��v*$��U�U����NO&Ӂ�Ө��H�O����1�?��������n�˒2x���� �z������#M�����|��� ������9PЏ�2�P�y>�������3?�T������q�kGN�������5?�n�_`����������b�*���~5N����P��1Z0~�+��!�@P<���(�Y�+0A��7p}��E(����6�����_�c����\��K~���������Tz@X��}7�X�������S��t	�_�ǃ�t�
�����rO��5`1������a_5������%��VH�������_��(�S��^`�۴	�����b��~&
�.@4���c�=mv�v��V��r~��0�ka�&CƗ=lp���=�A�E�&��W6��?�ixU}���G�_9�b?��r��
�}��B���'��e�s}4�yo�ɝ�v�'N�cT'�)-"�ʤ�(z��Jq����Zߍn������z)�3\Ο�ĕ;Y�Y�9S�*:���
��gE/t�C��@K*M��ae�׼o
�^=W���C��`�o�7���'</9н�����R����p��`�����&J�����Qa���3��n��^���7�� /rC�:晶Dc������-ј�X2	��G5�3�cc'%��[=p8���h��}�
��љ$xb�>��'��.p��E������z2��hL�q���0��s��Tk�����WВW|��ﲼ^ƅ><բ۹�`����E����,�?��S�H�;~ީB�*OM��e��ad��n��^5�
�E��BE>���V�~�}wPզ|�8��w���
�(�Ğ��tc����~�6Ŭ��Z�k}���.�����4�6NO�%��||���4����i��8�    �iΪ덞��o�z+6�h-sM���8vt�z�g��)�Ec�10��1�W	in���.>ͻ��d���Q��?��'��|��)��0���|O��M�'�hj?^���_ջ~�G�C����R�W��V`g8�|��W��޾y��� �����ʗ�lF'�al.�^F^�~�a%�?�fM\��"�O�5LqZ�[�겸������\��DY����:<�1k�[3�)�wر���Y��F����s�;>���|��ϭ{��9>r���~;]�x��W���/|�Z4�5q���#,�e�ef�V�Y�M*���U�%��r_t'%S�A�q+[8�)o��������m�Ru�~��?�W�t����w+[���/P�����e��g�6���=ک�4{|�*��({�ܿ�G�[B�T��oB�vjT��?,B8�l2�A�k Ǵ_�,�X:[ߴ��e*��w���wp�8��B�{���8��d��vt�2���g2{{JPϔL��3�v;l�@�i�,Z��&���:��Y8��]Ȭ:���Y8jc�de{�b���Da�
�5C&��<�֭d*�v�#��"��#��DΩ��s��K������B2^��L)�Ì��c�޽6�A������>�)?�ԱCg��*�i�F�&(�����+T.G� �z��Ӗ3���RLrj�Q�>��s��|�:k��|���C�蘜|��4�N�$�*(�k�K�	��6$e����B�*��}m�x�*r�P��z&B]H��m˱�_�+������l*)�ov@���y�~G�u�
���"|��.|-�e�r�s�*%-k[M�(�m{[��}_"���ϋ����pF�UI��#�E2��g�O�T`�0�=yqÅ/��_*Z�p=����%�:���؞v]W?��l�O������#��2�7��j]�����6�M%���D�W�x|n_�~�[W�g�@q��M�YU*�P+�5\���_G�t�k�!�O�ܿ���YSi7?��QF����v{�"x��	�&�����m|_��u�8��:8��G���4V74��vO������h��7h��6�L��ە`��W5f}Z�0�mi�K<]�j�㔯���х1�^e�����O�e��mc�����m�8顟�%+�u2�>��NM���0�{ݛE�`(�<�׈	�:զ��3>�!���(��1�=����~>�#!s֩�:�A�p;���.�KP�цhr���aw���!�T���@��ۿ��	��#pK��	ލ����d��g����-1�N���qfz9��|b���kuL�Bq�^s`� l����1�*����EM���	�H[�s@}�:�E�u���e�wհe7����8�|A��^b2r�m�'a[+[+-�����*4k���W����, c�&�w+���Ui.�J���W�\��_ѵ�������ɢh�oe�aj���v��p�����l}|T��L����m}8�����)�)��T�e���Q��?��<O��,���-��e��ؑ0x<�SNL���V?q��4�kB�s�%LKڤq�d�Nϗ[����t]���K3���YCa�x�6N�f����V��(3��֔����)�R�j|^�Q��4�x?Bq_r���&���	y$�L$D]_`6C�}~M_���p���l�k��xU�Dy��n��ںd3|e�IS��n)�}`�O헚禑��o=�_����er���?k�e!��]�<'�9�V�������01�l�s FA�n�_$z���'���4����_X���ϙ9��(�~�z�z�Ό�!t��lP�i�	<T:b࣮�-�1��&�/�5K�0x+�?����み�15!�r�M}y%��]r�N�+��=����.�|�,�a�a��i�����e[~<���,ԁA�C�(�Xߡ�7����&�#x����
��@��C��8'�J���:��:���u���T������Uk�'�e���3wz��wX��6g�u���)�wPԔ����������f�.X���O�3���������&�_ɻ��H�P�᯹�������0���o�Hq����/�m�ʣ�`��Y�)'�\ޒ��s��P�����>W���s��Z�U�r��דO��;C��z��ݳ�N?K;C�;r���.?%`Bw����3�~N}=�T{Ɏ��� ���9���`D��t%~��S���$H���;��m%d��:�N�T_�Lp=� [R���v��y��|��=O3��I��������A�*��Z�H�������ۗ�?���[º3�	�e�UHd�S	FN�P�>��"t���V�R���ƿ��w!J�"t�W�_t���3B�C�������$��˪=�(g�n�v�X���u��`�1Zsb��!��m-a���̩�7A�Id�m�	7~I0����Јx	'7G����» ���αo+ћ��:0��3|7���oZ�O^F�������$��Ӫ���X7�2����g�D�{�K���h� J�a=5j$���`K-�\��2�����oq����"�Wq��O��X�~��ww�>���R����*�4���:#��A~�w�ٿ�,nf���\D~\���ȕΞ��ѫ;�Q�聁�f�F��n�+~��S�7;�r�%W��I�?p����^�wT2��P1��:Tt��0�t㰽��V�{�o�A*f����i�l�P�-0x?�;}֥͍Ʉ2|7dB}�7K��!(�d���kZk˞���i�|6�+��I�c�89Jk��,�'?�/���I���"��
�ٮ���/����kvq=��)�ֲ���㺎Ы��Хq�(��6�	��,�A覩�<����O�#t+������1��!�4TB�j�
���B���!���U>��t��_�ȑ��>a�)>���H&�g�_W�l�D1�O�Pۍ���:CO�|t���.����#��&��X!B/�᯷!��N���?��M&���O҉���:�����.C�,}��0٦\����)aևU>:?�^�pmW��^#Jҕ��)?)Ჾ9P2���}�̞/��{ۇ,��^.!Yٮ!٩��[��䌸b��o,]�6zb���k���H�=�a��������w��g�[���o%�ҟ+hU��ȩ&�eK9Y��xh���:��*��b����F��xX���h���Q(>R�b�m2���%{8f�
�/>�1�G�BT�<7z^aƯq��v�0��=ۖS���])����1V��>���+S�g~Y"��2J10�����*9���T_���ֳ���6�ōO5	�G��=�~���;{Jgn3��,A����Ҝ�OM�._���_��r��H��:�R����Vޞ6�!�8�Fx����&a�v�h!v};*��g��\�6F�x�g�\�X�<�ق�Q2�L�]Н����go����;#p{�	_��V�[Ld!��h{C_=�^;��e�����	]�l˸I����;dX�άO��m�|��!ܵ�N!`r�ߪ�\�l�������	�/�7��;:8��9�Nַ�ԓg֯�U���,�f�/����Ѓ3����#ǂV�y-v���}�&̵��ƻ��RU�H�e�p�B��}St@,�	�k���]o�a�o.��Z˥'e��/���:�o�ʁ���������0�2y߲>��^��͝g��V�;-G���zצ���w<g���e�����Ug�`,���s��;�g����b������^��%f�+�W���w	U�t$�ouf�m��t�w�/���/�S�#��룊�ṙ�!ZO��Zm�)z	|F�J��qS��m���=�7h� �o�KR0�Mw�i�6��wp03>��0>��:A��̦�#�1X���l��_n���
�-�3}K�^#�~f�����-"�T0ۇ���{X$��Oh���F)j�i��:ܹ�	-|��m��Eb�1O    ���"���R���V�Έ���Y���CC�qՄN��a����՘/<B���e8�ٜ���A��m���Y�U�)���e-�4lYM��^�2�G��u	�-��RYa
�7�0����*;�wܐ���{9*!gև�3��>�3G��$�gqu�/�G�Ό�$t�'z�x���$��~q��o��s<�vOL������1����d��/|?��������\��'7�Ok�.|_��9�߭~���]6O�����)A��*��ҝ#q����@|W7�7��k�6��`*R�����C�S�?�-3���A�<:ca����]ڦg�cJ��Uڦ�~NpX����-iXQ���,�R[�,m`�k�(%�F����UZ��&���٧5�^9���B<Q�/ۚ}�}��Ck��ds��)Bm�J�%��oU
�m�"��}\*��O��5U*Wj��Ƴ]�d!گ;��)�x�C��qI����nf54e:�x��[�4��5��vKb|W��B�M��
��@��\c]����D�6}z���O�wt;��j�K�2T}A���-��y	�Xw8��cv�F�%��2���xߡ�A�,��5�w_Z����ɲu�3K��S�2P}?�N%�'�g�p�/��A�����LW1���_>[&����O�`�奊5�=��cp���"3��_��A�d��t�w�o��!��OǠ���x��w?�m|�P���/8�ף���O�_����*�6	��W�}�/1ԫA���!���=���V�����6����U�v61����x�-�T�@�O�Z3b�p�C�d����9�6�YV��>�Cܟ���˰�4d	b������rgf}^�0�&�yK���_Y���C��Ć)�|��q~(��?�e�8'��'�/SOƄ���^<�e�q�C})0���|�ғ�ZF���c~���4	T�6��H������+�ܡ2C���[�ovY!���0�F����q�n̰|ѵ��Z�>�F�iS�79��a&��)'�m����=����.{����6�d�P@ 2�	��x^(����ì ����g�z�������?*\�֩��(�|k&	��=���.�_9\��ّc���=-��A枲����BE`��i��a�6���o_V�p�_X����n	P��VwU��|���f]������`��VK:�n���\�_��{u]�Җᇕ=���ѶO����m�0|?T��&�;�p��4s���7��X����_z���$����N��CL����#>L�����(�I�Z�u<����(Q�5�"7��8�� ����r3�ىr�l�L~���v�x�i"/��<�aI�^�j5��)7�S>mc��A̟��q���X;6#{�b���(�OX��Y_7s��)�A���L���if�|QT^��	g=uP���Y��G�9d{8.��4v蕕�j�il�'B�ca���ЬiQ[��$�`�^�P�?F�oxO%e|�r�]\�%O��Д	c*{���l$/r�����+,-E�"�?�� �>���UZ��	B_�(�[�������]W�JDhX1��s���Cw�c��ݣwv���Z[�RB�]��5��wl`d��n��Y�0�7n�~�>L�1�����k�ء���_v�t���$��{��]Y��-	�wf��UY��/Q�u��we鲿:�T���"�����(�wk�^���k�u�~�/~���l�������g��z���,�e�y�Of8FM��o�[1�g�p[ ;aƗI��3h6l�ס4ܘ�a�J�I�m�>:%ԿA����b�nΡpilˬ���
�fYi�c�ȝ�2�����sgf�@�Ɉ��UW�Ɯ�w(p��?�Ѣ"+����]���Ish4����p^W�O��Iw�w$�՝+Q�*?��p$� ����i�&	+�5'�w��Tmj�B�Zgޱ6)��r#V'a�-�Z?�F��snr8a���[�a��n��7��k�G�E��?E\��c�)ˉ��hw��^{&��o�U��[7���P�T��%Lx]��*A�;�����=��i!���:�g���(r��eWu�)�5c��Il��%w^ ��QZj��i��#�f�%���i���������v~n'7�:g��N�|K��I�[�/�r�J�X	�e�_�yٛ�!ѝه��v~.��g�j��:�%�XG���K$<����&N����\�w��+�!��_�Ŝ�h'���x����(E�oco�?�jS���!!��V���^�*���*�F�f�<�����	OG���PW:�>��=�=�9���5��$���!,��=�G�r�T���$������I	��[h?P��?ﲬ�����p�1a���t�\���X5�����������マ̧܈�ܒ5�%^���`cʀ�[�t�G�G��"��{f�^�*ܱh�z��G-��?c�������;K���I��B�B^���*�]�/�F���k�a�	S��[����Ҏ��{�u6MÝ��;ݽ�KG�H<��?DH7����t�!�g�XZ�)풫5T������q6�Ϝ�?�����Km���9�ۧzמ��Р9�C����{�j��B\�V��u-��u*6��e�#M<�[S'��U���o����h�E��$^���cX%����@>�'�I�?�nʧ|�A��*gw��C�D��kFj�(!�u���M �I��Nx9z��?W��T��>.=R�f�gU���(������
�o���#�\;J��֬1���`HW�����NQ�����B��=5��=ص���>6�J��%��〉�0����_�?G��A�;�nDW	���Z�UV]�\��Ir
�'�$��\Q>m�s&OL� [���}�N(��n�X���)�)1���\)�l@u����{�(��r*ɖn}����r�.7�#I�4�hBS���x�s�_YE���ȡ����(��JG;�u�� �*"���:�%���N�u������9
��Z��l��C�1y�5R��O9�O}�����h"+~r�G��ӯ����W=�|:;�bы�~�f�7���[�k6��?�O�xɏhW�V~F/�|���Ֆ�GK����,m���\5=S1tS�iP��룂6Hm�
{a��~4�mt��eƫp���m��@h�$+�����>�w���%��P���#��yr�!��e
���~({z�1U߄�H3�Mڞ�79C�oz(?[<��k�����vF��~��j�h����/^5�����r�k�����"r��ݴjگ�4�����Uc}��:�k��?4c}5V�
��'^��(������Nv���	�Q��woo��E���yﻁ�g���� V���I|Ăov�ս��A�h�v�^LcZ�َ�����^.�Zώ���	,1e�F=l�{Y@�&®/k1ΰ��1���ߓ�6�����/�:e@͌���MS�S�(��C<$wdO�;���Ҫ�K�j{j�*�����! �7{�������yȍ�M6�hnO�n�Э�C�E5�Qu���ex������+dX��q1�8E����}b�r�~��u��ܟ���}e	��t����j�Nq�9	���`�#(�p�#ByH�|�K�lyF5���X��K���{$��=���^��U��o�G�W��/�j�=�|���r��,D����?�{��;%.�P����y5�l���"?.����!^*��od��?��v?$@�5�?��>l*1��.B�����T"̓�VxO!�����k
�_6���������'dg�C5D�S�wְ���!���F����#2	�H��o�V�X@��w�F�6_EIA{'m1�k��� ��9D�"���H���!���D��3�o?b؟���A�����,ۜ��o��U1��,�K!b���"���AnW�#��� 	SBӹ
	.2?,�І�+Mﱽ�H�ϛ����S"2�ɞS��/���GS߸�b����h    �y���t�<_���u9w�G���
��P5���Ѱ�k[�h�L����~�o�j"p-������,�A�}v�l�=$?lQg�`(t(|������]c������@�0�g��_%��y��e���j��5_�2�A��_!��/o�Y�	�7�W/�Z�:�ř�n���b#@��(9��X��Vׯn���<#@��2#��������|kG��_�4���d�K�}4��w*�o�;�YG'�wjaA���n�e�O�u�1�W�t���'0��̏+���<�=,�b�a��:��s~]�::�S�$�DQ��������6F!إW�NR�-�/�,柯�C'�(��/��ռ��/�Y'���(Gb��f���J�ٻs}��:)�s-0��lO�+�c!��ލ�ƟUXC�¾[��4�ٯo��`�k���%�8ܺ���Ț�i����><�����q|U�Կ�Z��y��)K+����WzIT�\��
f)�:st����TZ��zn��cK�>I��RJ�`�6����N)�w���<!�4��	��uE�}�|K�
��;(��е�3^����=G9S��wU])w�����kJI��( Cϖ=��g9j�����#��`k_����9yJ���r^�aO�q��t�,d����dnקL9�Tǎ�}�v7F�Ox� �����R��lj7(�F�cYo9�wj�YoJr�&]cu�N�Gԓ���_[aylvڌ[��~ƭz��jz_�2a� ���Vem�b�+�93�<�'z���ˤ��,����%1���̟��͖�F䍹�Or5ͯoa����I�~����t1�"7�3-[9|ԗ��#'G-�����y�5S�GQ��Lv5���aw#�������S�ڂ�o:y��WB���b��I��aV�O��/�*A�4���������q��y� ��W���C8z�C?�&�Jqd��;D��b��_�`�S� Ga�_�U� v3�O~5�Urr8���;Y�U��9���~ǟT�ZN&h}�].��t�gdܜY?�\���(|��Of�˪��r���ֽ� ��Yۗ�G�'�W�������Q����"����V#�>��	�z��A�'���I���S��Y�K��pHT��mP�9EJ���=wFR���1%zH��g�*����:���>�9�Δ4ll :�z�N�2��
#��5VC�OPf������υ�n1�hEdc�YЩ{�%Q���5�)�9��Q�/y��L�8`l�� )�Oѳ@�᧟IRmx޳���MS#�2˩�{���(A�}̝o3]���f�9��$���!�b�yv�o��#���Q��~�H!<���$���$LC,���������t�?����t�=a0󿣆�&K>.�����"��neA23��-��bQ2�x��5_���0�{�wwF��������3�?Ӊ�O|=)��ʏ�o��bU>j�￳����H(sO^��⼺dw��#�G��K�*��_��Żx
?��}-�9�������I����dF����f���������P��cS\������Qϥ���RY��S��=�@t%)&-]G<�u�)S�����W�:i��B��l��<k�C�5�R��v ��α�x��DWm)�wx�^�E0x���/�6s ��ЃjJ��ZY�=�6�R�¢
s�H��LͶ�vȀ���?�Ei|�:��\p'Qz�e������*_OX9[V�Z�sZ-�d������c�ٿ�\J�ZćbL��ַ���%f!8�o�����xX@�y?�����,4bޯ���6�~Z�25 �?]��ǕY��_��=.�A.+�3��:]��= �����e�K�(��nu��2����DA>���N���(��-|9��[���R����U�����R���ɳ ��ǭ^��Y<TC`�+S�cc�鹲b,�;�d(��F���F�y��	��a��=M����:��^��W��[בSIW
����n�����#C�6�hd����#���8	�&#��z���W���U����~<�x�C�IY�UťE6��gO�;NrbIᴐ>\N>�,7���\�Mȵ|���ݥR�D����r�6��۩|���p�R��E�vM���^�V ��rd������\>��S�)U�����	���j�o����&z��~4���R��=ت@�o#���#.'���,t���������:�6vǤ���	��*a���m�|!?����_��	?A�����FO08c�I���{8�W��\W�|�0�Ü?�7�~���	��-�5�+������M�*�G�G�����'��f޷q:�qO�=�l�ğ|�o����v~���⟼{�g{��Å,o�i��ˍ� ~���o�z�?C�����T_�9����� %�����������a:޴��;��A�>O�d�oK� ����j��sgf�w��y|^�0cw�J^Q�>Gw֘Uo-4��b�Oj�֍{!.ٻ�>?��2�$��)��Vz�Ѫ<kS� �څ�%3C�nl*�xGv���c��6C �:scn��Y����:��c���� ��)���:&*��}X�I��$�&�ݴ���a��_��m=�'�y���;|?C�!/a��}�@�w���&s���0�A�u�x|e��B�-���s���@d�^��c�8�?
���	��-
a'��!>ұ/7,
a"J�m�E��Cd�%��a��3t�~�]������f�!��d�Nn�6>�Z���w�A�6Ξ�P,۝~Q��Ւ��<��@�$�OE��!E�i��2	�Y�v���
S����|#:#l��4�ɞ���Sn��1}"Ӽ<�������^����Ct&�+P
���1�S����B�%�g���9���{��^����:��tt�K�����NY�f%�L��k�`Ja�����		��}��gjތ	7�0��I�,m� ���\N ���Ҽ�^��c��K��:	�MT��]>~(ԋ�uT0�e�	V�1���<b*u<�8c�6��l��L�f\P_�kt������p�׷L&L�m�G�:^c�;�4G�Wc����Z���7!��0g%�o�$��8�<c��ٝ:P=��wh�n�4�K�G�p�n��+��c����s�I��-���J^��p'���m���J����ɫ�b-���Piٟ,��?�|�B��k>E
z�R��9[�+�#���H����V�ZG���21]���F2WC����*��-�5vO�a2[�����<�[����!���v��sKPR?-=���I�X��W�ggO��#�������JI#����UƷ�Lc1��R��cq��Z�~���!6����ݱ����W��WӋ>D�+�:F9����l�~����Y����y�p�/9�W����o�h8�(f
ShA7O�"��MA�:��Pg�����R����X�,g������C�n������G�T�6*i�^�������L�X�,�BD���9�~�+Å�W>����݊^��sƠ�['|��E��\k;
�VC�}�XLk�,Ê��P���q��+�9ǲ��;��W8%	���S�e�6A�:��I��~m�B��9h����͟`��sK�.@s�]��?��.k��\a5%��w��<9�C����m�2B�̷��^�y�3��]�e��*���6�������,ü�����U> ���~���X\�S�
�����h}�z��A��؅��A'b�]�5��������UV�S`����ll���+Yb�ٟvu�8�����A?��&ȷ��������[���Cx� {��_#Rܜ0����{�_#R|��[
Pݎ}\����5u�e�}R��g����㈡��[�w�'�ˏӛ��,��(���}*n|�{Q�U���!��[�I�֭�BJ,���%7B|�!�X�[�l�~��5���df� �C��'��/��T+�/zLt�A���e�7�= �*��k��;��B�sli�� ������a
_�a��%�J����'Z|��-�_~Ѓ��为z?_W�&`!��    ӎ���*�8�7�/�/�*���$^���=�j}�)^�ajy��(0ݟᎯ�/̹��e=�К��}�;�e��wҜN��+��e������uH2{�%�i�a^m���w�m��;�A����n˟�-�?�5�gq[�o�hu���wC@OnB_���ݖ�~@���B�������`>�+k���c������DA[K�\�Z�yK�{�����`��YY�q���L��{��ݶ%���������r�
���r�g��b�ޥ��S�KA,ۘ;��4��FZb9N����p����z������a�23߯F�2n��YW C���!���Q��^�+���n���������O��)R��f�Y�i���]��R[e��F"2QV�^�
�B�����<�ܿ�G�L�m����e�V"x�L���^�,�/z��lK�a��=�!oO]�2,ug�ZU�Hy��s�P_�5�R6li�O�J	�����i��^�a������Z*T,��F�16��B��kbʷ�#H@{>���=h	^�r�\r[�X�-�\h��v��/9��a�[�k�O9vYa1�?�*c2s�������t�լ��c9�1ݷ[�X�����r�Cq{d���JS�(Î\f~܍*�%�U*#����eU�T��,T��v�ʚI^a��/i�e����k�{V	�v��b0k䞼��T磸�=LM���q�}"�)G����۸ u�QN�O������{��jN�r��垔:Ы1�tJ�l���H0s�*#�'g��y��r�E=y�x6ĕN�nf��/� �;����\��H �m�S�T�q�0��?���y|Dl	�$0ϴ�NIvc�^d��h]�̧����q�v�w��y*�:�sM����s<���_U�N�0�e�x���_<�6���(ʅ�i+:����M�{���������5C%Gfzk��,\���j5l�o	����Ї���v����F"e�1B�8B��W-t��G��y&�1����Cg3~�o�7(k��M�rx^����C�E?ڂ����D聚��MFU����^��ѩ���dHDö�+��|N��� �:���6f����g]�d��q7�^ˊ�Y��+m���,g�L_9�e{�Z})�Mۋ|���io�\a+���:Y�Q]��LN��_&�Z��>L��8L��#�����gа��kg����A���1[�:�S��D�5@�-?����m�,�<z:`�f��y�p��{��#���\��\���>�����\:-uS�Tk_��|��#�Y�r^�)�??k{�	�߀Ư����-���a�yЧ`sE�+�^1��A��?sL��홚��ȅ�o/N�����ǣ>�&��X0�f�������NG��?s,�)���O捞,�E��^������������.o��c,�ܮ��0x}I�?��Op�tҏ�v�1�!�~�ϐy3|��|/l���󜴗޾A}?f��c�U'6��fXɩ�'~,y���JN���𕏹gW�i�����c��-���,�)W�2�)����|��z��Wn��Fmˎ ����JN}W�0�ɖ7���Z^G.ؕ�Vv��ш��=�!C�Ak�������J��������wSx�z�b���l|Z+�����A��^�!>sO�α��Wx��>�=Q¿���'-��A���"��yQ�X�.0�K�d�>�6�S�ίK�[�����Jx����-��[]y�uk}9x��U��ͯ>1���נ����I)��o?�Sr (�pF,3~M�,��]�NH�Ʌm�:3Ti��'X������K��l�(AޡI>/���G6\������*�i�]�s��1�STM��]k�R���
';!t�2��Cg$��y�Ӆ� ��n&?~�B+t�3x�O�_
���5�������#�4��4�����#��"6K��N��?8�\��
��~B߇5+s�/l�����)|0���� '�2�̓~����қ��OA�˜ZX�����̖%dgDj�(S/i�O�)Do��2��~��c9����Ԝʌ	1�Ֆ��O��x:�w�Q�S���f�+�4��_kq�;��k�k�DHn.������0�L&
�ٵ���6�ꅣ`��&
VHg�̐1��Қ�B:��B�P�᧭57���(����Қ+��:����ut1���[�J�.{�����\;*�>�&4on�_u"�#$�7Y1>L�8�����߬:GN�q���Y�-g�I۠�W��b��&J��V#��K���Ɂ��5@2�Y��CYmK����x��Ăw�6�G�.[�{6�����"=�8�]*���T㧜ǫ�B�T��u��~�3���+�1=�Z�k]P=0����+��G#�����Q��ѫ�	������8�2�h�Pu|�uK�j��/zg1 B�i��k�8N�7��l�{c����y��k��~�0�8'e���������-1z���<�:?�G杭y��U�E���$ӆ��%���w����ň�3���=�ŗφ%����~�f��}+l�48�9�?��mP��Ǖc���A/�Mo_�\ܔX�����W�(F<�_���ɁQlo.�/������L^{L`����q�?�y�����/a0�,�Z����������T��L:�鼂o����CS��m�ȯ��S3ʹ�-Mr8;ئ��$��d�O3�d�,����~�J�[��C�Y�g�}�r�^Nx�G��˿�b���\��Cd���/rU���[(7{�c�K���!��!���u9Y���]�z�i�w����~���Ǡ��� l�� ��߆�#G�/��ҝ�n�Qeٴ�Fߦl�4��|��++��V`�B��Jѓ�K ��Boc�퍑7�n�P�g��G�(�Ė���0���^F�����1rfz}P_�TD!xӔl�=�;��dƧ��Z����᧩0�]��g�����������S�W��.7f�?��-E��2�ըq��,7��_E|?�M��-��kL�������9�?]��Z���.��u�Z�}f���?k������~�v��&�άߙ�� �b�~e��މ�A0�5
un��|������=
2�Wo�(�|��c��֒[��G����O?%|���>��������D�W˾f	�v�'����dW����Wc��>;|��B���Rx�N��e�mΰ*��o2��1��D/^�Г2�7y�bv�y-mG�%f|��ٹ�SdՍ~�u����7������W�뽃�Z쫊k>R�W���(Al(�۬9�/�,_v�叭�,���������x�f!C�N���r f�T�[�>�@]���訡����7���f�B��]�}���Y�⡢[W����|�����`31~�Ӡ�!�~�nx�$E���B����C2��w4�p~�:{L��?_U����~��-�&�A��o��`_)�7��37���1�y�j��S���Z�Ja��NRt�����Nq�'�m+qT�Y��gerG{���K���@��1�5�,��4�wvk{?yƱ~�C���U�mX~wI-�K��s�bX>��y�\���ᷡ����F��lq˞��[錡���aY�o��4���b�ѯ�x&���&�
+�<��c�gQ�0)�=Ag֧5�-���w	�ȧlB�4Ҿ���i�(7��9����g��1�C�g��[�6rX;7_={[`�s"��̫DI�1��V�WJ�p�Dyr�=�W(���)ǫ��_U��sE��cB��o�����2�X�*��g8ď��<Ʒ.��� E�u=%�_���tf� ��^]�s8>���N��:����B�%pJ�y�ک��>Qs�v��0�Fy��LN�C�q$��~�A0��Q��#led��+d{�58\���9N��!��G�xc��~�Fױkl�3rM���k<���״Vs|�&��g�49!��#F�|N��_w<{h���;h��y������.Y� A�u�`����K6����~ �  w�t���ѨI\||�����t���(ܽr�UH���y�f�g�kL�&I"�5��o��+���6���'�%&~��U����$M�:��z��\����f�d$MS�z�iR��C��ճ��(��]��v� 7f\I���&�%����'#Q�'ۚ���NF��X}�"ot�;kJk����a��~�:�+�S�vN���a�g�~��1��_�����a��gE��v�t��@N�M�Y�dƆ�Po�Y��� ��_x>
�|[zx]n6;�&�a�_�����>LA<?�B*��<_&�Jy���g�H��6<�;|�f��ݩ���r�Ѩ|��I����z�#gS����U����Y��n���!���<���W�������_�?Ƴ���k!]�b��c�C�o�'����M|��c�o��2����1^Da��,�=�T�G���~�5��3n9�����3�05ſ;>���l���(=�M��H܇�G�w]I!��Y?f������G��W杶��~�� ��>���'�cS)u� 
�������ܘLy}��=��Q����d�e�&�QpƎ��I�D�Π�s�o�'	>E���<s�'��a��4�V��]�I0�_V!����*+�a��'�S�HS8����7�3�'��`�3��yT̴�P
��ǲ<?�:�h|�bxq$��&�w�����`	5[�=�5�y��Y�!�>�V%��%Gʰ1�ժ����t`3[۩6^W�aZ�<S{d��	�������KL��+�˘�<�>�i�%
y�*v�U�-�Bqؙ�Эۧ~�U!&�ؽ
�j� pӪ[-'��q�ez����`�"B�S�n��0���(�X���]*��g�j3���5�%����G���s�����3[�l�xb2t�B���%�4vҬt��7×E��Ժ�ޱ��[`!2sO�O�O�0l�:�_)�|Ȱ��O���GU��bߖ���1�+��`��K�n�{8
���PS�ܙ>
��w!�u;��3a�����nc}5�B���J�e��d�=�pJ`|��R�n�a?�+�r�j�Eo��w�O�C���|3�]�6��Ł�ׇ��W����3��x�?�������^��q���*��0=���,DkaXߴ-���sy���'jF��9�G� �jW�=���n~�t�!�~q����L��2������P���s�x	#nH�k�_�#��5��v�_�R��-�<tg����y�T9��;�#_k��`꾗s_��������~h��k���=KƳS!���
K@�%�N'����
�����D*��^6���u��������v	F�}J)lt�2`�A��^���=9Z�@еq+�9^�s��&]@��X�5gX��Vudf���~��M��e��$�����J�Ubp��E�z5�L��լ>�}T`��k��\w���m6�՞ �5Vv�ߡ5���g��
�7�ꮊ��߬Ԟ�@�#��ެ4B`槕������M�<����=,�$���:��==Bv�-U�̗蒕u!�����kP��y�-v����7f_�j���g���ʹ�X]<��N �>�O��:
����흒g	���"W���>293���?CnY�i8�w�[�2Л���C&�Je��F��|��j[/'�%T�견W���R�BKP�rw�ta�c��VcJ������}̪�ᙨ����������o(����G�灮�:轂��O�6��T����������Q�      �      x���I�-'D�ʽP�~/5����O�
����p7����ڶ[�+V�K~y7v)��0�Z~Y�����g67C�.͛]K>�|�ݫ��KfY�#�p�+)m��W�j��O����6�aUs�z�V���q�(����5���z]ۻ<6O�u��Gs笺���d���^�wq���#��}O�������{Nnf6��:n��n�gj�tҔ�Ɖl��4;��n�]~���%-�r��IJ3��,n�pݼ��h7�<XVbL�_���#�f�����4�,��.íN����x������7�S�bY1^:�~�ݝ��z���wR��2L���i@0~��tv�2�,��ڦY����ԅ5�a��e�؛^�ۺ�Vw{.U6H	
?�S<���w��t��r��)��P���
H~�qZ>��@y�%$7R��2������B�� ���݆�e�X��k����~��ƥ�@�t5ļ�M>�$��<�\9,�@�ۥ4#�	�Tëfe�u����mv���}n�����bb����Ki������W�~��,�`[���R[��4�[�ߙ2 �UI�Z��m56u
��;����,�`�� )@����KW�!z�߻B�����j�q^�v��]���4禗��w��;�u���<t�l32'Cò�|�f�m��4���r��a��<j}�a�� 3B�<����{�܎^��(}�ɼR���nx�c�c�_�`iI���:�YV���f�w��v�:5N�2�yp�z��7�fa[�2~�c���LS`�6g��8S��,S��4(o?�~���8~��9���9w��^pg��9�{+�r��v1-�k���q�n�����fu̻�ۅʦ]�k� ���7��s{a��@;1ta,��rl:i�B��-x���N���#մN�U@T|sҬG���}�)ݒ�~Xh]��Je����5W`[�v�O8wm���("/���5����Z�_y[=���n�?z�w�Ƣ��YVʧø<2Xy�4+�ԁ:l����0sq5�nc3�	��"�-��egn?|�.GqT���?��>R������t�S��d��nR\�����K�Bg١��t�bC�:B|�]�pXB�P�%��Q�(��q��8��	��c=gf���Ӧ�@�
�R
"��7S�4g�۬n��C��߈/p��4+���{^�&FO�M��5+\qR/q����k6��]���R�u{*�MS��6=��|b�!�$h�!�z�9��s�q�0�z������v��ދ���
����;CyZ�6��)���݌ɣ��ΰ�E�ϲs�nM�9���'���ܱ?�"�|s��h��y��8���n�&��\7X@�wԍi��bV�F~�<~ۡ�*�P4@u����8k����30��,��|���|c�"F�����ɡ#�("�ՌhK��E�OG��hcׅ�ړ�6���7�[^���=�J�W� #��.4����D����S��^�C��UF�3e����ʾ��3QA@q4��V�Z���4u�w;��t�Pj�x�=����kw����+���V�w��ު�6+����X�vBcY�������$��Gj~=�T��v�18+���#C�����`S{kV��"�%�Ȉbh��!��^{c�S��Q^� �o�g5mu����x���ȭq�N�'��������Z��Y[��?�r���_f��|��B�����IN�_�6y�� �l�:NEuC���t�#a������mͨ��U��)lm��xw�F}<ZH�SA$p�Z�I-�C�ݮ�I=��nW�<�����K����J��o���7�F���ʒ^��2Ű ���*#��ƙS��H�������n�Z[O�䢅���S���[�e OT�D��5+�0�"��f9���^�@��$�<�v"�Ͽ1� �f�8-�Y���3�!����RH���;b�(?�V� .?����yQ$MV2���XMʛ��]�!��&A�4�a��#�)�d	�p��쌏a�Is3g�
!�4˾�X�PDI�3���	KLn�6(�?�چ	R1��8uHl-g~Ÿi�~�=6E�=(�� �F�+>�/���*jDe3����7�H�,��Æ7tE��SM�������D�@��4�7W��zO��rLL�d�JA"�A���$F�f�u��Z�d�l�"ȧ�Yw�W��bK������%�����#pq�39�r5�]aׅN�;U�;�F����2A9��:�{╞�%;۷�	,K��#��/�4ʇ�j�`�_O�{�ܮH�ݬ�v�l3��V�����* �A)y�J�!9+Q�N��W�Lu!�
9,�`W#��S���<P��E5��i�0��"���`K.$�z���9
��+�L�J� ot1��N�I��4F6l��,*/�ș�[��ũ�8Cф�(�w�w���t��ׁ%o�������B�������}���r�p8�{�O�p\�fu��9n:��d}�cpH��T��}����1#'���_.��%�}3�t�C�
~7�&~��dᵑ��wB��޲%
�����-�����#u�o��k ��'�ۺj%���Lͪ_n��}]���TV.�8�6hi���'ię���U��f��R�ԓ��jzڧ�	�.io�vU�2�'���#�������E�?�T3�K�]ٽ/Ա��9E�|-�:�%��2Č:B6��ӷ��p���E��٤?���f�ˍ�}�
{��NӢ3pg)b	H�����赢�~��Hd�����:B�iH�)�| �P�#Uz�ٛ����9��X�
��q������DXdh���0;0IzS��F�������!��A=nC]hQ��*��WoNB��:�K�D�P���e��E�"/]\!d1�c��L�����3�9'�9X����!�4�Oy$�d�:"��[ӳ�n	8�!$a��(�^/]0�KY�Z���!}݉r�6�K� ��J��o�H�[1&R�s#'����2�V2rMa qd��9��)�i���F��C��W�%�\A #Q5r� �ry�p�#���!E��xK�u-�S��V(��7�4ӧ���0�FL���釫W�TtF�kQ�a_v �'�� � �����Hu�z��G��"�^J'=�p;D�d~��//�o�;��h��U/= �+��2�g�7}iHsd
�j�i4+ȧ�ǿ�y�����.!|�픐��&š�49�ΣAҮ_�A �[�0�����;���􉄞z"r�'Q��I�!��ǟ��1�B-�S�X9�iZ��5}��V=�%
���\��'�l(�l�Wa��?i� 1�0�R,�C �%$ВƲO�?�S�:fAW���Oi0�4�$�"˘��F�q� d�C��@�8ǣ�}���[���I_=����#�!Jb�u���o���4����8�t|O�F�+W�>�`ĿS�Acn0�ɜ$v9�*j��L�&��@�w�����!��L�#��q5�2T����F*�vt�O�OA:3�%qЅ�v�e�c��z]u`q=
�ۼI�<<ֺ8���P�j��O$P)2o��3��v2-�Ľ�mt��(����̚�#���1Ku��j�9���.'�(ـ�>Sޒ���2������4�xQ�����r��.7�_>�R�8OzP���� �H�Ѻ1BG�1J�!�G���6���A��<�z�\&Ь�KO�{��)�4}�f3���fJ�\c%z}K�-�5:Sk?+�od>\�Ŀ�Vܝ�t�� r �D&~c�Z����o]��+u���Rmd�˝�"���O!�3�����K�1��}l�!S_�S�9Z��D��ST�nȨ����LР�ч�[���r�6ꦓWb��n�=�E�_�? }	w�yl�.��4	e�w�r}z�=^An�����#Y`�k�v��t��^QR����vn��z�����L�~���`���O��A'������xG]�4%�5����Ul�f�O�Z�I�R"�q�-��zNz��� �  �'�|��E�6_�e���|�^6E�����_��Ff]�B��@$�ؽ�v��@mDE�QM�z�;�5h�n�f�D��\t��w:j$0!�8Jqȗ{$`�"��gB�j�d���������_�{E�7(���OK����9ьQY����\QW��9���!�F�*z)��q}ҍ������dX��O�m�Z&k�Ö�ωc�8�P������ı�-*22���[SԤ2zm�^a���k�E�x"Z����Z�� �u1��g1��*\]Wa�E�`Wb�����U���ъ��K[HƝ ��ʆ$`P�8�Sv������\���)�_��i}��#�O/�7E$���(�+uӬ�I�*��e��3�0������2O��l�`~@"�yDcj��
������\�p'���}ҧ�:Z�qZ�s5)�B�Nօ$6���WL�r�k���]� ���@����,B^�$�\;ڠ����']�`�Rx$��@ޖ��w����"�U��̓pc/}ȸ�m#��A>n����=ko�A����]�m�Y]�t���pR���Zֻ.킖�����s5xo��ꃲ�B.���Y��C���/w ��x2]<����	]�G�^5��3T+�4�x)� #���\�C>��=�ٺC#�W}w���J:Om��E^�>�9Ŀ��������5�      �   �   x���;jC1Eki/4i����}Ix`����@��R�e��=wF[A�V�R	��e� }aQ]]$�ot��y����Cq=R	�P[, ܫ]�C�0�F�h�������+s�1ԀV�(BS�GK�8i���|��Z��?v�ݐ(;�{m�߆J{��+#{��f�m��;�%������z������{� ��|(      �   ~   x����!@ѳ��Fa�e����_��T��Ã��]x� �Q�mo��lcW��,���뗹����3��a�ƝP��P��}M�E����2*�v]�B��k����~�0��D���O��] \�      �      x��[Kv[Ir?��y�g9���Q,IU.��YRuO�)�< (5{�mx^�G�N�� )$P�O>G�"� f�Ȉ��L�����D,5�LQ6/���l�5�6<���������v<]��嘷��%����|Cן��Xm�Zj+�Ҏ��QJ�Lz+VEmD.A�Jɩ.T���N͑���K�DI�k[ɓ]�H��V��H��6W�P��� .���O+%սl��i|�e9Udq���Ma��
˺oK�ֆ(b�.,�&��UD�KJ�n�7�e����vqbX(�R��¤*QN�D��-kw����|SX���Rߒ�Z�t:���Em��EQ(�u�����֫���Kh��u^���|�a�0�(��.{jbخ�mA��bD������r��d�=���k���.׼������kZ������o^�<�H�Gi��R9$����BSj�v�"ֆo�O��qA���R�?��)aM�"{�D.YU��.;���ڈ���-F���2RL��"b�Š��m�[pt��O�r�%��Ǔ����k��B��"|w.[CZ9N>�niͅ��^����n����qp6Y�(]#��$[JhMD��lg��\W�'���h��>�d�L	�጖˿��^u�Zӆ�[jc��u�������h~=�&�(]��Z�AQ��/�+��4�A���D���M��<!6]�-5�_��KZo�'�E[����?6��a����w!��j��I����n�ale�9�YW�c�9��H���\-idex�Z��t��9�l䶼-���b��*/JEvm�XV�"l��xg��8�5&K�-��s#G�KY�����y�\������z�����?��r��m<[���4m^_5xoTO���@��'zM)�*��s�Egd��#���C%��]�5b6~�Xݬ�y|�e���_�!�K�X�C��KFǀ�UI!gȁ�g�i���"5�oI�Q�:�Oݗ��p�Z}�\o����������ֹ�XU�Vv�EJ�:M�1�P
�}@�&�%����(���un�c{p$��|~�.��bW!=P�۠d���@F�Y ���p���?�y�������j���?��9�;+�zx}~A�h�;�����.(�X�!�f����,�� �,_�h�
��d������a֌�Vwk�c
.4	 ����!��ǡвq�g�P�3e���tQ�L�h�Vi�/1D���(�[h���ߖ[8�@�Z9�cs���Skݤ!M������e�� ��ޤ0�Ds�P^[U�ǫ�\���ku@��dD����@��`{����`HJ��O� b���Q�>��*y�W�W�[|
*	�t O����Z�����%CI�C�9va���e�N� ����U՝��*Z�h�#�4+��4�l�|,���O�OOގ'��8�"�o�h�4ӷTz'���ţ�*ׄ/
��P��^#L �ʽ���.~����2�M[L%3�����`u���P��9+�W�r/����t����a~,3tA�1�3��W���T��f�4�$Dg��A�,��h/f�Һ���򯫛���b�\�7�y�����#K�'^�e*�c=�@'@S���L��6K�&]�G�6�ƲE��d�OY}e��3���ގ�����J��&�+(E˅5� 	ӓ�Q�`aefR�T���6Ǫ�A�z�l�� p2?��d(�����V_h}+^�o!�W�����O^Н�6	�`:2(܉���PL5u�|���0��8��2V�������x����.�����Pl?GZ�[x x�)ד]{��8����ja�f��쪅v\,n�����R����7����4Uh���P�D3a�=%���!:[�8$+X%�qG�p���;��*��R	l����ʍ2U����붺�Ce����.������J��(!��K�\3��|���6��m��w���']��7����wu��i�L�j_Ik�뻦����������UsbXǢq��-y�� F!8]z0�3��&��a<gg/������ժ�_b�
�Z����i�lr�136�=u؉�l ^���j`�ٌ�ߑQ�9��&�7�p0KA�0m��Q,�Q6d�\��5�Dt��y,:�~|���D���2��)����4+
��Ȳ:�w�l��(Yf�e5�ŔR|?��Z�����>����t�$�Q�*ր��[4haUC��H���z{I�����s�����	�5{Ո1�*2�����]02x�?]珐����N��'��|�˂�D�ϋO �p�c�3�R�Zr�G!���!Q B4|�y�K1Y�՗7�f /OE �����rhF<��	��fXC��Y+�}�g5�[�(w`� Q�N�SIó�٠�P	�����z7�9�	>� &����e���l*o[ �dn�Qb��+�򗝓��ǐ��������E������T��1���D��"ک�"��"�瘞'{��P�FM:j�a���i���Tٷ ��d購�8��W�߾yw��=��#I�� �+. �ێ:�3��+� :��A7E���?T-AdH�*,�lI��]WB̗������ҤqF(y� S����!*�L��!_���:��"/>�����j�!<�k�JZ �	�: �v�q��˳�،))��6���2�cܚ)ï/~|��ş7]��8�3�T^-F�q�ű���@��E@e�]}��W�9��x��?]�x�r~�4�{y4q�c-v�-��PkP|�-��u������-�./�h�۱��c�i�Py\?!x����a��NtVoO�.޼bD�_��?\���:����Cݫi@�VzSb;T=��U�H���j'�^�y}�OG&x�t���������L����h=�Jp�A��p���K���gZߌ��?|w����}7��{Gȏ'U@L�ۙ�S���쫆W�X�A/V�+}���7K��*t��YZ�2����1,��#�da�):�\�sG�yM��e����UӴX�;��ʐ�L
4�Aՙ��e�����@�+�����Q�=�)��u}�) c5y;q � j����e���f|�^���h�͖��A����=C:i���iB�G���M��|���X
�'3��5�>�Le����Y�[�ހ������:╠�A۷��,|*��}��'M�@�Z��vʁ\H=���%r<K{�^}Y�oW7y1�]������,|�Ju{�T=�e�5�r�-@���:���F{�YZ>+���/>L�۝\Ƚ�O�{dȇ ?�Ӽ7E@�p�m�;�G3��:��:����ng������D��R<. �\��)>��Kl��P�"��e�|��`x�e!ﭽ�9tE�_�Ϯo�׫/�[|3��|�s�x�1��)Z�6� !4 TP�!ni0 Ę���)\�7��3Z<���Nj?�_&M=�K����&MƇ �J����"up�p^���Ց��,��&�j�̣e%��~�"�Ak��j���6�႖K�(�����{g�w\Ǐ'@�Nz[�XGg8��!>�$�y�d�e���jTJ>u�,��U�i����!�E۝/{�;g�C�ުefƪ��v�X�Hx��U]�S������/�~}0�Qv�
�'�9b	� ��6�В�*Z�������P�'��}ޝns+�h�9�z썥xW&M=����6��Ӭ;�}t��4岂��o�����4v����-u4@͐`ej�+�{��}��o�0{�� ��0&i�,),�#�� ͬ���`������j������|]����݋��=����)4iF���TF@V�& Qm]b,�1DKl�Q-����J�����ޜa0v' � e Lv~�9K�pG
f�y��0��~wa��'	�^�Y[��NĄ\�PS��u�=�!0b��߃�ri��Af���x��ղ�@	�K���S^n������i��#A�.y�kg� B  1����@�S��t�y��־m�	�w|�H��g�� d� ��5��_�Im_��-_����ۏ��/���L��|�����rN������A��W��2?��O��M�0P*�
=V`��	
v�	ʍ:Gwp��H}d:�pN�iV-�.wǒ�;�H��2��'*�U"m����v|������ֱ㋓���:�=:=��9&��@iҴZ{� ׸;P�P2А� -�Q��띂�����մ�S?,&�;Һߒ�&F��uE��=��78���KS$K�?���ϗ������r�y�^e m�gA��@^�PD1�,4C��|�~����?o�� ��̷�J-�T@A\�\!�}Hu5*g��/d<�X<�8qt�� ;Pxa�|��ds��Mrx7�[�g��|�bU��ݪz���{�l?���-mVb��4��sb�4���"��-j�+*X���޺�=e�/��A.������ۙ�Uj�A=T�� nٕX����B��q�����C�gv'��C;q����pR�[��B�6�ȓ��d��b^���]].���n�G�.��I7�/;�l�P@�o��V��&�
�C�nN��r7[:2�P�IL�*����(-|Y� �����`��U
ȫ7C�#�ol��j�D���
��ђ��) |?._fk<�E��������{���/�Y�U�a��S�yV���\ ���K;�ix��M����d����+��i�*��ew����hI�p#Bv
���19�����M��wt찇�jeW��j�uė,��р�C��X�|_�<q�R?���k�o ���!�h�A��D�e�U��`*�f|�Zu'���Å�����u�T��^���B�4H�\:)?��=�]G �U8t��avˏ'9M�]�|�IC(�;���`/����z)г����m��%��3��o�;���%xJ�#����{�k��ΰ����y�f d
*���C����tAy	�.���aJ|�a�Ƕd�ɞ9�
�e9>O.$\��$���u���8�]�����楄DFT�
��߯�5��6Yg
�X>:���o�'��O�)A40�|l���7?2���
��a������D�ߠ��Mu�[� �+�!:#b >�U��N��t?]ufp��;�'�����#�ne�� ؘt���8�p���v��߾Ϸ��v��0C%��Y�<
����9�����Clhó|�E����QͭҾ����k��+�������M�K���y��ߜ`90ܻ�0��= &Cx!+�o�9n���b�@�?���:���:�VTMP�<U���LR����l6�?� ��      �   �  x�%�K�e�
��u���B������p?vv*�"IX�=ƶ2�M��H�ב�������3�����m�l��Z�^I/�y��ݭP�V~*^Ҷ�R��OOF�ò���ڤ�ԫ����/�+�V+'ͬ��\�kBw��<S]Gx۸i�QS��z�[δ(�'�l�<o;�%�t�fy��rZ���r���c椬�d�iZw�3��S����w�6{N��K[5�3�j�f�/ަ>��R�]R��n���b��j91�S)[g��E��8i�iI_��[r���>����.��M϶���M�]Tf���u�4�p����ޘ.���i�����ΖdܞZ�̲�Q�}_�#�mg�voI�)q�ө�o*r�L���*�Ԓ�T���m̭6y��JY�%�VgZ�,K�Mִ�R����N�Ӷ��a�N^�͵s�,�q� t;�w��S����xW״�{Zu�c����α��e�dY�8o�}늹�r����� �r)�ͥ�.s�YeWo����V�~�@��!�4�+�x�=HX�P��Nk���G�<�\�<��\%�3�fR���C���BV� Wt*7`	��o�ih[l!���{R���3o���gw?��d�d�豅JY��W$������}	l9�c��RV$��*����fm�#pD�K-�j�ySzw�$)o�I�i��W ���{;w�۲�8M�+-�)�i���HSx%g�(S�wF�BEvZR1�n�ӾK�VU�y�q�L��<&/аs�eu�sB����FG�7�����i:Jg ~-�����&��{���`�[:��&ǂT3�t��je�i�uK ����������O�
i��BToڲk���D,�,�u��sIh�sh������.��Nϫ�OO��-'m0��ԶkG�N��{���P$Vs�y�k�f_���B4�|�6.I:���j��I������3@Z�i�=�ј�EY���v�mR���?Wg���H�̢��>����Φ�����Q��:�� �i!��@�����}��*-��	?�#/��S
�ϳ�-ucn\�g�Id�]���(��c	�f3� 3q�H���~�y1��xӱ��a������{���
�ʉ\�(�͜�;����=����s��n��(R�XE��M�D�2e�v��rzt2�%�yt�vs��lr"W�n.=kr�����RG�vD�#��R�H�MQ,z��zwʌ]��|bY%��/�]k���6T��d�'�����h�S�~kq)����q'GH���$� �Ǣ���q~Rw`	8)�vG~�����(�́vVO�Hb}���k/.���9��;�i~l�u�E/ؾ-�|���:Jd$CO\�|��f��D"	a����HHV!y������_x��� ��Q�v���*�0v�������A�|gt��u&9�%;�*)���,/e�7��Un�~5�|�s?h���R��{C�u��֧̿2~�e9���e9��훡�w?��톨�BJ���B2_C8:�x[�܁I����l���	�LrHQ�0{)�p����3R��&�B`���^@p�q��JD[76&�V�c�22�;��V����&�:��3�;%��Q�+\z���'�:����l�����2:=-����NE�z*Q�%�t����^�Pmğ�O�NA�,�#��
7?�!��8�3�(L�ʑ�ǨAw�=c���ŕ������F�X�#�i}�a��Ė��� ��=�^�4�M�i���&H`(�<_�ɿ24{�C�B� �kX"u]"�Ǝ�U�;��I�G���td��RƎ22f͗�N�㴇׿\��1E(s��&
���S
�$E�X�E[��2�߻��#(o��UKw���E��\@��T���%��(#U�`o���W	Շ4[&�|��)�%��c��T���MB8.B $�GY���d$��:���j	_|t�@�y 8e2�1�x�_:Y�2���+n_��vvO�8�_��ۗg�72`Sx
�Y���0>��I$>"�2]L�20����^�/���Id&I�(����fuп�ݬ���\#��2���(���3�2�����Y�.��pO�Ӫ�����tԭ��-⃱O"A�r����2�l����`�CFR���ѡf�W6�]��cY�7b���~�-�W!7-h,�oġ��:�8��CYw� l�x����	"��g��᱅�����og�^�������R\�h�6�|�K����͈�\o�������I��      �   7   x�3�t.-PN-�L-�2�H���,��	s:%���&�)��&g�$b���� M��      �   	  x��XYS�X~V~�~ ����HHw��!ɄL3S5/w9�*d)%�Y���'�`��z�������-�\������3��aQ�̬�qB["�>���[�uT߬�Ҹ�JT�ǟ����Y����V+���_7�8WJU_Ɩ}����?���6�WļI�i!�E�%���&���u���c�տ���}�:t���3���8�W�w�v�ۼ ?��V���a��/c��o�BH�+�-Ӂ,�I,ikIzI��r�n�&���i��ן�X��a=����<�����/��8�-v�����>���J�|b�sf���%"3!k#�Ɩ�v�R߶�Pڼ�n����>N��8���X��܁�;��Bl Mu��QP�e<*�<�bQ���!8ԠzNC��;{K1/��_�al�6]u���t)��f�Lڔ<��0�mH^fR<��m�wC��/w�T�������YįT�#
��K>��2�ŰD�1Qi�U�T�Ï�<oK�x�x�����3$D�&����,�l45)�Fg�K���F�i?4���)a\N�O�&g)-KyN'Y�<��jo]�F��z;��i�����:���"1iQ"%3*!T��EO�H))XY]��}\���+�s5��G��M�0����fNcAI��l#7S�s���7G�BN�#a�_�2��1���j����a�����7�[�@4~���6ܫ��Ʃ�W[v��h��<g���x����D�#�����V*9�(��b.&O�D:��	]=o���3��GQ�e��g
��Ne37I�,EJ��+9��	�O��*�lp�������I�=�� ^��R���_���In�/�	�6�R���,	�O-��۱&(E�LIBU7C?,�Л�3h�6ø�8��2��^	Ü!�e9g^5�51&i���Q��P��v�j�j�F��ߗ��R��~��<���y2p�^z�J�vV�؁1Jܑ�AG��O�����>ŋoC_��bl�v����Z%� ���(#�af.����cS]�c^�@���ӂ�%�`�Uu�^(3����M����o�L�7gN�#R0��!��)Q:B����=ïs1og]}m���c9�ZY���
�p�^����M���*W3�?F�@����3�; 8Kp��,X �4���2�@XpP��F��O4�qjq�=|MB��8�5'�+��TXx&�@j1	��H�%U���y�O����՟0g�'p��g�-��Z,��t��'$�ӌgN.F^l��ƼX���h���dy��� ��B�)X�%�y��g�t���?0����[\~}h�{mk�ON�Wޚ�"s^Gk�64�)D�ec�ly���'��v���'ﾹ-���`-�1m���[��=�"@�K�X�.>���s ��).���T}0JG7\bf QKh w��൑n��-����p�S}�A%��
��j���s�O�O�d�HGY̦�~:�^(�&Y�i��?�������!r��y����J*�KȂ�6�p���%�d*F'L�[�ߏ��	�^V��v�M.a�/w�)������?Ƹ�43J��*LH��XZ�NC��P�F#�XJp�ޭ��([�à���m�t���c�=u�-��� �(M�I��
�'��Q�o 3�K�{rB��Ɉ�	�w��g ��j�`�[�{عE\:����G�9�L��4���e�v)rQ�A��߆%�&��۸l`���9�q���S�<j���lP����x��F��e�s���Y}3�_�x��=0[��,���`�Ԁmf:�B�]���%VTq�f�m���}:��$��������M����*�$<f��0��e�N��
폘�׹+Y�P3c:>�LK	54�a�x%�q�fn��Vi��}v���`S?�E�6x�Y����r&�!(1����*����������7����H��Q��^���}pu&f%�*�#�[�i �-��	;N�S}���6L�HwC�w�֝��y$N0��C�t��؊7jgUF��ɟ#^�	�5��:�����g�x"��O�	>����v�ػ���eN�ɗv�9�#Q��J G�m���;�ǥ(�E)��IY��	��ߣ�O���&���~�����6R� �p/�L��¢�s���}��{B�mG�-������3Eǒ#�w,���ch���)	k�QX̰6_��w�8���:9�
���p� ��**� �4U�o4>o���Y����=�v,��$���$�wz�O� "P�F�bHcV�EG3��i	b&.睓 �w_��q����7o��i^n     