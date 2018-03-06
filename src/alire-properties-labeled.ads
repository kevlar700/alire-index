with Alire.Conditional;

private with Alire.Utils;

package Alire.Properties.Labeled with Preelaborate is

   --  Properties that have a single string value and a name

   type Labels is (--  user labels
                   Author,      -- VIP
                   Comment,     -- Extra text
                   Description, -- One-liner description, so it is searched too
                   Executable,  -- A resulting executable built by the project
                   Maintainer,  -- Info about the maintainer of the alr-packaged project
                   Project_File,-- GPR files that the user can use. No path. This is purely informative
                   Website,

                   --  internal labels
                   GPR_Config, -- Extra config to pass to gprbuild for building the project with alr
                   GPR_File,   -- Alternative naming of the project file (or more than one)
                               -- Those are used when testing the build, and must include full relative path
                   GPR_Path    -- Extra path to add to the environment to look for projects
                  );    -- A website other than the repository

   type Label (<>) is new Properties.Property with private;

   function New_Label (Name : Labels; Value : String) return Label;

   function Name (L : Label) return Labels;

   function Value (L : Label) return String;

   overriding function Image (L : Label) return String;

--     generic
--        Name : Labels;
--     function Vec_New_Label (Value : String) return Properties.Vector;
--     --  Returns a vector so its directly usable during indexing

   generic
      Name : Labels;
   function Cond_New_Label (Value : String) return Conditional.Properties;

private

   type Label (Length : Natural) is new Properties.Property with record
      Name  : Labels;
      Value : String (1 .. Length);
   end record;

   function New_Label (Name : Labels; Value : String) return Label is
     (Properties.Property with Value'Length, Name, Value);

   function Name (L : Label) return Labels is (L.Name);

   function Value (L : Label) return String is (L.Value);

--     function Vec_New_Label (Value : String) return Properties.Vector is
--       (To_Vector (New_Label (Name, Value), 1));

   function Cond_New_Label (Value : String) return Conditional.Properties is
     (Conditional.For_Properties.New_Value (+New_Label (Name, Value)));

   overriding function Image (L : Label) return String is (Utils.To_Mixed_Case (L.Name'Img) & ": " & L.Value);

end Alire.Properties.Labeled;
