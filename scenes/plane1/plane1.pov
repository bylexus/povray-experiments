#include "colors.inc"

#declare Rows = 30;
#declare Cols = 30;
#declare PosRand = seed(1);
#declare TransRand = seed(5);
#declare RandDelta = 1;

global_settings {
    assumed_gamma 1.0
    #if(RADIOSITY)
    radiosity {
        count 150
      pretrace_start 0.08
      pretrace_end   0.01

      nearest_count 10
      error_bound 0.5
      recursion_limit 3
      low_error_factor 0.5
      gray_threshold 0.0
      minimum_reuse 0.005
      maximum_reuse 0.2
      brightness 1
      adc_bailout 0.005
    }
    #end
}

camera {
    location <1, 5, 1>
    look_at  <5, 1, 5>
    //location <1, 30, 1>
    //look_at  <10, 1, 10>
}

sky_sphere {
  pigment {
    gradient y
      color_map {
        [ 0.5  color CornflowerBlue ]
        [ 1.0  color MidnightBlue ]
        }
    scale 2
    translate -1
    }
  emission rgb <0.8,0.8,1>
  }

#declare StdCube = box {
    <0,0,0>,
    <0.99,0.99,0.99>

}

#for (xt,0,Cols-1)
  #for (zt,0,Rows-1)
    object {
        StdCube translate <xt,rand(PosRand)*RandDelta - RandDelta/2,zt>
            #if (xt = 6)
            texture {
                pigment { color rgbf <1,0,0,0.5> }
                finish {
                    diffuse 0.3
                    emission 0.2
                    reflection 0.4
                }
              }
              interior {
                ior 1.5
              }
            #else
            texture {
                pigment { color rgb <1,1,1> }
                finish {
                    diffuse 0.65
                    emission 0
                }
            }
            #end
        }
  #end
#end

light_source {
    <-5, 5, -5>
    color White
    spotlight
    radius 10
    falloff 45
    tightness 20
    point_at <10,0,10>
    area_light <4,0,-4>, <0,4,4>,15,15
}
