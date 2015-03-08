function [Data] = Dataset2Ts( Dataset )
    Data = struct;
    for i = 1:Dataset.numElements
        e = Dataset.get(i);
        if (isa(e,'Simulink.SimulationData.Dataset') == 1)
            Dataset2Ts(e);
        else
            Data.(e.Name) = e.Values;
        end
    end

end

