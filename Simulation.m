classdef Simulation
    %SIMULATION Summary of this class goes here
    %   Detailed explanation goes here

    properties
        numDevices
        deviceRange
        groundWidth
    end

    methods
        function obj = Simulation(numDevices,deviceRange, groundWidth)
            %SIMULATION Construct an instance of this class
            %   Detailed explanation goes here
            obj.numDevices = numDevices; % Number of devices
            obj.deviceRange = deviceRange; % Define device range in meters
            obj.groundWidth = groundWidth; % Define ground width size in meters
        end

        function connectionRatio = simulate(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            
            rng(0) % make deterministic
            
            % Preallocate result matrix with the correct size (20-by-2 for 20 devices)
            result = zeros(obj.numDevices, 2);
            
            % Generate random values based on the number of devices
            result(:,1) = randi([1 obj.groundWidth], obj.numDevices, 1); % X data
            result(:,2) = randi([1 obj.groundWidth], obj.numDevices, 1); % Y data
            
            adjMatrix = zeros(obj.numDevices, obj.numDevices);
            for i = 1:obj.numDevices
                for j = 1:obj.numDevices
                    if (sqrt( abs(result(i,1)-result(j,1))^2 + abs(result(i,2)-result(j,2))^2) <= obj.deviceRange)
                        adjMatrix(i,j) = 1;
                        if (i==j)
                            adjMatrix(i,j) = 0;
                        end
                    end
                end
            end
            grp = graph(adjMatrix);

            [~,binsize] = conncomp(grp);
            connectionRatio = 1-binsize(1)/80;
        end
    end
end

