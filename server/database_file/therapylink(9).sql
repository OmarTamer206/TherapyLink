-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 09, 2025 at 01:14 AM
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
(13, 'omar30000', 'admin30@gmail.com', '$2b$10$3SfswULyCWITJ.dxe6dUp.kuDHMj/upMk.3En1z5VG41JG6yZh3lS', '2001-03-03', 'Male', '23467823648', 3000.00, NULL, '2025-04-28 12:11:11');

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
(5, '2025-01-30 05:19:12');

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
(2, 'Brittany Graham', 'ashleygomez@example.org', 'KBV_5PiMRT', '1975-07-30', '+1-328-959-6785x8100', 'Male', 'Sort staff actually week choice quite door.', 'Depression', 64.50, '2025-02-28 20:18:53', NULL),
(3, 'Bruce Bradford', 'qmyers@example.org', 'z!OP#cg7_8', '1969-08-25', '(902)433-6552x50701', 'Female', 'Tough deal letter season finally involve.', 'Depression', 106.34, '2025-02-28 20:18:53', NULL),
(21, 'omart', 'manager1@gmail.com', '$2b$10$Ru01N/DYkKuVOkDkyh0ZUuVPO20J10b9zFKdQz96tnRUf.2HRFN/O', '2001-06-21', '012', 'Male', 'good doctor', 'Depression', 1900.00, '2025-03-03 02:31:11', NULL),
(22, 'omar', 'patient@gmail.com', '$2b$10$VuymoL/Po6V4ibdrDyq7MO3tJbnCDe8E.rUOTOYi2WbPtWit.w/H2', '0000-00-00', '015534234234', 'Male', 'suicidal Expert', 'suicidal Expert', 300.00, '2025-04-17 15:32:11', NULL),
(23, 'omar', 'doctor@gmail.com', '$2b$10$cnZN8wCCUPnFi5dghiparOKuaBWlPvhkZDkP5Z6.RnKbgZi1FEPya', '0000-00-00', '015534234234', 'Male', 'suicidal Expert', 'suicidal Expert', 300.00, '2025-04-17 15:32:22', NULL),
(24, 'omar tamre', 'd@gmail.com', '$2b$10$aUIdmWypyUD4qBe7GbpzVufZ.FGD4gsKZ3GrhXNsbCRQ1u82NKEO2', '1998-04-05', '2232313', 'Male', 'adfhsdfhsdfhjsdfhjhj', 'suicidal Expert', 300.00, '2025-04-19 16:52:54', NULL),
(25, 'asdasd', 'omarta', '$2b$10$t1qtdGivvniief2bimNNwuHIFHKulxwmzE..fBov53vyZon4sXvaW', '2000-01-01', '21312312', 'Male', 'asdasd', 'suicidal Expert', 0.00, '2025-04-19 19:57:51', NULL),
(26, 'kamal', 'kamal@gmail.com', '$2b$10$A/BW8Fgi7nSaEal4MDdix.AJqoCu83xXlWo/SBHDWlEmMB/aSk9pq', '2003-03-03', '015', 'Male', 'dssjklhfjkash', 'suicidal Expert', 443.00, '2025-04-19 20:03:33', NULL),
(27, 'magdy', 'dfsdfsd', '$2b$10$pY40f2AGveokEsJnK9DeMeZibwZA7OQKQhwmn/FlT1kT1ZJyVoRW6', '2000-01-01', '213123', 'Male', 'sdfsdfsd', 'suicidal Expert', 222.00, '2025-04-19 20:13:08', NULL),
(28, 'Mick', 'doctor20@gmail.com', '$2b$10$ttYw1Mm7w3DaQUGe7rf9HOrV54/G5.iSLGfHmiaSJA1vE9qsZ9byS', '2000-01-01', '287489237498', 'Male', 'kajsdkljaslkdjlskdj', 'Depression', 5000.00, '2025-04-28 23:05:53', NULL),
(29, 'Monika', 'mooo@gmail.com', '$2b$10$UJrpKj5HyKLVWe3yvGF4H.ByaIZ7mvFKLcMGL3c1P2svMcvXUk8Pm', '2000-01-01', '279823748972', 'Female', 'slfslkdfjlksdfjlkj', 'Stress Expert', 522.00, '2025-04-28 23:06:32', NULL);

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
(42, 28, 1, '2025-05-08 10:00:00');

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
  `rating` int(11) DEFAULT NULL,
  `communication_type` varchar(50) DEFAULT NULL,
  `report_id` int(11) DEFAULT NULL,
  `refunded` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor_session`
--

INSERT INTO `doctor_session` (`session_ID`, `patient_ID`, `doctor_ID`, `scheduled_time`, `cost`, `Duration`, `Created_at`, `rating`, `communication_type`, `report_id`, `refunded`) VALUES
(2, 1, 3, '2025-03-12 22:11:26', 163.42, 118, '2025-02-28 20:18:53', 2, 'follow', 1, 0),
(4, 6, 2, '2025-03-03 02:59:47', 108.62, 73, '2025-02-28 20:18:53', 3, 'especially', 3, 0),
(12, 7, 3, '2025-04-30 23:26:10', 127.90, 56, '2025-04-30 19:23:09', 3, 'follow', 8, 1),
(17, 2, 3, '2025-03-21 08:23:09', 192.92, 37, '2025-02-28 20:23:09', 2, 'wish', 9, 0),
(22, 2, 3, '2025-03-19 12:19:10', 100.49, 78, '2025-02-28 20:26:00', 1, 'practice', 2, 0),
(26, 2, 3, '2025-03-05 03:22:10', 163.88, 40, '2025-02-28 20:26:00', 2, 'production', 6, 0),
(29, 9, 2, '2025-03-20 06:02:36', 151.69, 54, '2025-02-28 20:26:00', 3, 'yard', 5, 0),
(32, 8, 2, '2025-03-11 04:40:06', 99.26, 52, '2025-02-28 20:35:20', 5, 'nor', 6, 0),
(37, 3, 2, '2025-03-09 04:45:28', 141.30, 90, '2025-02-28 20:35:20', 1, 'family', 4, 0),
(40, 8, 28, '2025-05-25 19:59:10', 130.48, 30, '2025-02-28 20:35:20', 4, 'officer', 5, 0),
(41, 36, 28, '2025-05-06 20:34:40', 200.00, 90, '2025-05-06 17:35:50', NULL, 'chat', NULL, 0);

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
(12, 'omar', 'emergencyteam@gmail.com', '$2b$10$owiWkPYuccgXV5fzayJmwusFfSNqVyLjQCqGMMkvAvA9MIBbT/xkS', '0000-00-00', '015534234234', 5000.00, NULL, '2025-04-17 15:35:23'),
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
  `cost` decimal(10,2) DEFAULT NULL,
  `Created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `report_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `replied` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`feedback_ID`, `patient_id`, `doctor_id`, `doctor_type`, `session_id`, `reason`, `response`, `replied`) VALUES
(1, 1, 3, 'doctor', 2, 'Feedback1', NULL, 0),
(2, 6, 2, 'doctor', 4, 'Feedback2', 'mnjklsklfjsdlkf', 0),
(3, 13, 1, 'life_coach', 2, 'Feedback3', 'omar', 0),
(4, 44, 1, 'life_coach', 2, 'Feedback4', 'iudihajshdias', 0),
(5, 37, 21, 'life_coach', 6, 'Feedback5', 'werwerwerwer', 0),
(6, 43, 21, 'life_coach', 6, 'Feedback6', NULL, 0);

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
(5, 8, '2025-02-18 01:59:34', 'Voice speech care home experience. Message able laugh short act feel.');

-- --------------------------------------------------------

--
-- Table structure for table `lifecoach_availability`
--

CREATE TABLE `lifecoach_availability` (
  `id` int(11) NOT NULL,
  `life_coach_ID` int(11) DEFAULT NULL,
  `IsReserved` tinyint(1) DEFAULT 0,
  `available_date` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lifecoach_availability`
