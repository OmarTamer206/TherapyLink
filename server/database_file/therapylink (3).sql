-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 15, 2025 at 06:13 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

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
(1, 'Lawrence Goodwin', 'usherman@example.com', '^2Jmisk8M*', '1997-05-18', 'Male', '612-787-5605x413', 3335.74, 'https://placekitten.com/835/24', '2025-02-28 20:26:00'),
(2, 'Erica Stein', 'kterry@example.org', 'V&7ShfUg5h', '1993-09-03', 'Male', '001-958-744-0413x935', 3901.86, 'https://placekitten.com/731/97', '2025-02-28 20:26:00'),
(3, 'Jonathan Jacobs', 'jeffreygonzales@example.net', 'jlXm1AUaa%', '1980-08-04', 'Male', '7436519447', 5323.74, 'https://dummyimage.com/10x729', '2025-02-28 20:26:00'),
(4, 'Tara Johnson', 'klivingston@example.net', '(iFh8gRuY+', '1993-03-01', 'Female', '001-699-618-3899x432', 7463.09, 'https://placekitten.com/691/52', '2025-02-28 20:35:20'),
(6, 'Jennifer Montgomery', 'adelgado@example.org', '&h8@1dLlu2', '1974-04-02', 'Male', '664.508.4089', 6424.47, 'https://placekitten.com/409/372', '2025-02-28 20:35:20'),
(7, 'omar', 'admin1@gmail.com', '$2b$10$FalDDoTJ3/uBWYnMVkhu9eiIobIHvdvN9G6u7gIF6dQ4tofS77qZ.', '0000-00-00', 'Male', '012', 1900.00, 'test', '2025-03-03 02:08:35'),
(8, 'omar', 'admin2@gmail.com', '$2b$10$xxZWApYK67.emZM8a4rhPOnB9S08Uu5fJERpnQ3rwF2/BSv66JZYK', '0000-00-00', 'Male', '012', 1900.00, NULL, '2025-03-03 02:09:22'),
(9, 'omart', 'admin3@gmail.com', '$2b$10$O/wcFOiBebayJE19f4QuGeMbPZf1yyHovfmC4eG1FR6TX6bsgHbuq', '2001-06-21', 'Male', '012', 1900.00, NULL, '2025-03-03 02:18:28');

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
(1, 'Andrea Harris', 'rhoward@example.com', '(5LKVdfg%9', '1987-05-19', '378-574-9937x008', 'Male', 'End law else daughter.', 'Town planner', 108.47, '2025-02-28 20:18:53', NULL),
(2, 'Brittany Graham', 'ashleygomez@example.org', 'KBV_5PiMRT', '1975-07-30', '+1-328-959-6785x8100', 'Male', 'Sort staff actually week choice quite door.', 'Brewing technologist', 64.50, '2025-02-28 20:18:53', NULL),
(3, 'Bruce Bradford', 'qmyers@example.org', 'z!OP#cg7_8', '1969-08-25', '(902)433-6552x50701', 'Female', 'Tough deal letter season finally involve.', 'Museum/gallery curator', 106.34, '2025-02-28 20:18:53', NULL),
(4, 'Jeremy Leonard', 'volson@example.com', '!%zv2OSyn+', '1987-05-30', '001-840-201-1309x629', 'Female', 'As political statement.', 'Industrial buyer', 155.58, '2025-02-28 20:18:53', NULL),
(6, 'Maurice Ellis', 'antoniopetersen@example.com', '^8S57Bvw9o', '1985-04-25', '877-534-7557', 'Male', 'Cultural special drop animal.', 'Marine scientist', 62.61, '2025-02-28 20:23:09', NULL),
(7, 'Vicki Baldwin', 'dnoble@example.org', 'c+89VUit_6', '1984-09-05', '320-374-7419x360', 'Male', 'Middle statement arm.', 'Geneticist, molecular', 107.71, '2025-02-28 20:23:09', NULL),
(8, 'Dr. Alexander Ortiz', 'carterseth@example.com', '$Gvt2G!hpi', '1955-01-11', '793.995.7942', 'Female', 'Hospital picture away customer church.', 'English as a foreign language teacher', 92.49, '2025-02-28 20:23:09', NULL),
(9, 'Dr. Todd Sampson', 'teresa75@example.com', '*4Wswq_En(', '1981-07-16', '(530)610-0163x271', 'Male', 'Class of deal seven.', 'Analytical chemist', 53.38, '2025-02-28 20:23:09', NULL),
(10, 'John Kramer', 'denisereed@example.net', 'sG&7ZlIZU^', '1962-03-23', '(519)367-1076', 'Female', 'Former note later everyone lead focus everyone.', 'Video editor', 173.14, '2025-02-28 20:23:09', NULL),
(11, 'Craig Martinez', 'beckevelyn@example.org', '&3aLqPrjO7', '1997-01-25', '509.224.3937', 'Female', 'Into also role group.', 'Midwife', 138.68, '2025-02-28 20:26:00', NULL),
(12, 'Lawrence Aguilar', 'cconrad@example.org', 'HyC67D+X!2', '1981-06-27', '001-427-776-9346x013', 'Female', 'Large forget anything doctor get.', 'Nurse, learning disability', 113.37, '2025-02-28 20:26:00', NULL),
(13, 'Amanda Harrison', 'jensenamanda@example.org', '&eEdTou%!7', '1997-12-03', '459-833-8362', 'Male', 'Prove share east my head most glass.', 'Historic buildings inspector/conservation officer', 116.90, '2025-02-28 20:26:00', NULL),
(14, 'James Burns', 'jamesrogers@example.net', 'RSw&R2Zir^', '1978-01-09', '552-487-5433x9382', 'Male', 'North official from would.', 'Chief Financial Officer', 78.98, '2025-02-28 20:26:00', NULL),
(15, 'Henry Flores', 'williamsbrandon@example.org', 'UG0kWPWx(z', '1997-08-15', '436.307.1587x15008', 'Male', 'Sure at majority country which.', 'Actuary', 120.94, '2025-02-28 20:26:00', NULL),
(16, 'Jennifer Eaton MD', 'beckergregory@example.org', ')5fGqy*yhk', '1975-06-11', '(360)667-5214x26265', 'Male', 'Several thought threat idea.', 'Nurse, children\'s', 136.33, '2025-02-28 20:35:20', NULL),
(17, 'Eric Woods', 'laura74@example.net', '91YFqYam+x', '1991-10-02', '218-334-1744', 'Female', 'Traditional office determine carry nice per listen.', 'Pharmacist, hospital', 98.97, '2025-02-28 20:35:20', NULL),
(18, 'Ricardo Washington', 'pgill@example.net', '3hV%9vuq!x', '1958-02-28', '+1-460-345-8129x056', 'Male', 'Light argue window.', 'Scientist, physiological', 71.09, '2025-02-28 20:35:20', NULL),
(19, 'Craig White', 'andrew81@example.com', 'n#8ZaNgf$9', '1988-05-29', '+1-674-557-3764x8160', 'Male', 'Sing kid increase song seven trouble.', 'Technical author', 136.11, '2025-02-28 20:35:20', NULL),
(20, 'John Davis', 'xroy@example.org', '@TJkgm@j58', '1967-05-22', '+1-799-781-3570x923', 'Female', 'Less nearly step baby bar I threat.', 'Estate agent', 74.11, '2025-02-28 20:35:20', NULL),
(21, 'omart', 'manager1@gmail.com', '$2b$10$Ru01N/DYkKuVOkDkyh0ZUuVPO20J10b9zFKdQz96tnRUf.2HRFN/O', '2001-06-21', '012', 'Male', 'good doctor', 'Depression', 1900.00, '2025-03-03 02:31:11', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `doctor_availability`
--

CREATE TABLE `doctor_availability` (
  `id` int(11) NOT NULL,
  `doctor_ID` int(11) DEFAULT NULL,
  `AvailableDate` date DEFAULT NULL,
  `StartTime` time DEFAULT NULL,
  `EndTime` time DEFAULT NULL,
  `IsReserved` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `feedback` text DEFAULT NULL,
  `communication_type` varchar(50) DEFAULT NULL,
  `report_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor_session`
--

INSERT INTO `doctor_session` (`session_ID`, `patient_ID`, `doctor_ID`, `scheduled_time`, `cost`, `Duration`, `Created_at`, `rating`, `feedback`, `communication_type`, `report_id`) VALUES
(1, 3, 4, '2025-03-23 12:39:24', 147.94, 65, '2025-02-28 20:18:53', 3, 'Pm about society seem color get.', 'small', 6),
(2, 1, 3, '2025-03-12 22:11:26', 163.42, 118, '2025-02-28 20:18:53', 2, 'Carry deep usually.', 'follow', 1),
(4, 6, 2, '2025-03-03 02:59:47', 108.62, 73, '2025-02-28 20:18:53', 3, 'Fight machine usually job market pull interview.', 'especially', 3),
(7, 2, 1, '2025-03-21 04:10:08', 135.61, 99, '2025-02-28 20:18:53', 2, 'Talk often garden indeed society.', 'off', 6),
(8, 2, 4, '2025-03-02 13:39:39', 155.31, 32, '2025-02-28 20:18:53', 1, 'Dream able to stuff these leg vote.', 'why', 4),
(9, 8, 1, '2025-03-21 13:40:15', 154.68, 84, '2025-02-28 20:18:53', 2, 'Democratic whether space effect policy story past score.', 'information', 9),
(12, 7, 3, '2025-02-28 23:26:10', 127.90, 56, '2025-02-28 20:23:09', 3, 'Dark sing audience energy with party pull.', 'follow', 8),
(15, 4, 4, '2025-03-17 10:57:38', 198.89, 44, '2025-02-28 20:23:09', 1, 'Vote computer size your feeling final.', 'sea', 5),
(17, 2, 3, '2025-03-21 08:23:09', 192.92, 37, '2025-02-28 20:23:09', 2, 'Congress shake operation garden.', 'wish', 9),
(18, 7, 4, '2025-03-17 15:39:52', 71.34, 47, '2025-02-28 20:23:09', 2, 'Avoid whole require.', 'move', 10),
(19, 6, 4, '2025-03-02 06:47:19', 173.43, 105, '2025-02-28 20:23:09', 5, 'Loss friend really president main it role out.', 'poor', 2),
(21, 7, 4, '2025-03-27 22:34:08', 88.86, 90, '2025-02-28 20:26:00', 1, 'Talk speak daughter goal bad.', 'significant', 4),
(22, 2, 3, '2025-03-19 12:19:10', 100.49, 78, '2025-02-28 20:26:00', 1, 'Medical human economy letter their fight.', 'practice', 2),
(26, 2, 3, '2025-03-05 03:22:10', 163.88, 40, '2025-02-28 20:26:00', 2, 'Gun series executive candidate relate.', 'production', 6),
(27, 3, 1, '2025-03-07 19:22:03', 137.04, 97, '2025-02-28 20:26:00', 1, 'Beautiful economy generation line.', 'among', 6),
(28, 1, 4, '2025-03-12 21:45:11', 58.65, 94, '2025-02-28 20:26:00', 2, 'Paper stock garden race important.', 'beyond', 3),
(29, 9, 2, '2025-03-20 06:02:36', 151.69, 54, '2025-02-28 20:26:00', 3, 'Home whose either.', 'yard', 5),
(30, 7, 1, '2025-03-24 03:45:10', 98.19, 100, '2025-02-28 20:26:00', 2, 'Personal national specific none couple thank.', 'story', 2),
(31, 2, 1, '2025-03-02 16:47:08', 130.90, 114, '2025-02-28 20:35:20', 3, 'Modern low put make.', 'administration', 1),
(32, 8, 2, '2025-03-11 04:40:06', 99.26, 52, '2025-02-28 20:35:20', 5, 'Religious laugh because capital ready try sea.', 'nor', 6),
(33, 8, 1, '2025-03-27 10:10:48', 109.80, 86, '2025-02-28 20:35:20', 5, 'Miss allow include image significant value event challenge.', 'audience', 2),
(34, 6, 1, '2025-03-20 10:51:56', 109.75, 34, '2025-02-28 20:35:20', 2, 'Development culture less read meeting few maybe design.', 'candidate', 10),
(37, 3, 2, '2025-03-09 04:45:28', 141.30, 90, '2025-02-28 20:35:20', 1, 'Win policy college contain war tell.', 'family', 4),
(39, 6, 1, '2025-03-11 23:46:43', 86.48, 75, '2025-02-28 20:35:20', 4, 'Staff at total lot situation.', 'sort', 9),
(40, 8, 2, '2025-03-25 19:59:10', 130.48, 30, '2025-02-28 20:35:20', 4, 'Kitchen account style you memory character.', 'officer', 5);

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
(1, 'Harold Callahan', 'christopher03@example.org', 'XRIeTQnk$6', '1999-03-15', '001-519-829-3125x797', 2731.97, 'https://placekitten.com/427/782', '2025-02-28 20:26:00'),
(2, 'Natalie Johnson', 'jhuang@example.com', 'MS%69Psc_0', '1998-01-04', '001-668-621-0955x286', 5950.34, 'https://placekitten.com/310/208', '2025-02-28 20:26:00'),
(3, 'Nicole Zuniga', 'hancockmary@example.com', '3t71GUaoM@', '1994-10-01', '532.524.0441x7445', 4953.47, 'https://picsum.photos/376/104', '2025-02-28 20:26:00'),
(4, 'Rachel Simpson', 'hodgesamanda@example.net', '_Q#2JVed7U', '1988-06-21', '775.303.8865', 4738.04, 'https://placekitten.com/695/36', '2025-02-28 20:26:00'),
(6, 'Jon Wallace', 'elizabeth88@example.com', ')gUpTmrzU6', '1992-05-26', '241.319.6615', 5145.11, 'https://dummyimage.com/324x310', '2025-02-28 20:35:20'),
(7, 'Andrew Roberson', 'maryjones@example.net', ')xA6zjZi0u', '1982-09-26', '001-474-434-6229', 3872.53, 'https://dummyimage.com/288x345', '2025-02-28 20:35:20'),
(8, 'Mary Hill', 'beth06@example.org', '&3@CmO6OJk', '1998-07-10', '(292)620-6670x885', 5378.20, 'https://placekitten.com/873/867', '2025-02-28 20:35:20'),
(9, 'Joseph Hughes', 'derek00@example.com', 'Z223OmxM2$', '1969-11-09', '+1-789-928-8137x557', 3046.29, 'https://dummyimage.com/554x961', '2025-02-28 20:35:20'),
(10, 'Cheryl Weber', 'schultzphillip@example.org', ')8o65PZyz+', '1981-03-28', '(801)552-0413x8678', 5631.89, 'https://dummyimage.com/403x26', '2025-02-28 20:35:20'),
(11, 'omart', 'emergency1@gmail.com', '$2b$10$NO4lO55e3Uw3UYcQb4NDkeyJRj/Zc.Kn1bakqzxqar8DOOp4KRmlG', '2001-06-21', '012', 1900.00, NULL, '2025-03-03 02:34:18');

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

--
-- Dumping data for table `emergency_team_session`
--

INSERT INTO `emergency_team_session` (`session_ID`, `patient_ID`, `team_member_ID`, `time`, `cost`, `Created_at`, `report_id`) VALUES
(1, 2, 1, '2025-03-15 13:44:22', 411.16, '2025-02-28 20:35:20', NULL),
(2, 7, 4, '2025-03-05 18:03:02', 479.57, '2025-02-28 20:35:20', NULL),
(3, 1, 1, '2025-03-23 12:38:07', 178.83, '2025-02-28 20:35:20', NULL),
(4, 3, 4, '2025-03-20 20:00:42', 232.83, '2025-02-28 20:35:20', NULL),
(5, 6, 3, '2025-03-25 03:23:35', 383.04, '2025-02-28 20:35:20', NULL);

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
  `AvailableDate` date DEFAULT NULL,
  `StartTime` time DEFAULT NULL,
  `EndTime` time DEFAULT NULL,
  `IsReserved` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, 'Lisa Davis', 'christophergarcia@example.net', 'T_a@7SbeH)', '1990-06-11', '(367)562-2824x47061', 'Male', 'Records manager', 'Want Congress hour network them expect.', 97.59, 'https://placekitten.com/271/708', '2025-02-28 20:18:53'),
(2, 'Norma Le', 'mcdonaldnatalie@example.com', 'IKkLbUq5$5', '1963-01-25', '001-921-253-4532x683', 'Male', 'Barrister\'s clerk', 'Film lot field fund item green we.', 55.15, 'https://placekitten.com/552/27', '2025-02-28 20:18:53'),
(3, 'Roberta Caldwell', 'ajohnson@example.org', ')7Oz1Qb+oi', '1956-10-05', '354.587.9309x6155', 'Male', 'Systems developer', 'Force drug current table scene consider century toward.', 123.15, 'https://dummyimage.com/441x14', '2025-02-28 20:18:53'),
(4, 'Kyle Robles', 'qwatson@example.net', '*s1&FOxOrB', '1981-11-03', '7893602422', 'Female', 'Logistics and distribution manager', 'Run possible do fire decision second.', 95.53, 'https://placekitten.com/94/994', '2025-02-28 20:18:53'),
(6, 'Anthony Caldwell', 'marquezdustin@example.net', '@!5JSMq2b(', '1979-06-24', '747.687.6502', 'Female', 'Retail buyer', 'Leader defense kitchen article machine green boy.', 117.55, 'https://placekitten.com/115/749', '2025-02-28 20:23:09'),
(7, 'Dawn Castillo', 'willisrebecca@example.org', 'P*2vKHgsio', '1983-04-23', '2345789884', 'Female', 'Newspaper journalist', 'Better worker goal stock everybody live.', 116.59, 'https://picsum.photos/445/658', '2025-02-28 20:23:09'),
(8, 'Olivia Craig DDS', 'michael92@example.com', 'kDq*8oVyD2', '1999-09-28', '(635)964-8763x88807', 'Female', 'Clinical research associate', 'During music open plant social record.', 31.60, 'https://placekitten.com/334/464', '2025-02-28 20:23:09'),
(9, 'Michael Robinson', 'qtorres@example.org', '+PJJQqyr8F', '1998-08-17', '(216)820-0247x47000', 'Male', 'Clinical research associate', 'Tax age these company deal.', 149.57, 'https://placekitten.com/677/878', '2025-02-28 20:23:09'),
(10, 'Edwin Adams', 'holly24@example.com', '(pmZZKkcd4', '1976-10-23', '810-447-4759x9663', 'Female', 'Archivist', 'Service response white writer marriage.', 105.70, 'https://dummyimage.com/706x899', '2025-02-28 20:23:09'),
(11, 'Kenneth Martinez', 'williamsjoseph@example.net', '!0nM^haP1s', '1983-08-02', '684.515.6252x0314', 'Male', 'Air cabin crew', 'Public until organization industry positive.', 51.16, 'https://picsum.photos/79/24', '2025-02-28 20:26:00'),
(12, 'Kelly Soto', 'christopherreyes@example.org', '+ae$2oTgc4', '1999-03-02', '001-444-628-6108x726', 'Male', 'Medical illustrator', 'Hold once enough because indeed.', 58.64, 'https://picsum.photos/491/713', '2025-02-28 20:26:00'),
(13, 'Adrienne Klein', 'breyes@example.net', 'yqC5Zvd%$C', '1976-04-18', '(854)324-4958', 'Male', 'Surgeon', 'Lay night product grow including fill.', 149.27, 'https://placekitten.com/131/824', '2025-02-28 20:26:00'),
(14, 'Laurie Bennett', 'fbrown@example.org', '!n%8xXBeUa', '1960-09-05', '(495)476-1480x29261', 'Female', 'Amenity horticulturist', 'Hospital large place fine heavy.', 116.06, 'https://dummyimage.com/822x735', '2025-02-28 20:26:00'),
(15, 'Mitchell Burke', 'vbauer@example.com', '!5rUBDrn(u', '1959-03-26', '001-554-430-5266x637', 'Female', 'Production manager', 'Share democratic responsibility support reach base rest.', 91.61, 'https://placekitten.com/738/825', '2025-02-28 20:26:00'),
(16, 'Alexander Robinson', 'ugonzalez@example.org', 'Ii9hB$nK^U', '1979-09-11', '731.736.0574', 'Female', 'Public librarian', 'Campaign career together table culture none long.', 47.63, 'https://dummyimage.com/639x115', '2025-02-28 20:35:20'),
(17, 'Charles Davis', 'marylopez@example.com', 'QI4rIxzq(k', '1963-08-18', '(618)336-6727x53022', 'Female', 'Fast food restaurant manager', 'Nor beat single example.', 30.19, 'https://placekitten.com/634/293', '2025-02-28 20:35:20'),
(18, 'Brittany Johnson', 'lgates@example.net', 'F*2Gfzm01K', '1957-04-03', '835-940-4828', 'Male', 'Psychotherapist, child', 'Product check scene million difficult indeed wife.', 117.77, 'https://dummyimage.com/706x717', '2025-02-28 20:35:20'),
(19, 'Kristin White', 'kristenfox@example.net', 'XLD4BIAi!z', '1999-04-30', '697.302.5528x2912', 'Male', 'Administrator, sports', 'Second detail huge simple.', 68.50, 'https://dummyimage.com/854x914', '2025-02-28 20:35:20'),
(20, 'Paul Foster', 'brownoscar@example.net', '2%ElB2bc_u', '1982-01-11', '+1-399-727-4858', 'Female', 'Production designer, theatre/television/film', 'Together change modern beat because.', 119.45, 'https://placekitten.com/104/750', '2025-02-28 20:35:20'),
(21, 'omart', 'lifeCoach1@gmail.com', '$2b$10$2Q13nbDAO03W/mDvwh0mieYQihKGb.E.WeHHmwHw0.TJFh4GftCCG', '2001-06-21', '012', 'Male', 'Depression', 'good life_Coach', 1900.00, NULL, '2025-03-03 02:32:31');

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
  `rating` int(11) DEFAULT NULL,
  `feedback` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `life_coach_session`
--

INSERT INTO `life_coach_session` (`session_ID`, `coach_ID`, `scheduled_time`, `cost`, `Duration`, `Created_at`, `rating`, `feedback`) VALUES
(1, 3, '2025-03-29 05:43:47', 125.30, 118, '2025-02-28 20:35:20', 2, 'Media walk score yes wonder rule skill.'),
(2, 1, '2025-03-29 11:18:59', 97.66, 75, '2025-02-28 20:35:20', 4, 'Six remember mission daughter final perhaps.'),
(3, 2, '2025-03-03 07:37:24', 93.81, 58, '2025-02-28 20:35:20', 2, 'Outside force financial style public recent practice.'),
(4, 3, '2025-03-03 05:10:03', 145.14, 84, '2025-02-28 20:35:20', 3, 'Modern individual most left south for challenge instead.'),
(5, 3, '2025-03-28 05:56:31', 97.56, 92, '2025-02-28 20:35:20', 4, 'Little community industry professor yeah.');

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
(1, 'Brandon Nelson', 'joecruz@example.com', '$^!0UUruUj', '1965-08-14', 'Female', '001-297-833-5660x278', 6013.52, 'https://placekitten.com/879/67', '2025-02-28 20:26:00'),
(2, 'Jodi Todd', 'aaronhenderson@example.com', '^0Blo6UaAv', '1977-11-12', 'Female', '001-696-647-2193x866', 4143.31, 'https://dummyimage.com/389x996', '2025-02-28 20:26:00'),
(3, 'Tammie Reid', 'mcculloughmichael@example.net', 'fSc7AoM$^&', '1986-09-13', 'Female', '5936174684', 8573.36, 'https://picsum.photos/1019/661', '2025-02-28 20:26:00'),
(4, 'Martin Clark', 'whitekathryn@example.org', 'V_Wq^cqU@9', '1979-08-09', 'Male', '001-421-585-5481x935', 5881.49, 'https://dummyimage.com/788x286', '2025-02-28 20:35:20'),
(6, 'Scott Anderson', 'fowlerjames@example.net', ')IF7Z!+8s5', '1977-08-27', 'Male', '+1-422-976-8534x0092', 8440.68, 'https://dummyimage.com/448x62', '2025-02-28 20:35:20'),
(7, 'omart', 'manager1@gmail.com', '$2b$10$1N6EXwQRpNHQ2ZxjVB.TFOx1EgwMWUE2uHLj3MsQCkSw3CSfxtNQS', '2001-06-21', 'Male', '012', 1900.00, NULL, '2025-03-03 02:28:27');

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
  `Profile_pic_url` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`id`, `Name`, `Email`, `Password`, `Created_at`, `Date_Of_Birth`, `phone_number`, `Marital_Status`, `Therapist_Preference`, `Diagnosis`, `Gender`, `Profile_pic_url`) VALUES
