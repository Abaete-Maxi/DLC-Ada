pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);
with Ada.Exceptions;

package body ada_main is

   E069 : Short_Integer; pragma Import (Ada, E069, "system__os_lib_E");
   E008 : Short_Integer; pragma Import (Ada, E008, "ada__exceptions_E");
   E013 : Short_Integer; pragma Import (Ada, E013, "system__soft_links_E");
   E025 : Short_Integer; pragma Import (Ada, E025, "system__exception_table_E");
   E038 : Short_Integer; pragma Import (Ada, E038, "ada__containers_E");
   E065 : Short_Integer; pragma Import (Ada, E065, "ada__io_exceptions_E");
   E050 : Short_Integer; pragma Import (Ada, E050, "ada__strings_E");
   E052 : Short_Integer; pragma Import (Ada, E052, "ada__strings__maps_E");
   E056 : Short_Integer; pragma Import (Ada, E056, "ada__strings__maps__constants_E");
   E075 : Short_Integer; pragma Import (Ada, E075, "interfaces__c_E");
   E026 : Short_Integer; pragma Import (Ada, E026, "system__exceptions_E");
   E077 : Short_Integer; pragma Import (Ada, E077, "system__object_reader_E");
   E045 : Short_Integer; pragma Import (Ada, E045, "system__dwarf_lines_E");
   E021 : Short_Integer; pragma Import (Ada, E021, "system__soft_links__initialize_E");
   E037 : Short_Integer; pragma Import (Ada, E037, "system__traceback__symbolic_E");
   E118 : Short_Integer; pragma Import (Ada, E118, "ada__strings__utf_encoding_E");
   E124 : Short_Integer; pragma Import (Ada, E124, "ada__tags_E");
   E116 : Short_Integer; pragma Import (Ada, E116, "ada__strings__text_buffers_E");
   E201 : Short_Integer; pragma Import (Ada, E201, "gnat_E");
   E226 : Short_Integer; pragma Import (Ada, E226, "interfaces__c__strings_E");
   E114 : Short_Integer; pragma Import (Ada, E114, "ada__streams_E");
   E140 : Short_Integer; pragma Import (Ada, E140, "system__file_control_block_E");
   E139 : Short_Integer; pragma Import (Ada, E139, "system__finalization_root_E");
   E137 : Short_Integer; pragma Import (Ada, E137, "ada__finalization_E");
   E136 : Short_Integer; pragma Import (Ada, E136, "system__file_io_E");
   E234 : Short_Integer; pragma Import (Ada, E234, "system__storage_pools_E");
   E232 : Short_Integer; pragma Import (Ada, E232, "system__finalization_masters_E");
   E236 : Short_Integer; pragma Import (Ada, E236, "system__storage_pools__subpools_E");
   E158 : Short_Integer; pragma Import (Ada, E158, "ada__strings__unbounded_E");
   E006 : Short_Integer; pragma Import (Ada, E006, "ada__calendar_E");
   E103 : Short_Integer; pragma Import (Ada, E103, "ada__calendar__time_zones_E");
   E112 : Short_Integer; pragma Import (Ada, E112, "ada__text_io_E");
   E251 : Short_Integer; pragma Import (Ada, E251, "gnat__secure_hashes_E");
   E258 : Short_Integer; pragma Import (Ada, E258, "gnat__secure_hashes__sha2_common_E");
   E253 : Short_Integer; pragma Import (Ada, E253, "gnat__secure_hashes__sha2_32_E");
   E249 : Short_Integer; pragma Import (Ada, E249, "gnat__sha256_E");
   E173 : Short_Integer; pragma Import (Ada, E173, "bitcoin_E");
   E198 : Short_Integer; pragma Import (Ada, E198, "gnatcoll__os_E");
   E204 : Short_Integer; pragma Import (Ada, E204, "gnatcoll__os__win32_E");
   E206 : Short_Integer; pragma Import (Ada, E206, "gnatcoll__os__win32__strings_E");
   E228 : Short_Integer; pragma Import (Ada, E228, "gnatcoll__string_builders_E");
   E212 : Short_Integer; pragma Import (Ada, E212, "gnatcoll__wstring_builders_E");
   E210 : Short_Integer; pragma Import (Ada, E210, "gnatcoll__os__fs_E");
   E208 : Short_Integer; pragma Import (Ada, E208, "gnatcoll__os__win32__files_E");
   E230 : Short_Integer; pragma Import (Ada, E230, "gnatcoll__wstring_list_builders_E");
   E222 : Short_Integer; pragma Import (Ada, E222, "gnatcoll__os__process_types_E");
   E200 : Short_Integer; pragma Import (Ada, E200, "gnatcoll__os__process_E");
   E194 : Short_Integer; pragma Import (Ada, E194, "fetch_bitcoin_info_E");
   E244 : Short_Integer; pragma Import (Ada, E244, "fetch_nostr_info_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E200 := E200 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "gnatcoll__os__process__finalize_spec");
      begin
         F1;
      end;
      E112 := E112 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "ada__text_io__finalize_spec");
      begin
         F2;
      end;
      E158 := E158 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "ada__strings__unbounded__finalize_spec");
      begin
         F3;
      end;
      E236 := E236 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "system__storage_pools__subpools__finalize_spec");
      begin
         F4;
      end;
      E232 := E232 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "system__finalization_masters__finalize_spec");
      begin
         F5;
      end;
      declare
         procedure F6;
         pragma Import (Ada, F6, "system__file_io__finalize_body");
      begin
         E136 := E136 - 1;
         F6;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (Ada, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;
   pragma Favor_Top_Level (No_Param_Proc);

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      if E008 = 0 then
         Ada.Exceptions'Elab_Spec;
      end if;
      if E013 = 0 then
         System.Soft_Links'Elab_Spec;
      end if;
      if E025 = 0 then
         System.Exception_Table'Elab_Body;
      end if;
      E025 := E025 + 1;
      if E038 = 0 then
         Ada.Containers'Elab_Spec;
      end if;
      E038 := E038 + 1;
      if E065 = 0 then
         Ada.Io_Exceptions'Elab_Spec;
      end if;
      E065 := E065 + 1;
      if E050 = 0 then
         Ada.Strings'Elab_Spec;
      end if;
      E050 := E050 + 1;
      if E052 = 0 then
         Ada.Strings.Maps'Elab_Spec;
      end if;
      E052 := E052 + 1;
      if E056 = 0 then
         Ada.Strings.Maps.Constants'Elab_Spec;
      end if;
      E056 := E056 + 1;
      if E075 = 0 then
         Interfaces.C'Elab_Spec;
      end if;
      E075 := E075 + 1;
      if E026 = 0 then
         System.Exceptions'Elab_Spec;
      end if;
      E026 := E026 + 1;
      if E077 = 0 then
         System.Object_Reader'Elab_Spec;
      end if;
      E077 := E077 + 1;
      if E045 = 0 then
         System.Dwarf_Lines'Elab_Spec;
      end if;
      E045 := E045 + 1;
      if E069 = 0 then
         System.Os_Lib'Elab_Body;
      end if;
      E069 := E069 + 1;
      if E021 = 0 then
         System.Soft_Links.Initialize'Elab_Body;
      end if;
      E021 := E021 + 1;
      E013 := E013 + 1;
      if E037 = 0 then
         System.Traceback.Symbolic'Elab_Body;
      end if;
      E037 := E037 + 1;
      E008 := E008 + 1;
      if E118 = 0 then
         Ada.Strings.Utf_Encoding'Elab_Spec;
      end if;
      E118 := E118 + 1;
      if E124 = 0 then
         Ada.Tags'Elab_Spec;
      end if;
      if E124 = 0 then
         Ada.Tags'Elab_Body;
      end if;
      E124 := E124 + 1;
      if E116 = 0 then
         Ada.Strings.Text_Buffers'Elab_Spec;
      end if;
      if E116 = 0 then
         Ada.Strings.Text_Buffers'Elab_Body;
      end if;
      E116 := E116 + 1;
      if E201 = 0 then
         Gnat'Elab_Spec;
      end if;
      E201 := E201 + 1;
      if E226 = 0 then
         Interfaces.C.Strings'Elab_Spec;
      end if;
      E226 := E226 + 1;
      if E114 = 0 then
         Ada.Streams'Elab_Spec;
      end if;
      E114 := E114 + 1;
      if E140 = 0 then
         System.File_Control_Block'Elab_Spec;
      end if;
      E140 := E140 + 1;
      if E139 = 0 then
         System.Finalization_Root'Elab_Spec;
      end if;
      if E139 = 0 then
         System.Finalization_Root'Elab_Body;
      end if;
      E139 := E139 + 1;
      if E137 = 0 then
         Ada.Finalization'Elab_Spec;
      end if;
      E137 := E137 + 1;
      if E136 = 0 then
         System.File_Io'Elab_Body;
      end if;
      E136 := E136 + 1;
      if E234 = 0 then
         System.Storage_Pools'Elab_Spec;
      end if;
      E234 := E234 + 1;
      if E232 = 0 then
         System.Finalization_Masters'Elab_Spec;
      end if;
      if E232 = 0 then
         System.Finalization_Masters'Elab_Body;
      end if;
      E232 := E232 + 1;
      if E236 = 0 then
         System.Storage_Pools.Subpools'Elab_Spec;
      end if;
      if E236 = 0 then
         System.Storage_Pools.Subpools'Elab_Body;
      end if;
      E236 := E236 + 1;
      if E158 = 0 then
         Ada.Strings.Unbounded'Elab_Spec;
      end if;
      if E158 = 0 then
         Ada.Strings.Unbounded'Elab_Body;
      end if;
      E158 := E158 + 1;
      if E006 = 0 then
         Ada.Calendar'Elab_Spec;
      end if;
      if E006 = 0 then
         Ada.Calendar'Elab_Body;
      end if;
      E006 := E006 + 1;
      if E103 = 0 then
         Ada.Calendar.Time_Zones'Elab_Spec;
      end if;
      E103 := E103 + 1;
      if E112 = 0 then
         Ada.Text_Io'Elab_Spec;
      end if;
      if E112 = 0 then
         Ada.Text_Io'Elab_Body;
      end if;
      E112 := E112 + 1;
      E251 := E251 + 1;
      E258 := E258 + 1;
      E253 := E253 + 1;
      if E249 = 0 then
         Gnat.Sha256'Elab_Spec;
      end if;
      E249 := E249 + 1;
      E173 := E173 + 1;
      if E198 = 0 then
         GNATCOLL.OS'ELAB_SPEC;
      end if;
      E198 := E198 + 1;
      E206 := E206 + 1;
      E204 := E204 + 1;
      E228 := E228 + 1;
      E212 := E212 + 1;
      E208 := E208 + 1;
      E210 := E210 + 1;
      E230 := E230 + 1;
      if E222 = 0 then
         GNATCOLL.OS.PROCESS_TYPES'ELAB_BODY;
      end if;
      E222 := E222 + 1;
      if E200 = 0 then
         GNATCOLL.OS.PROCESS'ELAB_SPEC;
      end if;
      E200 := E200 + 1;
      E194 := E194 + 1;
      E244 := E244 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      if gnat_argc = 0 then
         gnat_argc := argc;
         gnat_argv := argv;
      end if;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   C:\Projects\hashingtest\obj\bitcoin.o
   --   C:\Projects\hashingtest\obj\fetch_bitcoin_info.o
   --   C:\Projects\hashingtest\obj\fetch_nostr_info.o
   --   C:\Projects\hashingtest\obj\main.o
   --   -LC:\Projects\hashingtest\obj\
   --   -LC:\Projects\hashingtest\obj\
   --   -LC:\gnat\2021\lib\xmlada\xmlada_unicode.static\
   --   -LC:\gnat\2021\lib\xmlada\xmlada_sax.static\
   --   -LC:\gnat\2021\lib\xmlada\xmlada_input.static\
   --   -LC:\gnat\2021\lib\xmlada\xmlada_dom.static\
   --   -LC:\gnat\2021\lib\xmlada\xmlada_schema.static\
   --   -LC:\gnat\2021\lib\libadalang.static\
   --   -LC:\gnat\2021\lib\langkit_support.static\
   --   -LC:\gnat\2021\lib\gnatcoll_iconv.static\
   --   -LC:\gnat\2021\lib\gpr\static\gpr\
   --   -LC:\gnat\2021\lib\gnatcoll.static\
   --   -LC:\gnat\2021\lib\gnatcoll_gmp.static\
   --   -LC:\gnat\2021\lib\aws.static\
   --   -LC:/gnat/2021/lib/gcc/x86_64-w64-mingw32/10.3.1/adalib/
   --   -static
   --   -lgnat
   --   -Wl,--stack=0x2000000
--  END Object file/option list   

end ada_main;
