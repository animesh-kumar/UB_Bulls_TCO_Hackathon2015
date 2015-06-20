package com.stadium.nearme;

public class Coordinate {

	final String DEGREE = "\u00b0";
	public double longitude;
	public double latitude;

	public String getExpandedLongitude() {
		String expandedLongitude = getExpansion(longitude);
		StringBuilder sb = new StringBuilder(expandedLongitude);
		char longDirection = (longitude >= 0) ? 'E' : 'W';
		sb.append(longDirection);
		return sb.toString();
	}

	public String getExpandedLatitude() {
		String expandedLatitude = getExpansion(latitude);
		StringBuilder sb = new StringBuilder(expandedLatitude);
		char latDirection = (latitude >= 0) ? 'N' : 'S';
		sb.append(latDirection);
		return sb.toString();
	}

	private String getExpansion(double value) {
		StringBuilder sb = new StringBuilder();
		int seconds = (int) Math.round(Math.abs(value * 3600));
		int degrees = seconds / 3600;
		seconds = seconds % 3600;
		int minutes = seconds / 60;
		seconds %= 60;
		sb.append(degrees);
		sb.append(DEGREE);
		sb.append(" ");
		sb.append(minutes);
		sb.append("'");
		sb.append(" ");
		sb.append(seconds);
		sb.append("\"");
		sb.append(" ");
		return sb.toString();

	}

}
