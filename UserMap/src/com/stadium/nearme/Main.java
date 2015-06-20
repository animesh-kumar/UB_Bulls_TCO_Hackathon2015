package com.stadium.nearme;

public class Main {

	public static void main(String[] args) {

		Coordinate c = new Coordinate();
		c.longitude = -67.99;
		c.latitude = 30.77;
		System.out.println(c.getExpandedLatitude());
		System.out.println(c.getExpandedLongitude());
	}

}
