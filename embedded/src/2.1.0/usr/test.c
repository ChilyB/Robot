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

void i2cADC_test(){
	uint32_t ret = getChargingVoltage();
	esp8266_send((char*)"\r\nI2C_ADC:");
	esp8266_send_uint(ret);
	timer_delay_ms(1000);
}
void batADC_test(){
	uint32_t ret = getBatteryVoltage(100);
	esp8266_send((char*)"\r\nADC_BAT:");
	esp8266_send_uint(ret);
	timer_delay_ms(1000);
}



//chod rovno pokym nenarazíš na farbu
void charging_test_go_straight_until_line(u32 line_color){
	float base_speed_max = 10;
	float delay = 10;
	char pokracuj = true;

	while(pokracuj){
		rgb_get_line_position();
		g_motors.right = base_speed_max;
		g_motors.left = base_speed_max;

		switch (line_color)
		{
			case LINE_WHITE: pokracuj = (g_line_position.white_on_line == 0); break;
			case LINE_RED: pokracuj = (g_line_position.red_on_line == 0); break;
			case LINE_GREEN: pokracuj = (g_line_position.green_on_line == 0); break;
			case LINE_BLUE: pokracuj = (g_line_position.blue_on_line == 0); break;
		}
		timer_delay_ms(delay);
	}
	g_motors.right = 0;
	g_motors.left = 0;
}

void charging_wifi_test(){
	tx_buffer[0]=1;
	rx_buffer[0]=1;
	charging_send_message(WIFI_SERVER_IP,WIFI_SERVER_PORT,tx_buffer,1,rx_buffer,1);
	timer_delay_ms(100);
	/*if(rx_buffer[0]==1){
		uart_write('1');
	}else
	if(rx_buffer[0]==2){
		uart_write('2');
	}else{
		uart_write('0');
	}
	esp8266_send("\r\n");*/
	
}

void slightTurn(u32 time,i32 speed, char side){
	if(side == RIGHT_SIDE){
		g_motors.left = speed;
		g_motors.right = -speed/2;
		timer_delay_ms(time);
		g_motors.left = 0;
		g_motors.right = 0;
	}else if(side == LEFT_SIDE){
		g_motors.left = -speed/2;
		g_motors.right = speed;
		timer_delay_ms(time);
		g_motors.left = 0;
		g_motors.right = 0;
	}

}

void line_up_to_color(u32 line_color){
	i32 base_speed = 10;
char pokracuj = true;
char left_ok = false;
char right_ok = false;
	while(pokracuj){
		rgb_get_line_position();
		switch (line_color)
		{
			case LINE_WHITE: left_ok = g_rgb.ambient[3]> RGB_WHITE_LINE_TRESHOLD ;right_ok= g_rgb.ambient[1]> RGB_WHITE_LINE_TRESHOLD; break;
			case LINE_RED: left_ok = g_rgb.r[3]> RGB_RED_LINE_TRESHOLD ;right_ok= g_rgb.r[1]> RGB_RED_LINE_TRESHOLD; break;
			case LINE_GREEN: left_ok = g_rgb.g[3]> RGB_GREEN_LINE_TRESHOLD ;right_ok= g_rgb.g[1]> RGB_GREEN_LINE_TRESHOLD; break;
			case LINE_BLUE: left_ok = g_rgb.b[3]> RGB_BLUE_LINE_TRESHOLD ;right_ok=  g_rgb.b[1]> RGB_BLUE_LINE_TRESHOLD; break;
		}
		pokracuj = !(left_ok && right_ok);
		if(!left_ok && !right_ok){
			g_motors.right = base_speed;
			g_motors.left = base_speed;
		}else
		if(left_ok && !right_ok){
			g_motors.right = base_speed;
			//g_motors.left = -base_speed;
		}else
		if(!left_ok && right_ok){
			//g_motors.right = -base_speed;
			g_motors.left = base_speed;
		}
		timer_delay_ms(10);
	}
	g_motors.left = 0;
	g_motors.right = 0;
	

	


}


