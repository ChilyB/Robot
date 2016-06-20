#ifndef _TCP_DATA_STRUCT_H_
#define _TCP_DATA_STRUCT_H_

#define TCP_TERMINAL_BUFFER_MAX_LENGTH  ((u32)64)

#define TCP_DATA_MARK                   ((u8)0xAB)
#define TCP_DATA_TYPE_RGB_SENSORS       ((u8)'R')
#define TCP_DATA_TYPE_LINE_POSITION     ((u8)'L')
#define TCP_DATA_TYPE_IMU               ((u8)'I')
#define TCP_DATA_TYPE_TERMINAL          ((u8)'T')

struct sTCPTerminal
{
  u32 lenght;
  char buffer[TCP_TERMINAL_BUFFER_MAX_LENGTH];
};

struct sTcpData
{
  struct sRGBSensor     *rgb_sensors;
  struct sLinePosition  *line_position;
  struct sLSM9DS0IMU    *lsm9ds0_imu;
  struct sTCPTerminal   *tcp_terminal;
};






#endif
