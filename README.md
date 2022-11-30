# Profilometer Data Reading
This code analyzes profilometer readings. A single method that generates:
A) A plot of the profile
B) A plot of the roughness
And displays the average roughness and its standard deviation.

## Overview
The profilometer readings are two files. One containing the actual reading and the other containing relevant parameters of the reading.

The graph produced is the profile of the surface. The x axis being the length of the surface and the y axis is the elevation.

The program also fixes the slope of the surface against the profilometer, to make sure that the reading is of a flat surface.

The roughness is defined as the average "peak to peak" hieght difference in each small interval of the surface. The standard deviation of that distribution is also displayed in the console.

## Format of the Profilometer Data

The profilometer results are two ".txt" files. One containing the reading data and the other containing parameters of the reading (distance between points, scales, etc.).
The path of the original data should be a valid .txt file without the .txt suffix. the other file should have a matching name with a suffix "_parameters".
For example, the path of the data may be: "C:\profilometer\reading.txt" and the parameters file is: "C:\profilometer\reading_parameters.txt".

The reading is a table separated by tabs with the following format:
Counter	Altitude (µm)	Encoder1 (µm)	Encoder2 (µm)	Row number
37	623.381	-1.4	0	1
38	623.3406	-1.4	0	1
39	623.3882	-1.4	0	1
40	623.269	-1.4	0	1

The parameters are separated by line breaks;
Pen: 1000 µ
Frequency = 400 Hz
X distance = +30.00000 mm
X step distance = 0.005 mm
X velocity = 2.00000 mm/s
Number of rows = 10
Row step = 0.001 mm
Y velocity = 1.0000 mm/s

Note: while the reading file should contain a "Row number", this program only supports readings of a single row.

## Usage

The code contains a single method with the signature:
analyzeProfilometerData(sourcePath, range)
sourcePath - the path of the profilometer reading without the ".txt" suffix
range - used to analyze only a portion of the surface, for example [10 50] will use only data from 10mm to 50mm in the reading. Pass an empty array [] to incude the entire surface.

### Usage Example

analyzeProfilometerData('C:\profilometer\reading', [])

This call will read the parameters file at 'C:\profilometer\reading_parameters.txt' and the reading from the file at 'C:\profilometer\reading.txt'.
