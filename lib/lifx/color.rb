module LIFX
  class Color < Struct.new(:hue, :saturation, :brightness, :kelvin)
    # Color handles converting to and from the Hsbk structure
    # that the protocol requires
    UINT16_MAX = 65535
    DEFAULT_KELVIN = 0

    class << self
      def white(brightness = 1.0, kelvin = DEFAULT_KELVIN)
        new(0, 0, brightness, kelvin)
      end

      def hsb(hue, saturation, brightness)
        new(hue, saturation, brightness, DEFAULT_KELVIN)
      end

      def hsbk(hue, saturation, brightness, kelvin)
        new(hue, saturation, brightness, kelvin)
      end

      def hsl(hue, saturation, luminance)
        # From: http://ariya.blogspot.com.au/2008/07/converting-between-hsl-and-hsv.html
        l = luminance * 2
        saturation *= (l <= 1) ? l : 2 - l
        brightness = (l + saturation) / 2
        saturation = (2 * saturation) / (l + saturation)
        new(hue, saturation, brightness)
      end
    end

    def initialize(hue, saturation, brightness, kelvin)
      hue = hue % 360
      super(hue, saturation, brightness, kelvin)
    end

    def to_hsbk
      Protocol::Light::Hsbk.new(
        hue: (hue / 360.0 * UINT16_MAX).to_i,
        saturation: (saturation * UINT16_MAX).to_i,
        brightness: (brightness * UINT16_MAX).to_i,
        kelvin: kelvin.to_i
      )
    end
  end
end