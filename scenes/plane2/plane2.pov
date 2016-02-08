#include "colors.inc"

#declare r = 25;
#declare startAngle = radians(0);
#declare endAngle = radians(60);
#declare stepAngle = radians(2.1);
#declare rSeed = seed(2);


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
    //location <0,0,0>
    //look_at  <0,0,5>
    location <r - r/5,0,0>
    look_at <r,10,15>
}

sky_sphere {
  pigment {
    gradient y
      color_map {
        [ 0  color OrangeRed ]
        [ 1.0  color MidnightBlue ]
        }
    scale 2
    translate -1
    }
  emission rgb <0.8,0.8,1>
  }

#declare StdCube = box {
    <0,0,0>,
    <1,1,1>

}

#declare WhiteCube = object {
    StdCube
    texture {
        pigment { color White }
    }
}

#for (actYAngle,startAngle,endAngle,stepAngle)
    #for (actZAngle, startAngle,endAngle,stepAngle)
        #local rRand = ((rand(rSeed)*0.03) + 1) * r;

        // see http://www.mathepedia.de/Kugelkoordinaten.aspx:
        #local posX = rRand * cos(actZAngle) * cos(actYAngle);
        #local posY = rRand * cos(actZAngle) * sin(actYAngle);
        #local posZ = rRand * sin(actZAngle);

        #local turnZAngle = -(90 - degrees(actYAngle));
        #local turnYAngle = -degrees(actZAngle);
        object {
            StdCube
            texture {
                pigment {
                    color <1,(1-actYAngle / (endAngle-startAngle))*0.8,(1-actZAngle / (endAngle-startAngle))*0.8>
                }
                finish {
                    diffuse 0.9
                    emission 0
                    phong 1
                    reflection 0.2
                }
            }
            rotate <0,0,turnZAngle>
            rotate <0,turnYAngle,0>
            translate <posX, posY,posZ>
        }
    #end
#end


light_source {
    <r - r/8,0,0>
    color MandarinOrange
    area_light <1,0,-1>, <0,1,-1>,10,10
}

light_source {
    <r - r/2,0,r - r/2>
    color HuntersGreen
    area_light <1,0,-1>, <0,1,-1>,10,10
}
