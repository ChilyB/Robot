#ifndef _TCP_DATA_STRUCT_H_
#define _TCP_DATA_STRUCT_H_

#define TCP_TERMINAL_BUFFER_MAX_LENGTH  ((u32)64)

struct sTCPTerminal
{
  u32 lenght;
  char buffer[TCP_TERMINAL_BUFFER_MAX_LENGTH];
};

struct sRobotTcpData
{
  struct sRGBSensor     *rgb_sensors;
  struct sLinePosition  *line_position;
  struct sLSM9DS0IMU    *lsm9ds0_imu;
  struct sTCPTerminal   *tcp_terminal;
};


#endif
