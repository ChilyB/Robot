#include "robot_visualisation.h"


#include <X11/X.h>
#include <X11/Xlib.h>
#include <GL/gl.h>
#include <GL/glx.h>
#include <GL/glu.h>
#include <GL/freeglut.h>
#include <GL/glut.h>


CRobotVisualisation::CRobotVisualisation(u32 enable_opengl, class CAgentGroup *agent_group)
{
  terminal_width = 128;
  terminal_height = 32;

  cm_size = 10.0*100.0/81.0;


  screen_width = 1920;
  screen_height = 1080;

/*
  screen_width = 640;
  screen_height = screen_width*9.0/16.0;
*/
/*
  screen_width = 1024;
  screen_height = screen_width*9.0/16.0;
*/

  agent_idx = 0;

  u32 maximum_agents_count = 2048;
  double agent_life_time_ms = 2000.0;

  if (agent_group == NULL)
    this->agent_group = new CAgentGroup(maximum_agents_count, agent_life_time_ms);
  else
    this->agent_group = agent_group;

  clear();
  if (enable_opengl == true)
    visualise_init();

  client = new CClient();
}

CRobotVisualisation::~CRobotVisualisation()
{
  delete client;
  delete agent_group;
}

i32 CRobotVisualisation::read_from_server()
{
  struct sAgentInterface agent_interface;

  agent_interface.id = 0;
  agent_interface.param = 0;
  agent_interface.time_stamp = get_ms_time();
  agent_interface.type = AGENT_TYPE_VISUALISATION;
  agent_interface.type_behaviour = AGENT_TYPE_BEHAVIOUR_NULL;
  agent_interface.type_interaction = AGENT_TYPE_INTERACTION_NULL;

  agent_interface.x = 0.0;
  agent_interface.y = 0.0;
  agent_interface.z = 0.0;

  agent_interface.roll = 0.0;
  agent_interface.pitch = 0.0;
  agent_interface.yaw = 0.0;

  agent_interface.size = 1.0;
  agent_interface.dt = cfg_get_dt();

  agent_interface.action_type = ACTION_TYPE_NULL;

  agent_interface.param = agent_idx;
  i32 res  = client->process(&agent_interface);

  if (res == 0)
    agent_idx = (agent_idx+1)%agent_interface.action_type;


  if ( (res == 0) && (agent_interface.type != AGENT_TYPE_VISUALISATION) )
  {
    agent_interface.id = agent_interface.param;
    agent_group->update_agent(&agent_interface, NULL);
  }

  return res;
}


void CRobotVisualisation::print()
{
  return;
  u32 i;
  for (i = 0; i < agent_group->get_size(); i++)
  {
      struct sAgentInterface agent_interface;

      agent_group->get_agent(&agent_interface, i);

      if (agent_interface.id != 0)
        printf("%u %f %f\n", agent_interface.id, agent_interface.x, agent_interface.y);

      /*
      if (agent_interface.id != 0)
      {
        i32 x = 0;
        i32 y = 0;
        u32 c = ' ';

        c = 'A' + (agent_interface.type%27);

        x = terminal_width*(agent_interface.x + 1.0)/2.0;
        if (x < 0)
          x = 0;
        if (x >= terminal_width)
          x = terminal_width;


        y = terminal_height*(agent_interface.y + 1.0)/2.0;
        if (y < 0)
          y = 0;
        if (y >= terminal_height)
          y = terminal_height;


      	printf("%c[%d;%df",0x1B,(u32)y,(u32)x);
      	printf("%c", c);
      }
      */
  }
}

void CRobotVisualisation::clear()
{
  i32 x, y;

  for (y = 0; y <= terminal_height; y++)
  for (x = 0; x <= terminal_width; x++)
  {
    char c = ' ';
    printf("%c[%d;%df",0x1B,(u32)y,(u32)x);
    printf("%c", c);
  }
}





void point_rotate(float *x_res, float *y_res, float x, float y, float angle)
{
  *x_res = cos(angle)*x - sin(angle)*y;
  *y_res = sin(angle)*x + cos(angle)*y;
}


