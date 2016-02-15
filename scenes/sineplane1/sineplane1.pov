#include "colors.inc"
#include "rad_def.inc"
#include "shapes.inc"

#declare Rows = 100;
#declare Cols = 100;

global_settings {
    assumed_gamma 1.0
    #if(RADIOSITY)
    radiosity {
        Rad_Settings(Radiosity_Default, off, off)
    }
    #end
}

camera {
    location <7,30,4>
    look_at  <Cols * 0.3, 4,Rows * 0.38>
}

#declare StdCube = box {
  <0,0,0>, <0.9,0.9,0.9>
}

#declare BlackBox = object {
  StdCube
  texture {
    pigment {
      color <1,1,1>
    }
    finish {
      reflection 0.8
      phong 0.8
      diffuse 0.7
    }
  }
}

#declare BlackSphere = object {
  Round_Box(<0,0,0>,<1,3,1>,0.2,true)
  texture {
    pigment {
      color rgbf<1,1,1,0.7>
    }
    finish {
      reflection 0.2
      phong 0.8
      diffuse 0.7
    }
  }
  interior {
    ior 1.5
  }
}


#for (xt,0,Cols-1)
  #for (zt,0,Rows-1)
    /*object {
        BlackBox translate <xt,0,zt>
    }*/
    object {
      BlackSphere translate <xt,10*sin(xt / Cols * 6.0 * pi)*sin(zt / Rows * 6.0 * pi),zt>
    }
  #end
#end

light_source {
    <0,50,0>
    color Blue
}

light_source {
    <Rows,50,Cols>
    color Yellow
}

light_source {
    <0,50,Cols>
    color Red
}

light_source {
    <Cols,50,0>
    color Green
}
