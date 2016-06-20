#include "tcp_data.h"

struct sTcpData g_tcp_data;
struct sTCPTerminal g_tcp_terminal;



#define TCP_DATA_TX_BUFFER_LENGTH   (u32)128
#define TCP_DATA_RX_BUFFER_LENGTH   (u32)128

char tcp_data_tx_buffer[TCP_DATA_TX_BUFFER_LENGTH];
char tcp_data_rx_buffer[TCP_DATA_RX_BUFFER_LENGTH];


void tcp_init()
{
  u32 i;
  g_tcp_terminal.lenght = 0;
  for (i = 0; i < TCP_TERMINAL_BUFFER_MAX_LENGTH; i++)
    g_tcp_terminal.buffer[i] = '\0';


  g_tcp_data.rgb_sensors = (struct sRGBSensor*)(&g_rgb);
  g_tcp_data.line_position = (struct sLinePosition*)(&g_line_position);
  g_tcp_data.lsm9ds0_imu = (struct sLSM9DS0IMU *)(&g_lsm9ds0_imu);
  g_tcp_data.tcp_terminal = &g_tcp_terminal;

  for (i = 0; i < TCP_DATA_TX_BUFFER_LENGTH; i++)
    tcp_data_tx_buffer[i] = 0;

  for (i = 0; i < TCP_DATA_RX_BUFFER_LENGTH; i++)
    tcp_data_rx_buffer[i] = 0;
}


i32 tcp_rgb_sensors_send()
{
  u32 i, ptr;

  for (i = 0; i < TCP_DATA_TX_BUFFER_LENGTH; i++)
    tcp_data_tx_buffer[i] = 0;

  ptr = 2;
  tcp_data_tx_buffer[0] = TCP_DATA_MARK;
  tcp_data_tx_buffer[1] = TCP_DATA_TYPE_RGB_SENSORS;
  for (i = 0; i < sizeof(struct sRGBSensor); i++)
  {
    tcp_data_tx_buffer[ptr] = ((char*)g_tcp_data.rgb_sensors)[i];
    ptr++;
  }


  return esp8266_connect(WIFI_SERVER_IP, WIFI_TERMINAL_PORT,
                        tcp_data_tx_buffer,
                        TCP_DATA_TX_BUFFER_LENGTH,
                        tcp_data_rx_buffer,
                        TCP_DATA_RX_BUFFER_LENGTH);
}

i32 tcp_line_sensor_send()
{
  u32 i, ptr;

  for (i = 0; i < TCP_DATA_TX_BUFFER_LENGTH; i++)
    tcp_data_tx_buffer[i] = 0;

  ptr = 2;
  tcp_data_tx_buffer[0] = TCP_DATA_MARK;
  tcp_data_tx_buffer[1] = TCP_DATA_TYPE_LINE_POSITION;
  for (i = 0; i < sizeof(struct sLinePosition); i++)
  {
    tcp_data_tx_buffer[ptr] = ((char*)g_tcp_data.line_position)[i];
    ptr++;
  }


  return esp8266_connect(WIFI_SERVER_IP, WIFI_TERMINAL_PORT,
                        tcp_data_tx_buffer,
                        TCP_DATA_TX_BUFFER_LENGTH,
                        tcp_data_rx_buffer,
                        TCP_DATA_RX_BUFFER_LENGTH);
}

i32 tcp_lsm9ds0_imu_send()
{
  u32 i, ptr;

  for (i = 0; i < TCP_DATA_TX_BUFFER_LENGTH; i++)
    tcp_data_tx_buffer[i] = 0;

  ptr = 2;
  tcp_data_tx_buffer[0] = TCP_DATA_MARK;
  tcp_data_tx_buffer[1] = TCP_DATA_TYPE_IMU;
  for (i = 0; i < sizeof(struct sLSM9DS0IMU); i++)
  {
    tcp_data_tx_buffer[ptr] = ((char*)g_tcp_data.lsm9ds0_imu)[i];
    ptr++;
  }


  return esp8266_connect(WIFI_SERVER_IP, WIFI_TERMINAL_PORT,
                        tcp_data_tx_buffer,
                        TCP_DATA_TX_BUFFER_LENGTH,
                        tcp_data_rx_buffer,
                        TCP_DATA_RX_BUFFER_LENGTH);
}


i32 tcp_terminal_send()
{
  u32 i, ptr;
 
  for (i = 0; i < TCP_DATA_TX_BUFFER_LENGTH; i++)
    tcp_data_tx_buffer[i] = 0;

    /*
  ptr = 2;
  tcp_data_tx_buffer[0] = TCP_DATA_MARK;
  tcp_data_tx_buffer[1] = TCP_DATA_TYPE_TERMINAL;
  */
  ptr = 0;
  for (i = 0; i < sizeof(struct sTCPTerminal); i++)
  {
    tcp_data_tx_buffer[ptr] = ((char*)g_tcp_data.tcp_terminal)[i];
    ptr++;
  }


  return esp8266_connect(WIFI_SERVER_IP, WIFI_TERMINAL_PORT,
                        tcp_data_tx_buffer,
                        TCP_DATA_TX_BUFFER_LENGTH,
                        tcp_data_rx_buffer,
                        TCP_DATA_RX_BUFFER_LENGTH);
}


void tcp_terminal_puts(char *s)
{
  u32 i;
  for (i = 0; i < TCP_TERMINAL_BUFFER_MAX_LENGTH; i++)
    g_tcp_terminal.buffer[i] = 0;

  g_tcp_terminal.lenght = strlen_(s);

  if (g_tcp_terminal.lenght < TCP_TERMINAL_BUFFER_MAX_LENGTH)
  {
    for (i = 0; i < g_tcp_terminal.lenght; i++)
      g_tcp_terminal.buffer[i] = s[i];
  }
}


i32 tcp_send()
{
  i32 res = 0;

/*
  res = tcp_rgb_sensors_send();
  if (res != ESP8266_SUCCESS)
    return (res - 100);

  res = tcp_line_sensor_send();
  if (res != ESP8266_SUCCESS)
    return (res - 200);

  res = tcp_lsm9ds0_imu_send();
  if (res != ESP8266_SUCCESS)
    return (res - 300);
*/
  res = tcp_terminal_send();
  if (res != ESP8266_SUCCESS)
    return (res - 400);

  return ESP8266_SUCCESS;
}
