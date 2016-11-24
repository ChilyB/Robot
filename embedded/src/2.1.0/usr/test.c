#include "test.h"


void sensor_test()
{
	while (1)
	{
		led_on(LED_0);

		printf_("LSM9DS0 : ");
		printf_("%i %i %i , ", g_lsm9ds0_imu.gx, g_lsm9ds0_imu.gy, g_lsm9ds0_imu.gz);
		printf_("%i %i %i , ", g_lsm9ds0_imu.mx, g_lsm9ds0_imu.my, g_lsm9ds0_imu.mz);
		printf_("%i %i %i", g_lsm9ds0_imu.ax, g_lsm9ds0_imu.ay, g_lsm9ds0_imu.az);
		printf_("\n");

		printf_("\nRGB surface : ");

		u32 i;

		/*
		printf_("\nR: ");
		for (i = 0; i < RGB_SENSORS_COUNT; i++)
			printf_("%i ", g_rgb.r[i]);

		printf_("\nG: ");
		for (i = 0; i < RGB_SENSORS_COUNT; i++)
			printf_("%i ", g_rgb.g[i]);

		printf_("\nB: ");
		for (i = 0; i < RGB_SENSORS_COUNT; i++)
			printf_("%i ", g_rgb.b[i]);

		printf_("\nA: ");
		for (i = 0; i < RGB_SENSORS_COUNT; i++)
			printf_("%i ", g_rgb.ambient[i]);
		*/


		printf_("\nR: ");
		for (i = 0; i < RGB_SENSORS_COUNT; i++)
			printf_("%i ", g_rgb.r_color_normalised[i]);

		printf_("\nG: ");
		for (i = 0; i < RGB_SENSORS_COUNT; i++)
			printf_("%i ", g_rgb.g_color_normalised[i]);

		printf_("\nB: ");
		for (i = 0; i < RGB_SENSORS_COUNT; i++)
			printf_("%i ", g_rgb.b_color_normalised[i]);

		printf_("\n\n");
		led_off(LED_0);
		timer_delay_ms(300);
	}
}

void imu_test()
{
	float roll = 0.0;
	float pitch = 0.0;
	float yaw = 0.0, yaw_ofs = 0.0;;

	u32 dt = 10;

	u32 i, max = 100;
	for (i = 0; i < max; i++)
	{
		yaw_ofs+= g_lsm9ds0_imu.gz;
		timer_delay_ms(dt);
	}

	yaw_ofs/= max;

	while (1)
	{
		led_on(LED_0);

		roll = m_atan2(g_lsm9ds0_imu.ay, m_sqrt(g_lsm9ds0_imu.ax*g_lsm9ds0_imu.ax + g_lsm9ds0_imu.az*g_lsm9ds0_imu.az));
		pitch = m_atan2(g_lsm9ds0_imu.ax, m_sqrt(g_lsm9ds0_imu.ay*g_lsm9ds0_imu.ay + g_lsm9ds0_imu.az*g_lsm9ds0_imu.az));
		yaw+= (g_lsm9ds0_imu.gz - yaw_ofs)*(dt/1000.0)*0.0003; //*(90.0/272063.0);

		printf_("%i %i %i\n", (i32)(roll*180.0/PI_), (i32)(pitch*180.0/PI_), (i32)(yaw*180.0/PI_) );

		led_off(LED_0);

		timer_delay_ms(dt);
	}
}

void motors_test()
{
	u32 i;

	for (i = 0; i < 2; i++)
	{
		u32 time = 800;

		g_motors.left = SPEED_MAX;
		g_motors.right = -SPEED_MAX;
		timer_delay_ms(time);

		g_motors.left = -SPEED_MAX;
		g_motors.right = SPEED_MAX;
		timer_delay_ms(time);

		g_motors.left = SPEED_MAX/2;
		g_motors.right = SPEED_MAX/2;
		timer_delay_ms(time);

		g_motors.left = SPEED_MAX;
		g_motors.right = SPEED_MAX;
		timer_delay_ms(time);

		g_motors.left = -SPEED_MAX/2;
		g_motors.right = -SPEED_MAX/2;
		timer_delay_ms(time);


		g_motors.left = 0;
		g_motors.right = 0;
		timer_delay_ms(time);

	}
}

void go_forward_test()
{
	go_forward(1000000, SPEED_MAX, NULL);
	go_forward(1000, -SPEED_MAX, NULL);
}

void rotation_test()
{
	rotate_angle(90, NULL);
	rotate_angle(90, NULL);
	rotate_angle(90, NULL);
	rotate_angle(90, NULL);

	rotate_angle(-90, NULL);
	rotate_angle(-90, NULL);
	rotate_angle(-90, NULL);
	rotate_angle(-90, NULL);
}

void line_follower_test(u32 line_color)
{
	u32 dt = 10;

	float base_speed = 0;
	float base_speed_max = 20;

	int i;
	int border_resume_delay = 0;

	float Ks = 0.2;

	float error = 0.0;
	float error_prev = 0.0;

	float Kp = 40.0;
	float Kd = 100.0;

	//struct sLinePosition line_position;

	while (1)
	{
		rgb_get_line_position();

		if (g_line_position.white_on_line != 0)
		{
			g_motors.left = 0;
			g_motors.right = 0;
			border_resume_delay = 100;
		}


		if (border_resume_delay > 0)
		{
			border_resume_delay -= 1;
			timer_delay_ms(dt);
			continue;
		}

		switch (line_color)
		{
			case LINE_WHITE: error = 0.0 - g_line_position.white/70.0; break;
			case LINE_RED: error = 0.0 - g_line_position.red/70.0; break;
			case LINE_GREEN: error = 0.0 - g_line_position.green/70.0; break;
			case LINE_BLUE: error = 0.0 - g_line_position.blue/70.0; break;
		}


		if (error > 1.0)
			error = 1.0;

		if (error < -1.0)
			error = -1.0;

		float dif_speed = Kp*error + Kd*(error - error_prev);
		error_prev = error;

		base_speed = m_min(base_speed_max*(1.0-m_abs(error)), base_speed + Ks);

		//g_motors.left = base_speed - dif_speed;;
		//g_motors.right = base_speed + dif_speed;;
		g_motors.left = base_speed + dif_speed;;
		g_motors.right = base_speed - dif_speed;;
		timer_delay_ms(dt);
	}
}
