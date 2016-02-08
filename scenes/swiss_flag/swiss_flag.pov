#include "colors.inc"

#declare Cols = 30;
#declare Rows = 30;

global_settings {
    assumed_gamma 1.0
    #if(RADIOSITY)
    radiosity {
        count 150
        /*
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
      */
    }
    #end
}

camera {
  /*
    location <Cols / 2, Rows / 2, -50>
    look_at <Cols / 2, Rows / 2, 0>
    */
    location <6,3.5,-10>
    look_at <9.3,10,0>
}

#declare StdCube = box {
    <0,0,0>,
    <1,1,1>
}

#declare WhiteCube = object {
    superellipsoid { <0.2,0.2> scale <1, 1, 1>*0.5 translate<0.5,0.5,0.5> }
    texture {
        pigment { color White }
        finish {
          emission 0.2
          diffuse 0.6
          phong 0.9
          phong_size 20
          reflection {
            0.3
          }
        }
    }
}

#declare RedCube = object {
    superellipsoid { <0.3,0.6> scale <0.95,0.95, 0.5>*0.5 translate<0.5,0.5,0.25> }
    texture {
        pigment { color rgbf<1.0, 0, 0, 0.5> }
        //pigment { color Red }
        finish {
          phong 0.9
          phong_size 90
          reflection {
            1.0
          }
        }
    }
    interior {
      ior 1.5
    }
}


#for (Col,0,Cols-1)
  #for (Row,0,Rows-1)
    #if (
      (Col >=8 & Col <= 16 & Row >= 11 & Row <= 13) |
      (Row >=8 & Row <= 16 & Col >= 11 & Col <= 13)
    )
      object {
        WhiteCube
        rotate <-6,6,0>
        translate <Col,Row,-4*((Row+Col)/50)+1>
      }
    #else
      object {
        RedCube
        translate <Col,Row,0>
      }
    #end
  #end
#end

box {
  <0, 0, -1>,
  <30,30,1>
  pigment { rgbt 1 } hollow
  interior {
    media {
      scattering { 2, 0.2 extinction 0.7 }
      samples 30
    }
  }
}

light_source {
    <25 / 2, 25 / 2, -10>
    color White
    spotlight
    radius 25
    falloff 40
    point_at <25 / 2, 25 / 2, 0>
}

light_source {
    <25 / 2, 25 / 2, 10>
    color White
    spotlight
    radius 40
    falloff 50
    point_at <25 / 2, 25 / 2, 0>
}
