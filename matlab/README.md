# Simulink Development Demo #

## Files ##
1. test_create_subsystem: Model that is referenced in use_test.
2.  use_test: Model that references the external subsystem. This model is that you run.
3.  test.mat: Mat file that holds initial parameters for subsystem
4.  subsystem_script: Script that demos how to use the system

### test create subsystem ###

Multiplies the input by A. A is loaded by the test.mat when x in the base workspace is 2. Makes A = 3 if x is 3 and makes A = 10 otherwise. The code below can be found in the model explorer as the "data_source" of the model workspace

    x = evalin('base','x');
    
    if x == 2
      load test.mat
    elseif x == 3
      A = 3;
    else
      A = 10;
    end

### Use Test ###

Multiplies 1 by A and put it in out. Boring 

### test.mat ###

A = 2

### Subsystem script ###

Runs use test model in various tests. See comments in the file.

