function [] = RW3_Pikes_Peak_Defaults(Rider,Env,Battery,MotorController,Motor,Chassis,Gear,Brakes,Tires, FileName)
Battery.FileName = FileName.Battery;
Battery.reload();		% reload workspace from source file

Brakes.FileName = FileName.Brakes;
Brakes.reload();		% reload workspace from source file

Chassis.FileName = FileName.Chassis ;
Chassis.reload();		% reload workspace from source file

Env.FileName = FileName.Env ;
Env.reload();		% reload workspace from source file

Gear.FileName = FileName.Gear ;
Gear.reload();		% reload workspace from source file

Motor.FileName = FileName.Motor ;
Motor.reload();		% reload workspace from source file


MotorController.FileName = FileName.MotorController ;
MotorController.reload();		% reload workspace from source file

Rider.FileName = FileName.Rider ;
Rider.reload();		% reload workspace from source file

Tires.FileName = FileName.Tires  ;
Tires.reload();		% reload workspace from source file
end

