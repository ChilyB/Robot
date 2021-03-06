#ifndef _S_ROBOT_PACKET_H_
#define _S_ROBOT_PACKET_H_

#include "common.h"


#define ROBOT_PACKET_DATA_SIZE					(u32)256

struct sRobotPacket
{
	u32 robot_id;
	u32 type;
	u32 part;
	u32 crc;
	u32 size;

	u8 data[ROBOT_PACKET_DATA_SIZE];
};


#define ROBOT_PACKET_TYPE_NULL					(u32)0
#define ROBOT_PACKET_TYPE_PING_REQUEST			(u32)1
#define ROBOT_PACKET_TYPE_PING_RESPONSE			(u32)2
#define ROBOT_PACKET_TYPE_STATE_REQUEST			(u32)3
#define ROBOT_PACKET_TYPE_STATE_RESPONSE		(u32)4

#define ROBOT_PACKET_TYPE_FIRMWARE_REQUEST		(u32)5
#define ROBOT_PACKET_TYPE_FIRMWARE_RESPONSE		(u32)6

#define ROBOT_PACKET_TYPE_DATA_SEND				(u32)7
#define ROBOT_PACKET_TYPE_DATA_RECEIVE			(u32)8

#define ROBOT_PACKET_TYPE_COMMON_REQUEST		(u32)9
#define ROBOT_PACKET_TYPE_COMMON_RESPONSE		(u32)10


#endif