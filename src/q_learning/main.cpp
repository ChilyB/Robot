#include "common.h"
#include "robot_brain/robot_test.h"

void test()
{
	class CRobotTest *robot_test;

	robot_test = new CRobotTest();

	robot_test->run(100000);

	delete robot_test;
}


int main()
{
	srand(time(NULL));

	test();

	printf("program done\n");
	return 0;
} 
