### To build sokol on **WINDOWS** You must open a VS insiders cmd prompt i.e. installed with Visual Studio Code installer

#### Steps to install
- open VS Insiders cmd
- cd to third_party/sokol directory
- run script build_clibs_windows.cmd with command:

```.\build_clibs_windows```

NOTE: the above command builds sokol library for both the backends i.e. DirectX11 and OpenGL in both as debug and release

# Using sokol built clibs
When running odin run . if you wanna use debug sokol debug build specify debug flag like so:

```odin run . -debug```

and if you wanna use opengl backend specify -define:SOKOL_USE_GL=true flag like so:

```odin run . -define:SOKOL_USE_GL=true```


NOTE: SOKOL doesn't do any coordinate flipping it doesn't touch your TEXTURE UV's or the PROJECTION matrix.

You have to handle the TEXTURE UV coordinates distinction between OpenGL and DirectX11 yourself
*there a opt in setting which you can try in future for texture uv*
