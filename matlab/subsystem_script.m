clear all
sub = get_param('test_create_subsystem','ModelWorkspace');

x = 2;
sub.reload
sim('use_test')
out(1)
% should be 2


assignin(sub,'A',10)

sim('use_test')
out(1)
% should be 10

x = 3;
sub.reload
sim('use_test')
out(1)
% should be 3

assignin(sub,'A',10)

sim('use_test')
out(1)
% should be 10

clear all
