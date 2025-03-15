
# Using attributes

https://code.amazon.com/search?utf8=%E2%9C%93&term=attributes_&exact=&filepath=&repository=PryonNode*&group=&source_component_type=&graph_type=&ext=&commit=Search


Org: "pipe_builder_configuration_time_sum": 285392649,
New: "pipe_builder_configuration_time_sum": 177147058,  (still not reading legacy config, so it will degrade once I will start parsing that)

Org: "flow_main_task_execution_time_sum": 260805939, (includes TD routine, and fusion )
New: "flow_main_task_execution_time_sum": 127164774,

Org: "input_ti_profile_execution_time_sum": 60056,
New: "input_ti_profile_execution_time_sum": 119534, (not sure why, using the same profiles, will keep in mind to check in details later)

Org: "input_utt_bounds_execution_time_sum": 50194,
New: "input_utt_bounds_execution_time_sum": 25285, (I did optimize some routines during decoupling, for example switched from using vector to priority queue)

Org: "input_audio_execution_time_sum": 258559578,
New: "input_audio_execution_time_sum": 127003143,

Org: "pipe_build_total_time_sum": 1117759, (all nodes creation, including Shim, does not include detector creation time because Shim will trigger that only after it gets all TD and TI profiles)
New: "pipe_build_total_time_sum": 1204959, (all nodes instantiation - Pipe is ready to accept any data, though will throw if audio is pushed BEFORE all TI profiles are provided)

(we do not include TD related routines in new engine, since it is only TI)
"input_ww_profile_execution_time_sum": 2111110, (it hides detector creation time here together with the time to process TD profiles)
"input_ww_info_execution_time_sum": 11256,