void line_follower_until_color(u32 line_color,u32 end_color){

	
	u32 dt = 10;

	float base_speed = 0;
	float base_speed_max = 5;

	int i;
	int border_resume_delay = 0;

	float Ks = 0.15;

	float error = 0.0;
	float error_prev = 0.0;

	float Kp = 40.0;
	float Kd = 100.0;
	
	
	char pokracuj = true;
	//struct sLinePosition line_position;

	while (1)
	{

		rgb_get_line_position();


		switch (end_color)
		{
			case LINE_WHITE: pokracuj = (g_line_position.white_on_line == 0); break;
			case LINE_RED: pokracuj = (g_line_position.red_on_line == 0); break;
			case LINE_GREEN: pokracuj = (g_line_position.green_on_line == 0); break;
			case LINE_BLUE: pokracuj = (g_line_position.blue_on_line == 0); break;
		}



		if (!pokracuj)
		{
			g_motors.left = 0;
			g_motors.right = 0;
			border_resume_delay = 100;
			return;
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
		g_motors.right = base_speed - dif_speed;
		
		timer_delay_ms(dt);
	}

}

void line_follower_with_charging(u32 line_color,u32 charging_line_color,uint32_t low_battery_V, uint32_t high_battery_V,uint32_t charger_V){
	char charging_flag = 0;
	int charge_count = 0;
	int test_count =0;
	uint32_t test_sum =0;
	uint32_t volt = 0;
	//parametre start
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
	//parametre end

		while(1){
			if(charging_flag == 0){
				//štandardny program start
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
					g_motors.right = base_speed - dif_speed;


					timer_delay_ms(dt);
				
				////štandardny program end
			}
		switch(charging_flag){
			case 0:
			
			volt = getBatteryVoltage(100);
			test_sum+=volt;
				if(volt < low_battery_V){
					if(charge_count > 1000){
						charging_flag=1;
						g_motors.left=0;
						g_motors.right=0;
					}
					charge_count++;
					
				}else{
					if(charge_count >0){
						charge_count--;
					}
					
				}
				/*test_count++;
				if(test_count == 500){
					esp8266_send_uint(test_sum/test_count);
					esp8266_send("\r\n");
					test_count = 0;
					test_sum=0;
				}*/
				//timer_delay_ms(1000);
				//esp8266_send_uint(getBatteryVoltage());
				//esp8266_send("\r\n");
				
			break;
			case 1:
				rx_buffer[0]=0;
				tx_buffer[0]=1;
				charging_send_message(WIFI_SERVER_IP,WIFI_SERVER_PORT,tx_buffer,1,rx_buffer,1);
				timer_delay_ms(100);
				charging_flag = 2;
			break;
			case 2:
				if(rx_buffer[0]==0){//no response 
					timer_delay_ms(1000);
					charging_flag = 1;
				}else
				if(rx_buffer[0]==1){//aktive
					charging_flag = 3;
				}else
				if(rx_buffer[0]==2){//pasive
					charging_flag = 4;
				}else
				if(rx_buffer[0]==3){//busy
					timer_delay_ms(5000);
					charging_flag = 1;
				}else{
					timer_delay_ms(1000);
					charging_flag = 1;
				}
			break;
			case 3:
				line_follower_until_color(charging_line_color,LINE_WHITE);
				charging_flag = 5;
			break;
			case 4:
				charging_test_go_straight_until_line(charging_line_color);
				if(g_rgb.r[3] > RGB_RED_LINE_TRESHOLD){
			
					slightTurn(1000,20,LEFT_SIDE);	
					charging_test_go_straight_until_line(LINE_RED);
				}
				line_follower_until_color(charging_line_color,LINE_WHITE);
				charging_flag = 5;
			break;
			case 5:
			g_motors.right=0;
			g_motors.left=0;
			//if 5V na nabijani odosli spravu
			if(getChargingVoltage()>=charger_V){
			
				tx_buffer[0]=2;
				//esp8266_connect(WIFI_SERVER_IP,WIFI_SERVER_PORT,tx_buffer,1,rx_buffer,1);
				charging_send_message(WIFI_SERVER_IP,WIFI_SERVER_PORT,tx_buffer,1,rx_buffer,1);
				timer_delay_ms(100);
				charging_flag = 6;
			}

				
			break;
			case 6:
			if(getBatteryVoltage(100) > high_battery_V){
				charging_flag=0;
				g_motors.left = -10;
				g_motors.right = -10;
				timer_delay_ms(4000);
				g_motors.left = 0;
				g_motors.right = 0;
				charge_count = 0;
			}
			break;

		}

	}
	
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

/*
			//my addition to rotate on white
			border_resume_delay = 1;
			rotate_angle(180, NULL);
			g_motors.left = base_speed;
			g_motors.right = base_speed;
*/
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
		g_motors.right = base_speed - dif_speed;

/*


		//Stop/Rotate robot on white color
		//val = 1 is some middle sensor
		int val = 1;
		// raw_sensor values 0 to 1023
		// val_threshold get high val on r, g, b
		i16 val_threshold = 150; //150
		if ((g_rgb.r[val] > val_threshold)
		&& (g_rgb.g[val] > val_threshold)
		&& (g_rgb.b[val] > val_threshold))
		{
			rotate_angle(180, NULL);
		  g_motors.left = base_speed;
		  g_motors.right = base_speed;
		  timer_delay_ms(500);
		}
*/
		timer_delay_ms(dt);
	}
}
