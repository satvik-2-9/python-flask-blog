-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 24, 2023 at 03:44 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `flask_tut`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(50) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_num` varchar(50) NOT NULL,
  `mes` text NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `phone_num`, `mes`, `date`) VALUES
(1, 'first post', 'satvikbatra@gmail.com', '9599149289', 'This is my first flask project.', '2023-08-22 16:45:21'),
(2, 'miks batra', 'okaymiks@gmail.com', '999999999', 'hi, i am miks.', NULL),
(3, 'miksad', 'okaymiks@gmail.com', '999999999', 'hey, this is miks again, wassup?', '2023-08-22 17:10:01'),
(4, 'miksifyme', 'okaymiks@gmail.com', '999999999', 'lets bang!', '2023-08-22 18:48:42'),
(5, 'miksifyme', 'anotherone@gmail.com', '999999999', 'lets bang!', '2023-08-22 18:55:25');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `slug` varchar(30) NOT NULL,
  `content` text NOT NULL,
  `img_file` varchar(12) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `slug`, `content`, `img_file`, `date`) VALUES
(1, 'Flask Noobie', 'first-post', 'I am noob in flask & this is my first post.', 'about-bg.jpg', '2023-08-22 19:16:20'),
(2, 'SDE Job prep', 'sde-job-prep', 'Hey, this is Satvik Batra, incoming Technical Analyst at Morgan Stanley and i will take you through my journey through college to becoming a software developer.', 'home-bg.jpg', '2023-08-24 17:37:24'),
(4, 'Summary Functions and Maps', 'sum-func', 'Introduction\r\nIn the last tutorial, we learned how to select relevant data out of a DataFrame or Series. Plucking the right data out of our data representation is critical to getting work done, as we demonstrated in the exercises.\r\n\r\nHowever, the data does not always come out of memory in the format we want it in right out of the bat. Sometimes we have to do some more work ourselves to reformat it for the task at hand. This tutorial will cover different operations we can apply to our data to get the input \"just right\".\r\n\r\nTo start the exercise for this topic, please click here.\r\n\r\nWe\'ll use the Wine Magazine data for demonstration.\r\n\r\n', 'about-bg.jpg', '2023-08-23 11:39:07'),
(5, 'Morgan Stanley Technology Analyst Program | Onboarding and Orientation details- Mumbai, India | August 2023', 'ms-orientation', 'The Firm is first and foremost dedicated to providing you with a fulfilling experience in a safe environment.\r\n\r\nWe’re thrilled to re-confirm you will join us at Morgan Stanley’s Mumbai office, in-person on Friday, August 25, 2023:\r\n \r\n\r\nOffice Address: Athena Bldg. No. 5, Sector 30, Mindspace, Goregaon (West), Mumbai 400 090  \r\n\r\n \r\n\r\nYou will have the opportunity to participate in-person in the office minimum three days per week throughout the training program—more details to come, once you are onboarded!\r\n ', 'home-bg.jpg', '2023-08-23 11:39:52'),
(6, 'Onboarding and Orientation Details', 'orientation', 'Please review all of the below and attached information carefully and keep this email easily accessible for Day 1 transitions from session-to-session.\r\n\r\nDay 1 Details:\r\n\r\nFriday, August 25\r\n\r\nTIME (IST)\r\n\r\nSESSION\r\n\r\n8:00 a.m.\r\n\r\nReport to Office at 8:00 a.m.\r\n\r\nAthena Bldg. No. 5, Sector 30, Mindspace, Goregaon (West), Mumbai 400 090\r\n\r\n \r\n\r\n8:30 a.m. – 9:00 p.m.\r\n\r\nReport to CSI Room\r\n\r\nAthena, Security Team, Level 1\r\n\r\n \r\n\r\n9:00 a.m. – 9:30 a.m.\r\n\r\nIndia TAP Lead Briefing\r\n\r\nAthena, Level 6, Training Room 6C\r\n\r\n \r\n\r\n9:30 a.m. – 11:00 a.m.\r\n\r\nWSS Onboarding\r\n\r\nAthena, Level 6, Training Room 6C\r\n\r\n \r\n\r\n11:00 a.m. – 12:00 p.m.\r\n\r\nHR Session\r\n\r\nAthena, Level 6, Training Room 6C\r\n\r\n \r\n\r\n12:00 p.m. – 12:15 p.m.\r\n\r\nBreak\r\n\r\nAthena, Level 6, Cafe\r\n\r\n \r\n\r\n12:15 p.m. – 1:00 p.m.\r\n\r\nInformation Security Session\r\n\r\nAthena, Level 6, Training Room 6C\r\n\r\n \r\n\r\n1:00 p.m. – 2:00 p.m.\r\n\r\nLunch Break\r\n\r\nAthena, Level 6, Cafe\r\n\r\n \r\n\r\n2:00 p.m. – 3:00 p.m.\r\n\r\nEmployee Relations Session\r\n\r\nAthena, Level 6, Training Room 6C\r\n\r\n \r\n\r\n3:00 p.m. – 3:15 p.m.\r\n\r\nBreak\r\n\r\nAthena, Level 6, Cafe\r\n\r\n \r\n\r\n3:15 p.m. – 04:30 p.m.\r\n\r\nLegal & Compliance Session\r\n\r\nAthena, Level 6, Training Room 6C\r\n\r\n \r\n\r\n4:30 p.m. – 4:45 p.m.\r\n\r\nBreak\r\n\r\nAthena, Level 6, Cafe\r\n\r\n \r\n\r\n4:45 p.m. – 05:45 p.m.\r\n\r\nTech Café Session\r\n\r\nAthena, Level 6, Training Room 6C\r\n\r\n \r\n\r\n5:45 p.m. – 06:00 p.m.\r\n\r\nTAP Briefing\r\n\r\nAthena, Level 6, Training Room 6C', 'about-bg.jpg', '2023-08-23 11:40:36');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
