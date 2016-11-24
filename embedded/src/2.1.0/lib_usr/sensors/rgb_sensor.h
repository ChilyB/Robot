#ifndef _RGB_SENSOR_H_
#define _RGB_SENSOR_H_

#include "../lib_usr.h"
#include "rgb_i2c.h"

#define RGB_SENSORS_COUNT		(4)
#define LINE_MAX	(i32)	(128)

#define SET_BACKGROUND_COUNT (100)

#define RGB_WHITE_LINE_TRESHOLD		((i32)1000)
#define RGB_RED_LINE_TRESHOLD		((i32)40)
#define RGB_GREEN_LINE_TRESHOLD		((i32)10)
#define RGB_BLUE_LINE_TRESHOLD		((i32)10)

struct sRGBSensor
{
	i16 r[RGB_SENSORS_COUNT];
	i16 g[RGB_SENSORS_COUNT];
	i16 b[RGB_SENSORS_COUNT];

	i16 ambient[RGB_SENSORS_COUNT];
	i16 proximity[RGB_SENSORS_COUNT];

	i32 background_norm_white[RGB_SENSORS_COUNT];
	i32 background_norm_red[RGB_SENSORS_COUNT];
	i32 background_norm_green[RGB_SENSORS_COUNT];
	i32 background_norm_blue[RGB_SENSORS_COUNT];

	i16 r_color_normalised[RGB_SENSORS_COUNT];
	i16 g_color_normalised[RGB_SENSORS_COUNT];
	i16 b_color_normalised[RGB_SENSORS_COUNT];
};


struct sLinePosition
{
	i32 white, red, green, blue;
	u8 white_on_line, red_on_line, green_on_line, blue_on_line;
};

volatile struct sRGBSensor g_rgb;
volatile struct sLinePosition g_line_position;

u32 rgb_sensor_init();
void rgb_sensor_uninit();

void rgb_sensor_read();

void rgb_get_line_position();

void rgb_set_background();

#endif
