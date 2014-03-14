# Generated code ahoy!
module LIFX
  module Protocol
    module Sensor
      class GetAmbientLight < Payload
        endian :little

      end

      class StateAmbientLight < Payload
        endian :little

        float :lux
      end

      class GetDimmerVoltage < Payload
        endian :little

      end

      class StateDimmerVoltage < Payload
        endian :little

        uint32 :voltage
      end

    end
  end
end
