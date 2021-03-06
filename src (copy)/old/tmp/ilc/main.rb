require "./plant.rb"
require "./ilc.rb"
require "./input.rb"
require "./log.rb"
require "./kohonen.rb"

trial_size = 150
maneuvers_count = 20
kohonen_window_size = 4

plant = CPlant.new()
ilc = CILC.new(trial_size, maneuvers_count)
input = CInput.new()

kohonen = CKohonenNN.new(kohonen_window_size, 100, 0.1)


log = CLog.new("bin/result.txt", 4);
maneuvers_log = CLog.new("bin/maneuvers_result.txt", 6);
error_log = CLog.new("bin/maneuvers_error.txt", 2);


required_value = 0.0
plant_output = 0.0
controller_output = 0.0
 
trials = 200
for j in 0..trials

	total_error = 0.0

	for m in 0..maneuvers_count-1

		input.reset()
		ilc.reset()
		plant.reset()

		plant_output = 0.0

		for i in 0..trial_size-1
			
			required_value = input.get(i, m)
			error = required_value - plant_output
			
			controller_output = ilc.get(error, m)

			#kohonen.process(required_value/20.0)
			#controller_output = kohonen.get()
			#kohonen.learn(error)
			

			plant_output = plant.get(controller_output)

			total_error+= error.abs

			if ((j%(trials/5)) == 0) && (m == maneuvers_count-1)
				log.add(0, required_value)
				log.add(1, plant_output)
				log.add(2, controller_output)
				log.add(3, error)
			end

			if (j == trials)
				maneuvers_log.add(0, m)
				maneuvers_log.add(1, i)
				maneuvers_log.add(2, required_value)
				maneuvers_log.add(3, plant_output)
				maneuvers_log.add(4, controller_output)

				maneuvers_log.add(5, error)
			end
		end
		
	end



	total_error/= maneuvers_count

	printf("complete %6.2f%%, error %6.3f\n", j*100.0/trials, total_error);

	error_log.add(0, j)
	error_log.add(1, total_error)

end

log.save()
maneuvers_log.save()
error_log.save()

printf("program done\n")