(1, 'Michael Fisher', 'tranchristopher@example.org', 'e2SoIFEb@o', '2025-02-28 20:18:53', '1937-01-22', '9213850654', 'Married', 'No Preference', 'Group material focus hold chance.', 'Other', 'https://picsum.photos/21/112'),
(2, 'Kevin Martinez', 'heather88@example.com', '^A^z8AqQpz', '2025-02-28 20:18:53', '1949-01-23', '986.757.6745x68184', 'Single', 'Male', 'Little idea imagine week test teach attention production.', 'Other', 'https://dummyimage.com/635x468'),
(3, 'Kristin Rodriguez', 'tanthony@example.com', '3OK3+XjT%$', '2025-02-28 20:18:53', '1953-02-06', '964.676.1226x319', 'Single', 'Female', 'Nearly else better culture little response.', 'Female', 'https://picsum.photos/712/105'),
(4, 'Nancy Cordova', 'xjohnston@example.com', '8K0Pzfhd@b', '2025-02-28 20:18:53', '1987-09-18', '(821)359-6464x244', 'Divorced', 'No Preference', 'Present skin sister painting focus fact center treat.', 'Male', 'https://placekitten.com/241/811'),
(6, 'Andrew Martinez', 'fcantrell@example.net', ')i8OUT)2L+', '2025-02-28 20:18:53', '1952-03-11', '823.802.4986x1297', 'Divorced', 'No Preference', 'Seat month small project forward.', 'Other', 'https://picsum.photos/702/663'),
(7, 'Raymond Yang', 'juan83@example.net', '%8Z!Qsy2r_', '2025-02-28 20:18:53', '1981-12-19', '+1-923-459-1577', 'Divorced', 'Male', 'True describe successful treatment.', 'Other', 'https://dummyimage.com/310x316'),
(8, 'Christopher Davis', 'mcbridechristian@example.com', '#83gAfIwIR', '2025-02-28 20:18:53', '1943-05-21', '(823)261-9208x835', 'Divorced', 'Male', 'Treat soon finish we cold author.', 'Other', 'https://placekitten.com/999/855'),
(9, 'Daniel Mcdonald', 'wyattkrystal@example.org', 'x2tJ7q_u*Q', '2025-02-28 20:18:53', '2002-06-21', '202-507-5667', 'Single', 'No Preference', 'Thus skill hit new.', 'Other', 'https://dummyimage.com/937x542'),
(10, 'Rachel Crawford', 'aprilfernandez@example.org', '+zU1CNL&D2', '2025-02-28 20:18:53', '2003-05-11', '3436582965', 'Divorced', 'Male', 'Thus win manage beautiful cold only I.', 'Female', 'https://picsum.photos/8/809'),
(11, 'Timothy Spears', 'rserrano@example.net', '_+18yKud(Z', '2025-02-28 20:23:09', '1951-06-27', '851-457-5658x394', 'Married', 'Male', 'Theory student face night majority around.', 'Other', 'https://dummyimage.com/383x59'),
(12, 'Cathy Thompson', 'butlerbradley@example.net', 'NeI(5DoL)&', '2025-02-28 20:23:09', '1956-05-01', '6699734057', 'Single', 'Female', 'Myself information industry indicate economic power.', 'Female', 'https://picsum.photos/87/209'),
(13, 'Adrian Washington', 'ray93@example.com', '^AVvQlpzY0', '2025-02-28 20:23:09', '1985-11-04', '(373)573-0913', 'Divorced', 'Female', 'Sometimes attention cell democratic.', 'Male', 'https://dummyimage.com/484x89'),
(14, 'Kristen Reynolds', 'watsonmichael@example.com', 'YIlG5Nv)D+', '2025-02-28 20:23:09', '1989-05-27', '(916)628-3092x746', 'Married', 'Male', 'Scientist beyond enjoy rich theory true.', 'Male', 'https://placekitten.com/819/368'),
(15, 'Kimberly Reid', 'inguyen@example.org', 'PWa!3GSj_T', '2025-02-28 20:23:09', '1961-11-03', '(384)927-6331', 'Divorced', 'Female', 'Majority degree Republican performance south simply hard.', 'Other', 'https://picsum.photos/347/594'),
(16, 'Nancy Guerra', 'ygriffin@example.org', 'L!9TwcLY3r', '2025-02-28 20:23:09', '1962-07-26', '694-492-7211x8359', 'Single', 'Female', 'Across should serve reflect water.', 'Other', 'https://placekitten.com/465/504'),
(17, 'Roy Miller', 'atkinsjohn@example.com', 'Q9z57UfhX#', '2025-02-28 20:23:09', '1963-07-06', '(542)606-6940x807', 'Divorced', 'No Preference', 'Indicate mind democratic field compare effort cause brother.', 'Female', 'https://placekitten.com/243/376'),
(18, 'Richard Alvarez', 'loweamy@example.com', '&bIBHh)8I8', '2025-02-28 20:23:09', '1987-01-27', '+1-860-703-3670x702', 'Single', 'Female', 'Agency decade your thousand significant.', 'Other', 'https://dummyimage.com/522x24'),
(19, 'Wayne Santos', 'brandonphillips@example.com', '8g)30UrE#1', '2025-02-28 20:23:09', '1972-05-01', '001-280-281-9407x602', 'Divorced', 'Female', 'Big carry admit treat trial.', 'Female', 'https://picsum.photos/370/1005'),
(20, 'Jason Barnes', 'lmartinez@example.net', '^0IDDdj@@s', '2025-02-28 20:23:09', '1995-06-05', '249-305-0912x5409', 'Married', 'No Preference', 'Owner sense program hope though blood begin.', 'Other', 'https://dummyimage.com/800x384'),
(21, 'Julia Silva', 'mdavis@example.com', '+w7XA5b%k%', '2025-02-28 20:26:00', '1953-09-18', '+1-667-341-7977x2117', 'Single', 'No Preference', 'Moment everyone real shake sell really rich chair.', 'Male', 'https://dummyimage.com/193x64'),
(22, 'Kathleen Cuevas', 'brandonjames@example.org', 'i6c)7XPo5X', '2025-02-28 20:26:00', '1949-06-03', '(647)506-7845x64216', 'Divorced', 'Female', 'Occur similar discuss adult close.', 'Other', 'https://dummyimage.com/524x88'),
(23, 'David Bennett', 'julie68@example.net', 'peNXnHcy(9', '2025-02-28 20:26:00', '1940-04-18', '+1-448-599-7524x8321', 'Divorced', 'Female', 'Trade history recent value eat need.', 'Male', 'https://placekitten.com/89/854'),
(24, 'Shelby Calderon', 'joseph30@example.com', '^QXoT7Acmx', '2025-02-28 20:26:00', '1972-09-04', '903-780-5592', 'Divorced', 'Female', 'Knowledge financial occur kind management size serious.', 'Male', 'https://picsum.photos/940/964'),
(25, 'Lauren Mendoza', 'whitebarbara@example.org', '$)0KgHgCCS', '2025-02-28 20:26:00', '1939-11-26', '(949)943-9445', 'Divorced', 'Male', 'Term man bring you.', 'Male', 'https://placekitten.com/790/808'),
(26, 'Mario Lowery', 'trandaniel@example.org', '(pPNb5EtT5', '2025-02-28 20:26:00', '1945-04-26', '790-257-3289', 'Single', 'Female', 'Half effort nearly through yeah environmental involve culture.', 'Female', 'https://placekitten.com/901/979'),
(27, 'John Sims', 'lhill@example.org', '@5TNmU4i_h', '2025-02-28 20:26:00', '1948-05-19', '487-781-3728x6885', 'Single', 'Female', 'Fill same seek oil soon.', 'Other', 'https://dummyimage.com/910x868'),
(28, 'Kevin Brown', 'meganblankenship@example.net', 'w3($6U(j_s', '2025-02-28 20:26:00', '1936-06-06', '(664)443-4046x8048', 'Divorced', 'No Preference', 'Would million drop expert little.', 'Male', 'https://dummyimage.com/234x574'),
(29, 'Robin Anderson', 'xrose@example.com', '*P(4ZXfH%b', '2025-02-28 20:26:00', '1999-10-21', '001-398-864-0200', 'Single', 'Male', 'Trade finish hit require yet.', 'Female', 'https://picsum.photos/385/728'),
(30, 'Sylvia Perry', 'cjohnston@example.net', '%uKDBURls7', '2025-02-28 20:26:00', '1971-05-31', '3307096577', 'Married', 'No Preference', 'Protect away research child.', 'Female', 'https://placekitten.com/361/1004'),
(31, 'Holly Lee', 'shawteresa@example.net', '&%VjDiwl@5', '2025-02-28 20:35:20', '1940-11-19', '(340)220-9332', 'Married', 'No Preference', 'Our article already before source machine impact color.', 'Male', 'https://dummyimage.com/456x34'),
(32, 'Michael Bishop', 'brandon80@example.com', 'r+XA7UKyeP', '2025-02-28 20:35:20', '1988-08-09', '669.516.0252', 'Married', 'Female', 'Science speech be interest character.', 'Female', 'https://picsum.photos/520/402'),
(33, 'John Nguyen', 'williamslaura@example.net', '34v7Np&q_y', '2025-02-28 20:35:20', '2005-07-06', '834-961-0558x358', 'Single', 'Female', 'Plant can because.', 'Male', 'https://placekitten.com/790/299'),
(34, 'Tara Hudson', 'christina90@example.net', 'cB2xG1*zV@', '2025-02-28 20:35:20', '1948-09-11', '(962)896-5989', 'Single', 'Male', 'Music gas face picture myself structure never.', 'Male', 'https://dummyimage.com/21x732'),
(35, 'Teresa Caldwell', 'kirkjeffrey@example.net', '9ELrGMSt*5', '2025-02-28 20:35:20', '1950-03-18', '001-370-994-2132x370', 'Divorced', 'No Preference', 'Establish energy five key.', 'Male', 'https://picsum.photos/606/731'),
(36, 'Brandi Walsh', 'michaelbrown@example.org', '^tkY2Uk1+4', '2025-02-28 20:35:20', '1969-12-07', '(743)544-0937', 'Married', 'No Preference', 'Eye minute trip almost sense meeting.', 'Other', 'https://placekitten.com/168/695'),
(37, 'Jessica Powell', 'xbaker@example.org', '!3qOjzXA(0', '2025-02-28 20:35:20', '1981-11-25', '001-764-444-6305x958', 'Divorced', 'Female', 'Responsibility eat stand position understand clearly knowledge.', 'Other', 'https://picsum.photos/631/638'),
(38, 'Michael Ellis', 'nmercer@example.net', 'l&$2ES6ntH', '2025-02-28 20:35:20', '1980-06-11', '203-842-3375x8905', 'Married', 'No Preference', 'Education unit join while.', 'Female', 'https://picsum.photos/440/914'),
(39, 'Jackson Waters', 'garyblack@example.com', '#b@1Sr&NBy', '2025-02-28 20:35:20', '1991-08-15', '001-532-231-7962', 'Divorced', 'Female', 'Audience on challenge but leader born line apply.', 'Female', 'https://placekitten.com/231/600'),
(40, 'Timothy Alvarez', 'russellanthony@example.org', 'LAqB$Zh!!4', '2025-02-28 20:35:20', '1979-08-23', '001-270-993-5984x785', 'Single', 'No Preference', 'Memory dark artist population.', 'Female', 'https://placekitten.com/849/802'),
(42, 'omart', 'patient1@gmail.com', '$2b$10$CN5McTqIjuLrEfFzmh/dG.0oDbku8XUeXHdbnThQtm6pQ8e2WrGf6', '2025-03-03 02:41:26', '2001-06-21', '012', 'married', NULL, NULL, 'Male', NULL);

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
(2, 4, 1),
(8, 4, 1),
(3, 4, 4),
(1, 3, 5),
(7, 3, 5);

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
(1, '2025-02-14 01:19:19', 'Mrs building doctor nation standard relationship experience. Determine question firm own more ask beyond. Item even mean.', NULL, NULL, NULL),
(2, '2025-02-22 02:55:47', 'Low successful together notice beat fine. Doctor physical mother.', NULL, NULL, NULL),
(3, '2025-01-10 05:32:25', 'Source standard certain drug research seat. Environmental use reflect claim security item hear.', NULL, NULL, NULL),
(4, '2025-02-09 15:07:18', 'Community interview purpose newspaper ready. Star sound building class. Develop threat Mr fly.', NULL, NULL, NULL),
(5, '2025-01-18 20:55:46', 'Born professor open stay painting. Around material however. Kid staff late off population song quite.', NULL, NULL, NULL),
(6, '2025-02-13 18:58:17', 'Serious four seven. Nearly doctor owner too church professor piece.', NULL, NULL, NULL),
(7, '2025-01-23 06:35:01', 'Too simply response important go look record.', NULL, NULL, NULL),
(8, '2025-02-18 11:09:17', 'Across remain around power us. Certain hard yeah commercial card. Order forward until the do party fall.', NULL, NULL, NULL),
(9, '2025-02-14 08:15:35', 'Grow attention quality kitchen lead describe. Religious foreign decade himself include charge front. Difficult call goal seat skill cover.', NULL, NULL, NULL),
(10, '2025-01-11 09:06:43', 'That might book. She recently size let painting training clear station. Too them hard technology well figure.', NULL, NULL, NULL),
(11, '2025-02-21 09:58:45', 'Fear star career require recently relate note. Allow hot radio read issue.', NULL, NULL, NULL),
(12, '2025-02-10 04:08:21', 'Accept hair show firm feel life. Respond water edge animal. Production answer nor subject big item.', NULL, NULL, NULL),
(13, '2025-01-27 09:53:34', 'Now old address contain point. Official generation space girl upon.', NULL, NULL, NULL),
(14, '2025-01-30 19:38:55', 'Toward need save hospital level doctor. Claim role test imagine next sister say.', NULL, NULL, NULL),
(15, '2025-02-09 21:50:24', 'Final eight put myself. Relationship bank through.', NULL, NULL, NULL),
(16, '2025-02-17 21:51:25', 'Chance this travel this even view suggest prove. Painting he event product herself world someone.', NULL, NULL, NULL),
(17, '2025-01-13 05:51:55', 'Member author hot along street. Red same good director kid know hit.', NULL, NULL, NULL),
(18, '2025-01-10 13:37:16', 'Company sort cell good. Matter question data reality discussion movement. Attack number home.', NULL, NULL, NULL),
(19, '2025-02-06 09:06:29', 'None various system sure couple. Include threat arrive tell at.', NULL, NULL, NULL),
(20, '2025-01-05 03:23:24', 'Fire customer civil father. Day carry five fall.', NULL, NULL, NULL),
(21, '2025-01-27 05:14:40', 'Week decision avoid project. Particular hear set different garden. Minute marriage perform whatever party themselves else. Process food will end.', NULL, NULL, NULL),
(22, '2025-02-08 09:54:52', 'Above imagine figure town. Which maintain individual tend feeling in culture. Long woman sell institution peace. Human second memory what.', NULL, NULL, NULL),
(23, '2025-02-22 15:23:13', 'Art free card teach. Poor none drug. Wish season cover hand or probably.', NULL, NULL, NULL),
(24, '2025-02-24 10:35:28', 'Other itself entire international. Ready word similar.', NULL, NULL, NULL),
(25, '2025-02-06 01:03:46', 'Hard many magazine. Create whatever learn model firm address factor.', NULL, NULL, NULL),
(26, '2025-01-18 19:19:00', 'Reduce more life different case six. Develop rich task window.', NULL, NULL, NULL),
(27, '2025-01-10 15:45:23', 'Would decide meet exist crime herself need. Service church peace without third single.', NULL, NULL, NULL),
(28, '2025-01-17 23:34:45', 'Within accept garden. Commercial boy night. Only perform you heavy wrong brother bag.', NULL, NULL, NULL),
(29, '2025-01-20 09:03:47', 'Drop small government challenge short. Anything seven read week yard enjoy imagine. Goal plan argue spring.', NULL, NULL, NULL),
(30, '2025-01-03 09:49:31', 'Stock we bring paper several require. Continue far feel reach officer stop culture.', NULL, NULL, NULL),
(31, '2025-01-15 10:25:45', 'Prevent name particular perform detail bed together. Coach if discuss animal husband effect movie. People all appear region sure.', NULL, NULL, NULL),
(32, '2025-01-05 10:53:24', 'House police and military day young. Expert knowledge court defense. According law level course in.', NULL, NULL, NULL),
(33, '2025-01-24 11:20:02', 'Protect several tend evening rule adult life. When technology include.', NULL, NULL, NULL),
(34, '2025-01-11 18:52:30', 'Answer interest firm wear he. Teacher them indeed explain. Sell good wear.', NULL, NULL, NULL),
(35, '2025-01-16 13:30:00', 'Model draw team pass. Increase have institution the move relationship make during.', NULL, NULL, NULL),
(36, '2025-01-23 22:52:09', 'All nothing reason natural hear expert. Man act that state.', NULL, NULL, NULL),
(37, '2025-02-12 20:55:06', 'Particular president imagine building executive. Catch difficult strategy. Even benefit above prove necessary gun.', NULL, NULL, NULL),
(38, '2025-02-17 14:38:23', 'Political later successful toward significant somebody check. Seat whether bar apply break country. Sign necessary kid someone behavior bank near.', NULL, NULL, NULL),
(39, '2025-01-07 09:35:01', 'Form number minute next half door travel. Get these race benefit.', NULL, NULL, NULL),
(40, '2025-01-17 15:42:02', 'Still professional their produce. Chance professional father detail model billion ask.', NULL, NULL, NULL),
(41, '2025-01-11 22:55:21', 'Across hotel bed floor present system stock. Resource understand forget. Along activity prepare buy. Board quality activity identify discussion challenge meet.', NULL, NULL, NULL),
(42, '2025-02-13 19:50:58', 'Issue goal if especially skill. Friend hot life fill along fund. Author despite true beautiful stop trouble head.', NULL, NULL, NULL),
(43, '2025-02-24 14:24:31', 'Myself early throughout. Method second likely behavior throw drug kitchen.', NULL, NULL, NULL),
(44, '2025-01-18 16:05:22', 'Store go population writer try news.', NULL, NULL, NULL),
(45, '2025-01-09 03:26:08', 'Late blood animal rule ready than. Drop bed next so certain safe city. Water Mr cost born baby.', NULL, NULL, NULL);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `doctor_availability`
--
ALTER TABLE `doctor_availability`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `doctor_session`
--
ALTER TABLE `doctor_session`
  MODIFY `session_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `emergency_team`
--
ALTER TABLE `emergency_team`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `emergency_team_session`
--
ALTER TABLE `emergency_team_session`
  MODIFY `session_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `journal`
--
ALTER TABLE `journal`
  MODIFY `journal_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `lifecoach_availability`
--
ALTER TABLE `lifecoach_availability`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `life_coach`
--
ALTER TABLE `life_coach`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `life_coach_session`
--
ALTER TABLE `life_coach_session`
  MODIFY `session_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `manager`
--
ALTER TABLE `manager`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `message_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

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
