with Alire.Index.Libglfw3;
with Alire.Index.LibX11;

package Alire.Index.OpenGLAda is

   Prj_Name : constant Project_Name        := "openglada";
   Prj_Desc : constant Project_Description := "Thick Ada binding for OpenGL and GLFW";
   Prj_Repo : constant URL                 := "https://github.com/flyx/OpenGLAda.git";

   Prj_Author     : constant String := "Felix Krause <contact@flyx.org>";
   Prj_Website    : constant URL    := "http://flyx.github.io/OpenGLAda/";

   V_0_0_0 : constant Release :=
               Register (Prj_Name,
                         V ("0.6"),
                         Prj_Desc,
                         Git (Prj_Repo, "54a7a50cebab2cba0262c7f59b927e9ddf6e4649"),

                         Dependencies =>
                           On_Condition
                             (System_Is (GNU_Linux),
                              Within_Major (Libglfw3.V_3) and Within_Major (LibX11.V_2)),

                         Properties =>
                           GPR_File ("opengl.gpr") and
                           GPR_File ("opengl-glfw.gpr") and
                           GPR_File ("opengl-soil.gpr") and
                           GPR_File ("opengl-test.gpr") and

                           GPR_Scenario ("GLFW_Version", "2" or "3") and
                           GPR_Scenario ("Mode", "debug" or "release") and
                           GPR_Scenario ("Auto_Exceptions", "enabled" or "disabled") and

                           Executable ("gl_test-opengl3") and
                           Executable ("gl_test-context") and
                           Executable ("gl_test-vbos") and
                           Executable ("gl_test-shaders") and
                           Executable ("gl_test-framebuffers") and
                           Executable ("gl_test-immediate") and

                           Author     (Prj_Author) and
                           Website    (Prj_Website) and
                           License    (MIT),

                         Alr_Properties =>
                           On_Condition
                             (System_Is (GNU_Linux), GPR_Config ("-XWindowing_System=x11")),

                         Available_When =>
                           System_Is (GNU_Linux)
                        );

end Alire.Index.OpenGLAda;