--

INSERT INTO `lifecoach_availability` (`id`, `life_coach_ID`, `IsReserved`, `available_date`) VALUES
(1, 21, 1, NULL);

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
(1, 'Lisa Davis', 'christophergarcia@example.net', 'T_a@7SbeH)', '1990-06-11', '(367)562-2824x47061', 'Male', 'Depression', 'Want Congress hour network them expect.', 97.59, 'https://placekitten.com/271/708', '2025-02-28 20:18:53'),
(21, 'omart', 'lifeCoach1@gmail.com', '$2b$10$2Q13nbDAO03W/mDvwh0mieYQihKGb.E.WeHHmwHw0.TJFh4GftCCG', '2001-06-21', '012', 'Male', 'Depression', 'good life_Coach', 1900.00, NULL, '2025-03-03 02:32:31'),
(22, 'omar', 'lifecoach@gmail.com', '$2b$10$Me/H9wqYO0uF4FeP4Voa/./O3RfGy4HAQlLfZsJ9hXEif/WqvDtxa', '0000-00-00', '015534234234', 'Male', 'suicidal Expert', 'suicidal Expert', 300.00, NULL, '2025-04-17 15:32:43'),
(23, 'asdasdasd asdasdasdas', 'fsdfsdfs', '$2b$10$DVIqUgwqT0Alsswmlbf3dOOEe0YqEPjpnxUUxFd2H.TpESwtcOqBu', '2000-04-08', '32434234', 'Male', 'suicidal Expert', 'fsdfsdf', 333.00, NULL, '2025-04-19 16:56:52');

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
  `refunded` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `life_coach_session`
