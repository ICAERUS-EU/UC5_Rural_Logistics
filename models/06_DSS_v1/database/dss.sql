-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 13, 2025 at 03:45 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dss`
--

-- --------------------------------------------------------

--
-- Table structure for table `devices`
--

CREATE TABLE `devices` (
  `id` int(11) NOT NULL,
  `deviceCategory` int(11) NOT NULL,
  `deviceType` int(11) NOT NULL DEFAULT 10000,
  `devicePlates` varchar(200) DEFAULT NULL,
  `deviceSerial` varchar(255) DEFAULT NULL,
  `deviceModel` varchar(600) DEFAULT NULL,
  `createdAtTimestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `lastUpdatedTimestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `deviceCreatedBy` varchar(1000) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `devices`
--

INSERT INTO `devices` (`id`, `deviceCategory`, `deviceType`, `devicePlates`, `deviceSerial`, `deviceModel`, `createdAtTimestamp`, `lastUpdatedTimestamp`, `deviceCreatedBy`, `active`) VALUES
(1, 1, 3, 'GS-200', 'GS-s200', 'GeoSense-QUAD-A', '2022-11-16 17:11:47', '2025-02-06 12:10:10', 'Kostas', 1),
(2, 1, 1, 'GS-100', 'GS-s100', 'GeoSense-VTOL-A', '2023-10-28 06:43:13', '2025-02-06 12:16:12', 'Kostas', 0),
(4, 1, 8, 'GS-1', 'VELOS1', 'VELOS', '2024-06-07 07:58:43', '2024-06-07 10:59:11', 'Device', 1);

-- --------------------------------------------------------

--
-- Table structure for table `devices_attributes`
--

CREATE TABLE `devices_attributes` (
  `id` int(11) NOT NULL,
  `attribute` varchar(300) DEFAULT NULL,
  `notes` text NOT NULL,
  `added` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `devices_attributes`
--

INSERT INTO `devices_attributes` (`id`, `attribute`, `notes`, `added`) VALUES
(1, 'autonomy', 'Max Low risk route length (km)', '2022-11-16 09:24:27'),
(2, 'payload', 'Max payload in kg', '2022-11-16 09:24:27'),
(4, 'h_speed', 'Horizontal speed (m/s)', '2024-03-26 15:48:05'),
(5, 'v_speed', 'Vertical speed (m/s)', '2024-03-26 15:48:05'),
(6, 'max_flight_time', 'Maximum flight time in minutes', '2024-03-26 15:49:31'),
(7, 'max_wind_resistance', 'Maximum wind resistance (m/s)', '2024-03-26 15:49:31'),
(8, 'min_operating_temperature', 'Minimum operating temperature (°C)', '2024-03-26 15:51:09'),
(9, 'max_operating_temperature', 'Maximum operating temperature (°C)', '2024-03-26 15:51:09'),
(12, 'max_cargo_length', 'Max cargo length in cm', '2025-02-05 16:02:05'),
(13, 'max_cargo_width', 'Max cargo width in cm', '2025-02-05 16:02:05'),
(14, 'max_cargo_height', 'Max cargo height in cm', '2025-02-05 16:02:21');

-- --------------------------------------------------------

--
-- Table structure for table `devices_attributes_devices`
--

CREATE TABLE `devices_attributes_devices` (
  `id` int(11) NOT NULL,
  `device_id` int(11) NOT NULL,
  `attribute_id` int(11) NOT NULL,
  `value` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `devices_attributes_devices`
--

INSERT INTO `devices_attributes_devices` (`id`, `device_id`, `attribute_id`, `value`) VALUES
(1, 1, 2, '2.5'),
(2, 4, 1, '50'),
(3, 4, 2, '10'),
(4, 4, 4, '33'),
(5, 4, 6, '80'),
(7, 2, 7, '14'),
(8, 2, 2, '2'),
(12, 2, 4, '12'),
(13, 1, 1, '5'),
(14, 1, 7, '10'),
(16, 1, 4, '15'),
(17, 2, 1, '50.7'),
(18, 1, 6, '35'),
(19, 2, 6, '30'),
(22, 2, 5, '1'),
(23, 2, 8, '2'),
(24, 2, 9, '3'),
(26, 1, 5, '4'),
(27, 1, 8, '-20'),
(28, 1, 9, '60'),
(29, 1, 12, '30'),
(30, 1, 13, '20'),
(31, 1, 14, '15'),
(32, 4, 5, ''),
(33, 4, 7, '8'),
(34, 4, 8, '0'),
(35, 4, 9, '36'),
(36, 4, 12, '54'),
(37, 4, 13, '28'),
(38, 4, 14, '28');

-- --------------------------------------------------------

--
-- Table structure for table `devices_availability_status`
--

CREATE TABLE `devices_availability_status` (
  `id` int(11) NOT NULL,
  `deviceId` int(11) NOT NULL,
  `statusId` int(11) NOT NULL,
  `added` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `devices_availability_status`
--

INSERT INTO `devices_availability_status` (`id`, `deviceId`, `statusId`, `added`) VALUES
(1, 1, 1, '2024-06-07 08:21:38'),
(2, 2, 1, '2024-06-07 08:21:38'),
(3, 4, 1, '2024-06-07 08:22:26');

-- --------------------------------------------------------

--
-- Table structure for table `devices_categories`
--

CREATE TABLE `devices_categories` (
  `id` int(11) NOT NULL,
  `deviceCategory` varchar(200) NOT NULL,
  `added` timestamp NOT NULL DEFAULT current_timestamp(),
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `devices_categories`
--

INSERT INTO `devices_categories` (`id`, `deviceCategory`, `added`, `active`) VALUES
(1, 'UAV', '2022-09-06 07:38:17', 1),
(2, 'ROV', '2022-09-06 07:38:17', 1),
(3, 'CAR', '2022-09-06 07:38:38', 1),
(4, 'MOTORCYCLE', '2022-09-06 07:38:38', 1),
(5, 'BICYCLE', '2022-09-06 07:38:48', 1),
(6, 'BOAT', '2022-09-06 07:39:05', 1);

-- --------------------------------------------------------

--
-- Table structure for table `devices_statuses`
--

CREATE TABLE `devices_statuses` (
  `id` int(11) NOT NULL,
  `status` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `devices_statuses`
--

INSERT INTO `devices_statuses` (`id`, `status`) VALUES
(1, 'available'),
(2, 'on mission'),
(3, 'decommissioned'),
(4, 'for repair');

-- --------------------------------------------------------

--
-- Table structure for table `devices_types`
--

CREATE TABLE `devices_types` (
  `id` int(11) NOT NULL,
  `device_category_id` int(11) NOT NULL,
  `type` varchar(300) NOT NULL,
  `added` timestamp NOT NULL DEFAULT current_timestamp(),
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `devices_types`
--

INSERT INTO `devices_types` (`id`, `device_category_id`, `type`, `added`, `active`) VALUES
(1, 1, 'VTOL', '2023-09-18 11:05:41', 1),
(2, 1, 'Octocopter', '2023-09-18 11:05:41', 1),
(3, 1, 'Quadcopter', '2023-09-18 11:05:41', 1),
(4, 3, 'SUV', '2023-09-18 11:05:41', 1),
(5, 3, 'Pick Up', '2023-09-18 11:05:41', 1),
(6, 5, 'Personal', '2023-09-18 11:05:41', 1),
(7, 5, 'Family', '2023-09-18 11:05:41', 1),
(8, 1, 'Helicopter', '2023-09-18 14:54:03', 1),
(9, 1, 'Fixed Wing', '2023-09-18 14:54:30', 1);

-- --------------------------------------------------------

--
-- Table structure for table `dss_cases`
--

CREATE TABLE `dss_cases` (
  `id` int(11) NOT NULL,
  `uuid` varchar(100) NOT NULL,
  `results_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`results_json`)),
  `timestamp` timestamp NULL DEFAULT current_timestamp(),
  `identifier` varchar(600) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dss_cases`
--

INSERT INTO `dss_cases` (`id`, `uuid`, `results_json`, `timestamp`, `identifier`) VALUES
(1, '67a5ff3379fcc', '{\"routes\": [{\"route\": [{\"pickup_load\": 0, \"location_lat\": 40.6050811, \"location_lng\": 22.9533302, \"delivery_load\": 0, \"location_index\": 0}, {\"pickup_load\": 0, \"location_lat\": 40.59062, \"location_lng\": 22.95876, \"delivery_load\": 2, \"location_index\": 2}, {\"pickup_load\": 0, \"location_lat\": 40.6050811, \"location_lng\": 22.9533302, \"delivery_load\": 0, \"location_index\": 0}], \"distance\": 3.344, \"vehicle_id\": \"1\"}, {\"route\": [{\"pickup_load\": 0, \"location_lat\": 40.6050811, \"location_lng\": 22.9533302, \"delivery_load\": 0, \"location_index\": 0}, {\"pickup_load\": 0, \"location_lat\": 40.58180970464255, \"location_lng\": 22.95332577060855, \"delivery_load\": 1, \"location_index\": 1}, {\"pickup_load\": 0, \"location_lat\": 40.6050811, \"location_lng\": 22.9533302, \"delivery_load\": 0, \"location_index\": 0}], \"distance\": 5.174, \"vehicle_id\": \"4\"}], \"depot_coords\": [40.6050811, 22.9533302], \"solution_found\": true, \"total_distance\": 8.518, \"total_pickup_load\": 0, \"total_delivery_load\": 3}', '2025-02-07 12:40:19', NULL),
(2, '67a9c5fcd94ed', '{\"routes\": [{\"route\": [{\"pickup_load\": 0, \"location_lat\": 40.6050811, \"location_lng\": 22.9533302, \"delivery_load\": 0, \"location_index\": 0}, {\"pickup_load\": 0, \"location_lat\": 40.59062, \"location_lng\": 22.95876, \"delivery_load\": 2, \"location_index\": 2}, {\"pickup_load\": 0, \"location_lat\": 40.6050811, \"location_lng\": 22.9533302, \"delivery_load\": 0, \"location_index\": 0}], \"distance\": 3.344, \"vehicle_id\": \"1\"}, {\"route\": [{\"pickup_load\": 0, \"location_lat\": 40.6050811, \"location_lng\": 22.9533302, \"delivery_load\": 0, \"location_index\": 0}, {\"pickup_load\": 0, \"location_lat\": 40.58180970464255, \"location_lng\": 22.95332577060855, \"delivery_load\": 1, \"location_index\": 1}, {\"pickup_load\": 0, \"location_lat\": 40.6050811, \"location_lng\": 22.9533302, \"delivery_load\": 0, \"location_index\": 0}], \"distance\": 5.174, \"vehicle_id\": \"4\"}], \"depot_coords\": [40.6050811, 22.9533302], \"solution_found\": true, \"total_distance\": 8.518, \"total_pickup_load\": 0, \"total_delivery_load\": 3}', '2025-02-10 09:25:16', NULL),
(3, '67ade0a4b3587', '{\"solution_found\":true,\"routes\":[{\"vehicle_id\":\"1\",\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":3.344},{\"vehicle_id\":\"4\",\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":5.174}],\"depot_coords\":[40.6050811,22.9533302],\"total_distance\":8.518,\"total_pickup_load\":0,\"total_delivery_load\":3}', '2025-02-13 12:08:04', NULL),
(4, '67ade167737f0', '{\"solution_found\":true,\"routes\":[{\"vehicle_id\":1,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":3.344},{\"vehicle_id\":4,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":5.174}],\"depot_coords\":[40.6050811,22.9533302],\"total_distance\":8.518,\"total_pickup_load\":0,\"total_delivery_load\":3}', '2025-02-13 12:11:19', NULL),
(5, '67ade16bd369b', '{\"solution_found\":true,\"routes\":[{\"vehicle_id\":1,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":3.344},{\"vehicle_id\":4,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":5.174}],\"depot_coords\":[40.6050811,22.9533302],\"total_distance\":8.518,\"total_pickup_load\":0,\"total_delivery_load\":3}', '2025-02-13 12:11:23', NULL),
(6, '67ade1a47084e', '{\"solution_found\":true,\"routes\":[{\"vehicle_id\":1,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":3.344},{\"vehicle_id\":4,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":5.174}],\"depot_coords\":[40.6050811,22.9533302],\"total_distance\":8.518,\"total_pickup_load\":0,\"total_delivery_load\":3}', '2025-02-13 12:12:20', NULL),
(7, '67ade277e0108', '{\"solution_found\":true,\"routes\":[{\"vehicle_id\":1,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":3.344},{\"vehicle_id\":4,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":5.174}],\"depot_coords\":[40.6050811,22.9533302],\"total_distance\":8.518,\"total_pickup_load\":0,\"total_delivery_load\":3}', '2025-02-13 12:15:51', NULL),
(8, '67ade2a2cdb32', '{\"solution_found\":true,\"routes\":[{\"vehicle_id\":1,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":3.344},{\"vehicle_id\":4,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":5.174}],\"depot_coords\":[40.6050811,22.9533302],\"total_distance\":8.518,\"total_pickup_load\":0,\"total_delivery_load\":3}', '2025-02-13 12:16:34', NULL),
(9, '67ade2ba0e5e6', '{\"solution_found\":true,\"routes\":[{\"vehicle_id\":1,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":3.344},{\"vehicle_id\":4,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":5.174}],\"depot_coords\":[40.6050811,22.9533302],\"total_distance\":8.518,\"total_pickup_load\":0,\"total_delivery_load\":3}', '2025-02-13 12:16:58', NULL),
(10, '67ade33d4919c', '{\"solution_found\":true,\"routes\":[{\"vehicle_id\":1,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":3.344},{\"vehicle_id\":4,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":5.174}],\"depot_coords\":[40.6050811,22.9533302],\"total_distance\":8.518,\"total_pickup_load\":0,\"total_delivery_load\":3}', '2025-02-13 12:19:09', NULL),
(11, '67ade4414e5c9', '{\"solution_found\":true,\"routes\":[{\"vehicle_id\":1,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":3.344},{\"vehicle_id\":4,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":5.174}],\"depot_coords\":[40.6050811,22.9533302],\"total_distance\":8.518,\"total_pickup_load\":0,\"total_delivery_load\":3}', '2025-02-13 12:23:29', NULL),
(12, '67ade4c4debb1', '{\"solution_found\":true,\"routes\":[{\"vehicle_id\":1,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":3.344},{\"vehicle_id\":4,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":5.174}],\"depot_coords\":[40.6050811,22.9533302],\"total_distance\":8.518,\"total_pickup_load\":0,\"total_delivery_load\":3}', '2025-02-13 12:25:40', NULL),
(13, '67ade816c00e0', '{\"solution_found\":true,\"routes\":[{\"vehicle_id\":1,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":3.344},{\"vehicle_id\":4,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":5.174}],\"depot_coords\":[40.6050811,22.9533302],\"total_distance\":8.518,\"total_pickup_load\":0,\"total_delivery_load\":3}', '2025-02-13 12:39:50', NULL),
(14, '67adec22cbaa7', '{\"solution_found\":true,\"routes\":[{\"vehicle_id\":1,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":3.344},{\"vehicle_id\":4,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":5.174}],\"depot_coords\":[40.6050811,22.9533302],\"total_distance\":8.518,\"total_pickup_load\":0,\"total_delivery_load\":3}', '2025-02-13 12:57:06', NULL),
(15, '67adf56f36112', '{\"solution_found\":true,\"routes\":[{\"vehicle_id\":1,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":3.344},{\"vehicle_id\":4,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":5.174}],\"depot_coords\":[40.6050811,22.9533302],\"total_distance\":8.518,\"total_pickup_load\":0,\"total_delivery_load\":3}', '2025-02-13 13:36:47', NULL),
(16, '67ae0443cac23', '{\"solution_found\":true,\"routes\":[{\"vehicle_id\":1,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":3.344},{\"vehicle_id\":4,\"route\":[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.59920486748849,\"location_lng\":22.9720182819242},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}],\"distance\":3.414}],\"depot_coords\":[40.6050811,22.9533302],\"total_distance\":6.758,\"total_pickup_load\":0,\"total_delivery_load\":3}', '2025-02-13 14:40:03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `dss_route_history`
--

CREATE TABLE `dss_route_history` (
  `id` int(11) NOT NULL,
  `route_id` varchar(50) NOT NULL,
  `dss_case_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `stops` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`stops`)),
  `total_distance` float NOT NULL,
  `total_pickup_load` float NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dss_route_history`
--

INSERT INTO `dss_route_history` (`id`, `route_id`, `dss_case_id`, `vehicle_id`, `stops`, `total_distance`, `total_pickup_load`, `created_at`) VALUES
(1, '67a5ff337b0f8', 1, 1, '[{\"pickup_load\": 0, \"location_lat\": 40.6050811, \"location_lng\": 22.9533302, \"delivery_load\": 0, \"location_index\": 0}, {\"pickup_load\": 0, \"location_lat\": 40.59062, \"location_lng\": 22.95876, \"delivery_load\": 2, \"location_index\": 2}, {\"pickup_load\": 0, \"location_lat\": 40.6050811, \"location_lng\": 22.9533302, \"delivery_load\": 0, \"location_index\": 0}]', 8.518, 0, '2025-02-07 12:40:19'),
(2, '67a5ff337bd15', 1, 4, '[{\"pickup_load\": 0, \"location_lat\": 40.6050811, \"location_lng\": 22.9533302, \"delivery_load\": 0, \"location_index\": 0}, {\"pickup_load\": 0, \"location_lat\": 40.58180970464255, \"location_lng\": 22.95332577060855, \"delivery_load\": 1, \"location_index\": 1}, {\"pickup_load\": 0, \"location_lat\": 40.6050811, \"location_lng\": 22.9533302, \"delivery_load\": 0, \"location_index\": 0}]', 8.518, 0, '2025-02-07 12:40:19'),
(3, '67a9c5fcda004', 2, 1, '[{\"pickup_load\": 0, \"location_lat\": 40.6050811, \"location_lng\": 22.9533302, \"delivery_load\": 0, \"location_index\": 0}, {\"pickup_load\": 0, \"location_lat\": 40.59062, \"location_lng\": 22.95876, \"delivery_load\": 2, \"location_index\": 2}, {\"pickup_load\": 0, \"location_lat\": 40.6050811, \"location_lng\": 22.9533302, \"delivery_load\": 0, \"location_index\": 0}]', 8.518, 0, '2025-02-10 09:25:16'),
(4, '67a9c5fcda58e', 2, 4, '[{\"pickup_load\": 0, \"location_lat\": 40.6050811, \"location_lng\": 22.9533302, \"delivery_load\": 0, \"location_index\": 0}, {\"pickup_load\": 0, \"location_lat\": 40.58180970464255, \"location_lng\": 22.95332577060855, \"delivery_load\": 1, \"location_index\": 1}, {\"pickup_load\": 0, \"location_lat\": 40.6050811, \"location_lng\": 22.9533302, \"delivery_load\": 0, \"location_index\": 0}]', 8.518, 0, '2025-02-10 09:25:16'),
(5, '67ade0a4b4439', 3, 1, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:08:04'),
(6, '67ade0a4b50a0', 3, 4, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:08:04'),
(7, '67ade16774406', 4, 1, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:11:19'),
(8, '67ade16774e6e', 4, 4, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:11:19'),
(9, '67ade16bd40e6', 5, 1, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:11:23'),
(10, '67ade16bd4ac8', 5, 4, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:11:23'),
(11, '67ade1a472320', 6, 1, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:12:20'),
(12, '67ade1a472df3', 6, 4, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:12:20'),
(13, '67ade277e2225', 7, 1, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:15:51'),
(14, '67ade277e2d76', 7, 4, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:15:51'),
(15, '67ade2a2ce783', 8, 1, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:16:34'),
(16, '67ade2a2cf2d2', 8, 4, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:16:34'),
(17, '67ade2ba0fac5', 9, 1, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:16:58'),
(18, '67ade2ba1059b', 9, 4, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:16:58'),
(19, '67ade33d49e64', 10, 1, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:19:09'),
(20, '67ade33d4a8ab', 10, 4, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:19:09'),
(21, '67ade4414f163', 11, 1, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:23:29'),
(22, '67ade4414fd0f', 11, 4, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:23:29'),
(23, '67ade4c4df92a', 12, 1, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:25:40'),
(24, '67ade4c4e04e6', 12, 4, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:25:40'),
(25, '67ade816c0d6b', 13, 1, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:39:50'),
(26, '67ade816c1853', 13, 4, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:39:50'),
(27, '67adec22cc8cf', 14, 1, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:57:06'),
(28, '67adec22cda5e', 14, 4, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 12:57:06'),
(29, '67adf56f38a36', 15, 1, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 13:36:47'),
(30, '67adf56f3acaf', 15, 4, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.58180970464255,\"location_lng\":22.953325770608554},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 8.518, 0, '2025-02-13 13:36:47'),
(31, '67ae0443cbc00', 16, 1, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":2,\"delivery_load\":2,\"pickup_load\":0,\"location_lat\":40.59062,\"location_lng\":22.95876},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 6.758, 0, '2025-02-13 14:40:03'),
(32, '67ae0443cc473', 16, 4, '[{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302},{\"location_index\":1,\"delivery_load\":1,\"pickup_load\":0,\"location_lat\":40.59920486748849,\"location_lng\":22.9720182819242},{\"location_index\":0,\"delivery_load\":0,\"pickup_load\":0,\"location_lat\":40.6050811,\"location_lng\":22.9533302}]', 6.758, 0, '2025-02-13 14:40:03');

-- --------------------------------------------------------

--
-- Table structure for table `gcs`
--

CREATE TABLE `gcs` (
  `id` int(11) NOT NULL,
  `coordinates` varchar(500) NOT NULL,
  `address` varchar(1000) NOT NULL,
  `name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gcs`
--

INSERT INTO `gcs` (`id`, `coordinates`, `address`, `name`) VALUES
(1, '40.6050811,22.9533302', 'Αναλήψεως 4, Θεσσαλονίκη 54643', 'Demo GCS 1');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `order_tracking_no` varchar(300) NOT NULL,
  `order_status_id` int(11) DEFAULT 1,
  `service_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `order_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`order_data`)),
  `added` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `order_tracking_no`, `order_status_id`, `service_id`, `customer_id`, `order_data`, `added`) VALUES
(52, 'm6s2663y-95yw1gdpmtg-3', 2, 1, 46, '{\"userId\": \"3\", \"service\": \"1\", \"geofences\": [], \"logistics\": [{\"name\": \"shipping_name\", \"value\": \"Κωνσταντίνος\"}, {\"name\": \"shipping_surname\", \"value\": \"Γρηγοριάδης\"}, {\"name\": \"email\", \"value\": \"kgrigor.new@gmail.com\"}, {\"name\": \"phone\", \"value\": \"6932349529\"}, {\"name\": \"shipping_company\", \"value\": \"ΚΩΝΣΤΑΝΤΙΝΟΣ ΓΡΗΓΟΡΙΑΔΗΣ\"}, {\"name\": \"shipping_address\", \"value\": \"ΒΑΣ ΟΛΓΑΣ\"}, {\"name\": \"shipping_postal_code\", \"value\": \"54643\"}, {\"name\": \"shipping_city\", \"value\": \"ΘΕΣΣΑΛΟΝΙΚΗ\"}, {\"name\": \"shipping_country\", \"value\": \"Greece (Ελλάδα)\"}, {\"name\": \"shipping_address_coordinates\", \"value\": \"40.59920486748849, 22.9720182819242\"}, {\"name\": \"start_date\", \"value\": \"05/02/2025\"}, {\"name\": \"end_date\", \"value\": \"06/02/2025\"}, {\"name\": \"cargo_type\", \"value\": \"Medical\"}, {\"name\": \"cargo_details\", \"value\": \"Covid tests\"}, {\"name\": \"cargo_width\", \"value\": \"20\"}, {\"name\": \"cargo_depth\", \"value\": \"5\"}, {\"name\": \"cargo_height\", \"value\": \"10\"}, {\"name\": \"cargo_weight\", \"value\": \"1\"}, {\"name\": \"cargo_type_pu\", \"value\": \"0\"}, {\"name\": \"cargo_details_pu\", \"value\": \"\"}, {\"name\": \"cargo_width_pu\", \"value\": \"\"}, {\"name\": \"cargo_depth_pu\", \"value\": \"\"}, {\"name\": \"cargo_height_pu\", \"value\": \"\"}, {\"name\": \"cargo_weight_pu\", \"value\": \"\"}], \"deliverables\": [], \"userComments\": \"\", \"order_tracking_no\": \"m6s2663y-95yw1gdpmtg-3\"}', '2025-02-05 15:24:50'),
(53, 'm6t9v0ic-c2oa0ks12t-3', 2, 1, 3, '{\"userId\": \"3\", \"service\": \"1\", \"geofences\": [], \"logistics\": [{\"name\": \"shipping_name\", \"value\": \"ΓΙΩΡΓΟΣ\"}, {\"name\": \"shipping_surname\", \"value\": \"ΓΡΗΓΟΡΙΑΔΗΣ\"}, {\"name\": \"email\", \"value\": \"kgrigor.new@gmail.com\"}, {\"name\": \"phone\", \"value\": \"\"}, {\"name\": \"shipping_company\", \"value\": \"\"}, {\"name\": \"shipping_address\", \"value\": \"ΛΕΩΦΟΡΟΣ ΒΑΣΙΛΙΣΣΗΣ ΟΛΓΑΣ\"}, {\"name\": \"shipping_postal_code\", \"value\": \"54643\"}, {\"name\": \"shipping_city\", \"value\": \"ΘΕΣΣΑΛΟΝΙΚΗ\"}, {\"name\": \"shipping_country\", \"value\": \"Greece (Ελλάδα)\"}, {\"name\": \"shipping_address_coordinates\", \"value\": \"40.59062,22.95876\"}, {\"name\": \"start_date\", \"value\": \"06/02/2025\"}, {\"name\": \"end_date\", \"value\": \"13/02/2025\"}, {\"name\": \"cargo_type\", \"value\": \"Liquid\"}, {\"name\": \"cargo_details\", \"value\": \"Νερά\"}, {\"name\": \"cargo_width\", \"value\": \"10\"}, {\"name\": \"cargo_depth\", \"value\": \"10\"}, {\"name\": \"cargo_height\", \"value\": \"10\"}, {\"name\": \"cargo_weight\", \"value\": \"2\"}, {\"name\": \"cargo_type_pu\", \"value\": \"0\"}, {\"name\": \"cargo_details_pu\", \"value\": \"\"}, {\"name\": \"cargo_width_pu\", \"value\": \"\"}, {\"name\": \"cargo_depth_pu\", \"value\": \"\"}, {\"name\": \"cargo_height_pu\", \"value\": \"\"}, {\"name\": \"cargo_weight_pu\", \"value\": \"\"}], \"deliverables\": [], \"userComments\": \"\", \"order_tracking_no\": \"m6t9v0ic-c2oa0ks12t-3\"}', '2025-02-06 11:48:07');

-- --------------------------------------------------------

--
-- Table structure for table `orders_progress`
--

CREATE TABLE `orders_progress` (
  `id` int(11) NOT NULL,
  `orderId` int(11) NOT NULL,
  `statusId` int(11) NOT NULL,
  `updated_by` int(11) NOT NULL DEFAULT 0,
  `comments` text NOT NULL,
  `added` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders_progress`
