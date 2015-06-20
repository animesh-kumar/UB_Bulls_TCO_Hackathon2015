package com.stadium.nearme;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class NearMeMapper {

	class UserDistance {
		User user;
		double distance;
	}

	class HaversineDistanceCalculator {

		public double calculate(Coordinate location1, Coordinate location2) {

			double R = 6371000; // metres
			double loc1Lat = Math.toRadians(location1.latitude);
			double loc2Lat = Math.toRadians(location2.latitude);
			double loc1Long = Math.toRadians(location1.longitude);
			double loc2Long = Math.toRadians(location2.longitude);
			double latDiff = Math.toRadians((loc2Lat - loc1Lat));
			double lonDiff = Math.toRadians((loc2Long - loc1Long));
			double a = Math.sin(latDiff / 2) * Math.sin(latDiff / 2)
					+ Math.cos(lonDiff) * Math.cos(lonDiff)
					* Math.sin(lonDiff / 2) * Math.sin(lonDiff / 2);
			double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

			return R * c;
		}
	}

	public List<User> getNearestNeighbors(User user, List<User> neighbors) {
		List<UserDistance> nearestNeighbors = new ArrayList<UserDistance>();
		HaversineDistanceCalculator hdc = new HaversineDistanceCalculator();
		for (User neighbor : neighbors) {
			UserDistance userdistance = new UserDistance();
			userdistance.user = neighbor;
			userdistance.distance = hdc.calculate(neighbor.coordinate,
					user.coordinate);
			nearestNeighbors.add(userdistance);
		}
		// Sort based on our comparator
		Collections.sort(nearestNeighbors, new Comparator<UserDistance>() {

			@Override
			public int compare(UserDistance o1, UserDistance o2) {
				return (int) (o1.distance - o2.distance);
			}
		});
		List<User> sortedNeighbors = new ArrayList<User>();
		for (int i = 0; i < 5; i++) {
			if (nearestNeighbors.size() > i) {
				sortedNeighbors.add(nearestNeighbors.get(i).user);
			}
		}
		return sortedNeighbors;

	}

}
