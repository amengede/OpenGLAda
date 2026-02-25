--  part of OpenGLAda, (c) 2017 Felix Krause
--  released under the terms of the MIT license, see the file "COPYING"

with Interfaces.C.Pointers;

with GL.Vectors;
with GL.Matrices;

generic
   type Element_Type is private;
   type Index_Type   is (<>);
   with function "+" (Left, Right : Element_Type) return Element_Type is <>;
   with function "-" (Left, Right : Element_Type) return Element_Type is <>;
   with function "-" (Left        : Element_Type) return Element_Type is <>;
   with function "*" (Left, Right : Element_Type) return Element_Type is <>;
   with function "/" (Left, Right : Element_Type) return Element_Type is <>;
   Null_Value, One_Value : Element_Type;
package GL.Algebra is
   pragma Preelaborate;

   -----------------------------------------------------------------------------
   --                              Vector types                               --
   -----------------------------------------------------------------------------

   package Vectors2 is new Vectors (Index_Type   => Index_2D,
                                    Element_Type => Element_Type);
   package Vectors3 is new Vectors (Index_Type   => Index_3D,
                                    Element_Type => Element_Type);
   package Vectors4 is new Vectors (Index_Type   => Index_Homogeneous,
                                    Element_Type => Element_Type);

   --  Two Dimensional Vector
   type Vector2 is new Vectors2.Vector;
   --  Three Dimensional Vector
   type Vector3 is new Vectors3.Vector;
   -- Four Dimensional Vector
   type Vector4 is new Vectors4.Vector;

   -- Truncate a 3D Vector to a 2D Vector
   -- @param Vector Vector to truncate
   -- @return Truncated result
   function To_Vector2 (Vector : Vector3) return Vector2;
   -- Truncate a 4D Vector to a 2D Vector
   -- @param Vector Vector to truncate
   -- @return Truncated result
   function To_Vector2 (Vector : Vector4) return Vector2;
   -- Extend a 2D Vector to a 3D Vector, appending Z = 0.
   -- @param Vector Vector to extend
   -- @return Extended result
   function To_Vector3 (Vector : Vector2) return Vector3;
   -- Truncate a 4D Vector to a 3D Vector
   -- @param Vector Vector to truncate
   -- @return Truncated result
   function To_Vector3 (Vector : Vector4) return Vector3;
   -- Extend a 2D Vector to a 4D Vector, appending Z = 0, W = 1
   -- @param Vector Vector to extend
   -- @return Extended result
   function To_Vector4 (Vector : Vector2) return Vector4;
   -- Extend a 3D Vector to a 4D Vector, appending W = 1
   -- @param Vector Vector to extend
   -- @return Extended result
   function To_Vector4 (Vector : Vector3) return Vector4;
   pragma Inline (To_Vector2);
   pragma Inline (To_Vector3);
   pragma Inline (To_Vector4);

   -- Vector Cross Product
   -- @param Left First Vector
   -- @param Right Second Vector
   -- @return the vector cross product (Left x Right)
   function Cross_Product (Left, Right : Vector3) return Vector3;

   -----------------------------------------------------------------------------
   --                              Matrix types                               --
   -----------------------------------------------------------------------------

   package Matrices2 is new Matrices (Index_Type   => Index_2D,
                                      Element_Type => Element_Type,
                                      Vector_Type  => Vector2);
   package Matrices3 is new Matrices (Index_Type   => Index_3D,
                                      Element_Type => Element_Type,
                                      Vector_Type  => Vector3);
   package Matrices4 is new Matrices (Index_Type   => Index_Homogeneous,
                                      Element_Type => Element_Type,
                                      Vector_Type  => Vector4);

   -- 2x2 Matrix
   type Matrix2 is new Matrices2.Matrix;
   -- 3x3 Matrix
   type Matrix3 is new Matrices3.Matrix;
   -- 4x4 Matrix
   type Matrix4 is new Matrices4.Matrix;
   -- 2x2 Identity Matrix
   Identity2 : constant Matrix2 := ((One_Value, Null_Value), (Null_Value, One_Value));
   -- 3x3 Identity Matrix
   Identity3 : constant Matrix3 := ((One_Value, Null_Value, Null_Value),
                                    (Null_Value, One_Value, Null_Value),
                                    (Null_Value, Null_Value, One_Value));
   -- 4x4 Identity Matrix
   Identity4 : constant Matrix4 := ((One_Value, Null_Value, Null_Value, Null_Value),
                                    (Null_Value, One_Value, Null_Value, Null_Value),
                                    (Null_Value, Null_Value, One_Value, Null_Value),
                                    (Null_Value, Null_Value, Null_Value, One_Value));

   -----------------------------------------------------------------------------
   --                               Array types                               --
   -----------------------------------------------------------------------------

   -- Array of 2D Vectors
   type Vector2_Array is array (Index_Type range <>) of aliased Vector2;
   -- Array of 3D Vectors
   type Vector3_Array is array (Index_Type range <>) of aliased Vector3;
   -- Array of 4D Vectors
   type Vector4_Array is array (Index_Type range <>) of aliased Vector4;

   -- Array of 2x2 Matrices
   type Matrix2_Array is array (Index_Type range <>) of aliased Matrix2;
   -- Array of 3x3 Matrices
   type Matrix3_Array is array (Index_Type range <>) of aliased Matrix3;
   -- Array of 4x4 Matrices
   type Matrix4_Array is array (Index_Type range <>) of aliased Matrix4;

   pragma Convention (C, Vector2_Array);
   pragma Convention (C, Vector3_Array);
   pragma Convention (C, Vector4_Array);
   pragma Convention (C, Matrix2_Array);
   pragma Convention (C, Matrix3_Array);
   pragma Convention (C, Matrix4_Array);

   -----------------------------------------------------------------------------
   --                              Pointer types                              --
   -- note: These instances of the Pointers package do not have a usable      --
   --       default terminator. Only use the size-based subroutines.          --
   -----------------------------------------------------------------------------

   package Vector2_Pointers is new Interfaces.C.Pointers
     (Index_Type, Vector2, Vector2_Array, Vector2'(others => <>));
   package Vector3_Pointers is new Interfaces.C.Pointers
     (Index_Type, Vector3, Vector3_Array, Vector3'(others => <>));
   package Vector4_Pointers is new Interfaces.C.Pointers
     (Index_Type, Vector4, Vector4_Array, Vector4'(others => <>));

   package Matrix2_Pointers is new Interfaces.C.Pointers
     (Index_Type, Matrix2, Matrix2_Array, Matrix2'(others => (others => <>)));
   package Matrix3_Pointers is new Interfaces.C.Pointers
     (Index_Type, Matrix3, Matrix3_Array, Matrix3'(others => (others => <>)));
   package Matrix4_Pointers is new Interfaces.C.Pointers
     (Index_Type, Matrix4, Matrix4_Array, Matrix4'(others => (others => <>)));
end GL.Algebra;
