-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 17-02-2025 a las 16:17:42
-- Versión del servidor: 10.11.10-MariaDB
-- Versión de PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `u395713662_wispomg`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ap_clientes`
--

CREATE TABLE `ap_clientes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `ip` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `version` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ap_emisor`
--

CREATE TABLE `ap_emisor` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `ip` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `version` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ap_receptor`
--

CREATE TABLE `ap_receptor` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `ip` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `version` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `archivos`
--

CREATE TABLE `archivos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo` varchar(100) DEFAULT NULL,
  `size` int(11) NOT NULL,
  `ruta` text NOT NULL,
  `tabla` varchar(100) NOT NULL,
  `object_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `backups`
--

CREATE TABLE `backups` (
  `id` bigint(10) NOT NULL,
  `archive` varchar(100) NOT NULL,
  `size` varchar(50) NOT NULL,
  `registration_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- Volcado de datos para la tabla `backups`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bills`
--

CREATE TABLE `bills` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `clientid` bigint(10) NOT NULL,
  `voucherid` bigint(10) NOT NULL,
  `serieid` bigint(10) NOT NULL,
  `internal_code` varchar(50) NOT NULL,
  `correlative` bigint(5) NOT NULL,
  `date_issue` date NOT NULL,
  `expiration_date` date NOT NULL,
  `billed_month` date NOT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  `discount` decimal(12,2) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `amount_paid` decimal(12,2) NOT NULL,
  `remaining_amount` decimal(12,2) NOT NULL,
  `type` bigint(1) NOT NULL,
  `sales_method` bigint(1) NOT NULL,
  `observation` text NOT NULL,
  `state` bigint(1) NOT NULL DEFAULT 2,
  `compromise_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `business`
--

