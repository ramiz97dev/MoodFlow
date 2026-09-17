-- MoodFlow database schema and sample data

CREATE TABLE `tracks` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `mood` varchar(255) NOT NULL,
  `artist` varchar(255) NOT NULL,
  `track` varchar(255) NOT NULL,
  `notes` text NOT NULL,
  `date` datetime NOT NULL,
  `isFavorite` tinyint(1) DEFAULT NULL,
  `imageUrl` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `tracks` (`id`, `title`, `mood`, `artist`, `track`, `notes`, `date`, `isFavorite`, `imageUrl`) VALUES
(28, 'Night Walk', 'Melancholic', 'Nina Kraviz', 'IMRV', 'Cold air and empty streets.', '2026-07-16 00:00:00', 1, 'uploads/night_city.png'),
(29, 'Neon Lights', 'Energetic', 'DJ Nastia', 'Believe', 'Bright lights and late-night energy.', '2026-07-15 00:00:00', 0, 'uploads/neon_street.png'),
(30, 'Forest Escape', 'Calm', 'Ben Böhmer', 'Beyond Beliefs', 'A peaceful walk through nature.', '2026-07-14 00:00:00', 0, 'uploads/forest_mist.png'),
(31, 'Sunset Dreams', 'Relaxed', 'RÜFÜS DU SOL', 'Innerbloom', 'Watching the sunset with music.', '2026-07-13 00:00:00', 1, 'uploads/sunset_beach.png'),
(32, 'Mountain Silence', 'Reflective', 'Monolink', 'Return to Oz', 'Quiet moments in the mountains.', '2026-07-12 00:00:00', 0, 'uploads/mountain_lake.png'),
(33, 'Rainy Mood', 'Sad', 'Lane 8', 'Road', 'Rain outside the window all evening.', '2026-07-11 00:00:00', 0, 'uploads/rain_window.png'),
(34, 'Late Focus', 'Focused', 'Stephan Bodzin', 'Singularity', 'Working late without distractions.', '2026-07-10 00:00:00', 1, 'uploads/cozy_room.png'),
(35, 'Galaxy Ride', 'Dreamy', 'Anyma', 'Pictures Of You', 'Looking at the stars while listening.', '2026-07-09 00:00:00', 0, 'uploads/starry_sky.png'),
(36, 'Campfire Talks', 'Warm', 'Ben Böhmer', 'Breathing', 'A calm evening around the fire.', '2026-07-08 00:00:00', 0, 'uploads/campfire.png'),
(37, 'Night Drive', 'Dark', 'ARTBAT', 'Flame', 'Driving through empty roads at night.', '2026-07-07 00:00:00', 1, 'uploads/night_road.png'),
(38, 'Purple Horizon', 'Melancholic', 'Charlotte de Witte', 'High Street', 'Lost in electronic melodies.', '2026-07-06 00:00:00', 0, 'uploads/night_city.png'),
(39, 'Electric Pulse', 'Energetic', 'KI/KI', '5 Mins Of Acid', 'Fast beats and neon lights.', '2026-07-05 00:00:00', 0, 'uploads/neon_street.png'),
(40, 'Morning Fog', 'Peaceful', 'Adriatique', 'Home', 'Fresh forest air after sunrise.', '2026-07-04 00:00:00', 1, 'uploads/forest_mist.png'),
(41, 'Golden Coast', 'Happy', 'CamelPhat', 'Cola', 'Warm sand and ocean waves.', '2026-07-03 00:00:00', 0, 'uploads/sunset_beach.png'),
(42, 'Above Clouds', 'Inspired', 'Kevin de Vries', 'Metro', 'Fresh air and endless landscapes.', '2026-07-02 00:00:00', 0, 'uploads/mountain_lake.png'),
(43, 'Window Thoughts', 'Lonely', 'Tale Of Us', 'Another Earth', 'Listening to rain while thinking.', '2026-07-01 00:00:00', 1, 'uploads/rain_window.png'),
(44, 'Creative Flow', 'Motivated', 'Boris Brejcha', 'Gravity', 'Everything just clicked today.', '2026-06-30 00:00:00', 0, 'uploads/cozy_room.png'),
(45, 'Milky Way', 'Dreamy', 'Massano', 'Closure', 'The sky was unbelievably clear tonight.', '2026-06-29 00:00:00', 0, 'uploads/starry_sky.png'),
(46, 'Firelight', 'Comfort', 'Monolink', 'Father Ocean', 'Warm light and good conversations.', '2026-06-28 00:00:00', 1, 'uploads/campfire.png'),
(47, 'Last Exit', 'Reflective', 'Fred again..', 'Delilah', 'One last drive before going home.', '2026-06-27 00:00:00', 0, 'uploads/night_road.png');

ALTER TABLE `tracks` ADD PRIMARY KEY (`id`);
ALTER TABLE `tracks` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;
