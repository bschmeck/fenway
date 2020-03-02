Launch with `mix scenic.run`

Mix will boot the Fenway application, which loads viewport config via Application.get_env and starts two children:
1. `Fenway.Sensor.Supervisor`
2. Scenic, with the loaded viewport config

The Sensor.Supervisor came with the default Scenic app, I'm not sure why it's still around.

The viewport config loads the Monster scene, which builds a graph, adds the Scoreboard component and pushes it.

Currently, the AtBat component starts a timer and has an handle_info/2 method that updates the at bat display every two seconds.