void CRobotVisualisation::visualise_paint_agent(struct sAgentInterface agent_interface)
{
  float x = agent_interface.x;
  float y = agent_interface.y;
  float z = agent_interface.z;

  float yaw = agent_interface.yaw;

  float width = agent_interface.size*cm_size*0.1;
  float depth = agent_interface.size*cm_size*0.1;
  float height = agent_interface.size*cm_size*0.1;

  struct sBotColor color = bot_to_color(agent_interface);
  float r = color.r*agent_interface.color_intensity;
  float g = color.g*agent_interface.color_intensity;
  float b = color.b*agent_interface.color_intensity;

  float ax, ay;
  float bx, by;
  float cx, cy;
  float dx, dy;

  point_rotate(&ax, &ay, -width/2.0, -depth/2.0, yaw);
  point_rotate(&bx, &by, -width/2.0, depth/2.0, yaw);
  point_rotate(&cx, &cy, width/2.0, depth/2.0, yaw);
  point_rotate(&dx, &dy, width/2.0, -depth/2.0, yaw);

  glColor3f(r, g, b);

  glBegin(GL_QUADS);
  glVertex3f(x + ax, y + ay, z + 0.001);
  glVertex3f(x + bx, y + by, z + 0.001);
  glVertex3f(x + cx, y + cy, z + 0.001);
  glVertex3f(x + dx, y + dy, z + 0.001);

/*
  glVertex3f(x + ax, y + ay, z + height);
  glVertex3f(x + bx, y + by, z + height);
  glVertex3f(x + cx, y + cy, z + height);
  glVertex3f(x + dx, y + dy, z + height);
*/

  glEnd();

  glBegin(GL_LINES);
  glVertex3f(x, y, z + 0.001);
  glVertex3f(x, y, z + 0.001 + height);
  glEnd();

/*
  char str[256];
//  sprintf(str,"%i %i", agent_interface.id, agent_interface.value);
  sprintf(str,"g%i", agent_interface.value);

  struct sBotColor font_color = uint_to_color(agent_interface.value, 8);

  print(x, y, font_color.r, font_color.g, font_color.b, GLUT_BITMAP_8_BY_13, str);
*/

}

void CRobotVisualisation::print(float x, float y, float r, float g, float b, void *font, char *string)
{
  glColor3f( r, g, b );
  glRasterPos2f(x, y);
  int len, i;
  len = (int)strlen(string);
  for (i = 0; i < len; i++) {
    glutBitmapCharacter(font, string[i]);
  }
}

void CRobotVisualisation::visualise_refresh()
{
  glMatrixMode(GL_PROJECTION);
  glShadeModel(GL_SMOOTH);
  glEnable(GL_DEPTH_TEST);
  glMatrixMode(GL_MODELVIEW);

  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  glLoadIdentity();

  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LEQUAL);

  glMatrixMode(GL_MODELVIEW);

  u32 g_view_state = 0;

  switch (g_view_state)
  {
    case 0:
          glTranslatef(0.0, 0.0, -800.0);
          glRotatef(0.0, 0.0, 0.0, 0.0);
          break;

    case 1:
          glTranslatef(0.0, 0.0, -4.0);
          glRotatef(0.0, 0.0, 0.0, 0.0);
          break;


    case 2:
          glTranslatef(0.0, 0.0, -1000.0);
          glRotatef(-70.0, 1.0, 0.0, 0.0);
          break;

  }

  glClearColor(0.0, 0.0, 0.0, 0.0);

  u32 max_y = 100;
  u32 max_x = (max_y*16.0)/9.0;
  u32 j, i;

  for (j = 0; j < max_y; j++)
    for (i = 0; i < max_x; i++)
    {
      if ((j%2) == (i%2))
        glColor3f(0.05, 0.05, 0.05);
      else
        glColor3f(0.0, 0.0, 0.0);

      float size = cm_size;
      float x = size*(i - max_x/2.0);
      float y = size*(j - max_y/2.0);


      glBegin(GL_QUADS);
      glVertex3f(x - 0.5*size, y - 0.5*size, 0.0);
      glVertex3f(x + 0.5*size, y - 0.5*size, 0.0);
      glVertex3f(x + 0.5*size, y + 0.5*size, 0.0);
      glVertex3f(x - 0.5*size, y + 0.5*size, 0.0);
      glEnd();
    }

    i32 get_agent(struct sAgentInterface *agent_interface, u32 idx);

  for (j = 0; j < agent_group->get_size() ; j++)
  {
    struct sAgentInterface agent_interface;
    agent_group->get_agent(&agent_interface, j);
    if (agent_interface.id != 0)
      visualise_paint_agent(agent_interface);
  }

  glutSwapBuffers();
}

void CRobotVisualisation::visualise_init()
{
  u32 window_width = screen_width;
  u32 window_height = screen_height;

  int num = 0;

  glutInit(&num, NULL);
  glutInitWindowSize(window_width, window_height);
  glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE);
  glutCreateWindow("robot visualisation");


  //glutIdleFunc(visualise_idle);
  //glutKeyboardFunc(visualise_process_keys);

  glViewport(0, 0, window_width, window_height);
  glMatrixMode(GL_PROJECTION);
  glEnable(GL_DEPTH_TEST);
  gluPerspective(45, (float) window_width / window_height, 0.1, 2000);
  glMatrixMode(GL_MODELVIEW);

//  rendering_thread = new std::thread(visualise_rendering_thread);
}

void CRobotVisualisation::kill_zombies()
{
  agent_group->kill_zombies();
}
