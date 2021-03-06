#ifndef _APP_CORE_H_
#define _APP_CORE_H_

// #define _CORE_H_ 1

// #include "common.h"


struct sSquare
{
	float x, y, z;
	float r, g, b;
	float x_size, y_size, z_size;
};

class CAppCore
{
	public:
		CAppCore();
		~CAppCore();

	public:
		void on_delete();
	    void on_wall(); 

    	void on_red_robot();
		void on_red_target();
	    void on_red_path();


        void on_green_robot();
        void on_green_target();
        void on_green_path();

        void on_blue_robot();
        void on_blue_target();
        void on_blue_path();

	    void on_path();
        void on_target();
        void on_source();
        void on_destination();
    
	    void on_new(char* file_name);
	    void on_open(char* file_name);
	    int on_save();
	    void on_save_as(char* file_name);


	    void on_click(int x, int y, int width, int height);
	    void on_paint();

	    struct sSquare *get_square();

        unsigned int get_width();
        unsigned int get_height();
	    
	private:
		struct sSquare square;
};

#endif
