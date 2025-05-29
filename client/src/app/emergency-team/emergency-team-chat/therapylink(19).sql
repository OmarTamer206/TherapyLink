-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 29, 2025 at 10:39 AM
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
-- Database: `therapylink`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Date_Of_Birth` date DEFAULT NULL,
  `Gender` enum('Male','Female','Other') DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `Profile_pic_url` varchar(500) DEFAULT NULL,
  `Created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `Name`, `Email`, `Password`, `Date_Of_Birth`, `Gender`, `phone_number`, `Salary`, `Profile_pic_url`, `Created_at`) VALUES
(7, 'omar', 'admin1@gmail.com', '$2b$10$FalDDoTJ3/uBWYnMVkhu9eiIobIHvdvN9G6u7gIF6dQ4tofS77qZ.', '0000-00-00', 'Male', '012', 1900.00, 'test', '2025-03-03 02:08:35'),
(8, 'omar', 'admin2@gmail.com', '$2b$10$xxZWApYK67.emZM8a4rhPOnB9S08Uu5fJERpnQ3rwF2/BSv66JZYK', '0000-00-00', 'Male', '012', 1900.00, NULL, '2025-03-03 02:09:22'),
(9, 'omart', 'admin3@gmail.com', '$2b$10$O/wcFOiBebayJE19f4QuGeMbPZf1yyHovfmC4eG1FR6TX6bsgHbuq', '2001-06-21', 'Male', '012', 1900.00, NULL, '2025-03-03 02:18:28'),
(10, 'omar', 'admin@gmail.com', '$2b$10$ilwsnwll1FhrC7nrAm7oe.1Tgl8AWyPX6nqoBB44jjCQLzAu8gEX6', '0000-00-00', 'Male', '015534234234', 5000.00, NULL, '2025-04-17 15:34:04'),
(12, 'omarT', 'admin20@gmail.com', '$2b$10$NlHVNl7s9xaFvTtZdYq9C.2NvdGwGblDUCZnk.ARANAtno91lY.Uu', '1985-07-03', 'Male', '015534234234', 5000.00, NULL, '2025-04-25 02:03:00'),
(13, 'omar30000', 'admin30@gmail.com', '$2b$10$3SfswULyCWITJ.dxe6dUp.kuDHMj/upMk.3En1z5VG41JG6yZh3lS', '2001-03-03', 'Male', '23467823648', 3000.00, NULL, '2025-04-28 12:11:11'),
(14, 'jiimmy', 'admin40@gmail.com', '$2b$10$Mlb..Dgs3DuNrQNxfXYeQ.mBOOkqMczgBn7ODkGKUQonhyS1wLTJ2', '1985-02-05', 'Male', '2332312312312312', 5000.00, NULL, '2025-05-15 17:12:13'),
(15, 'admin45', 'admin45@gmail.com', '$2b$10$vTVIIHdIaM.x0Dj7R9BhJe.XlHvkPbXOKa7UlLpzqcQOshzeFsVJK', '2005-03-04', 'Male', '234924928347', 3000.00, NULL, '2025-05-15 20:04:11');

-- --------------------------------------------------------

--
-- Table structure for table `call`
--