--

INSERT INTO `life_coach_session` (`session_ID`, `coach_ID`, `scheduled_time`, `cost`, `Duration`, `Created_at`, `refunded`) VALUES
(2, 1, '2025-03-29 11:18:59', 97.66, 75, '2025-02-28 20:35:20', 0),
(6, 21, '2025-05-01 03:40:05', 200.00, 60, '2025-05-01 00:40:46', 0);

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
  `time` datetime DEFAULT NULL,
  `message_content` text DEFAULT NULL,
  `Created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `reciver_type` varchar(200) DEFAULT NULL,
  `sender_type` varchar(200) DEFAULT NULL,
  `reciever_id` int(11) DEFAULT NULL,
  `sender_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `message`
--

INSERT INTO `message` (`message_ID`, `chat_ID`, `time`, `message_content`, `Created_at`, `reciver_type`, `sender_type`, `reciever_id`, `sender_id`) VALUES
(1, 3, '2025-02-27 09:12:07', 'Market involve bar safe low prevent.', '2025-02-28 20:35:20', NULL, NULL, NULL, NULL),
(2, 4, '2025-02-20 02:11:06', 'Easy staff miss player ten.', '2025-02-28 20:35:20', NULL, NULL, NULL, NULL),
(3, 1, '2025-01-23 16:05:48', 'Project commercial which.', '2025-02-28 20:35:20', NULL, NULL, NULL, NULL),
(4, 1, '2025-02-18 17:09:28', 'Daughter use visit real first worker range.', '2025-02-28 20:35:20', NULL, NULL, NULL, NULL),
(5, 2, '2025-01-12 22:55:51', 'State view respond left show.', '2025-02-28 20:35:20', NULL, NULL, NULL, NULL),
(6, 4, '2025-02-04 22:39:26', 'Stop hundred color class change practice.', '2025-02-28 20:35:20', NULL, NULL, NULL, NULL),
(7, 4, '2025-02-23 07:15:14', 'Participant least message available alone throughout.', '2025-02-28 20:35:20', NULL, NULL, NULL, NULL),
(8, 2, '2025-02-26 11:56:36', 'Country west general close year.', '2025-02-28 20:35:20', NULL, NULL, NULL, NULL),
(9, 2, '2025-01-11 12:09:37', 'East likely put occur option participant prepare.', '2025-02-28 20:35:20', NULL, NULL, NULL, NULL),
(10, 3, '2025-01-15 13:44:41', 'Medical determine reality discover century source avoid.', '2025-02-28 20:35:20', NULL, NULL, NULL, NULL);

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
  `Therapist_Preference` varchar(50) DEFAULT NULL,
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
(3, 'Kristin Rodriguez', 'tanthony@example.com', '3OK3+XjT%$', '2025-02-28 20:18:53', '1953-02-06', '964.676.1226x319', 'Single', 'Female', 'Nearly else better culture little response.', 'Female', 'https://picsum.photos/712/105', 0),
(4, 'Nancy Cordova', 'xjohnston@example.com', '8K0Pzfhd@b', '2025-02-28 20:18:53', '1987-09-18', '(821)359-6464x244', 'Divorced', 'No Preference', 'Present skin sister painting focus fact center treat.', 'Male', 'https://placekitten.com/241/811', 0),
(6, 'Andrew Martinez', 'fcantrell@example.net', ')i8OUT)2L+', '2025-02-28 20:18:53', '1952-03-11', '823.802.4986x1297', 'Divorced', 'No Preference', 'Seat month small project forward.', 'Other', 'https://picsum.photos/702/663', 108.62),
(7, 'Raymond Yang', 'juan83@example.net', '%8Z!Qsy2r_', '2025-02-28 20:18:53', '1981-12-19', '+1-923-459-1577', 'Divorced', 'Male', 'True describe successful treatment.', 'Other', 'https://dummyimage.com/310x316', 0),
(8, 'Christopher Davis', 'mcbridechristian@example.com', '#83gAfIwIR', '2025-02-28 20:18:53', '1943-05-21', '(823)261-9208x835', 'Divorced', 'Male', 'Treat soon finish we cold author.', 'Other', 'https://placekitten.com/999/855', 0),
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
(36, 'Brandi Walsh', 'michaelbrown@example.org', '^tkY2Uk1+4', '2025-02-28 20:35:20', '1969-12-07', '(743)544-0937', 'Married', 'No Preference', 'Eye minute trip almost sense meeting.', 'Other', 'https://placekitten.com/168/695', 0),
(37, 'Jessica Powell', 'xbaker@example.org', '!3qOjzXA(0', '2025-02-28 20:35:20', '1981-11-25', '001-764-444-6305x958', 'Divorced', 'Female', 'Responsibility eat stand position understand clearly knowledge.', 'Other', 'https://picsum.photos/631/638', 400),
(38, 'Michael Ellis', 'nmercer@example.net', 'l&$2ES6ntH', '2025-02-28 20:35:20', '1980-06-11', '203-842-3375x8905', 'Married', 'No Preference', 'Education unit join while.', 'Female', 'https://picsum.photos/440/914', 0),
(39, 'Jackson Waters', 'garyblack@example.com', '#b@1Sr&NBy', '2025-02-28 20:35:20', '1991-08-15', '001-532-231-7962', 'Divorced', 'Female', 'Audience on challenge but leader born line apply.', 'Female', 'https://placekitten.com/231/600', 0),
(40, 'Timothy Alvarez', 'russellanthony@example.org', 'LAqB$Zh!!4', '2025-02-28 20:35:20', '1979-08-23', '001-270-993-5984x785', 'Single', 'No Preference', 'Memory dark artist population.', 'Female', 'https://placekitten.com/849/802', 0),
(42, 'omart', 'patient1@gmail.com', '$2b$10$CN5McTqIjuLrEfFzmh/dG.0oDbku8XUeXHdbnThQtm6pQ8e2WrGf6', '2025-03-03 02:41:26', '2001-06-21', '012', 'married', NULL, NULL, 'Male', NULL, 0),
(43, 'omar', 'patient@gmail.com', '$2b$10$H3yhzYC36blatE6GCfXHP.aL4XpEcTop3f6p0WLxBLEu.MsTF3Z0G', '2025-04-17 15:29:28', '0000-00-00', '015534234234', 'single', NULL, NULL, 'Male', NULL, 400),
(44, 'Jana', 'jana@gmail.com', '$2b$10$3Rjtw9LHeTnfbnHF57NAMuQazrtJhPYBt7TPB6H4nJQn25jyNm31O', '2025-04-28 10:51:43', '2005-01-09', '79847287498', 'Single', NULL, NULL, 'Female', NULL, 195.32),
(45, 'Jana', 'jana1@gmail.com', '$2b$10$812z935xCxHw5jjB3auYqO9gFiVL3dhgKWLpNQO2AZPmhMt2GrcDO', '2025-04-28 10:52:13', '2005-01-09', '79847287498', 'Single', NULL, NULL, 'Female', NULL, 0),
(46, 'jana', 'jana3@gmail.com', '$2b$10$d.fTZOyG/.cinIr5r4l51u8S3D.oyJ6McKgto/Q4BGj5IeXgLEesK', '2025-04-28 10:53:48', '2005-01-09', '798274982374', 'Single', NULL, NULL, 'Female', NULL, 0),
(47, 'Jana', 'jana5@gmail.com', '$2b$10$PHps2zsmikcCzbvvSZtBt.MoP/xiOZ87HAfQkuKEzjyTaU.uVL91G', '2025-04-28 10:58:45', '2005-01-09', '92783623489', 'Single', NULL, NULL, 'Female', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `patient_lifecoach_session`
--

CREATE TABLE `patient_lifecoach_session` (
  `patient_ID` int(11) NOT NULL,
  `session_ID` int(11) NOT NULL,
  `report_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient_lifecoach_session`
--

INSERT INTO `patient_lifecoach_session` (`patient_ID`, `session_ID`, `report_id`, `rating`) VALUES
(13, 2, NULL, 0),
(37, 6, NULL, 0),
(43, 6, NULL, 0),
(44, 2, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `report` (
  `report_ID` int(11) NOT NULL,
  `time` datetime DEFAULT NULL,
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
(45, '2025-01-09 03:26:08', 'Late blood animal rule ready than. Drop bed next so certain safe city. Water Mr cost born baby.', NULL, NULL, 'doctor');

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
  ADD KEY `team_member_ID` (`team_member_ID`),
  ADD KEY `fk_ET_report` (`report_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `chat_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `chatbot_session`
--
ALTER TABLE `chatbot_session`
  MODIFY `chatbot_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `doctor`
--
ALTER TABLE `doctor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `doctor_availability`
--
ALTER TABLE `doctor_availability`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `doctor_session`
--
ALTER TABLE `doctor_session`
  MODIFY `session_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `emergency_team`
--
ALTER TABLE `emergency_team`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `emergency_team_session`
--
ALTER TABLE `emergency_team_session`
  MODIFY `session_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `feedback_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `journal`
--
ALTER TABLE `journal`
  MODIFY `journal_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `lifecoach_availability`
--
ALTER TABLE `lifecoach_availability`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `life_coach`
--
ALTER TABLE `life_coach`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `life_coach_session`
--
ALTER TABLE `life_coach_session`
  MODIFY `session_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `manager`
--
ALTER TABLE `manager`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `message_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `report`
--
ALTER TABLE `report`
  MODIFY `report_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

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
  ADD CONSTRAINT `emergency_team_session_ibfk_2` FOREIGN KEY (`team_member_ID`) REFERENCES `emergency_team` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ET_report` FOREIGN KEY (`report_id`) REFERENCES `report` (`report_ID`) ON DELETE CASCADE;

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
