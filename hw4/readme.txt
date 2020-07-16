There are 2 main scripts.
>>mlp_model_q1.m
>>mlp_model_q2.m

At the first question, almost all random initial weight matrices converge to optimum weight matrix at about 80000 iterations and it lasts about 1 minute.

At the second question,random initial weight matrices may not converge to optimum weight matrix. 
When the code is run, it terminates until the error becomes less than 0.0075 or the number of iterations reaches 1 million. It lasts about 10 minutes.

!!! If the random initial matrix does not converge, the initial matrix file (w_init_q2.mat) at the folder can be loaded and used.
!!! To use this matrix as initial weight, definition of the initial weight must be changed at the line 17. 
!!! It must be commented and the initialization at the line 14 must be uncommented. 
The results at the report can be checked using this weight. (It lasts about 3 minutes.)

line 14 %init_weight = w_init_q2;

random_weight = rand(layer_size-1,max_node,max_node);
line 17 %init_weight = random_weight;