CREATE TABLE `call` (
  `id` int(11) NOT NULL,
  `Created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `call`
--

INSERT INTO `call` (`id`, `Created_at`) VALUES
(1, '2025-05-19 01:07:03'),
(2, '2025-05-26 00:10:18'),
(3, '2025-05-28 00:14:54'),
(4, '2025-05-28 00:15:58'),
(5, '2025-05-28 00:16:34'),
(6, '2025-05-28 00:17:08'),
(7, '2025-05-28 02:07:49'),
(8, '2025-05-28 02:08:25'),
(9, '2025-05-28 02:08:50'),
(10, '2025-05-28 02:09:36'),
(11, '2025-05-28 02:11:54'),
(12, '2025-05-28 02:12:26'),
(13, '2025-05-28 02:14:37'),
(14, '2025-05-28 02:20:56'),
(15, '2025-05-28 02:21:53'),
(16, '2025-05-28 02:22:12'),
(17, '2025-05-28 02:44:08'),
(18, '2025-05-28 02:46:10'),
(19, '2025-05-28 02:46:57'),
(20, '2025-05-28 02:48:33'),
(21, '2025-05-28 02:49:06'),
(22, '2025-05-28 02:50:30'),
(23, '2025-05-28 02:55:27'),
(24, '2025-05-28 02:59:43'),
(25, '2025-05-28 03:01:15'),
(26, '2025-05-28 03:05:33'),
(27, '2025-05-28 03:07:58'),
(28, '2025-05-28 03:08:07'),
(29, '2025-05-28 03:10:12'),
(30, '2025-05-28 03:11:57'),
(31, '2025-05-28 03:13:01'),
(32, '2025-05-28 03:17:02'),
(33, '2025-05-28 03:17:28'),
(34, '2025-05-28 03:17:49'),
(35, '2025-05-28 03:22:44'),
(36, '2025-05-28 03:28:06'),
(37, '2025-05-28 03:30:54'),
(38, '2025-05-28 03:35:18'),
(39, '2025-05-28 03:36:20'),
(40, '2025-05-28 03:37:40'),
(41, '2025-05-28 03:38:50'),
(42, '2025-05-28 03:39:39'),
(43, '2025-05-28 03:47:30'),
(44, '2025-05-28 03:47:53'),
(45, '2025-05-28 03:48:14'),
(46, '2025-05-28 03:50:30'),
(47, '2025-05-28 03:50:56'),
(48, '2025-05-28 03:56:44'),
(49, '2025-05-28 03:57:10'),
(50, '2025-05-28 03:57:33');

-- --------------------------------------------------------

--
-- Table structure for table `chat`
--

CREATE TABLE `chat` (
  `chat_ID` int(11) NOT NULL,
  `Created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat`
--

INSERT INTO `chat` (`chat_ID`, `Created_at`) VALUES
(1, '2025-01-01 01:41:32'),
(2, '2025-02-15 05:32:48'),
(3, '2025-01-12 08:52:00'),
(4, '2025-02-01 12:52:15'),
(5, '2025-01-30 05:19:12'),
(6, '2025-05-19 01:04:21');

-- --------------------------------------------------------

--
-- Table structure for table `chatbot_session`
--

CREATE TABLE `chatbot_session` (
  `chatbot_ID` int(11) NOT NULL,
  `Created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `patient_id` int(11) DEFAULT NULL,
  `chat_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chatbot_session`
--

INSERT INTO `chatbot_session` (`chatbot_ID`, `Created_at`, `patient_id`, `chat_id`) VALUES
(1, '2025-02-02 11:16:25', 1, 1),
(2, '2025-02-17 13:47:09', NULL, NULL),
(3, '2025-02-05 02:36:57', NULL, NULL),
(4, '2025-02-16 07:17:11', NULL, NULL),
(5, '2025-02-26 17:46:33', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `id` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Date_Of_Birth` date DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `Gender` enum('Male','Female','Other') DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `Specialization` varchar(255) DEFAULT NULL,
  `Session_price` decimal(10,2) DEFAULT NULL,
  `Created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `profile_pic_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`id`, `Name`, `Email`, `Password`, `Date_Of_Birth`, `phone_number`, `Gender`, `Description`, `Specialization`, `Session_price`, `Created_at`, `profile_pic_url`) VALUES
(2, 'Brittany Graham', 'ashleygomez@example.org', 'KBV_5PiMRT', '1975-07-30', '+1-328-959-6785x8100', 'Male', 'Sort staff actually week choice quite door.', 'Clinical Depression and Crisis Prevention Specialist', 64.50, '2025-02-28 20:18:53', NULL),
(3, 'Bruce Bradford', 'qmyers@example.org', 'z!OP#cg7_8', '1969-08-25', '(902)433-6552x50701', 'Female', 'Tough deal letter season finally involve.', 'Clinical Depression and Crisis Prevention Specialist', 106.34, '2025-02-28 20:18:53', NULL),
(21, 'omart', 'manager1@gmail.com', '$2b$10$Ru01N/DYkKuVOkDkyh0ZUuVPO20J10b9zFKdQz96tnRUf.2HRFN/O', '2001-06-21', '012', 'Male', 'good doctor', 'Clinical Depression and Crisis Prevention Specialist', 1900.00, '2025-03-03 02:31:11', NULL),
(22, 'omar', 'patient@gmail.com', '$2b$10$VuymoL/Po6V4ibdrDyq7MO3tJbnCDe8E.rUOTOYi2WbPtWit.w/H2', '0000-00-00', '015534234234', 'Male', 'suicidal Expert', 'Clinical Depression and Crisis Prevention Specialist', 300.00, '2025-04-17 15:32:11', NULL),
(23, 'omar', 'doctor@gmail.com', '$2b$10$cnZN8wCCUPnFi5dghiparOKuaBWlPvhkZDkP5Z6.RnKbgZi1FEPya', '0000-00-00', '015534234234', 'Male', 'suicidal Expert', 'Clinical Depression and Crisis Prevention Specialist', 300.00, '2025-04-17 15:32:22', NULL),
(24, 'omar tamre', 'd@gmail.com', '$2b$10$aUIdmWypyUD4qBe7GbpzVufZ.FGD4gsKZ3GrhXNsbCRQ1u82NKEO2', '1998-04-05', '2232313', 'Male', 'adfhsdfhsdfhjsdfhjhj', 'Clinical Depression and Crisis Prevention Specialist', 300.00, '2025-04-19 16:52:54', NULL),
(25, 'asdasd', 'omarta', '$2b$10$t1qtdGivvniief2bimNNwuHIFHKulxwmzE..fBov53vyZon4sXvaW', '2000-01-01', '21312312', 'Male', 'asdasd', 'Clinical Depression and Crisis Prevention Specialist', 0.00, '2025-04-19 19:57:51', NULL),
(26, 'kamal', 'kamal@gmail.com', '$2b$10$A/BW8Fgi7nSaEal4MDdix.AJqoCu83xXlWo/SBHDWlEmMB/aSk9pq', '2003-03-03', '015', 'Male', 'dssjklhfjkash', 'Clinical Depression and Crisis Prevention Specialist', 443.00, '2025-04-19 20:03:33', NULL),
(27, 'magdy', 'dfsdfsd', '$2b$10$pY40f2AGveokEsJnK9DeMeZibwZA7OQKQhwmn/FlT1kT1ZJyVoRW6', '2000-01-01', '213123', 'Male', 'sdfsdfsd', 'Clinical Depression and Crisis Prevention Specialist', 222.00, '2025-04-19 20:13:08', NULL),
(28, 'OMEGA', 'doctor20@gmail.com', '$2b$10$ttYw1Mm7w3DaQUGe7rf9HOrV54/G5.iSLGfHmiaSJA1vE9qsZ9byS', '2007-04-18', '287489237498', 'Male', 'kajsdkljaslkdjlskdj', 'Clinical Depression and Crisis Prevention Specialist', 5000.00, '2025-04-28 23:05:53', NULL),
(29, 'Monika', 'mooo@gmail.com', '$2b$10$UJrpKj5HyKLVWe3yvGF4H.ByaIZ7mvFKLcMGL3c1P2svMcvXUk8Pm', '2000-01-01', '279823748972', 'Female', 'slfslkdfjlksdfjlkj', 'Clinical Depression and Crisis Prevention Specialist', 522.00, '2025-04-28 23:06:32', NULL),
(30, 'Karim', 'doctor00@gmail.com', '$2b$10$pWBB5/hz3RcesB8ID9wWUOYve5k2TrGEQihwW/BVzZdwFNEDsnjOa', '2000-02-01', '32423423', 'Male', 'sfsdsdf', 'General Psychological Support', 3434.00, '2025-05-15 17:24:54', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `doctor_availability`
--

CREATE TABLE `doctor_availability` (
  `id` int(11) NOT NULL,
  `doctor_ID` int(11) DEFAULT NULL,
  `IsReserved` tinyint(1) DEFAULT 0,
  `available_date` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor_availability`
--

INSERT INTO `doctor_availability` (`id`, `doctor_ID`, `IsReserved`, `available_date`) VALUES
(31, 28, 1, '2025-05-10 20:00:00'),
(34, 28, 1, '2025-05-01 14:00:00'),
(38, 28, 0, '2025-05-08 20:00:00'),
(39, 28, 0, '2025-05-08 16:00:00'),
(40, 28, 1, '2025-05-08 12:00:00'),
(41, 28, 0, '2025-05-08 14:00:00'),
(42, 28, 1, '2025-05-22 10:00:00'),
(47, 28, 0, '2025-05-11 18:00:00'),
(49, 28, 0, '2025-05-12 08:00:00'),
(50, 28, 1, '2025-05-24 18:00:00'),
(51, 28, 1, '2025-05-24 14:00:00'),
(52, 28, 1, '2025-05-23 10:00:00'),
(53, 28, 0, '2025-05-22 12:00:00'),
(55, 30, 0, '2025-05-16 10:00:00'),
(56, 30, 0, '2025-05-16 12:00:00'),
(57, 30, 0, '2025-05-16 18:00:00'),
(58, 28, 1, '2025-05-18 06:00:00'),
(59, 28, 0, '2025-05-18 12:00:00'),
(60, 28, 0, '2025-05-18 14:00:00'),
(61, 28, 1, '2025-05-24 20:00:00'),
(62, 28, 0, '2025-05-26 22:00:00'),
(63, 28, 0, '2025-05-27 20:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `doctor_session`
--

CREATE TABLE `doctor_session` (
  `session_ID` int(11) NOT NULL,
  `patient_ID` int(11) DEFAULT NULL,
  `doctor_ID` int(11) DEFAULT NULL,
  `scheduled_time` datetime DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  `Duration` int(11) DEFAULT NULL,
  `Created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `communication_type` varchar(50) DEFAULT NULL,
  `report_id` int(11) DEFAULT NULL,
  `refunded` tinyint(1) DEFAULT 0,
  `isCancelled` tinyint(1) DEFAULT 0,
  `chat_ID` int(11) DEFAULT NULL,
  `call_ID` int(11) DEFAULT NULL,
  `ended` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor_session`
--

INSERT INTO `doctor_session` (`session_ID`, `patient_ID`, `doctor_ID`, `scheduled_time`, `cost`, `Duration`, `Created_at`, `communication_type`, `report_id`, `refunded`, `isCancelled`, `chat_ID`, `call_ID`, `ended`) VALUES
(2, 1, 3, '2025-03-12 22:11:26', 163.42, 118, '2025-02-28 20:18:53', 'follow', 1, 0, 0, NULL, NULL, 0),
(4, 6, 2, '2025-03-03 02:59:47', 108.62, 73, '2025-02-28 20:18:53', 'especially', 3, 0, 0, NULL, NULL, 0),
(12, 7, 3, '2025-04-30 23:26:10', 127.90, 56, '2025-04-30 19:23:09', 'follow', 8, 1, 0, NULL, NULL, 0),
(17, 2, 3, '2025-03-21 08:23:09', 192.92, 37, '2025-02-28 20:23:09', 'wish', 9, 0, 0, NULL, NULL, 0),
(22, 2, 3, '2025-03-19 12:19:10', 100.49, 78, '2025-02-28 20:26:00', 'practice', 2, 0, 0, NULL, NULL, 0),
(26, 2, 3, '2025-03-05 03:22:10', 163.88, 40, '2025-02-28 20:26:00', 'production', 6, 0, 0, NULL, NULL, 0),
(29, 9, 2, '2025-03-20 06:02:36', 151.69, 54, '2025-02-28 20:26:00', 'yard', 5, 0, 0, NULL, NULL, 0),
(32, 8, 28, '2025-06-20 04:40:06', 99.26, 52, '2025-02-28 20:35:20', 'nor', 6, 0, 0, NULL, NULL, 0),
(37, 3, 28, '2025-08-14 04:45:28', 141.30, 90, '2025-02-28 20:35:20', 'family', 4, 1, 1, NULL, NULL, 0),
(40, 3, 28, '2025-05-29 19:59:10', 130.48, 30, '2025-02-28 20:35:20', 'officer', 5, 0, 0, NULL, NULL, 0),
(41, 36, 28, '2025-05-16 20:34:40', 200.00, 90, '2025-05-06 17:35:50', 'chat', NULL, 0, 0, NULL, NULL, 0),
(42, 3, 28, '2025-05-17 20:34:40', 200.00, 90, '2025-05-06 17:35:50', 'chat', NULL, 0, 0, NULL, NULL, 0),
(43, 36, 28, '2025-05-26 20:34:40', 200.00, 90, '2025-05-06 17:35:50', 'chat', NULL, 0, 0, NULL, NULL, 0),
(44, 48, 28, '2025-05-27 01:00:00', 10000.00, 2, '2025-05-15 03:02:30', 'Chatting', NULL, 0, 0, 4, NULL, 1),
(57, 48, 28, '2025-05-27 01:40:00', 5000.00, 60, '2025-05-19 01:07:03', 'Voice / Video Call', NULL, 0, 0, NULL, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `emergency_team`
--

CREATE TABLE `emergency_team` (
  `id` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Date_Of_Birth` date DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `Profile_pic_url` varchar(500) DEFAULT NULL,
  `Created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `emergency_team`
--

INSERT INTO `emergency_team` (`id`, `Name`, `Email`, `Password`, `Date_Of_Birth`, `phone_number`, `Salary`, `Profile_pic_url`, `Created_at`) VALUES
(11, 'omart', 'emergency1@gmail.com', '$2b$10$NO4lO55e3Uw3UYcQb4NDkeyJRj/Zc.Kn1bakqzxqar8DOOp4KRmlG', '2001-06-21', '012', 1900.00, NULL, '2025-03-03 02:34:18'),
(12, 'omarTamer', 'emergencyteam20@gmail.com', '$2b$10$zKyoX9ti5zvCOUjvrRlskOMcJuY8/WcP1ZhruYt01ZyJPJD7bkAlS', '1967-08-17', '015534234234', 5000.00, NULL, '2025-04-17 15:35:23'),
(13, 'kamal gameel', 'et@gmail.com', '$2b$10$GQyQKGDL6YNNQFHCYCbyp.u6z37J7xsjJ88XS0655MfwNeQ1ntp5y', '0000-00-00', '0155555555555', 5000.00, NULL, '2025-04-18 19:37:32'),
(14, 'kimo kimo', 'ett@gmail.com', '$2b$10$iV81en9Ne1dBlc2mMA2YSOcvdm6bn8gLhHek.Plx81LQUGEycBTRm', '0000-00-00', '01555552355', 5000.00, NULL, '2025-04-18 19:38:54');

-- --------------------------------------------------------

--
-- Table structure for table `emergency_team_session`
--

CREATE TABLE `emergency_team_session` (
  `session_ID` int(11) NOT NULL,
  `patient_ID` int(11) DEFAULT NULL,
  `team_member_ID` int(11) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `Created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `call_id` int(11) DEFAULT NULL,
  `ended` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `emergency_team_session`
--

INSERT INTO `emergency_team_session` (`session_ID`, `patient_ID`, `team_member_ID`, `time`, `Created_at`, `call_id`, `ended`) VALUES
(6, 48, 12, NULL, '2025-05-28 02:08:50', 9, 0),
(7, 48, 12, '2025-05-28 05:09:36', '2025-05-28 02:09:36', 10, 0),
(8, 48, 12, '2025-05-28 05:11:54', '2025-05-28 02:11:54', 11, 0),
(9, 48, 12, '2025-05-28 05:12:26', '2025-05-28 02:12:26', 12, 0),
(10, 48, 12, '2025-05-28 05:14:37', '2025-05-28 02:14:37', 13, 0),
(11, 48, 12, '2025-05-28 05:20:56', '2025-05-28 02:20:56', 14, 0),
(12, 48, 12, '2025-05-28 05:21:53', '2025-05-28 02:21:53', 15, 0),
(13, 48, 12, '2025-05-28 05:22:12', '2025-05-28 02:22:12', 16, 0),
(14, 48, 12, '2025-05-28 05:44:08', '2025-05-28 02:44:08', 17, 0),
(15, 48, 12, '2025-05-28 05:46:10', '2025-05-28 02:46:10', 18, 0),
(16, 48, 12, '2025-05-28 05:46:57', '2025-05-28 02:46:57', 19, 0),
(17, 48, 12, '2025-05-28 05:48:33', '2025-05-28 02:48:33', 20, 0),
(18, 48, 12, '2025-05-28 05:49:06', '2025-05-28 02:49:06', 21, 0),
(19, 48, 12, '2025-05-28 05:50:30', '2025-05-28 02:50:30', 22, 0),
(20, 48, 12, '2025-05-28 05:55:27', '2025-05-28 02:55:27', 23, 0),
(21, 48, 12, '2025-05-28 05:59:43', '2025-05-28 02:59:43', 24, 0),
(22, 48, 12, '2025-05-28 06:01:15', '2025-05-28 03:01:15', 25, 0),
(23, 48, 12, '2025-05-28 06:05:33', '2025-05-28 03:05:33', 26, 0),
(24, 48, 12, '2025-05-28 06:07:58', '2025-05-28 03:07:58', 27, 0),
(25, 48, 12, '2025-05-28 06:08:07', '2025-05-28 03:08:07', 28, 0),
(26, 48, 12, '2025-05-28 06:10:12', '2025-05-28 03:10:12', 29, 0),
(27, 48, 12, '2025-05-28 06:11:57', '2025-05-28 03:11:57', 30, 0),
(28, 48, 12, '2025-05-28 06:13:01', '2025-05-28 03:13:01', 31, 0),
(29, 48, 12, '2025-05-28 06:17:02', '2025-05-28 03:17:02', 32, 0),
(30, 48, 12, '2025-05-28 06:17:28', '2025-05-28 03:17:28', 33, 0),
(31, 48, 12, '2025-05-28 06:17:49', '2025-05-28 03:17:49', 34, 1),
(32, 48, 12, '2025-05-28 06:22:44', '2025-05-28 03:22:44', 35, 1),
(33, 48, 12, '2025-05-28 06:28:06', '2025-05-28 03:28:06', 36, 1),
(34, 48, 12, '2025-05-28 06:30:54', '2025-05-28 03:30:54', 37, 1),
(35, 48, 12, '2025-05-28 06:35:18', '2025-05-28 03:35:18', 38, 1),
(36, 48, 12, '2025-05-28 06:36:20', '2025-05-28 03:36:20', 39, 1),
(37, 48, 12, '2025-05-28 06:37:40', '2025-05-28 03:37:40', 40, 1),
(38, 48, 12, '2025-05-28 06:38:50', '2025-05-28 03:38:50', 41, 1),
(39, 48, 12, '2025-05-28 06:39:39', '2025-05-28 03:39:39', 42, 1),
(40, 48, 12, '2025-05-28 06:47:30', '2025-05-28 03:47:30', 43, 1),
(41, 48, 12, '2025-05-28 06:47:53', '2025-05-28 03:47:53', 44, 1),
(42, 48, 12, '2025-05-28 06:48:14', '2025-05-28 03:48:14', 45, 1),
(43, 48, 12, '2025-05-28 06:50:30', '2025-05-28 03:50:30', 46, 1),
(44, 48, 12, '2025-05-28 06:50:56', '2025-05-28 03:50:56', 47, 1),
(45, 48, 12, '2025-05-28 06:56:44', '2025-05-28 03:56:44', 48, 0),
(46, 48, 12, '2025-05-28 06:57:10', '2025-05-28 03:57:10', 49, 1),
(47, 48, 12, '2025-05-28 06:57:33', '2025-05-28 03:57:33', 50, 1);

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `feedback_ID` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `doctor_type` varchar(255) NOT NULL,
  `session_id` int(11) NOT NULL,
  `reason` text DEFAULT NULL,
  `response` varchar(400) DEFAULT NULL,
  `replied` tinyint(1) DEFAULT 0,
  `rating` int(10) DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`feedback_ID`, `patient_id`, `doctor_id`, `doctor_type`, `session_id`, `reason`, `response`, `replied`, `rating`, `time`) VALUES
(1, 1, 28, 'doctor', 2, 'Feedback1', NULL, 0, 1, '2025-04-30 22:32:58'),
(2, 6, 28, 'doctor', 4, 'Feedback2', 'mnjklsklfjsdlkf', 0, 2, '2025-05-01 22:32:58'),
(3, 13, 28, 'doctor', 2, 'Feedback3', 'omar', 0, 1, '2025-05-13 22:54:03'),
(4, 44, 22, 'life_coach', 2, 'Feedback4', 'iudihajshdias', 0, 1, '2025-05-03 22:32:58'),
(5, 37, 22, 'life_coach', 6, 'Feedback5', 'sorry for confusion', 0, 1, '2025-05-15 17:17:46'),
(6, 43, 22, 'life_coach', 6, 'Feedback6', 'xcvsvd', 1, 1, '2025-05-15 20:09:44'),
(16, 48, 22, 'life_coach', 7, 'test3', NULL, 0, 4, '2025-05-22 04:17:09'),
(18, 48, 28, 'doctor', 44, 'wfdfssdffsdfsddsfsdf', NULL, 0, 3, '2025-05-23 01:00:59'),
(19, 48, 28, 'doctor', 57, 'to7faa casllll\n', NULL, 0, 3, '2025-05-24 18:09:06');

-- --------------------------------------------------------

--
-- Table structure for table `journal`
--

CREATE TABLE `journal` (
  `journal_ID` int(11) NOT NULL,
  `patient_ID` int(11) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `journal_content` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `journal`
--

INSERT INTO `journal` (`journal_ID`, `patient_ID`, `time`, `journal_content`) VALUES
(1, 1, '2025-02-12 11:52:21', 'Laugh option necessary buy. Perform many arm Mrs should page third. Sister focus almost owner couple.'),
(3, 6, '2025-01-28 18:49:39', 'Begin mouth talk approach attention ago large. Crime teacher trial why. Name easy degree foreign picture letter car.'),
(4, 1, '2025-02-08 16:59:05', 'Ever official baby surface scene. Resource concern quality happen between.'),
(5, 8, '2025-02-18 01:59:34', 'Voice speech care home experience. Message able laugh short act feel.'),
(23, 48, '2025-05-15 23:38:45', 'home\n');

-- --------------------------------------------------------

--
-- Table structure for table `lifecoach_availability`
--

CREATE TABLE `lifecoach_availability` (
  `id` int(11) NOT NULL,
  `life_coach_ID` int(11) DEFAULT NULL,
  `IsReserved` tinyint(1) DEFAULT 0,
  `available_date` timestamp NULL DEFAULT NULL,
  `topic` varchar(255) DEFAULT NULL,
  `full` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lifecoach_availability`
--

INSERT INTO `lifecoach_availability` (`id`, `life_coach_ID`, `IsReserved`, `available_date`, `topic`, `full`) VALUES
(9, 22, 0, '2025-05-12 10:00:00', 'truma', 0),
(10, 22, 0, '2025-05-12 08:00:00', 'tag', 0),
(11, 22, 0, '2025-05-13 10:00:00', 'Tagsds', 0),
(12, 22, 0, '2025-05-13 12:00:00', 'Tagsds', 0),
(13, 22, 0, '2025-05-13 14:00:00', 'Tagsds', 0),
(14, 22, 1, '2025-05-18 12:00:00', 'Kimo', 1),
(15, 22, 1, '2025-05-18 18:00:00', 'Kimo', 0),
(16, 22, 0, '2025-05-18 14:00:00', 'Kimo', 0),
(17, 22, 0, '2025-05-09 18:00:00', 'Stress', 0),
(18, 22, 0, '2025-05-09 16:00:00', 'Stress', 0),
(19, 22, 1, '2025-05-19 10:00:00', 'Stress', 0),
(20, 22, 1, '2025-05-26 20:00:00', 'Fera5', 0);

-- --------------------------------------------------------

--
-- Table structure for table `life_coach`
--

CREATE TABLE `life_coach` (
  `id` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Date_Of_Birth` date DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `Gender` enum('Male','Female','Other') DEFAULT NULL,
  `Specialization` varchar(255) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `Session_price` decimal(10,2) DEFAULT NULL,
  `Profile_pic_url` varchar(500) DEFAULT NULL,
  `Created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `life_coach`
--

INSERT INTO `life_coach` (`id`, `Name`, `Email`, `Password`, `Date_Of_Birth`, `phone_number`, `Gender`, `Specialization`, `Description`, `Session_price`, `Profile_pic_url`, `Created_at`) VALUES
(1, 'Lisa Davis', 'christophergarcia@example.net', 'T_a@7SbeH)', '1990-06-11', '(367)562-2824x47061', 'Male', 'Clinical Depression and Crisis Prevention Specialist', 'Want Congress hour network them expect.', 97.59, 'https://placekitten.com/271/708', '2025-02-28 20:18:53'),
(21, 'omart', 'lifeCoach1@gmail.com', '$2b$10$2Q13nbDAO03W/mDvwh0mieYQihKGb.E.WeHHmwHw0.TJFh4GftCCG', '2001-06-21', '012', 'Male', 'Clinical Depression and Crisis Prevention Specialist', 'good life_Coach', 1900.00, NULL, '2025-03-03 02:32:31'),
(22, 'omar', 'lifecoach20@gmail.com', '$2b$10$Xo/Mi4COvKOy2zWvguZR4.1ZBLD2qGqltp8.SB559sy3C7NUMlpVm', '1970-01-01', '015534234234', 'Male', 'Mood and Anxiety Disorder Specialist', 'suicidal Expert', 300.00, NULL, '2025-04-17 15:32:43'),
(23, 'asdasdasd asdasdasdas', 'fsdfsdfs', '$2b$10$DVIqUgwqT0Alsswmlbf3dOOEe0YqEPjpnxUUxFd2H.TpESwtcOqBu', '2000-04-08', '32434234', 'Male', 'Clinical Depression and Crisis Prevention Specialist', 'fsdfsdf', 333.00, NULL, '2025-04-19 16:56:52');

-- --------------------------------------------------------

--
-- Table structure for table `life_coach_session`
--

CREATE TABLE `life_coach_session` (
  `session_ID` int(11) NOT NULL,
  `coach_ID` int(11) DEFAULT NULL,
  `scheduled_time` datetime DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  `Duration` int(11) DEFAULT NULL,
  `Created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `refunded` tinyint(1) DEFAULT 0,
  `isCancelled` tinyint(1) DEFAULT 0,
  `topic` varchar(255) DEFAULT NULL,
  `call_ID` int(11) DEFAULT NULL,
  `ended` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `life_coach_session`
--

INSERT INTO `life_coach_session` (`session_ID`, `coach_ID`, `scheduled_time`, `cost`, `Duration`, `Created_at`, `refunded`, `isCancelled`, `topic`, `call_ID`, `ended`) VALUES
(2, 22, '2025-05-30 11:18:59', 97.66, 75, '2025-02-28 20:35:20', 0, 0, 'Test1', NULL, 0),
(6, 22, '2025-05-11 06:40:05', 200.00, 60, '2025-05-01 00:40:46', 1, 0, 'Test2', NULL, 0),
(7, 22, '2025-05-18 15:00:00', 300.00, 60, '2025-05-15 05:09:33', 0, 0, 'Test3', NULL, 0),
(8, 22, '2025-05-18 17:00:00', 300.00, 60, '2025-05-15 05:15:08', 0, 0, 'Test4', NULL, 0),
(10, 22, '2025-05-18 21:00:00', 300.00, 60, '2025-05-15 17:52:37', 0, 0, 'Kimo', NULL, 0),
(11, 22, '2025-05-25 13:00:00', 300.00, 60, '2025-05-15 17:53:55', 0, 0, 'Stress', NULL, 0),
(12, 22, '2025-05-26 03:00:00', 300.00, 60, '2025-05-25 21:10:23', 0, 0, 'Fera5', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `manager`
--

CREATE TABLE `manager` (
  `id` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Date_Of_Birth` date DEFAULT NULL,
  `Gender` enum('Male','Female','Other') DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `Profile_pic_url` varchar(500) DEFAULT NULL,
  `Created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `manager`
--

INSERT INTO `manager` (`id`, `Name`, `Email`, `Password`, `Date_Of_Birth`, `Gender`, `phone_number`, `Salary`, `Profile_pic_url`, `Created_at`) VALUES
(7, 'omart', 'manager1@gmail.com', '$2b$10$1N6EXwQRpNHQ2ZxjVB.TFOx1EgwMWUE2uHLj3MsQCkSw3CSfxtNQS', '2001-06-21', 'Male', '012', 1900.00, NULL, '2025-03-03 02:28:27'),
(8, 'omar', 'manager@gmail.com', '$2b$10$mC7HL9udo2PaldMw4kicpupK7B3zifjx2uOPBrHVK7ISr6ThMSbOu', '0000-00-00', 'Male', '015534234234', 5000.00, NULL, '2025-04-17 15:34:32'),
(9, 'omar', 'manager20@gmail.com', '$2b$10$OERwc04X0ZUUduQ.5Db6je3N.YnerfGnKtBhluuyGDZVbQM7yCVYi', '1970-01-01', 'Male', '015534234234', 5000.00, NULL, '2025-04-28 11:05:30');

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `message_ID` int(11) NOT NULL,
  `chat_ID` int(11) DEFAULT NULL,
  `time` datetime DEFAULT current_timestamp(),
  `message_content` text DEFAULT NULL,
  `receiver_type` varchar(200) DEFAULT NULL,
  `sender_type` varchar(200) DEFAULT NULL,
  `receiver_id` int(11) DEFAULT NULL,
  `sender_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `message`
--

INSERT INTO `message` (`message_ID`, `chat_ID`, `time`, `message_content`, `receiver_type`, `sender_type`, `receiver_id`, `sender_id`) VALUES
(26, 4, '2025-05-22 08:13:43', 'omar', 'doctor', 'patient', 28, 48),
(27, 4, '2025-05-22 08:13:58', 'doctor', 'patient', 'doctor', 48, 28),
(28, 4, '2025-05-22 09:26:41', 'dsasdsa', 'doctor', 'patient', 28, 48),
(29, 4, '2025-05-22 09:26:44', 'asdasd', 'patient', 'doctor', 48, 28),
(30, 4, '2025-05-22 09:27:10', 'dgf', 'patient', 'doctor', 48, 28),
(31, 4, '2025-05-22 09:28:49', 'sdf', 'patient', 'doctor', 48, 28),
(32, 4, '2025-05-22 09:35:03', 'asdasdasd', 'patient', 'doctor', 48, 28),
(33, 4, '2025-05-22 09:35:05', 'asdasdasd', 'doctor', 'patient', 28, 48),
(34, 4, '2025-05-22 09:35:11', 'asdasdasdas', 'doctor', 'patient', 28, 48),
(35, 4, '2025-05-22 09:35:15', 'sdfsdfsdfa', 'patient', 'doctor', 48, 28),
(36, 4, '2025-05-22 09:35:21', 'asdasd', 'patient', 'doctor', 48, 28),
(37, 4, '2025-05-22 09:35:23', 'asdsad', 'patient', 'doctor', 48, 28),
(38, 4, '2025-05-22 09:41:40', 'asdasd', 'doctor', 'patient', 28, 48),
(39, 4, '2025-05-22 09:41:44', 'asdasdsa', 'patient', 'doctor', 48, 28),
(40, 4, '2025-05-22 09:46:23', 'sdfsdf', 'doctor', 'patient', 28, 48),
(41, 4, '2025-05-22 09:46:32', 'aaaaaaaa', 'doctor', 'patient', 28, 48),
(42, 4, '2025-05-22 09:46:46', 'okay', 'patient', 'doctor', 48, 28),
(43, 4, '2025-05-22 10:01:31', 'asdasdsa', 'doctor', 'patient', 28, 48),
(44, 4, '2025-05-22 10:03:03', 'okay', 'patient', 'doctor', 48, 28),
(45, 4, '2025-05-22 10:03:08', 'asdasdas', 'patient', 'doctor', 48, 28),
(46, 4, '2025-05-22 10:03:16', 'asssasasdasdasasd', 'doctor', 'patient', 28, 48),
(47, 4, '2025-05-22 10:03:30', 'asdasdasdasdasd', 'doctor', 'patient', 28, 48),
(48, 4, '2025-05-22 10:03:34', 'asdsadsadasd', 'patient', 'doctor', 48, 28),
(49, 4, '2025-05-22 10:03:37', 'asdasd', 'patient', 'doctor', 48, 28),
(50, 4, '2025-05-22 10:03:38', 'asdasd', 'patient', 'doctor', 48, 28),
(51, 4, '2025-05-22 10:03:41', 'assdasdasdasd', 'patient', 'doctor', 48, 28),
(52, 4, '2025-05-22 10:03:44', 'asdasdsdaasdsdaasd', 'patient', 'doctor', 48, 28),
(53, 4, '2025-05-22 10:48:47', 'sdfsdfsdfsdfsdfsdfsdfsdfsdf', 'doctor', 'patient', 28, 48),
(54, 4, '2025-05-22 11:27:12', 'asdas', 'doctor', 'patient', 28, 48),
(55, 4, '2025-05-22 11:27:20', 'a', 'doctor', 'patient', 28, 48),
(56, 4, '2025-05-22 11:41:52', 'sd', 'doctor', 'patient', 28, 48),
(57, 4, '2025-05-23 02:42:30', 'ddfd', 'patient', 'doctor', 48, 28),
(58, 4, '2025-05-23 02:46:29', 'asdasjhdkajsd', 'doctor', 'patient', 28, 48),
(59, 4, '2025-05-23 02:46:32', 'asdasdasd', 'patient', 'doctor', 48, 28),
(60, 4, '2025-05-23 03:32:14', 'sdasd', 'doctor', 'patient', 28, 48),
(61, 4, '2025-05-23 03:32:16', 'adasdsad', 'doctor', 'patient', 28, 48),
(62, 4, '2025-05-23 03:32:28', 'fgre', 'doctor', 'patient', 28, 48),
(63, 4, '2025-05-23 03:32:35', 'asasd', 'patient', 'doctor', 48, 28),
(64, 4, '2025-05-23 03:36:51', 'Hamza', 'doctor', 'patient', 28, 48),
(65, 4, '2025-05-23 03:37:52', 'azyk', 'doctor', 'patient', 28, 48),
(66, 4, '2025-05-23 03:37:57', 'kowys', 'patient', 'doctor', 48, 28),
(67, 4, '2025-05-23 03:46:49', 'dfgdfg', 'doctor', 'patient', 28, 48),
(68, 4, '2025-05-23 03:47:04', 'fgdgdfgdfgdf', 'patient', 'doctor', 48, 28),
(69, 4, '2025-05-23 03:47:08', ' dfgdfgdfgdfg', 'doctor', 'patient', 28, 48),
(70, 4, '2025-05-23 03:51:41', 'asds', 'patient', 'doctor', 48, 28),
(71, 4, '2025-05-23 05:54:05', 'sdfsdfsdfsdfsfsdfsdfsdfsdf', 'doctor', 'patient', 28, 48),
(72, 4, '2025-05-23 05:54:09', 'sdfsdfsdfsdfsdfsd', 'patient', 'doctor', 48, 28),
(73, 4, '2025-05-23 09:41:03', 'dfgdfgdfg\\', 'patient', 'doctor', 48, 28),
(74, 4, '2025-05-23 09:42:19', 'ssssss', 'patient', 'doctor', 48, 28),
(75, 4, '2025-05-23 09:45:22', 'ddsadasdasd', 'patient', 'doctor', 48, 28),
(76, 4, '2025-05-23 09:45:26', 'asdasdasasdasdasd', 'doctor', 'patient', 28, 48),
(77, 4, '2025-05-27 01:42:48', 'asdasdasdasdasdasdasdasdasasd', 'patient', 'doctor', 48, 28),
(78, 4, '2025-05-27 01:42:51', 'asdasdasdasd', 'doctor', 'patient', 28, 48);

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `id` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `Date_Of_Birth` date DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `Marital_Status` varchar(50) DEFAULT NULL,
  `Therapist_Preference` varchar(100) DEFAULT NULL,
  `Diagnosis` text DEFAULT NULL,
  `Gender` enum('Male','Female','Other') DEFAULT NULL,
  `Profile_pic_url` varchar(500) DEFAULT NULL,
  `wallet` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`id`, `Name`, `Email`, `Password`, `Created_at`, `Date_Of_Birth`, `phone_number`, `Marital_Status`, `Therapist_Preference`, `Diagnosis`, `Gender`, `Profile_pic_url`, `wallet`) VALUES
(1, 'Michael Fisher', 'tranchristopher@example.org', 'e2SoIFEb@o', '2025-02-28 20:18:53', '1937-01-22', '9213850654', 'Married', 'No Preference', 'Group material focus hold chance.', 'Other', 'https://picsum.photos/21/112', 0),
(2, 'Kevin Martinez', 'heather88@example.com', '^A^z8AqQpz', '2025-02-28 20:18:53', '1949-01-23', '986.757.6745x68184', 'Single', 'Male', 'Little idea imagine week test teach attention production.', 'Other', 'https://dummyimage.com/635x468', 0),
(3, 'Kristin Rodriguez', 'tanthony@example.com', '3OK3+XjT%$', '2025-02-28 20:18:53', '1953-02-06', '964.676.1226x319', 'Single', 'Female', 'Nearly else better culture little response.', 'Female', 'https://picsum.photos/712/105', 706.5),
(4, 'Nancy Cordova', 'xjohnston@example.com', '8K0Pzfhd@b', '2025-02-28 20:18:53', '1987-09-18', '(821)359-6464x244', 'Divorced', 'No Preference', 'Present skin sister painting focus fact center treat.', 'Male', 'https://placekitten.com/241/811', 0),
(6, 'Andrew Martinez', 'fcantrell@example.net', ')i8OUT)2L+', '2025-02-28 20:18:53', '1952-03-11', '823.802.4986x1297', 'Divorced', 'No Preference', 'Seat month small project forward.', 'Other', 'https://picsum.photos/702/663', 108.62),
(7, 'Raymond Yang', 'juan83@example.net', '%8Z!Qsy2r_', '2025-02-28 20:18:53', '1981-12-19', '+1-923-459-1577', 'Divorced', 'Male', 'True describe successful treatment.', 'Other', 'https://dummyimage.com/310x316', 0),
(8, 'Christopher Davis', 'mcbridechristian@example.com', '#83gAfIwIR', '2025-02-28 20:18:53', '1943-05-21', '(823)261-9208x835', 'Divorced', 'Male', 'Treat soon finish we cold author.', 'Other', 'https://placekitten.com/999/855', 800),
(9, 'Daniel Mcdonald', 'wyattkrystal@example.org', 'x2tJ7q_u*Q', '2025-02-28 20:18:53', '2002-06-21', '202-507-5667', 'Single', 'No Preference', 'Thus skill hit new.', 'Other', 'https://dummyimage.com/937x542', 0),
(10, 'Rachel Crawford', 'aprilfernandez@example.org', '+zU1CNL&D2', '2025-02-28 20:18:53', '2003-05-11', '3436582965', 'Divorced', 'Male', 'Thus win manage beautiful cold only I.', 'Female', 'https://picsum.photos/8/809', 0),
(11, 'Timothy Spears', 'rserrano@example.net', '_+18yKud(Z', '2025-02-28 20:23:09', '1951-06-27', '851-457-5658x394', 'Married', 'Male', 'Theory student face night majority around.', 'Other', 'https://dummyimage.com/383x59', 0),
(12, 'Cathy Thompson', 'butlerbradley@example.net', 'NeI(5DoL)&', '2025-02-28 20:23:09', '1956-05-01', '6699734057', 'Single', 'Female', 'Myself information industry indicate economic power.', 'Female', 'https://picsum.photos/87/209', 0),
(13, 'Adrian Washington', 'ray93@example.com', '^AVvQlpzY0', '2025-02-28 20:23:09', '1985-11-04', '(373)573-0913', 'Divorced', 'Female', 'Sometimes attention cell democratic.', 'Male', 'https://dummyimage.com/484x89', 195.32),
(14, 'Kristen Reynolds', 'watsonmichael@example.com', 'YIlG5Nv)D+', '2025-02-28 20:23:09', '1989-05-27', '(916)628-3092x746', 'Married', 'Male', 'Scientist beyond enjoy rich theory true.', 'Male', 'https://placekitten.com/819/368', 0),
(15, 'Kimberly Reid', 'inguyen@example.org', 'PWa!3GSj_T', '2025-02-28 20:23:09', '1961-11-03', '(384)927-6331', 'Divorced', 'Female', 'Majority degree Republican performance south simply hard.', 'Other', 'https://picsum.photos/347/594', 0),
(16, 'Nancy Guerra', 'ygriffin@example.org', 'L!9TwcLY3r', '2025-02-28 20:23:09', '1962-07-26', '694-492-7211x8359', 'Single', 'Female', 'Across should serve reflect water.', 'Other', 'https://placekitten.com/465/504', 0),
(17, 'Roy Miller', 'atkinsjohn@example.com', 'Q9z57UfhX#', '2025-02-28 20:23:09', '1963-07-06', '(542)606-6940x807', 'Divorced', 'No Preference', 'Indicate mind democratic field compare effort cause brother.', 'Female', 'https://placekitten.com/243/376', 0),
(18, 'Richard Alvarez', 'loweamy@example.com', '&bIBHh)8I8', '2025-02-28 20:23:09', '1987-01-27', '+1-860-703-3670x702', 'Single', 'Female', 'Agency decade your thousand significant.', 'Other', 'https://dummyimage.com/522x24', 0),
(19, 'Wayne Santos', 'brandonphillips@example.com', '8g)30UrE#1', '2025-02-28 20:23:09', '1972-05-01', '001-280-281-9407x602', 'Divorced', 'Female', 'Big carry admit treat trial.', 'Female', 'https://picsum.photos/370/1005', 0),
(20, 'Jason Barnes', 'lmartinez@example.net', '^0IDDdj@@s', '2025-02-28 20:23:09', '1995-06-05', '249-305-0912x5409', 'Married', 'No Preference', 'Owner sense program hope though blood begin.', 'Other', 'https://dummyimage.com/800x384', 0),
(21, 'Julia Silva', 'mdavis@example.com', '+w7XA5b%k%', '2025-02-28 20:26:00', '1953-09-18', '+1-667-341-7977x2117', 'Single', 'No Preference', 'Moment everyone real shake sell really rich chair.', 'Male', 'https://dummyimage.com/193x64', 0),
(22, 'Kathleen Cuevas', 'brandonjames@example.org', 'i6c)7XPo5X', '2025-02-28 20:26:00', '1949-06-03', '(647)506-7845x64216', 'Divorced', 'Female', 'Occur similar discuss adult close.', 'Other', 'https://dummyimage.com/524x88', 0),
(23, 'David Bennett', 'julie68@example.net', 'peNXnHcy(9', '2025-02-28 20:26:00', '1940-04-18', '+1-448-599-7524x8321', 'Divorced', 'Female', 'Trade history recent value eat need.', 'Male', 'https://placekitten.com/89/854', 0),
(24, 'Shelby Calderon', 'joseph30@example.com', '^QXoT7Acmx', '2025-02-28 20:26:00', '1972-09-04', '903-780-5592', 'Divorced', 'Female', 'Knowledge financial occur kind management size serious.', 'Male', 'https://picsum.photos/940/964', 0),
(25, 'Lauren Mendoza', 'whitebarbara@example.org', '$)0KgHgCCS', '2025-02-28 20:26:00', '1939-11-26', '(949)943-9445', 'Divorced', 'Male', 'Term man bring you.', 'Male', 'https://placekitten.com/790/808', 0),
(26, 'Mario Lowery', 'trandaniel@example.org', '(pPNb5EtT5', '2025-02-28 20:26:00', '1945-04-26', '790-257-3289', 'Single', 'Female', 'Half effort nearly through yeah environmental involve culture.', 'Female', 'https://placekitten.com/901/979', 0),
(27, 'John Sims', 'lhill@example.org', '@5TNmU4i_h', '2025-02-28 20:26:00', '1948-05-19', '487-781-3728x6885', 'Single', 'Female', 'Fill same seek oil soon.', 'Other', 'https://dummyimage.com/910x868', 0),
(28, 'Kevin Brown', 'meganblankenship@example.net', 'w3($6U(j_s', '2025-02-28 20:26:00', '1936-06-06', '(664)443-4046x8048', 'Divorced', 'No Preference', 'Would million drop expert little.', 'Male', 'https://dummyimage.com/234x574', 0),
(29, 'Robin Anderson', 'xrose@example.com', '*P(4ZXfH%b', '2025-02-28 20:26:00', '1999-10-21', '001-398-864-0200', 'Single', 'Male', 'Trade finish hit require yet.', 'Female', 'https://picsum.photos/385/728', 0),
(30, 'Sylvia Perry', 'cjohnston@example.net', '%uKDBURls7', '2025-02-28 20:26:00', '1971-05-31', '3307096577', 'Married', 'No Preference', 'Protect away research child.', 'Female', 'https://placekitten.com/361/1004', 0),
(31, 'Holly Lee', 'shawteresa@example.net', '&%VjDiwl@5', '2025-02-28 20:35:20', '1940-11-19', '(340)220-9332', 'Married', 'No Preference', 'Our article already before source machine impact color.', 'Male', 'https://dummyimage.com/456x34', 0),
(32, 'Michael Bishop', 'brandon80@example.com', 'r+XA7UKyeP', '2025-02-28 20:35:20', '1988-08-09', '669.516.0252', 'Married', 'Female', 'Science speech be interest character.', 'Female', 'https://picsum.photos/520/402', 0),
(33, 'John Nguyen', 'williamslaura@example.net', '34v7Np&q_y', '2025-02-28 20:35:20', '2005-07-06', '834-961-0558x358', 'Single', 'Female', 'Plant can because.', 'Male', 'https://placekitten.com/790/299', 0),
(34, 'Tara Hudson', 'christina90@example.net', 'cB2xG1*zV@', '2025-02-28 20:35:20', '1948-09-11', '(962)896-5989', 'Single', 'Male', 'Music gas face picture myself structure never.', 'Male', 'https://dummyimage.com/21x732', 0),
(35, 'Teresa Caldwell', 'kirkjeffrey@example.net', '9ELrGMSt*5', '2025-02-28 20:35:20', '1950-03-18', '001-370-994-2132x370', 'Divorced', 'No Preference', 'Establish energy five key.', 'Male', 'https://picsum.photos/606/731', 0),
(36, 'Brandi Walsh', 'michaelbrown@example.org', '^tkY2Uk1+4', '2025-02-28 20:35:20', '1969-12-07', '(743)544-0937', 'Married', 'No Preference', 'Eye minute trip almost sense meeting.', 'Other', 'https://placekitten.com/168/695', 200),
(37, 'Jessica Powell', 'xbaker@example.org', '!3qOjzXA(0', '2025-02-28 20:35:20', '1981-11-25', '001-764-444-6305x958', 'Divorced', 'Female', 'Responsibility eat stand position understand clearly knowledge.', 'Other', 'https://picsum.photos/631/638', 400),
(38, 'Michael Ellis', 'nmercer@example.net', 'l&$2ES6ntH', '2025-02-28 20:35:20', '1980-06-11', '203-842-3375x8905', 'Married', 'No Preference', 'Education unit join while.', 'Female', 'https://picsum.photos/440/914', 0),
(39, 'Jackson Waters', 'garyblack@example.com', '#b@1Sr&NBy', '2025-02-28 20:35:20', '1991-08-15', '001-532-231-7962', 'Divorced', 'Female', 'Audience on challenge but leader born line apply.', 'Female', 'https://placekitten.com/231/600', 0),
(40, 'Timothy Alvarez', 'russellanthony@example.org', 'LAqB$Zh!!4', '2025-02-28 20:35:20', '1979-08-23', '001-270-993-5984x785', 'Single', 'No Preference', 'Memory dark artist population.', 'Female', 'https://placekitten.com/849/802', 0),
(42, 'omart', 'patient1@gmail.com', '$2b$10$CN5McTqIjuLrEfFzmh/dG.0oDbku8XUeXHdbnThQtm6pQ8e2WrGf6', '2025-03-03 02:41:26', '2001-06-21', '012', 'married', NULL, NULL, 'Male', NULL, 0),
(43, 'omar', 'patient@gmail.com', '$2b$10$H3yhzYC36blatE6GCfXHP.aL4XpEcTop3f6p0WLxBLEu.MsTF3Z0G', '2025-04-17 15:29:28', '0000-00-00', '015534234234', 'single', NULL, NULL, 'Male', NULL, 800),
(44, 'Jana', 'jana@gmail.com', '$2b$10$3Rjtw9LHeTnfbnHF57NAMuQazrtJhPYBt7TPB6H4nJQn25jyNm31O', '2025-04-28 10:51:43', '2005-01-09', '79847287498', 'Single', NULL, NULL, 'Female', NULL, 595.32),
(45, 'Jana', 'jana1@gmail.com', '$2b$10$812z935xCxHw5jjB3auYqO9gFiVL3dhgKWLpNQO2AZPmhMt2GrcDO', '2025-04-28 10:52:13', '2005-01-09', '79847287498', 'Single', NULL, NULL, 'Female', NULL, 0),
(46, 'jana', 'jana3@gmail.com', '$2b$10$d.fTZOyG/.cinIr5r4l51u8S3D.oyJ6McKgto/Q4BGj5IeXgLEesK', '2025-04-28 10:53:48', '2005-01-09', '798274982374', 'Single', NULL, NULL, 'Female', NULL, 0),
(47, 'Jana', 'jana5@gmail.com', '$2b$10$PHps2zsmikcCzbvvSZtBt.MoP/xiOZ87HAfQkuKEzjyTaU.uVL91G', '2025-04-28 10:58:45', '2005-01-09', '92783623489', 'Single', NULL, NULL, 'Female', NULL, 0),
(48, 'Omar Tamer 12', 'patient20@gmail.com', '$2b$10$gjANU.pjlk4WKrX89OHW6uxNT42hlrDLkgq1vA5YY2ns45K7YryLK', '2025-05-12 03:27:11', '2003-06-20', '01553072551', 'Married', 'Mood and Anxiety Disorder Specialist', NULL, 'Male', '1747341569083.jpg', 0),
(49, 'ay haga', 'patient30@gmail.com', '$2b$10$pggEd4eK1e6IPrqHvtZZIuFpd828f67AaO2mYHXhyQ58Pisb..Dhq', '2025-05-15 05:51:36', '2004-01-01', '324234234', 'Single', 'Mood and Anxiety Disorder Specialist', NULL, 'Male', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `patient_lifecoach_session`
--

CREATE TABLE `patient_lifecoach_session` (
  `patient_ID` int(11) NOT NULL,
  `session_ID` int(11) NOT NULL,
  `report_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient_lifecoach_session`
--

INSERT INTO `patient_lifecoach_session` (`patient_ID`, `session_ID`, `report_id`) VALUES
(8, 2, NULL),
(8, 6, NULL),
(43, 6, NULL),
(44, 6, NULL),
(48, 7, NULL),
(48, 11, NULL),
(48, 12, NULL),
(49, 7, NULL),
(49, 12, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `report` (
  `report_ID` int(11) NOT NULL,
  `time` datetime DEFAULT current_timestamp(),
  `report_content` text DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `reporter_id` int(11) DEFAULT NULL,
  `reporter_type` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `report`
--

INSERT INTO `report` (`report_ID`, `time`, `report_content`, `patient_id`, `reporter_id`, `reporter_type`) VALUES
(1, '2025-02-14 01:19:19', 'Mrs building doctor nation standard relationship experience. Determine question firm own more ask beyond. Item even mean.', 8, 28, 'doctor'),
(2, '2025-02-22 02:55:47', 'Low successful together notice beat fine. Doctor physical mother.', NULL, NULL, 'doctor'),
(3, '2025-01-10 05:32:25', 'Source standard certain drug research seat. Environmental use reflect claim security item hear.', NULL, NULL, 'doctor'),
(4, '2025-02-09 15:07:18', 'Community interview purpose newspaper ready. Star sound building class. Develop threat Mr fly.', NULL, NULL, 'doctor'),
(5, '2025-01-18 20:55:46', 'Born professor open stay painting. Around material however. Kid staff late off population song quite.', NULL, NULL, 'doctor'),
(6, '2025-02-13 18:58:17', 'Serious four seven. Nearly doctor owner too church professor piece.', NULL, NULL, 'doctor'),
(7, '2025-01-23 06:35:01', 'Too simply response important go look record.', NULL, NULL, 'doctor'),
(8, '2025-02-18 11:09:17', 'Across remain around power us. Certain hard yeah commercial card. Order forward until the do party fall.', NULL, NULL, 'doctor'),
(9, '2025-02-14 08:15:35', 'Grow attention quality kitchen lead describe. Religious foreign decade himself include charge front. Difficult call goal seat skill cover.', NULL, NULL, 'doctor'),
(10, '2025-01-11 09:06:43', 'That might book. She recently size let painting training clear station. Too them hard technology well figure.', NULL, NULL, 'doctor'),
(11, '2025-02-21 09:58:45', 'Fear star career require recently relate note. Allow hot radio read issue.', NULL, NULL, 'doctor'),
(12, '2025-02-10 04:08:21', 'Accept hair show firm feel life. Respond water edge animal. Production answer nor subject big item.', NULL, NULL, 'doctor'),
(13, '2025-01-27 09:53:34', 'Now old address contain point. Official generation space girl upon.', NULL, NULL, 'doctor'),
(14, '2025-01-30 19:38:55', 'Toward need save hospital level doctor. Claim role test imagine next sister say.', NULL, NULL, 'doctor'),
(15, '2025-02-09 21:50:24', 'Final eight put myself. Relationship bank through.', NULL, NULL, 'doctor'),
(16, '2025-02-17 21:51:25', 'Chance this travel this even view suggest prove. Painting he event product herself world someone.', NULL, NULL, 'doctor'),
(17, '2025-01-13 05:51:55', 'Member author hot along street. Red same good director kid know hit.', NULL, NULL, 'doctor'),
(18, '2025-01-10 13:37:16', 'Company sort cell good. Matter question data reality discussion movement. Attack number home.', NULL, NULL, 'doctor'),
(19, '2025-02-06 09:06:29', 'None various system sure couple. Include threat arrive tell at.', NULL, NULL, 'doctor'),
(20, '2025-01-05 03:23:24', 'Fire customer civil father. Day carry five fall.', NULL, NULL, 'doctor'),
(21, '2025-01-27 05:14:40', 'Week decision avoid project. Particular hear set different garden. Minute marriage perform whatever party themselves else. Process food will end.', NULL, NULL, 'doctor'),
(22, '2025-02-08 09:54:52', 'Above imagine figure town. Which maintain individual tend feeling in culture. Long woman sell institution peace. Human second memory what.', NULL, NULL, 'doctor'),
(23, '2025-02-22 15:23:13', 'Art free card teach. Poor none drug. Wish season cover hand or probably.', NULL, NULL, 'doctor'),
(24, '2025-02-24 10:35:28', 'Other itself entire international. Ready word similar.', NULL, NULL, 'doctor'),
(25, '2025-02-06 01:03:46', 'Hard many magazine. Create whatever learn model firm address factor.', NULL, NULL, 'doctor'),
(26, '2025-01-18 19:19:00', 'Reduce more life different case six. Develop rich task window.', NULL, NULL, 'doctor'),
(27, '2025-01-10 15:45:23', 'Would decide meet exist crime herself need. Service church peace without third single.', NULL, NULL, 'doctor'),
(28, '2025-01-17 23:34:45', 'Within accept garden. Commercial boy night. Only perform you heavy wrong brother bag.', NULL, NULL, 'doctor'),
(29, '2025-01-20 09:03:47', 'Drop small government challenge short. Anything seven read week yard enjoy imagine. Goal plan argue spring.', NULL, NULL, 'doctor'),
(30, '2025-01-03 09:49:31', 'Stock we bring paper several require. Continue far feel reach officer stop culture.', NULL, NULL, 'doctor'),
(31, '2025-01-15 10:25:45', 'Prevent name particular perform detail bed together. Coach if discuss animal husband effect movie. People all appear region sure.', NULL, NULL, 'doctor'),
(32, '2025-01-05 10:53:24', 'House police and military day young. Expert knowledge court defense. According law level course in.', NULL, NULL, 'doctor'),
(33, '2025-01-24 11:20:02', 'Protect several tend evening rule adult life. When technology include.', NULL, NULL, 'doctor'),
(34, '2025-01-11 18:52:30', 'Answer interest firm wear he. Teacher them indeed explain. Sell good wear.', NULL, NULL, 'doctor'),
(35, '2025-01-16 13:30:00', 'Model draw team pass. Increase have institution the move relationship make during.', NULL, NULL, 'doctor'),
(36, '2025-01-23 22:52:09', 'All nothing reason natural hear expert. Man act that state.', NULL, NULL, 'doctor'),
(37, '2025-02-12 20:55:06', 'Particular president imagine building executive. Catch difficult strategy. Even benefit above prove necessary gun.', NULL, NULL, 'doctor'),
(38, '2025-02-17 14:38:23', 'Political later successful toward significant somebody check. Seat whether bar apply break country. Sign necessary kid someone behavior bank near.', NULL, NULL, 'doctor'),
(39, '2025-01-07 09:35:01', 'Form number minute next half door travel. Get these race benefit.', NULL, NULL, 'doctor'),
(40, '2025-01-17 15:42:02', 'Still professional their produce. Chance professional father detail model billion ask.', NULL, NULL, 'doctor'),
(41, '2025-01-11 22:55:21', 'Across hotel bed floor present system stock. Resource understand forget. Along activity prepare buy. Board quality activity identify discussion challenge meet.', NULL, NULL, 'doctor'),
(42, '2025-02-13 19:50:58', 'Issue goal if especially skill. Friend hot life fill along fund. Author despite true beautiful stop trouble head.', NULL, NULL, 'doctor'),
(43, '2025-02-24 14:24:31', 'Myself early throughout. Method second likely behavior throw drug kitchen.', NULL, NULL, 'doctor'),
(44, '2025-01-18 16:05:22', 'Store go population writer try news.', NULL, NULL, 'doctor'),
(45, '2025-01-09 03:26:08', 'Late blood animal rule ready than. Drop bed next so certain safe city. Water Mr cost born baby.', NULL, NULL, 'doctor'),
(47, '2025-05-23 02:43:52', 'Gamed', 48, 28, 'doctor'),
(48, '2025-05-23 02:46:40', 'Ra23', 48, 28, 'doctor'),
(49, '2025-05-23 03:47:22', 'adasdas', 48, 28, 'doctor'),
(50, '2025-05-23 04:00:56', 'ertgegf', 48, 28, 'doctor'),
(51, '2025-05-23 05:19:28', 'a', 48, 28, 'doctor'),
(52, '2025-05-23 05:55:46', 'x', 48, 28, 'doctor'),
(53, '2025-05-23 07:51:44', 'm', 48, 28, 'doctor'),
(54, '2025-05-23 07:56:21', 'vgj\n', 48, 28, 'doctor'),
(55, '2025-05-23 09:42:34', 'he is good', 48, 28, 'doctor'),
(56, '2025-05-23 09:45:30', 'fdfsdfdsf', 48, 28, 'doctor'),
(57, '2025-05-24 07:46:58', 'sdasdasd', 48, 28, 'doctor'),
(58, '2025-05-24 07:57:53', 'fg', 48, 28, 'doctor'),
(59, '2025-05-24 08:02:21', ',', 48, 28, 'doctor'),
(60, '2025-05-24 08:18:05', 's', 48, 28, 'doctor'),
(61, '2025-05-24 10:03:49', 'sdfsdfsdf', 48, 28, 'doctor'),
(62, '2025-05-24 10:06:04', 'sdasd', 48, 28, 'doctor'),
(63, '2025-05-24 10:06:58', 'sdfsdfsd', 48, 28, 'doctor'),
(64, '2025-05-24 10:14:04', 'm', 48, 28, 'doctor'),
(65, '2025-05-24 11:09:42', 'c', 48, 28, 'doctor'),
(66, '2025-05-24 20:48:21', 'd', 48, 28, 'doctor'),
(67, '2025-05-24 21:08:49', 'accalled\\\n\n', 48, 28, 'doctor'),
(68, '2025-05-24 21:26:40', 'mmm', 48, 28, 'doctor'),
(69, '2025-05-24 21:28:22', 'm', 48, 28, 'doctor'),
(70, '2025-05-24 21:29:21', 'm', 48, 28, 'doctor'),
(71, '2025-05-24 21:32:33', 'nnn', 48, 28, 'doctor'),
(72, '2025-05-24 21:40:17', 'q', 48, 28, 'doctor'),
(73, '2025-05-24 21:50:40', 'm', 48, 28, 'doctor'),
(74, '2025-05-24 21:52:51', 'm', 48, 28, 'doctor'),
(75, '2025-05-26 00:08:56', 'ended', 48, 28, 'doctor'),
(76, '2025-05-27 01:41:15', 'Emad mot5lf\n', 48, 28, 'doctor'),
(77, '2025-05-27 01:43:11', 'sddsds', 48, 28, 'doctor'),
(78, '2025-05-28 06:38:58', 'hello emergency team', 48, 12, 'emergency_team'),
(79, '2025-05-28 06:39:46', 'asd', 48, 12, 'emergency_team'),
(80, '2025-05-28 06:47:57', 'vvv', 48, 12, 'emergency_team'),
(81, '2025-05-28 06:48:39', 'asasdasd', 48, 12, 'emergency_team'),
(82, '2025-05-28 06:50:46', 'asAS', 48, 12, 'emergency_team'),
(83, '2025-05-28 06:51:12', 'ASD', 48, 12, 'emergency_team'),
(84, '2025-05-28 06:57:15', 'mmomo', 48, 12, 'emergency_team'),
(85, '2025-05-28 06:57:39', 'mmm\n', 48, 12, 'emergency_team');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `call`
--
ALTER TABLE `call`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`chat_ID`);

--
-- Indexes for table `chatbot_session`
--
ALTER TABLE `chatbot_session`
  ADD PRIMARY KEY (`chatbot_ID`),
  ADD KEY `fkp_report` (`patient_id`),
  ADD KEY `fkch_report` (`chat_id`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `doctor_availability`
--
ALTER TABLE `doctor_availability`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_doctor_slot` (`doctor_ID`,`available_date`),
  ADD KEY `doctor_ID` (`doctor_ID`);

--
-- Indexes for table `doctor_session`
--
ALTER TABLE `doctor_session`
  ADD PRIMARY KEY (`session_ID`),
  ADD KEY `patient_ID` (`patient_ID`),
  ADD KEY `doctor_ID` (`doctor_ID`),
  ADD KEY `fk_LC_report` (`report_id`);

--
-- Indexes for table `emergency_team`
--
ALTER TABLE `emergency_team`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `emergency_team_session`
--
ALTER TABLE `emergency_team_session`
  ADD PRIMARY KEY (`session_ID`),
  ADD KEY `patient_ID` (`patient_ID`),
  ADD KEY `team_member_ID` (`team_member_ID`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`feedback_ID`),
  ADD KEY `patient_id` (`patient_id`);

--
-- Indexes for table `journal`
--
ALTER TABLE `journal`
  ADD PRIMARY KEY (`journal_ID`),
  ADD KEY `patient_ID` (`patient_ID`);

--
-- Indexes for table `lifecoach_availability`
--
ALTER TABLE `lifecoach_availability`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_doctor_slot` (`life_coach_ID`,`available_date`),
  ADD KEY `life_coach_ID` (`life_coach_ID`);

--
-- Indexes for table `life_coach`
--
ALTER TABLE `life_coach`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `life_coach_session`
--
ALTER TABLE `life_coach_session`
  ADD PRIMARY KEY (`session_ID`),
  ADD KEY `coach_ID` (`coach_ID`);

--
-- Indexes for table `manager`
--
ALTER TABLE `manager`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`message_ID`),
  ADD KEY `chat_ID` (`chat_ID`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `patient_lifecoach_session`
--
ALTER TABLE `patient_lifecoach_session`
  ADD PRIMARY KEY (`patient_ID`,`session_ID`),
  ADD KEY `session_ID` (`session_ID`),
  ADD KEY `fk_report` (`report_id`);

--
-- Indexes for table `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`report_ID`),
  ADD KEY `fk_customer` (`patient_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `call`
--
ALTER TABLE `call`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `chat_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `chatbot_session`
--
ALTER TABLE `chatbot_session`
  MODIFY `chatbot_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `doctor`
--
ALTER TABLE `doctor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `doctor_availability`
--
ALTER TABLE `doctor_availability`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `doctor_session`
--
ALTER TABLE `doctor_session`
  MODIFY `session_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `emergency_team`
--
ALTER TABLE `emergency_team`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `emergency_team_session`
--
ALTER TABLE `emergency_team_session`
  MODIFY `session_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `feedback_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `journal`
--
ALTER TABLE `journal`
  MODIFY `journal_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `lifecoach_availability`
--
ALTER TABLE `lifecoach_availability`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `life_coach`
--
ALTER TABLE `life_coach`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `life_coach_session`
--
ALTER TABLE `life_coach_session`
  MODIFY `session_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `manager`
--
ALTER TABLE `manager`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `message_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `report`
--
ALTER TABLE `report`
  MODIFY `report_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chatbot_session`
--
ALTER TABLE `chatbot_session`
  ADD CONSTRAINT `fkch_report` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`chat_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `fkp_report` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `doctor_availability`
--
ALTER TABLE `doctor_availability`
  ADD CONSTRAINT `doctor_availability_ibfk_1` FOREIGN KEY (`doctor_ID`) REFERENCES `doctor` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `doctor_session`
--
ALTER TABLE `doctor_session`
  ADD CONSTRAINT `doctor_session_ibfk_1` FOREIGN KEY (`patient_ID`) REFERENCES `patient` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `doctor_session_ibfk_2` FOREIGN KEY (`doctor_ID`) REFERENCES `doctor` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_LC_report` FOREIGN KEY (`report_id`) REFERENCES `report` (`report_ID`) ON DELETE CASCADE;

--
-- Constraints for table `emergency_team_session`
--
ALTER TABLE `emergency_team_session`
  ADD CONSTRAINT `emergency_team_session_ibfk_1` FOREIGN KEY (`patient_ID`) REFERENCES `patient` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `emergency_team_session_ibfk_2` FOREIGN KEY (`team_member_ID`) REFERENCES `emergency_team` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`id`);

--
-- Constraints for table `journal`
--
ALTER TABLE `journal`
  ADD CONSTRAINT `journal_ibfk_1` FOREIGN KEY (`patient_ID`) REFERENCES `patient` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `lifecoach_availability`
--
ALTER TABLE `lifecoach_availability`
  ADD CONSTRAINT `lifecoach_availability_ibfk_1` FOREIGN KEY (`life_coach_ID`) REFERENCES `life_coach` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `life_coach_session`
--
ALTER TABLE `life_coach_session`
  ADD CONSTRAINT `life_coach_session_ibfk_1` FOREIGN KEY (`coach_ID`) REFERENCES `life_coach` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `message_ibfk_1` FOREIGN KEY (`chat_ID`) REFERENCES `chat` (`chat_ID`) ON DELETE CASCADE;

--
-- Constraints for table `patient_lifecoach_session`
--
ALTER TABLE `patient_lifecoach_session`
  ADD CONSTRAINT `fk_report` FOREIGN KEY (`report_id`) REFERENCES `report` (`report_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `patient_lifecoach_session_ibfk_1` FOREIGN KEY (`patient_ID`) REFERENCES `patient` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `patient_lifecoach_session_ibfk_2` FOREIGN KEY (`session_ID`) REFERENCES `life_coach_session` (`session_ID`) ON DELETE CASCADE;

--
-- Constraints for table `report`
--
ALTER TABLE `report`
  ADD CONSTRAINT `fk_customer` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