--

INSERT INTO `orders_progress` (`id`, `orderId`, `statusId`, `updated_by`, `comments`, `added`) VALUES
(73, 52, 1, 0, 'New Order', '2025-02-05 15:24:50'),
(74, 53, 1, 0, 'New Order', '2025-02-06 11:48:07');

-- --------------------------------------------------------

--
-- Table structure for table `order_statuses_categories`
--

CREATE TABLE `order_statuses_categories` (
  `id` int(11) NOT NULL,
  `status` varchar(600) NOT NULL,
  `added` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_statuses_categories`
--

INSERT INTO `order_statuses_categories` (`id`, `status`, `added`) VALUES
(1, 'Submitted', '2022-07-22 14:24:46'),
(2, 'Accepted', '2022-07-22 14:24:46'),
(3, 'In progress', '2022-07-22 14:25:09'),
(4, 'Completed', '2024-03-03 11:32:17'),
(5, 'Repository updated', '2024-03-03 11:32:42'),
(6, 'Declined', '2024-03-03 11:33:12'),
(7, 'Canceled', '2024-03-08 11:45:04'),
(8, 'Action', '2024-03-13 14:52:03');

-- --------------------------------------------------------

--
-- Table structure for table `order_types`
--

CREATE TABLE `order_types` (
  `id` int(11) NOT NULL,
  `type` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_types`
--

INSERT INTO `order_types` (`id`, `type`) VALUES
(1, 'delivery'),
(2, 'pickup');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `vehicle plates` (`devicePlates`),
  ADD KEY `device category` (`deviceCategory`),
  ADD KEY `device type` (`deviceType`);

--
-- Indexes for table `devices_attributes`
--
ALTER TABLE `devices_attributes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `devices_attributes_devices`
--
ALTER TABLE `devices_attributes_devices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `deviceId-AttributeId` (`device_id`,`attribute_id`),
  ADD KEY `attribute id` (`attribute_id`);

--
-- Indexes for table `devices_availability_status`
--
ALTER TABLE `devices_availability_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `devices_categories`
--
ALTER TABLE `devices_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `devices_statuses`
--
ALTER TABLE `devices_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `devices_types`
--
ALTER TABLE `devices_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `device category id` (`device_category_id`);

--
-- Indexes for table `dss_cases`
--
ALTER TABLE `dss_cases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dss_route_history`
--
ALTER TABLE `dss_route_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gcs`
--
ALTER TABLE `gcs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_tracking_no` (`order_tracking_no`),
  ADD KEY `user id` (`customer_id`);

--
-- Indexes for table `orders_progress`
--
ALTER TABLE `orders_progress`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orderId` (`orderId`);

--
-- Indexes for table `order_statuses_categories`
--
ALTER TABLE `order_statuses_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_types`
--
ALTER TABLE `order_types`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `devices`
--
ALTER TABLE `devices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=242;

--
-- AUTO_INCREMENT for table `devices_attributes`
--
ALTER TABLE `devices_attributes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `devices_attributes_devices`
--
ALTER TABLE `devices_attributes_devices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `devices_availability_status`
--
ALTER TABLE `devices_availability_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `devices_categories`
--
ALTER TABLE `devices_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `devices_statuses`
--
ALTER TABLE `devices_statuses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `devices_types`
--
ALTER TABLE `devices_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `dss_cases`
--
ALTER TABLE `dss_cases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `dss_route_history`
--
ALTER TABLE `dss_route_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `gcs`
--
ALTER TABLE `gcs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `orders_progress`
--
ALTER TABLE `orders_progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `order_statuses_categories`
--
ALTER TABLE `order_statuses_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `order_types`
--
ALTER TABLE `order_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `devices_attributes_devices`
--
ALTER TABLE `devices_attributes_devices`
  ADD CONSTRAINT `devices_attributes_devices_ibfk_1` FOREIGN KEY (`attribute_id`) REFERENCES `devices_attributes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders_progress`
--
ALTER TABLE `orders_progress`
  ADD CONSTRAINT `orders_progress_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `orders` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