CREATE TABLE `business` (
  `id` bigint(10) NOT NULL,
  `documentid` bigint(10) NOT NULL,
  `ruc` char(20) NOT NULL,
  `business_name` varchar(100) NOT NULL,
  `tradename` varchar(100) NOT NULL,
  `slogan` text NOT NULL,
  `mobile` varchar(9) NOT NULL,
  `mobile_refrence` varchar(9) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `server_host` varchar(200) NOT NULL,
  `port` varchar(50) NOT NULL,
  `address` text NOT NULL,
  `department` varchar(100) NOT NULL,
  `province` varchar(100) NOT NULL,
  `district` varchar(100) NOT NULL,
  `ubigeo` char(6) NOT NULL,
  `footer_text` text NOT NULL,
  `currencyid` bigint(10) NOT NULL,
  `print_format` varchar(100) NOT NULL,
  `logotyope` varchar(200) NOT NULL,
  `logo_login` varchar(200) NOT NULL,
  `logo_email` varchar(1000) NOT NULL,
  `favicon` varchar(200) NOT NULL,
  `country_code` varchar(20) NOT NULL,
  `google_apikey` text NOT NULL,
  `reniec_apikey` text NOT NULL,
  `background` varchar(100) NOT NULL,
  `whatsapp_api` varchar(100) DEFAULT NULL,
  `whatsapp_key` varchar(100) DEFAULT NULL,
  `mikrotik_endpoint` varchar(100) DEFAULT NULL,
  `mikrotik_token` varchar(100) DEFAULT NULL,
  `mikrotik_client` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- Volcado de datos para la tabla `business`
--

INSERT INTO `business` (`id`, `documentid`, `ruc`, `business_name`, `tradename`, `slogan`, `mobile`, `mobile_refrence`, `email`, `password`, `server_host`, `port`, `address`, `department`, `province`, `district`, `ubigeo`, `footer_text`, `currencyid`, `print_format`, `logotyope`, `logo_login`, `logo_email`, `favicon`, `country_code`, `google_apikey`, `reniec_apikey`, `background`, `whatsapp_api`, `whatsapp_key`, `mikrotik_endpoint`, `mikrotik_token`, `mikrotik_client`) VALUES
(1, 3, '20609021331', 'GLOBAL SERVICE S&N S.A.C', 'GLOBAL SERVICE S&N S.A.C', 'LA TECNOLOGÍA A TU ALCANCE', '950298219', '927506692', 'globalsn.telecom@gmail.com', 'pqeczbtqpzdxukrp', 'smtp.gmail.com', '465', 'HUANUCO-HUAMALIES-MONZON JR. TINGO MARIA S/N', 'HUANUCO', 'HUAMALIES', 'MONZON', '000000', '<p style=\"text-align: center;\"><span style=\"font-family: georgia, palatino, serif;\"><strong>FORMA DE PAGO AUTORIZADO:</strong></span></p>\r\n<p style=\"text-align: center;\"><strong>YAPE: 927506692<br />PLIN: 927506692<br />TITULAR: GLOBAL SERVICE S&amp;N SAC<br /></strong><strong>________________________________________</strong></p>\r\n<p style=\"text-align: center;\"><strong>BCP: 560-1507574084<br />&nbsp; &nbsp;CCI: 002-560-001507574084-13<br />TITULAR: GLOBAL SERVICE S&amp;N SAC</strong></p>\r\n<p style=\"text-align: center;\"><br /><strong>________________________________________</strong></p>\r\n<p style=\"text-align: center;\"><strong>Banco de la Naci&oacute;n: 04-580-416794</strong><br /><strong>&nbsp; &nbsp;CCI: 018-580-004580416794-13</strong><br /><strong>TITULAR: JORVING JHOEL NIETO SILVA</strong><br /><strong>________________________________________</strong></p>\r\n<p style=\"text-align: center;\"><strong>&iexcl;Paga puntual tu recibo!, evita el corte del servicio.</strong><br /><strong>GRACIAS POR SU PREFERENCIA</strong><br /><strong>Telefono De Soporte: 950298219 / 927506692</strong></p>', 1, 'a4', 'logo_c03e91b4137d57f566cf83555043ebb0.png', 'login_e6d34699ec0a11a08e09a50fa66383df.png', 'https://i.ibb.co/vVkJNZ7/logowisp.png', 'favicon_21a32d1f3868c6a1b2b2ca46fafd1dc3.ico', '52', 'AIzaSyDBXDtzDIktV3TC_75Jk13EJFjfcF-KnvQ', 'affea70cbb536d5e85852e2b78181521a12a3fb1a043e8ad8ce426152a11be47', 'bg-2.jpeg', 'https://api.then.net.pe', 'kOBG8RxIyLqrok1', 'https://mikrotik.novedadesfamel.org.pe/api', '260da1f3-29eb-4d5b-912d-bbe75ae51d76', 'https://wispglobal.netlify.app');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caja_nap`
--

CREATE TABLE `caja_nap` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `longitud` varchar(100) NOT NULL,
  `latitud` varchar(100) NOT NULL,
  `puertos` int(11) NOT NULL,
  `detalles` varchar(100) NOT NULL,
  `ubicacion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caja_nap_clientes`
--

CREATE TABLE `caja_nap_clientes` (
  `id` int(11) NOT NULL,
  `puerto` int(11) NOT NULL,
  `nap_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clients`
--

CREATE TABLE `clients` (
  `id` bigint(10) NOT NULL,
  `names` varchar(100) NOT NULL,
  `surnames` varchar(100) NOT NULL,
  `documentid` bigint(10) NOT NULL,
  `document` varchar(15) NOT NULL,
  `mobile` varchar(10) NOT NULL,
  `mobile_optional` varchar(15) NOT NULL,
  `zona` varchar(30) NOT NULL,
  `email` varchar(100) NOT NULL,
  `address` text NOT NULL,
  `reference` text NOT NULL,
  `latitud` varchar(50) NOT NULL,
  `longitud` varchar(50) NOT NULL,
  `ap_cliente_id` int(11) DEFAULT NULL,
  `state` bigint(1) NOT NULL DEFAULT 1,
  `nap_cliente_id` int(11) DEFAULT NULL,
  `opcion` enum('NINGUNO','WISP','ISP','PPOE') DEFAULT 'NINGUNO',
  `ppoe_usuario` varchar(100) DEFAULT NULL,
  `ppoe_password` varchar(100) DEFAULT NULL,
  `route_ssid` varchar(255) DEFAULT NULL,
  `route_password` varchar(255) DEFAULT NULL,
  `route_cred_user` varchar(255) DEFAULT NULL,
  `route_cred_password` varchar(255) DEFAULT NULL,
  `mikrotik` varchar(250) DEFAULT NULL,
  `mikrotik_referen` varchar(100) DEFAULT NULL,
  `corte_firewall` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contracts`
--

CREATE TABLE `contracts` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `clientid` bigint(10) NOT NULL,
  `internal_code` varchar(50) NOT NULL,
  `payday` bigint(5) NOT NULL,
  `create_invoice` bigint(5) NOT NULL,
  `days_grace` bigint(5) NOT NULL,
  `discount` bigint(1) NOT NULL,
  `discount_price` decimal(12,2) NOT NULL,
  `months_discount` bigint(5) NOT NULL,
  `remaining_discount` bigint(5) NOT NULL,
  `contract_date` datetime NOT NULL,
  `suspension_date` date NOT NULL,
  `finish_date` date NOT NULL,
  `state` bigint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `currency`
--

CREATE TABLE `currency` (
  `id` bigint(10) NOT NULL,
  `currency_iso` varchar(3) NOT NULL,
  `language` varchar(3) NOT NULL,
  `currency_name` varchar(50) NOT NULL,
  `money` varchar(30) NOT NULL,
  `money_plural` varchar(50) NOT NULL,
  `symbol` varchar(3) NOT NULL,
  `registration_date` datetime NOT NULL,
  `state` bigint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- Volcado de datos para la tabla `currency`
--

INSERT INTO `currency` (`id`, `currency_iso`, `language`, `currency_name`, `money`, `money_plural`, `symbol`, `registration_date`, `state`) VALUES
(1, 'PES', 'ES', 'PESO MEXICANO', 'PESO', 'PESOS', '$', '2023-06-13 19:57:37', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departures`
--

CREATE TABLE `departures` (
  `id` bigint(10) NOT NULL,
  `billid` bigint(10) NOT NULL,
  `productid` bigint(10) NOT NULL,
  `departure_date` datetime NOT NULL,
  `description` varchar(200) NOT NULL,
  `quantity_departures` bigint(5) NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `total_cost` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detail_bills`
--

CREATE TABLE `detail_bills` (
  `id` bigint(10) NOT NULL,
  `billid` bigint(10) NOT NULL,
  `type` bigint(1) NOT NULL,
  `serproid` bigint(5) NOT NULL,
  `description` text NOT NULL,
  `quantity` bigint(5) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `total` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detail_contracts`
--

CREATE TABLE `detail_contracts` (
  `id` bigint(10) NOT NULL,
  `contractid` bigint(10) NOT NULL,
  `serviceid` bigint(10) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `registration_date` datetime NOT NULL,
  `state` bigint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detail_facility`
--

CREATE TABLE `detail_facility` (
  `id` bigint(10) NOT NULL,
  `facilityid` bigint(10) NOT NULL,
  `technicalid` bigint(10) NOT NULL,
  `opening_date` datetime NOT NULL,
  `closing_date` datetime NOT NULL,
  `comment` text NOT NULL,
  `state` bigint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `document_type`
--

CREATE TABLE `document_type` (
  `id` bigint(10) NOT NULL,
  `document` varchar(100) NOT NULL,
  `maxlength` int(2) NOT NULL DEFAULT 8,
  `is_required` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- Volcado de datos para la tabla `document_type`
--

INSERT INTO `document_type` (`id`, `document`, `maxlength`, `is_required`) VALUES
(1, 'SIN DOCUMENTO', 8, 0),
(2, 'DNI', 8, 1),
(3, 'RUC', 11, 1),
(4, 'CARNET DE EXTRANJERIA', 20, 0),
(5, 'PASAPORTE', 20, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emails`
--

CREATE TABLE `emails` (
  `id` bigint(10) NOT NULL,
  `clientid` bigint(10) NOT NULL,
  `billid` bigint(10) NOT NULL,
  `affair` varchar(500) NOT NULL,
  `sender` varchar(200) NOT NULL,
  `files` varchar(10) NOT NULL,
  `type_file` varchar(100) NOT NULL,
  `template_email` varchar(100) NOT NULL,
  `registration_date` datetime NOT NULL,
  `state` bigint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facility`
--

CREATE TABLE `facility` (
  `id` bigint(10) NOT NULL,
  `clientid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `technical` bigint(10) NOT NULL,
  `attention_date` datetime NOT NULL,
  `opening_date` datetime NOT NULL,
  `closing_date` datetime NOT NULL,
  `cost` decimal(12,2) NOT NULL,
  `detail` text NOT NULL,
  `registration_date` datetime NOT NULL,
  `state` bigint(1) NOT NULL DEFAULT 2
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `forms_payment`
--

CREATE TABLE `forms_payment` (
  `id` bigint(10) NOT NULL,
  `payment_type` varchar(500) NOT NULL,
  `registration_date` datetime NOT NULL,
  `state` bigint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- Volcado de datos para la tabla `forms_payment`
--

INSERT INTO `forms_payment` (`id`, `payment_type`, `registration_date`, `state`) VALUES
(1, 'EFECTIVO', '2023-06-13 21:50:55', 1),
(2, 'DEPOSITO EN CUENTA', '2023-06-23 15:19:52', 1),
(3, 'TRANSFERENCIA', '2023-06-23 15:19:58', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gallery_images`
--

CREATE TABLE `gallery_images` (
  `id` bigint(10) NOT NULL,
  `clientid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `type` bigint(1) NOT NULL,
  `typeid` bigint(10) NOT NULL,
  `registration_date` datetime NOT NULL,
  `image` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `incidents`
--

CREATE TABLE `incidents` (
  `id` bigint(10) NOT NULL,
  `incident` varchar(500) NOT NULL,
  `registration_date` datetime NOT NULL,
  `state` bigint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `income`
--

CREATE TABLE `income` (
  `id` bigint(10) NOT NULL,
  `productid` bigint(10) NOT NULL,
  `income_date` datetime NOT NULL,
  `description` varchar(200) NOT NULL,
  `quantity_income` bigint(5) NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `total_cost` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ips`
--

CREATE TABLE `ips` (
  `id` varchar(15) NOT NULL,
  `grupo` varchar(100) NOT NULL,
  `estado` enum('LIBRE','OCUPADO') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ips`
--

INSERT INTO `ips` (`id`, `grupo`, `estado`) VALUES
('192.168.80.10', '192.168.80', 'LIBRE'),
('192.168.80.100', '192.168.80', 'LIBRE'),
('192.168.80.101', '192.168.80', 'LIBRE'),
('192.168.80.102', '192.168.80', 'LIBRE'),
('192.168.80.103', '192.168.80', 'LIBRE'),
('192.168.80.104', '192.168.80', 'LIBRE'),
('192.168.80.105', '192.168.80', 'LIBRE'),
('192.168.80.106', '192.168.80', 'LIBRE'),
('192.168.80.107', '192.168.80', 'LIBRE'),
('192.168.80.108', '192.168.80', 'LIBRE'),
('192.168.80.109', '192.168.80', 'LIBRE'),
('192.168.80.11', '192.168.80', 'LIBRE'),
('192.168.80.110', '192.168.80', 'LIBRE'),
('192.168.80.111', '192.168.80', 'LIBRE'),
('192.168.80.112', '192.168.80', 'LIBRE'),
('192.168.80.113', '192.168.80', 'LIBRE'),
('192.168.80.114', '192.168.80', 'LIBRE'),
('192.168.80.115', '192.168.80', 'LIBRE'),
('192.168.80.116', '192.168.80', 'LIBRE'),
('192.168.80.117', '192.168.80', 'LIBRE'),
('192.168.80.118', '192.168.80', 'LIBRE'),
('192.168.80.119', '192.168.80', 'LIBRE'),
('192.168.80.12', '192.168.80', 'LIBRE'),
('192.168.80.120', '192.168.80', 'LIBRE'),
('192.168.80.121', '192.168.80', 'LIBRE'),
('192.168.80.122', '192.168.80', 'LIBRE'),
('192.168.80.123', '192.168.80', 'LIBRE'),
('192.168.80.124', '192.168.80', 'LIBRE'),
('192.168.80.125', '192.168.80', 'LIBRE'),
('192.168.80.126', '192.168.80', 'LIBRE'),
('192.168.80.127', '192.168.80', 'LIBRE'),
('192.168.80.128', '192.168.80', 'LIBRE'),
('192.168.80.129', '192.168.80', 'LIBRE'),
('192.168.80.13', '192.168.80', 'LIBRE'),
('192.168.80.130', '192.168.80', 'LIBRE'),
('192.168.80.131', '192.168.80', 'LIBRE'),
('192.168.80.132', '192.168.80', 'LIBRE'),
('192.168.80.133', '192.168.80', 'LIBRE'),
('192.168.80.134', '192.168.80', 'LIBRE'),
('192.168.80.135', '192.168.80', 'LIBRE'),
('192.168.80.136', '192.168.80', 'LIBRE'),
('192.168.80.137', '192.168.80', 'LIBRE'),
('192.168.80.138', '192.168.80', 'LIBRE'),
('192.168.80.139', '192.168.80', 'LIBRE'),
('192.168.80.14', '192.168.80', 'LIBRE'),
('192.168.80.140', '192.168.80', 'LIBRE'),
('192.168.80.141', '192.168.80', 'LIBRE'),
('192.168.80.142', '192.168.80', 'LIBRE'),
('192.168.80.143', '192.168.80', 'LIBRE'),
('192.168.80.144', '192.168.80', 'LIBRE'),
('192.168.80.145', '192.168.80', 'LIBRE'),
('192.168.80.146', '192.168.80', 'LIBRE'),
('192.168.80.147', '192.168.80', 'LIBRE'),
('192.168.80.148', '192.168.80', 'LIBRE'),
('192.168.80.149', '192.168.80', 'LIBRE'),
('192.168.80.15', '192.168.80', 'LIBRE'),
('192.168.80.150', '192.168.80', 'LIBRE'),
('192.168.80.151', '192.168.80', 'LIBRE'),
('192.168.80.152', '192.168.80', 'LIBRE'),
('192.168.80.153', '192.168.80', 'LIBRE'),
('192.168.80.154', '192.168.80', 'LIBRE'),
('192.168.80.155', '192.168.80', 'LIBRE'),
('192.168.80.156', '192.168.80', 'LIBRE'),
('192.168.80.157', '192.168.80', 'LIBRE'),
('192.168.80.158', '192.168.80', 'LIBRE'),
('192.168.80.159', '192.168.80', 'LIBRE'),
('192.168.80.16', '192.168.80', 'LIBRE'),
('192.168.80.160', '192.168.80', 'LIBRE'),
('192.168.80.161', '192.168.80', 'LIBRE'),
('192.168.80.162', '192.168.80', 'LIBRE'),
('192.168.80.163', '192.168.80', 'LIBRE'),
('192.168.80.164', '192.168.80', 'LIBRE'),
('192.168.80.165', '192.168.80', 'LIBRE'),
('192.168.80.166', '192.168.80', 'LIBRE'),
('192.168.80.167', '192.168.80', 'LIBRE'),
('192.168.80.168', '192.168.80', 'LIBRE'),
('192.168.80.169', '192.168.80', 'LIBRE'),
('192.168.80.17', '192.168.80', 'LIBRE'),
('192.168.80.170', '192.168.80', 'LIBRE'),
('192.168.80.171', '192.168.80', 'LIBRE'),
('192.168.80.172', '192.168.80', 'LIBRE'),
('192.168.80.173', '192.168.80', 'LIBRE'),
('192.168.80.174', '192.168.80', 'LIBRE'),
('192.168.80.175', '192.168.80', 'LIBRE'),
('192.168.80.176', '192.168.80', 'LIBRE'),
('192.168.80.177', '192.168.80', 'LIBRE'),
('192.168.80.178', '192.168.80', 'LIBRE'),
('192.168.80.179', '192.168.80', 'LIBRE'),
('192.168.80.18', '192.168.80', 'LIBRE'),
('192.168.80.180', '192.168.80', 'LIBRE'),
('192.168.80.181', '192.168.80', 'LIBRE'),
('192.168.80.182', '192.168.80', 'LIBRE'),
('192.168.80.183', '192.168.80', 'LIBRE'),
('192.168.80.184', '192.168.80', 'LIBRE'),
('192.168.80.185', '192.168.80', 'LIBRE'),
('192.168.80.186', '192.168.80', 'LIBRE'),
('192.168.80.187', '192.168.80', 'LIBRE'),
('192.168.80.188', '192.168.80', 'LIBRE'),
('192.168.80.189', '192.168.80', 'LIBRE'),
('192.168.80.19', '192.168.80', 'LIBRE'),
('192.168.80.2', '192.168.80', 'LIBRE'),
('192.168.80.20', '192.168.80', 'LIBRE'),
('192.168.80.21', '192.168.80', 'LIBRE'),
('192.168.80.22', '192.168.80', 'LIBRE'),
('192.168.80.23', '192.168.80', 'LIBRE'),
('192.168.80.24', '192.168.80', 'LIBRE'),
('192.168.80.25', '192.168.80', 'LIBRE'),
('192.168.80.26', '192.168.80', 'LIBRE'),
('192.168.80.27', '192.168.80', 'LIBRE'),
('192.168.80.28', '192.168.80', 'LIBRE'),
('192.168.80.29', '192.168.80', 'LIBRE'),
('192.168.80.3', '192.168.80', 'LIBRE'),
('192.168.80.30', '192.168.80', 'LIBRE'),
('192.168.80.31', '192.168.80', 'LIBRE'),
('192.168.80.32', '192.168.80', 'LIBRE'),
('192.168.80.33', '192.168.80', 'LIBRE'),
('192.168.80.34', '192.168.80', 'LIBRE'),
('192.168.80.35', '192.168.80', 'LIBRE'),
('192.168.80.36', '192.168.80', 'LIBRE'),
('192.168.80.37', '192.168.80', 'LIBRE'),
('192.168.80.38', '192.168.80', 'LIBRE'),
('192.168.80.39', '192.168.80', 'LIBRE'),
('192.168.80.4', '192.168.80', 'LIBRE'),
('192.168.80.40', '192.168.80', 'LIBRE'),
('192.168.80.41', '192.168.80', 'LIBRE'),
('192.168.80.42', '192.168.80', 'LIBRE'),
('192.168.80.43', '192.168.80', 'LIBRE'),
('192.168.80.44', '192.168.80', 'LIBRE'),
('192.168.80.45', '192.168.80', 'LIBRE'),
('192.168.80.46', '192.168.80', 'LIBRE'),
('192.168.80.47', '192.168.80', 'LIBRE'),
('192.168.80.48', '192.168.80', 'LIBRE'),
('192.168.80.49', '192.168.80', 'LIBRE'),
('192.168.80.5', '192.168.80', 'LIBRE'),
('192.168.80.50', '192.168.80', 'LIBRE'),
('192.168.80.51', '192.168.80', 'LIBRE'),
('192.168.80.52', '192.168.80', 'LIBRE'),
('192.168.80.53', '192.168.80', 'LIBRE'),
('192.168.80.54', '192.168.80', 'LIBRE'),
('192.168.80.55', '192.168.80', 'LIBRE'),
('192.168.80.56', '192.168.80', 'LIBRE'),
('192.168.80.57', '192.168.80', 'LIBRE'),
('192.168.80.58', '192.168.80', 'LIBRE'),
('192.168.80.59', '192.168.80', 'LIBRE'),
('192.168.80.6', '192.168.80', 'LIBRE'),
('192.168.80.60', '192.168.80', 'LIBRE'),
('192.168.80.61', '192.168.80', 'LIBRE'),
('192.168.80.62', '192.168.80', 'LIBRE'),
('192.168.80.63', '192.168.80', 'LIBRE'),
('192.168.80.64', '192.168.80', 'LIBRE'),
('192.168.80.65', '192.168.80', 'LIBRE'),
('192.168.80.66', '192.168.80', 'LIBRE'),
('192.168.80.67', '192.168.80', 'LIBRE'),
('192.168.80.68', '192.168.80', 'LIBRE'),
('192.168.80.69', '192.168.80', 'LIBRE'),
('192.168.80.7', '192.168.80', 'LIBRE'),
('192.168.80.70', '192.168.80', 'LIBRE'),
('192.168.80.71', '192.168.80', 'LIBRE'),
('192.168.80.72', '192.168.80', 'LIBRE'),
('192.168.80.73', '192.168.80', 'LIBRE'),
('192.168.80.74', '192.168.80', 'LIBRE'),
('192.168.80.75', '192.168.80', 'LIBRE'),
('192.168.80.76', '192.168.80', 'LIBRE'),
('192.168.80.77', '192.168.80', 'LIBRE'),
('192.168.80.78', '192.168.80', 'LIBRE'),
('192.168.80.79', '192.168.80', 'LIBRE'),
('192.168.80.8', '192.168.80', 'LIBRE'),
('192.168.80.80', '192.168.80', 'LIBRE'),
('192.168.80.81', '192.168.80', 'LIBRE'),
('192.168.80.82', '192.168.80', 'LIBRE'),
('192.168.80.83', '192.168.80', 'LIBRE'),
('192.168.80.84', '192.168.80', 'LIBRE'),
('192.168.80.85', '192.168.80', 'LIBRE'),
('192.168.80.86', '192.168.80', 'LIBRE'),
('192.168.80.87', '192.168.80', 'LIBRE'),
('192.168.80.88', '192.168.80', 'LIBRE'),
('192.168.80.89', '192.168.80', 'LIBRE'),
('192.168.80.9', '192.168.80', 'LIBRE'),
('192.168.80.90', '192.168.80', 'LIBRE'),
('192.168.80.91', '192.168.80', 'LIBRE'),
('192.168.80.92', '192.168.80', 'LIBRE'),
('192.168.80.93', '192.168.80', 'LIBRE'),
('192.168.80.94', '192.168.80', 'LIBRE'),
('192.168.80.95', '192.168.80', 'LIBRE'),
('192.168.80.96', '192.168.80', 'LIBRE'),
('192.168.80.97', '192.168.80', 'LIBRE'),
('192.168.80.98', '192.168.80', 'LIBRE'),
('192.168.80.99', '192.168.80', 'LIBRE');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modules`
--

CREATE TABLE `modules` (
  `id` bigint(10) NOT NULL,
  `module` varchar(100) NOT NULL,
  `state` bigint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- Volcado de datos para la tabla `modules`
--

INSERT INTO `modules` (`id`, `module`, `state`) VALUES
(1, 'Dashboard', 1),
(2, 'Clientes', 1),
(3, 'Usuarios', 1),
(4, 'Tickets', 1),
(5, 'Incidencias', 1),
(6, 'Facturas', 1),
(7, 'Productos', 1),
(8, 'Categorias', 1),
(9, 'Proveedores', 1),
(10, 'Pagos', 1),
(11, 'Servicios', 1),
(12, 'Empresa', 1),
(13, 'Instalaciones', 1),
(14, 'Divisas', 1),
(15, 'Formas de pago', 1),
(16, 'Comprobantes', 1),
(17, 'Unidades', 1),
(18, 'Correos', 1),
(19, 'Gestión de Red', 1),
(20, 'Campaña', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `otros_ingresos`
--

CREATE TABLE `otros_ingresos` (
  `id` int(11) NOT NULL,
  `tipo` enum('INGRESO','EGRESO') NOT NULL,
  `fecha` date DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `monto` decimal(12,2) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `state` enum('NORMAL','PENDIENTE','PAGADO') NOT NULL DEFAULT 'NORMAL'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `payments`
--

CREATE TABLE `payments` (
  `id` bigint(10) NOT NULL,
  `billid` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `clientid` bigint(10) NOT NULL,
  `internal_code` varchar(50) NOT NULL,
  `paytypeid` bigint(10) NOT NULL,
  `payment_date` datetime NOT NULL,
  `comment` text NOT NULL,
  `amount_paid` decimal(12,2) NOT NULL,
  `amount_total` decimal(12,2) NOT NULL DEFAULT 0.00,
  `remaining_credit` decimal(12,2) NOT NULL DEFAULT 0.00,
  `state` bigint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permits`
--

CREATE TABLE `permits` (
  `id` bigint(10) NOT NULL,
  `profileid` bigint(10) NOT NULL,
  `moduleid` bigint(10) NOT NULL,
  `r` bigint(1) NOT NULL,
  `a` bigint(1) NOT NULL,
  `e` bigint(1) NOT NULL,
  `v` bigint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- Volcado de datos para la tabla `permits`
--

INSERT INTO `permits` (`id`, `profileid`, `moduleid`, `r`, `a`, `e`, `v`) VALUES
(37, 3, 1, 0, 0, 0, 1),
(38, 3, 2, 0, 0, 0, 0),
(39, 3, 3, 0, 0, 0, 0),
(40, 3, 4, 0, 0, 0, 0),
(41, 3, 5, 0, 0, 0, 0),
(42, 3, 6, 1, 0, 0, 1),
(43, 3, 7, 0, 0, 0, 0),
(44, 3, 8, 0, 0, 0, 0),
(45, 3, 9, 0, 0, 0, 0),
(46, 3, 10, 1, 0, 0, 1),
(47, 3, 11, 0, 0, 0, 0),
(48, 3, 12, 0, 0, 0, 0),
(49, 3, 13, 0, 0, 0, 0),
(50, 3, 14, 0, 0, 0, 0),
(51, 3, 15, 0, 0, 0, 0),
(52, 3, 16, 0, 0, 0, 0),
(53, 3, 17, 0, 0, 0, 0),
(54, 3, 18, 0, 0, 0, 0),
(55, 2, 1, 0, 0, 0, 1),
(56, 2, 2, 1, 1, 0, 1),
(57, 2, 3, 0, 0, 0, 0),
(58, 2, 4, 1, 1, 0, 1),
(59, 2, 5, 0, 0, 0, 0),
(60, 2, 6, 0, 0, 0, 0),
(61, 2, 7, 0, 0, 0, 0),
(62, 2, 8, 0, 0, 0, 0),
(63, 2, 9, 0, 0, 0, 0),
(64, 2, 10, 1, 0, 0, 1),
(65, 2, 11, 0, 0, 0, 0),
(66, 2, 12, 0, 0, 0, 0),
(67, 2, 13, 1, 1, 0, 1),
(68, 2, 14, 0, 0, 0, 0),
(69, 2, 15, 0, 0, 0, 0),
(70, 2, 16, 0, 0, 0, 0),
(71, 2, 17, 0, 0, 0, 0),
(72, 2, 18, 0, 0, 0, 0),
(351, 1, 1, 1, 1, 1, 1),
(352, 1, 2, 1, 1, 1, 1),
(353, 1, 3, 1, 1, 1, 1),
(354, 1, 4, 1, 1, 1, 1),
(355, 1, 5, 1, 1, 1, 1),
(356, 1, 6, 1, 1, 1, 1),
(357, 1, 7, 1, 1, 1, 1),
(358, 1, 8, 1, 1, 1, 1),
(359, 1, 9, 1, 1, 1, 1),
(360, 1, 10, 1, 1, 1, 1),
(361, 1, 11, 1, 1, 1, 1),
(362, 1, 12, 1, 1, 1, 1),
(363, 1, 13, 1, 1, 1, 1),
(364, 1, 14, 1, 1, 1, 1),
(365, 1, 15, 1, 1, 1, 1),
(366, 1, 16, 1, 1, 1, 1),
(367, 1, 17, 1, 1, 1, 1),
(368, 1, 18, 1, 1, 1, 1),
(369, 1, 19, 1, 1, 1, 1),
(370, 1, 20, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `products`
--

CREATE TABLE `products` (
  `id` bigint(10) NOT NULL,
  `internal_code` varchar(20) NOT NULL,
  `barcode` varchar(13) NOT NULL,
  `product` varchar(200) NOT NULL,
  `model` varchar(500) NOT NULL,
  `brand` varchar(500) NOT NULL,
  `extra_info` bigint(1) NOT NULL,
  `serial_number` varchar(50) NOT NULL,
  `mac` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `sale_price` decimal(12,2) NOT NULL,
  `purchase_price` decimal(12,2) NOT NULL,
  `stock` bigint(5) NOT NULL,
  `stock_alert` bigint(5) NOT NULL,
  `categoryid` bigint(10) NOT NULL,
  `unitid` bigint(10) NOT NULL,
  `providerid` bigint(10) NOT NULL,
  `image` text NOT NULL,
  `registration_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `product_category`
--

CREATE TABLE `product_category` (
  `id` bigint(10) NOT NULL,
  `category` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `registration_date` datetime NOT NULL,
  `state` bigint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profiles`
--

CREATE TABLE `profiles` (
  `id` bigint(10) NOT NULL,
  `profile` varchar(50) NOT NULL,
  `description` varchar(300) NOT NULL,
  `registration_date` datetime NOT NULL,
  `state` bigint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- Volcado de datos para la tabla `profiles`
--

INSERT INTO `profiles` (`id`, `profile`, `description`, `registration_date`, `state`) VALUES
(1, 'ADMINISTRADOR', 'ACCESOS A TODOS LOS MODULOS', '2023-06-13 15:51:53', 1),
(2, 'TECNICO', 'CLIENTES, TICKET Y COBRANZA, CON RESTRICCIONES', '2023-06-13 15:51:53', 1),
(3, 'COBRANZA', 'COBRANZA DE FACTURAS PENDIENTES', '2023-06-13 15:51:53', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `providers`
--

CREATE TABLE `providers` (
  `id` bigint(10) NOT NULL,
  `provider` varchar(200) NOT NULL,
  `documentid` bigint(10) NOT NULL,
  `document` varchar(15) NOT NULL,
  `mobile` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `address` text NOT NULL,
  `registration_date` datetime NOT NULL,
  `state` bigint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `p_campos`
--

CREATE TABLE `p_campos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `obligatorio` tinyint(1) DEFAULT NULL,
  `tablaId` int(11) DEFAULT NULL,
  `tipo` varchar(100) DEFAULT NULL,
  `campo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `p_tabla`
--

CREATE TABLE `p_tabla` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tabla` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `p_tabla`
--

INSERT INTO `p_tabla` (`id`, `nombre`, `tabla`) VALUES
(1, 'Ap Clientes', 'ap_clientes'),
(2, 'Ap Emisor', 'ap_emisor'),
(3, 'Ap Receptor', 'ap_receptor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `RouterOS`
--

CREATE TABLE `RouterOS` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `services`
--

CREATE TABLE `services` (
  `id` bigint(10) NOT NULL,
  `internal_code` varchar(20) NOT NULL,
  `service` varchar(200) NOT NULL,
  `type` bigint(1) NOT NULL,
  `rise` bigint(5) NOT NULL,
  `rise_type` varchar(50) NOT NULL,
  `descent` bigint(5) NOT NULL,
  `descent_type` varchar(50) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `details` text NOT NULL,
  `registration_date` datetime NOT NULL,
  `state` bigint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tickets`
--

CREATE TABLE `tickets` (
  `id` bigint(10) NOT NULL,
  `userid` bigint(10) NOT NULL,
  `clientid` bigint(10) NOT NULL,
  `technical` bigint(10) NOT NULL,
  `incidentsid` bigint(10) NOT NULL,
  `description` text NOT NULL,
  `priority` bigint(1) NOT NULL,
  `attention_date` datetime NOT NULL,
  `opening_date` datetime NOT NULL,
  `closing_date` datetime NOT NULL,
  `registration_date` datetime NOT NULL,
  `state` bigint(1) NOT NULL DEFAULT 2
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ticket_solution`
--

CREATE TABLE `ticket_solution` (
  `id` bigint(10) NOT NULL,
  `ticketid` bigint(10) NOT NULL,
  `technicalid` bigint(10) NOT NULL,
  `opening_date` datetime NOT NULL,
  `closing_date` datetime NOT NULL,
  `comment` text NOT NULL,
  `state` bigint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tools`
--

CREATE TABLE `tools` (
  `id` bigint(10) NOT NULL,
  `facilityid` bigint(10) NOT NULL,
  `productid` bigint(10) NOT NULL,
  `quantity` bigint(10) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `product_condition` varchar(100) NOT NULL,
  `serie` varchar(100) DEFAULT NULL,
  `mac` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unit`
--

CREATE TABLE `unit` (
  `id` bigint(10) NOT NULL,
  `code` varchar(5) NOT NULL,
  `united` varchar(50) NOT NULL,
  `registration_date` datetime NOT NULL,
  `state` bigint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- Volcado de datos para la tabla `unit`
--

INSERT INTO `unit` (`id`, `code`, `united`, `registration_date`, `state`) VALUES
(1, 'NIU', 'UNIDAD', '2023-06-13 21:03:40', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(10) NOT NULL,
  `names` varchar(100) NOT NULL,
  `surnames` varchar(100) NOT NULL,
  `documentid` bigint(10) NOT NULL,
  `document` varchar(15) NOT NULL,
  `mobile` varchar(10) NOT NULL,
  `email` varchar(200) NOT NULL,
  `profileid` bigint(10) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(100) NOT NULL,
  `token` varchar(100) NOT NULL,
  `image` varchar(200) NOT NULL,
  `registration_date` datetime NOT NULL,
  `state` bigint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `names`, `surnames`, `documentid`, `document`, `mobile`, `email`, `profileid`, `username`, `password`, `token`, `image`, `registration_date`, `state`) VALUES
(1, 'TU NOMBRE', 'TU APELLIDO', 2, '12345678', '999111222', 'tucorreo@gmail.com', 1, 'administrador', 'c3pHVGQzZEg1dHJxejZOOEF3NEVHUT09', '', 'profile_2ead195e3c5a55a4647c7deaee782e26.jpg', '2023-06-13 19:39:22', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vouchers`
--

CREATE TABLE `vouchers` (
  `id` bigint(10) NOT NULL,
  `voucher` varchar(100) NOT NULL,
  `registration_date` datetime NOT NULL,
  `state` bigint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- Volcado de datos para la tabla `vouchers`
--

INSERT INTO `vouchers` (`id`, `voucher`, `registration_date`, `state`) VALUES
(1, 'RECIBO', '2023-06-13 17:37:14', 1),
(2, 'FACTURA ELECTRONICA', '2023-06-13 18:06:12', 1),
(3, 'BOLETA ELECTRONICA', '2023-06-13 09:27:20', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `voucher_series`
--

CREATE TABLE `voucher_series` (
  `id` bigint(10) NOT NULL,
  `date` date NOT NULL,
  `serie` varchar(50) NOT NULL,
  `fromc` bigint(10) NOT NULL,
  `until` bigint(10) NOT NULL,
  `voucherid` bigint(10) NOT NULL,
  `available` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- Volcado de datos para la tabla `voucher_series`
--

INSERT INTO `voucher_series` (`id`, `date`, `serie`, `fromc`, `until`, `voucherid`, `available`) VALUES
(1, '2022-07-07', 'R001', 1, 1000000, 1, 1000000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zonas`
--

CREATE TABLE `zonas` (
  `id` bigint(10) NOT NULL,
  `nombre_zona` varchar(500) NOT NULL,
  `registration_date` datetime NOT NULL,
  `state` bigint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ap_clientes`
--
ALTER TABLE `ap_clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ap_emisor`
--
ALTER TABLE `ap_emisor`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ap_receptor`
--
ALTER TABLE `ap_receptor`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `archivos`
--
ALTER TABLE `archivos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `backups`
--
ALTER TABLE `backups`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `bills`
--
ALTER TABLE `bills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `serviceid` (`clientid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `voucherid` (`voucherid`),
  ADD KEY `serieid` (`serieid`);

--
-- Indices de la tabla `business`
--
ALTER TABLE `business`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documentid` (`documentid`),
  ADD KEY `currencyid` (`currencyid`);

--
-- Indices de la tabla `caja_nap`
--
ALTER TABLE `caja_nap`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `caja_nap_clientes`
--
ALTER TABLE `caja_nap_clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documentid` (`documentid`);

--
-- Indices de la tabla `contracts`
--
ALTER TABLE `contracts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid` (`userid`),
  ADD KEY `clientid` (`clientid`);

--
-- Indices de la tabla `currency`
--
ALTER TABLE `currency`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `departures`
--
ALTER TABLE `departures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `billid` (`billid`),
  ADD KEY `productid` (`productid`);

--
-- Indices de la tabla `detail_bills`
--
ALTER TABLE `detail_bills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `billid` (`billid`);

--
-- Indices de la tabla `detail_contracts`
--
ALTER TABLE `detail_contracts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contractid` (`contractid`),
  ADD KEY `serviceid` (`serviceid`);

--
-- Indices de la tabla `detail_facility`
--
ALTER TABLE `detail_facility`
  ADD PRIMARY KEY (`id`),
  ADD KEY `facilityid` (`facilityid`),
  ADD KEY `technicalid` (`technicalid`);

--
-- Indices de la tabla `document_type`
--
ALTER TABLE `document_type`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `emails`
--
ALTER TABLE `emails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clientid` (`clientid`),
  ADD KEY `billid` (`billid`);

--
-- Indices de la tabla `facility`
--
ALTER TABLE `facility`
  ADD PRIMARY KEY (`id`),
  ADD KEY `technicalid` (`userid`),
  ADD KEY `clientid` (`clientid`);

--
-- Indices de la tabla `forms_payment`
--
ALTER TABLE `forms_payment`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `gallery_images`
--
ALTER TABLE `gallery_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clientid` (`clientid`),
  ADD KEY `userid` (`userid`);

--
-- Indices de la tabla `incidents`
--
ALTER TABLE `incidents`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `income`
--
ALTER TABLE `income`
  ADD PRIMARY KEY (`id`),
  ADD KEY `productid` (`productid`);

--
-- Indices de la tabla `ips`
--
ALTER TABLE `ips`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `modules`
--
ALTER TABLE `modules`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `otros_ingresos`
--
ALTER TABLE `otros_ingresos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `billid` (`billid`),
  ADD KEY `clientid` (`clientid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `paytypeid` (`paytypeid`);

--
-- Indices de la tabla `permits`
--
ALTER TABLE `permits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `profileid` (`profileid`),
  ADD KEY `moduleid` (`moduleid`);

--
-- Indices de la tabla `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoryid` (`categoryid`),
  ADD KEY `unitid` (`unitid`),
  ADD KEY `providerid` (`providerid`);

--
-- Indices de la tabla `product_category`
--
ALTER TABLE `product_category`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `providers`
--
ALTER TABLE `providers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documentid` (`documentid`);

--
-- Indices de la tabla `p_campos`
--
ALTER TABLE `p_campos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `p_tabla`
--
ALTER TABLE `p_tabla`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid` (`userid`),
  ADD KEY `clientid` (`clientid`),
  ADD KEY `incidentsid` (`incidentsid`);

--
-- Indices de la tabla `ticket_solution`
--
ALTER TABLE `ticket_solution`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticketid` (`ticketid`),
  ADD KEY `technicalid` (`technicalid`);

--
-- Indices de la tabla `tools`
--
ALTER TABLE `tools`
  ADD PRIMARY KEY (`id`),
  ADD KEY `facilityid` (`facilityid`),
  ADD KEY `productid` (`productid`);

--
-- Indices de la tabla `unit`
--
ALTER TABLE `unit`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documentid` (`documentid`),
  ADD KEY `profileid` (`profileid`);

--
-- Indices de la tabla `vouchers`
--
ALTER TABLE `vouchers`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `voucher_series`
--
ALTER TABLE `voucher_series`
  ADD PRIMARY KEY (`id`),
  ADD KEY `voucherid` (`voucherid`);

--
-- Indices de la tabla `zonas`
--
ALTER TABLE `zonas`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ap_clientes`
--
ALTER TABLE `ap_clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ap_emisor`
--
ALTER TABLE `ap_emisor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ap_receptor`
--
ALTER TABLE `ap_receptor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `archivos`
--
ALTER TABLE `archivos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `backups`
--
ALTER TABLE `backups`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `bills`
--
ALTER TABLE `bills`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `business`
--
ALTER TABLE `business`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `caja_nap`
--
ALTER TABLE `caja_nap`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `caja_nap_clientes`
--
ALTER TABLE `caja_nap_clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `clients`
--
ALTER TABLE `clients`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `contracts`
--
ALTER TABLE `contracts`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `currency`
--
ALTER TABLE `currency`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `departures`
--
ALTER TABLE `departures`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detail_bills`
--
ALTER TABLE `detail_bills`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detail_contracts`
--
ALTER TABLE `detail_contracts`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detail_facility`
--
ALTER TABLE `detail_facility`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `document_type`
--
ALTER TABLE `document_type`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `emails`
--
ALTER TABLE `emails`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `facility`
--
ALTER TABLE `facility`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `forms_payment`
--
ALTER TABLE `forms_payment`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `gallery_images`
--
ALTER TABLE `gallery_images`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `incidents`
--
ALTER TABLE `incidents`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `income`
--
ALTER TABLE `income`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `modules`
--
ALTER TABLE `modules`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `otros_ingresos`
--
ALTER TABLE `otros_ingresos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `permits`
--
ALTER TABLE `permits`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=371;

--
-- AUTO_INCREMENT de la tabla `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `product_category`
--
ALTER TABLE `product_category`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `profiles`
--
ALTER TABLE `profiles`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `providers`
--
ALTER TABLE `providers`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `p_campos`
--
ALTER TABLE `p_campos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `p_tabla`
--
ALTER TABLE `p_tabla`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `services`
--
ALTER TABLE `services`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ticket_solution`
--
ALTER TABLE `ticket_solution`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tools`
--
ALTER TABLE `tools`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `unit`
--
ALTER TABLE `unit`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `vouchers`
--
ALTER TABLE `vouchers`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `voucher_series`
--
ALTER TABLE `voucher_series`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `zonas`
--
ALTER TABLE `zonas`
  MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `bills`
--
ALTER TABLE `bills`
  ADD CONSTRAINT `bills_ibfk_3` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bills_ibfk_5` FOREIGN KEY (`clientid`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bills_ibfk_6` FOREIGN KEY (`voucherid`) REFERENCES `vouchers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bills_ibfk_7` FOREIGN KEY (`serieid`) REFERENCES `voucher_series` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `business`
--
ALTER TABLE `business`
  ADD CONSTRAINT `business_ibfk_1` FOREIGN KEY (`documentid`) REFERENCES `document_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `business_ibfk_2` FOREIGN KEY (`currencyid`) REFERENCES `currency` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `clients_ibfk_1` FOREIGN KEY (`documentid`) REFERENCES `document_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `contracts`
--
ALTER TABLE `contracts`
  ADD CONSTRAINT `contracts_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `contracts_ibfk_3` FOREIGN KEY (`clientid`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `departures`
--
ALTER TABLE `departures`
  ADD CONSTRAINT `departures_ibfk_1` FOREIGN KEY (`productid`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detail_bills`
--
ALTER TABLE `detail_bills`
  ADD CONSTRAINT `detail_bills_ibfk_1` FOREIGN KEY (`billid`) REFERENCES `bills` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detail_contracts`
--
ALTER TABLE `detail_contracts`
  ADD CONSTRAINT `detail_contracts_ibfk_1` FOREIGN KEY (`contractid`) REFERENCES `contracts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detail_contracts_ibfk_2` FOREIGN KEY (`serviceid`) REFERENCES `services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detail_facility`
--
ALTER TABLE `detail_facility`
  ADD CONSTRAINT `detail_facility_ibfk_1` FOREIGN KEY (`facilityid`) REFERENCES `facility` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detail_facility_ibfk_2` FOREIGN KEY (`technicalid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `emails`
--
ALTER TABLE `emails`
  ADD CONSTRAINT `emails_ibfk_1` FOREIGN KEY (`billid`) REFERENCES `bills` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `emails_ibfk_2` FOREIGN KEY (`clientid`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `facility`
--
ALTER TABLE `facility`
  ADD CONSTRAINT `facility_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `facility_ibfk_3` FOREIGN KEY (`clientid`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `gallery_images`
--
ALTER TABLE `gallery_images`
  ADD CONSTRAINT `gallery_images_ibfk_1` FOREIGN KEY (`clientid`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `gallery_images_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `income`
--
ALTER TABLE `income`
  ADD CONSTRAINT `income_ibfk_1` FOREIGN KEY (`productid`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`billid`) REFERENCES `bills` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_3` FOREIGN KEY (`clientid`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_4` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_ibfk_5` FOREIGN KEY (`paytypeid`) REFERENCES `forms_payment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `permits`
--
ALTER TABLE `permits`
  ADD CONSTRAINT `permits_ibfk_1` FOREIGN KEY (`profileid`) REFERENCES `profiles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `permits_ibfk_2` FOREIGN KEY (`moduleid`) REFERENCES `modules` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`unitid`) REFERENCES `unit` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`categoryid`) REFERENCES `product_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `products_ibfk_3` FOREIGN KEY (`providerid`) REFERENCES `providers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`incidentsid`) REFERENCES `incidents` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tickets_ibfk_3` FOREIGN KEY (`clientid`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tickets_ibfk_4` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ticket_solution`
--
ALTER TABLE `ticket_solution`
  ADD CONSTRAINT `ticket_solution_ibfk_1` FOREIGN KEY (`ticketid`) REFERENCES `tickets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_solution_ibfk_2` FOREIGN KEY (`technicalid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tools`
--
ALTER TABLE `tools`
  ADD CONSTRAINT `tools_ibfk_1` FOREIGN KEY (`productid`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tools_ibfk_2` FOREIGN KEY (`facilityid`) REFERENCES `facility` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`profileid`) REFERENCES `profiles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`documentid`) REFERENCES `document_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `voucher_series`
--
ALTER TABLE `voucher_series`
  ADD CONSTRAINT `voucher_series_ibfk_1` FOREIGN KEY (`voucherid`) REFERENCES `vouchers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
