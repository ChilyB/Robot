#ifndef _ENVIRONMENT_H_
#define _ENVIRONMENT_H_

#include "../common.h"

class CEnvironment
{
  private:
    class CAgentGroup *agent_group;
    class CMap *map;

    class CServer *server;

    bool visualisation_enabled;
    std::thread *visualisation_thread;

  public:
    CEnvironment( struct sMapInit map_init, char *map_file_name = NULL,
                  u32 maximum_agents_count = 1024, double agent_life_time_ms = 2000.0,
                  bool visualisation_enabled = false
                );
    ~CEnvironment();

    i32 call_back(struct sAgentInterface *agent_interface);

    void kill_zombies();

  private:
    void process_bot_collisions(struct sAgentInterface *agent_interface);

    void visualisation_refresh();
};

#endif
