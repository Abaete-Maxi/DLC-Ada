pragma Warnings (Off);
pragma Ada_95;
with System;
with System.Parameters;
with System.Secondary_Stack;
package ada_main is

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   GNAT_Version : constant String :=
                    "GNAT Version: Community 2021 (20210519-103)" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   GNAT_Version_Address : constant System.Address := GNAT_Version'Address;
   pragma Export (C, GNAT_Version_Address, "__gnat_version_address");

   Ada_Main_Program_Name : constant String := "_ada_main" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#5b25739a#;
   pragma Export (C, u00001, "mainB");
   u00002 : constant Version_32 := 16#2e11c0b1#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#664ecad3#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#76789da1#;
   pragma Export (C, u00004, "adaS");
   u00005 : constant Version_32 := 16#48583e4e#;
   pragma Export (C, u00005, "ada__calendarB");
   u00006 : constant Version_32 := 16#31350a81#;
   pragma Export (C, u00006, "ada__calendarS");
   u00007 : constant Version_32 := 16#f75ad8f1#;
   pragma Export (C, u00007, "ada__exceptionsB");
   u00008 : constant Version_32 := 16#eb3857a3#;
   pragma Export (C, u00008, "ada__exceptionsS");
   u00009 : constant Version_32 := 16#19b42e05#;
   pragma Export (C, u00009, "ada__exceptions__last_chance_handlerB");
   u00010 : constant Version_32 := 16#fc9377ef#;
   pragma Export (C, u00010, "ada__exceptions__last_chance_handlerS");
   u00011 : constant Version_32 := 16#2ffa5114#;
   pragma Export (C, u00011, "systemS");
   u00012 : constant Version_32 := 16#adf22619#;
   pragma Export (C, u00012, "system__soft_linksB");
   u00013 : constant Version_32 := 16#63b0b7fe#;
   pragma Export (C, u00013, "system__soft_linksS");
   u00014 : constant Version_32 := 16#e10050ae#;
   pragma Export (C, u00014, "system__secondary_stackB");
   u00015 : constant Version_32 := 16#de516690#;
   pragma Export (C, u00015, "system__secondary_stackS");
   u00016 : constant Version_32 := 16#896564a3#;
   pragma Export (C, u00016, "system__parametersB");
   u00017 : constant Version_32 := 16#68a895df#;
   pragma Export (C, u00017, "system__parametersS");
   u00018 : constant Version_32 := 16#ced09590#;
   pragma Export (C, u00018, "system__storage_elementsB");
   u00019 : constant Version_32 := 16#02391b10#;
   pragma Export (C, u00019, "system__storage_elementsS");
   u00020 : constant Version_32 := 16#ce3e0e21#;
   pragma Export (C, u00020, "system__soft_links__initializeB");
   u00021 : constant Version_32 := 16#5697fc2b#;
   pragma Export (C, u00021, "system__soft_links__initializeS");
   u00022 : constant Version_32 := 16#41837d1e#;
   pragma Export (C, u00022, "system__stack_checkingB");
   u00023 : constant Version_32 := 16#a1453afc#;
   pragma Export (C, u00023, "system__stack_checkingS");
   u00024 : constant Version_32 := 16#34742901#;
   pragma Export (C, u00024, "system__exception_tableB");
   u00025 : constant Version_32 := 16#3cc6bdbe#;
   pragma Export (C, u00025, "system__exception_tableS");
   u00026 : constant Version_32 := 16#7134ce8f#;
   pragma Export (C, u00026, "system__exceptionsS");
   u00027 : constant Version_32 := 16#69416224#;
   pragma Export (C, u00027, "system__exceptions__machineB");
   u00028 : constant Version_32 := 16#59a6462e#;
   pragma Export (C, u00028, "system__exceptions__machineS");
   u00029 : constant Version_32 := 16#aa0563fc#;
   pragma Export (C, u00029, "system__exceptions_debugB");
   u00030 : constant Version_32 := 16#1fe22d38#;
   pragma Export (C, u00030, "system__exceptions_debugS");
   u00031 : constant Version_32 := 16#9f73225f#;
   pragma Export (C, u00031, "system__img_intS");
   u00032 : constant Version_32 := 16#01838199#;
   pragma Export (C, u00032, "system__tracebackB");
   u00033 : constant Version_32 := 16#6f77a74f#;
   pragma Export (C, u00033, "system__tracebackS");
   u00034 : constant Version_32 := 16#1f08c83e#;
   pragma Export (C, u00034, "system__traceback_entriesB");
   u00035 : constant Version_32 := 16#09528275#;
   pragma Export (C, u00035, "system__traceback_entriesS");
   u00036 : constant Version_32 := 16#8dd2b87e#;
   pragma Export (C, u00036, "system__traceback__symbolicB");
   u00037 : constant Version_32 := 16#4f57b9be#;
   pragma Export (C, u00037, "system__traceback__symbolicS");
   u00038 : constant Version_32 := 16#179d7d28#;
   pragma Export (C, u00038, "ada__containersS");
   u00039 : constant Version_32 := 16#701f9d88#;
   pragma Export (C, u00039, "ada__exceptions__tracebackB");
   u00040 : constant Version_32 := 16#bba159a5#;
   pragma Export (C, u00040, "ada__exceptions__tracebackS");
   u00041 : constant Version_32 := 16#e865e681#;
   pragma Export (C, u00041, "system__bounded_stringsB");
   u00042 : constant Version_32 := 16#5807700d#;
   pragma Export (C, u00042, "system__bounded_stringsS");
   u00043 : constant Version_32 := 16#66134eae#;
   pragma Export (C, u00043, "system__crtlS");
   u00044 : constant Version_32 := 16#13176495#;
   pragma Export (C, u00044, "system__dwarf_linesB");
   u00045 : constant Version_32 := 16#881894a3#;
   pragma Export (C, u00045, "system__dwarf_linesS");
   u00046 : constant Version_32 := 16#5b4659fa#;
   pragma Export (C, u00046, "ada__charactersS");
   u00047 : constant Version_32 := 16#ba03ad8f#;
   pragma Export (C, u00047, "ada__characters__handlingB");
   u00048 : constant Version_32 := 16#21df700b#;
   pragma Export (C, u00048, "ada__characters__handlingS");
   u00049 : constant Version_32 := 16#4b7bb96a#;
   pragma Export (C, u00049, "ada__characters__latin_1S");
   u00050 : constant Version_32 := 16#e6d4fa36#;
   pragma Export (C, u00050, "ada__stringsS");
   u00051 : constant Version_32 := 16#24ece25f#;
   pragma Export (C, u00051, "ada__strings__mapsB");
   u00052 : constant Version_32 := 16#ac61938c#;
   pragma Export (C, u00052, "ada__strings__mapsS");
   u00053 : constant Version_32 := 16#1db72f30#;
   pragma Export (C, u00053, "system__bit_opsB");
   u00054 : constant Version_32 := 16#0765e3a3#;
   pragma Export (C, u00054, "system__bit_opsS");
   u00055 : constant Version_32 := 16#04fd2587#;
   pragma Export (C, u00055, "system__unsigned_typesS");
   u00056 : constant Version_32 := 16#20c3a773#;
   pragma Export (C, u00056, "ada__strings__maps__constantsS");
   u00057 : constant Version_32 := 16#edec285f#;
   pragma Export (C, u00057, "interfacesS");
   u00058 : constant Version_32 := 16#a0d3d22b#;
   pragma Export (C, u00058, "system__address_imageB");
   u00059 : constant Version_32 := 16#8e16cc2e#;
   pragma Export (C, u00059, "system__address_imageS");
   u00060 : constant Version_32 := 16#58ecb7ed#;
   pragma Export (C, u00060, "system__img_unsS");
   u00061 : constant Version_32 := 16#20ec7aa3#;
   pragma Export (C, u00061, "system__ioB");
   u00062 : constant Version_32 := 16#b1b8a65b#;
   pragma Export (C, u00062, "system__ioS");
   u00063 : constant Version_32 := 16#c1351856#;
   pragma Export (C, u00063, "system__mmapB");
   u00064 : constant Version_32 := 16#45fa04ea#;
   pragma Export (C, u00064, "system__mmapS");
   u00065 : constant Version_32 := 16#92d882c5#;
   pragma Export (C, u00065, "ada__io_exceptionsS");
   u00066 : constant Version_32 := 16#6c9b7dbc#;
   pragma Export (C, u00066, "system__mmap__os_interfaceB");
   u00067 : constant Version_32 := 16#52ab6463#;
   pragma Export (C, u00067, "system__mmap__os_interfaceS");
   u00068 : constant Version_32 := 16#c7b29a75#;
   pragma Export (C, u00068, "system__os_libB");
   u00069 : constant Version_32 := 16#1c53dcbe#;
   pragma Export (C, u00069, "system__os_libS");
   u00070 : constant Version_32 := 16#ec4d5631#;
   pragma Export (C, u00070, "system__case_utilB");
   u00071 : constant Version_32 := 16#102fe740#;
   pragma Export (C, u00071, "system__case_utilS");
   u00072 : constant Version_32 := 16#2a8e89ad#;
   pragma Export (C, u00072, "system__stringsB");
   u00073 : constant Version_32 := 16#63b7b2c6#;
   pragma Export (C, u00073, "system__stringsS");
   u00074 : constant Version_32 := 16#fb01eaa4#;
   pragma Export (C, u00074, "interfaces__cB");
   u00075 : constant Version_32 := 16#7300324d#;
   pragma Export (C, u00075, "interfaces__cS");
   u00076 : constant Version_32 := 16#a2bb689b#;
   pragma Export (C, u00076, "system__object_readerB");
   u00077 : constant Version_32 := 16#7d8b329a#;
   pragma Export (C, u00077, "system__object_readerS");
   u00078 : constant Version_32 := 16#f21a80dd#;
   pragma Export (C, u00078, "system__val_lliS");
   u00079 : constant Version_32 := 16#197f7a7d#;
   pragma Export (C, u00079, "system__val_lluS");
   u00080 : constant Version_32 := 16#879d81a3#;
   pragma Export (C, u00080, "system__val_utilB");
   u00081 : constant Version_32 := 16#835ae7ea#;
   pragma Export (C, u00081, "system__val_utilS");
   u00082 : constant Version_32 := 16#992dbac1#;
   pragma Export (C, u00082, "system__exception_tracesB");
   u00083 : constant Version_32 := 16#2dd6549f#;
   pragma Export (C, u00083, "system__exception_tracesS");
   u00084 : constant Version_32 := 16#e3e8dc36#;
   pragma Export (C, u00084, "system__win32S");
   u00085 : constant Version_32 := 16#8c33a517#;
   pragma Export (C, u00085, "system__wch_conB");
   u00086 : constant Version_32 := 16#348773c6#;
   pragma Export (C, u00086, "system__wch_conS");
   u00087 : constant Version_32 := 16#9721e840#;
   pragma Export (C, u00087, "system__wch_stwB");
   u00088 : constant Version_32 := 16#19965fc7#;
   pragma Export (C, u00088, "system__wch_stwS");
   u00089 : constant Version_32 := 16#1f681dab#;
   pragma Export (C, u00089, "system__wch_cnvB");
   u00090 : constant Version_32 := 16#3b30c935#;
   pragma Export (C, u00090, "system__wch_cnvS");
   u00091 : constant Version_32 := 16#ece6fdb6#;
   pragma Export (C, u00091, "system__wch_jisB");
   u00092 : constant Version_32 := 16#bb40d014#;
   pragma Export (C, u00092, "system__wch_jisS");
   u00093 : constant Version_32 := 16#24ec69e6#;
   pragma Export (C, u00093, "system__os_primitivesB");
   u00094 : constant Version_32 := 16#280734e2#;
   pragma Export (C, u00094, "system__os_primitivesS");
   u00095 : constant Version_32 := 16#2f9cb76c#;
   pragma Export (C, u00095, "system__arith_64B");
   u00096 : constant Version_32 := 16#9d9eabfb#;
   pragma Export (C, u00096, "system__arith_64S");
   u00097 : constant Version_32 := 16#05c60a38#;
   pragma Export (C, u00097, "system__task_lockB");
   u00098 : constant Version_32 := 16#4e70667a#;
   pragma Export (C, u00098, "system__task_lockS");
   u00099 : constant Version_32 := 16#b8c476a4#;
   pragma Export (C, u00099, "system__win32__extS");
   u00100 : constant Version_32 := 16#89410887#;
   pragma Export (C, u00100, "ada__calendar__formattingB");
   u00101 : constant Version_32 := 16#a2aff7a7#;
   pragma Export (C, u00101, "ada__calendar__formattingS");
   u00102 : constant Version_32 := 16#974d849e#;
   pragma Export (C, u00102, "ada__calendar__time_zonesB");
   u00103 : constant Version_32 := 16#ade8f076#;
   pragma Export (C, u00103, "ada__calendar__time_zonesS");
   u00104 : constant Version_32 := 16#f6b440a2#;
   pragma Export (C, u00104, "system__val_fixed_64S");
   u00105 : constant Version_32 := 16#ae4beccb#;
   pragma Export (C, u00105, "system__val_intS");
   u00106 : constant Version_32 := 16#a5b55d2f#;
   pragma Export (C, u00106, "system__val_unsS");
   u00107 : constant Version_32 := 16#26060166#;
   pragma Export (C, u00107, "ada__command_lineB");
   u00108 : constant Version_32 := 16#3cdef8c9#;
   pragma Export (C, u00108, "ada__command_lineS");
   u00109 : constant Version_32 := 16#f64b89a4#;
   pragma Export (C, u00109, "ada__integer_text_ioB");
   u00110 : constant Version_32 := 16#2ec7c168#;
   pragma Export (C, u00110, "ada__integer_text_ioS");
   u00111 : constant Version_32 := 16#d8bb58e0#;
   pragma Export (C, u00111, "ada__text_ioB");
   u00112 : constant Version_32 := 16#1eb2ee39#;
   pragma Export (C, u00112, "ada__text_ioS");
   u00113 : constant Version_32 := 16#10558b11#;
   pragma Export (C, u00113, "ada__streamsB");
   u00114 : constant Version_32 := 16#67e31212#;
   pragma Export (C, u00114, "ada__streamsS");
   u00115 : constant Version_32 := 16#8c178268#;
   pragma Export (C, u00115, "ada__strings__text_buffersB");
   u00116 : constant Version_32 := 16#0800bb5e#;
   pragma Export (C, u00116, "ada__strings__text_buffersS");
   u00117 : constant Version_32 := 16#cd3494c7#;
   pragma Export (C, u00117, "ada__strings__utf_encodingB");
   u00118 : constant Version_32 := 16#37e3917d#;
   pragma Export (C, u00118, "ada__strings__utf_encodingS");
   u00119 : constant Version_32 := 16#d1d1ed0b#;
   pragma Export (C, u00119, "ada__strings__utf_encoding__wide_stringsB");
   u00120 : constant Version_32 := 16#103ad78c#;
   pragma Export (C, u00120, "ada__strings__utf_encoding__wide_stringsS");
   u00121 : constant Version_32 := 16#c2b98963#;
   pragma Export (C, u00121, "ada__strings__utf_encoding__wide_wide_stringsB");
   u00122 : constant Version_32 := 16#91eda35b#;
   pragma Export (C, u00122, "ada__strings__utf_encoding__wide_wide_stringsS");
   u00123 : constant Version_32 := 16#b3f0dfa6#;
   pragma Export (C, u00123, "ada__tagsB");
   u00124 : constant Version_32 := 16#cb8ac80c#;
   pragma Export (C, u00124, "ada__tagsS");
   u00125 : constant Version_32 := 16#5534feb6#;
   pragma Export (C, u00125, "system__htableB");
   u00126 : constant Version_32 := 16#ab38e2fe#;
   pragma Export (C, u00126, "system__htableS");
   u00127 : constant Version_32 := 16#089f5cd0#;
   pragma Export (C, u00127, "system__string_hashB");
   u00128 : constant Version_32 := 16#09668980#;
   pragma Export (C, u00128, "system__string_hashS");
   u00129 : constant Version_32 := 16#5fc04ee2#;
   pragma Export (C, u00129, "system__put_imagesB");
   u00130 : constant Version_32 := 16#52d4e162#;
   pragma Export (C, u00130, "system__put_imagesS");
   u00131 : constant Version_32 := 16#e264263f#;
   pragma Export (C, u00131, "ada__strings__text_buffers__utilsB");
   u00132 : constant Version_32 := 16#608bd105#;
   pragma Export (C, u00132, "ada__strings__text_buffers__utilsS");
   u00133 : constant Version_32 := 16#73d2d764#;
   pragma Export (C, u00133, "interfaces__c_streamsB");
   u00134 : constant Version_32 := 16#066a78a0#;
   pragma Export (C, u00134, "interfaces__c_streamsS");
   u00135 : constant Version_32 := 16#30f1a29e#;
   pragma Export (C, u00135, "system__file_ioB");
   u00136 : constant Version_32 := 16#888bb071#;
   pragma Export (C, u00136, "system__file_ioS");
   u00137 : constant Version_32 := 16#86c56e5a#;
   pragma Export (C, u00137, "ada__finalizationS");
   u00138 : constant Version_32 := 16#95817ed8#;
   pragma Export (C, u00138, "system__finalization_rootB");
   u00139 : constant Version_32 := 16#60082284#;
   pragma Export (C, u00139, "system__finalization_rootS");
   u00140 : constant Version_32 := 16#d265cbbc#;
   pragma Export (C, u00140, "system__file_control_blockS");
   u00141 : constant Version_32 := 16#7a00bb28#;
   pragma Export (C, u00141, "ada__text_io__generic_auxB");
   u00142 : constant Version_32 := 16#48b7189e#;
   pragma Export (C, u00142, "ada__text_io__generic_auxS");
   u00143 : constant Version_32 := 16#3720d920#;
   pragma Export (C, u00143, "system__img_biuS");
   u00144 : constant Version_32 := 16#7a7e1efe#;
   pragma Export (C, u00144, "system__img_llbS");
   u00145 : constant Version_32 := 16#15e60e4c#;
   pragma Export (C, u00145, "system__img_lliS");
   u00146 : constant Version_32 := 16#0d8feb8c#;
   pragma Export (C, u00146, "system__img_lllbS");
   u00147 : constant Version_32 := 16#7e360bb4#;
   pragma Export (C, u00147, "system__img_llliS");
   u00148 : constant Version_32 := 16#07fbf280#;
   pragma Export (C, u00148, "system__img_lllwS");
   u00149 : constant Version_32 := 16#264c6bf5#;
   pragma Export (C, u00149, "system__img_llwS");
   u00150 : constant Version_32 := 16#08fa6212#;
   pragma Export (C, u00150, "system__img_wiuS");
   u00151 : constant Version_32 := 16#e37e7d10#;
   pragma Export (C, u00151, "system__val_llliS");
   u00152 : constant Version_32 := 16#f82486d6#;
   pragma Export (C, u00152, "system__val_llluS");
   u00153 : constant Version_32 := 16#0de7ae30#;
   pragma Export (C, u00153, "ada__strings__fixedB");
   u00154 : constant Version_32 := 16#64881af1#;
   pragma Export (C, u00154, "ada__strings__fixedS");
   u00155 : constant Version_32 := 16#bb264ce2#;
   pragma Export (C, u00155, "ada__strings__searchB");
   u00156 : constant Version_32 := 16#73987e07#;
   pragma Export (C, u00156, "ada__strings__searchS");
   u00157 : constant Version_32 := 16#42b36dfe#;
   pragma Export (C, u00157, "ada__strings__unboundedB");
   u00158 : constant Version_32 := 16#da258d18#;
   pragma Export (C, u00158, "ada__strings__unboundedS");
   u00159 : constant Version_32 := 16#a1d6147d#;
   pragma Export (C, u00159, "system__compare_array_unsigned_8B");
   u00160 : constant Version_32 := 16#86f92099#;
   pragma Export (C, u00160, "system__compare_array_unsigned_8S");
   u00161 : constant Version_32 := 16#a8025f3c#;
   pragma Export (C, u00161, "system__address_operationsB");
   u00162 : constant Version_32 := 16#3cf6ef27#;
   pragma Export (C, u00162, "system__address_operationsS");
   u00163 : constant Version_32 := 16#020a3f4d#;
   pragma Export (C, u00163, "system__atomic_countersB");
   u00164 : constant Version_32 := 16#9ba67c99#;
   pragma Export (C, u00164, "system__atomic_countersS");
   u00165 : constant Version_32 := 16#c9a3fcbc#;
   pragma Export (C, u00165, "system__stream_attributesB");
   u00166 : constant Version_32 := 16#414158da#;
   pragma Export (C, u00166, "system__stream_attributesS");
   u00167 : constant Version_32 := 16#3e25f63c#;
   pragma Export (C, u00167, "system__stream_attributes__xdrB");
   u00168 : constant Version_32 := 16#ce9a2a0c#;
   pragma Export (C, u00168, "system__stream_attributes__xdrS");
   u00169 : constant Version_32 := 16#ecc88e78#;
   pragma Export (C, u00169, "system__fat_fltS");
   u00170 : constant Version_32 := 16#cafa8775#;
   pragma Export (C, u00170, "system__fat_lfltS");
   u00171 : constant Version_32 := 16#b02a299f#;
   pragma Export (C, u00171, "system__fat_llfS");
   u00172 : constant Version_32 := 16#b1306c3f#;
   pragma Export (C, u00172, "bitcoinB");
   u00173 : constant Version_32 := 16#5be9bb28#;
   pragma Export (C, u00173, "bitcoinS");
   u00174 : constant Version_32 := 16#e18a47a0#;
   pragma Export (C, u00174, "ada__float_text_ioB");
   u00175 : constant Version_32 := 16#39060f6c#;
   pragma Export (C, u00175, "ada__float_text_ioS");
   u00176 : constant Version_32 := 16#6424aad3#;
   pragma Export (C, u00176, "system__img_fltS");
   u00177 : constant Version_32 := 16#1b28662b#;
   pragma Export (C, u00177, "system__float_controlB");
   u00178 : constant Version_32 := 16#cf061228#;
   pragma Export (C, u00178, "system__float_controlS");
   u00179 : constant Version_32 := 16#2549028f#;
   pragma Export (C, u00179, "system__img_utilB");
   u00180 : constant Version_32 := 16#44802e3b#;
   pragma Export (C, u00180, "system__img_utilS");
   u00181 : constant Version_32 := 16#690df0ad#;
   pragma Export (C, u00181, "system__powten_fltS");
   u00182 : constant Version_32 := 16#c90890af#;
   pragma Export (C, u00182, "system__img_lfltS");
   u00183 : constant Version_32 := 16#b684afd1#;
   pragma Export (C, u00183, "system__img_lluS");
   u00184 : constant Version_32 := 16#0be1c959#;
   pragma Export (C, u00184, "system__powten_lfltS");
   u00185 : constant Version_32 := 16#1422974c#;
   pragma Export (C, u00185, "system__img_llfS");
   u00186 : constant Version_32 := 16#b6fa998a#;
   pragma Export (C, u00186, "system__powten_llfS");
   u00187 : constant Version_32 := 16#18ee5867#;
   pragma Export (C, u00187, "system__val_fltS");
   u00188 : constant Version_32 := 16#8aea7eed#;
   pragma Export (C, u00188, "system__exn_fltS");
   u00189 : constant Version_32 := 16#0414e57b#;
   pragma Export (C, u00189, "system__val_lfltS");
   u00190 : constant Version_32 := 16#34ab9f34#;
   pragma Export (C, u00190, "system__exn_lfltS");
   u00191 : constant Version_32 := 16#de111da4#;
   pragma Export (C, u00191, "system__val_llfS");
   u00192 : constant Version_32 := 16#19055f44#;
   pragma Export (C, u00192, "system__exn_llfS");
   u00193 : constant Version_32 := 16#a8696e01#;
   pragma Export (C, u00193, "fetch_bitcoin_infoB");
   u00194 : constant Version_32 := 16#bb73ba4c#;
   pragma Export (C, u00194, "fetch_bitcoin_infoS");
   u00195 : constant Version_32 := 16#e753e265#;
   pragma Export (C, u00195, "ada__characters__conversionsB");
   u00196 : constant Version_32 := 16#761d31b0#;
   pragma Export (C, u00196, "ada__characters__conversionsS");
   u00197 : constant Version_32 := 16#6a5da479#;
   pragma Export (C, u00197, "gnatcollS");
   u00198 : constant Version_32 := 16#271e6f93#;
   pragma Export (C, u00198, "gnatcoll__osS");
   u00199 : constant Version_32 := 16#ce083c2b#;
   pragma Export (C, u00199, "gnatcoll__os__processB");
   u00200 : constant Version_32 := 16#87f4f981#;
   pragma Export (C, u00200, "gnatcoll__os__processS");
   u00201 : constant Version_32 := 16#b5988c27#;
   pragma Export (C, u00201, "gnatS");
   u00202 : constant Version_32 := 16#485b8267#;
   pragma Export (C, u00202, "gnat__task_lockS");
   u00203 : constant Version_32 := 16#05042e59#;
   pragma Export (C, u00203, "gnatcoll__os__win32B");
   u00204 : constant Version_32 := 16#99419635#;
   pragma Export (C, u00204, "gnatcoll__os__win32S");
   u00205 : constant Version_32 := 16#2f82d776#;
   pragma Export (C, u00205, "gnatcoll__os__win32__stringsB");
   u00206 : constant Version_32 := 16#21a9d11a#;
   pragma Export (C, u00206, "gnatcoll__os__win32__stringsS");
   u00207 : constant Version_32 := 16#947dfa20#;
   pragma Export (C, u00207, "gnatcoll__os__win32__filesB");
   u00208 : constant Version_32 := 16#2e825fcd#;
   pragma Export (C, u00208, "gnatcoll__os__win32__filesS");
   u00209 : constant Version_32 := 16#7b0984ee#;
   pragma Export (C, u00209, "gnatcoll__os__fsB");
   u00210 : constant Version_32 := 16#6a0f50ff#;
   pragma Export (C, u00210, "gnatcoll__os__fsS");
   u00211 : constant Version_32 := 16#786a34d5#;
   pragma Export (C, u00211, "gnatcoll__wstring_buildersB");
   u00212 : constant Version_32 := 16#5daca379#;
   pragma Export (C, u00212, "gnatcoll__wstring_buildersS");
   u00213 : constant Version_32 := 16#bb85b20a#;
   pragma Export (C, u00213, "gnatcoll__os__win32__processS");
   u00214 : constant Version_32 := 16#fd8f4503#;
   pragma Export (C, u00214, "ada__containers__hash_tablesS");
   u00215 : constant Version_32 := 16#de53e0a3#;
   pragma Export (C, u00215, "ada__containers__helpersB");
   u00216 : constant Version_32 := 16#4adfc5eb#;
   pragma Export (C, u00216, "ada__containers__helpersS");
   u00217 : constant Version_32 := 16#c24eaf4d#;
   pragma Export (C, u00217, "ada__containers__prime_numbersB");
   u00218 : constant Version_32 := 16#6d3af8ed#;
   pragma Export (C, u00218, "ada__containers__prime_numbersS");
   u00219 : constant Version_32 := 16#75de1dee#;
   pragma Export (C, u00219, "ada__strings__hashB");
   u00220 : constant Version_32 := 16#3655ad4c#;
   pragma Export (C, u00220, "ada__strings__hashS");
   u00221 : constant Version_32 := 16#28a44902#;
   pragma Export (C, u00221, "gnatcoll__os__process_typesB");
   u00222 : constant Version_32 := 16#dea0dbf8#;
   pragma Export (C, u00222, "gnatcoll__os__process_typesS");
   u00223 : constant Version_32 := 16#5d3fd3ea#;
   pragma Export (C, u00223, "ada__environment_variablesB");
   u00224 : constant Version_32 := 16#767099b7#;
   pragma Export (C, u00224, "ada__environment_variablesS");
   u00225 : constant Version_32 := 16#0039537b#;
   pragma Export (C, u00225, "interfaces__c__stringsB");
   u00226 : constant Version_32 := 16#eda3d306#;
   pragma Export (C, u00226, "interfaces__c__stringsS");
   u00227 : constant Version_32 := 16#d3315ac1#;
   pragma Export (C, u00227, "gnatcoll__string_buildersB");
   u00228 : constant Version_32 := 16#2c503533#;
   pragma Export (C, u00228, "gnatcoll__string_buildersS");
   u00229 : constant Version_32 := 16#2a482ba9#;
   pragma Export (C, u00229, "gnatcoll__wstring_list_buildersB");
   u00230 : constant Version_32 := 16#5c157667#;
   pragma Export (C, u00230, "gnatcoll__wstring_list_buildersS");
   u00231 : constant Version_32 := 16#ca8c282d#;
   pragma Export (C, u00231, "system__finalization_mastersB");
   u00232 : constant Version_32 := 16#4e386d0b#;
   pragma Export (C, u00232, "system__finalization_mastersS");
   u00233 : constant Version_32 := 16#35d6ef80#;
   pragma Export (C, u00233, "system__storage_poolsB");
   u00234 : constant Version_32 := 16#548cb6a3#;
   pragma Export (C, u00234, "system__storage_poolsS");
   u00235 : constant Version_32 := 16#8e7c94d7#;
   pragma Export (C, u00235, "system__storage_pools__subpoolsB");
   u00236 : constant Version_32 := 16#8393ab70#;
   pragma Export (C, u00236, "system__storage_pools__subpoolsS");
   u00237 : constant Version_32 := 16#cafa918a#;
   pragma Export (C, u00237, "system__storage_pools__subpools__finalizationB");
   u00238 : constant Version_32 := 16#8bd8fdc9#;
   pragma Export (C, u00238, "system__storage_pools__subpools__finalizationS");
   u00239 : constant Version_32 := 16#75390335#;
   pragma Export (C, u00239, "system__strings__stream_opsB");
   u00240 : constant Version_32 := 16#ec029138#;
   pragma Export (C, u00240, "system__strings__stream_opsS");
   u00241 : constant Version_32 := 16#fd83e873#;
   pragma Export (C, u00241, "system__concat_2B");
   u00242 : constant Version_32 := 16#2d5a86c4#;
   pragma Export (C, u00242, "system__concat_2S");
   u00243 : constant Version_32 := 16#0d90b9b0#;
   pragma Export (C, u00243, "fetch_nostr_infoB");
   u00244 : constant Version_32 := 16#ec6c61b3#;
   pragma Export (C, u00244, "fetch_nostr_infoS");
   u00245 : constant Version_32 := 16#8099c5e3#;
   pragma Export (C, u00245, "gnat__ioB");
   u00246 : constant Version_32 := 16#2a95b695#;
   pragma Export (C, u00246, "gnat__ioS");
   u00247 : constant Version_32 := 16#2b995a0d#;
   pragma Export (C, u00247, "gnat__os_libS");
   u00248 : constant Version_32 := 16#c083f050#;
   pragma Export (C, u00248, "gnat__sha256B");
   u00249 : constant Version_32 := 16#2cb9e506#;
   pragma Export (C, u00249, "gnat__sha256S");
   u00250 : constant Version_32 := 16#23079ce3#;
   pragma Export (C, u00250, "gnat__secure_hashesB");
   u00251 : constant Version_32 := 16#5634196a#;
   pragma Export (C, u00251, "gnat__secure_hashesS");
   u00252 : constant Version_32 := 16#8d5c5596#;
   pragma Export (C, u00252, "gnat__secure_hashes__sha2_32B");
   u00253 : constant Version_32 := 16#0f4795b6#;
   pragma Export (C, u00253, "gnat__secure_hashes__sha2_32S");
   u00254 : constant Version_32 := 16#0668360c#;
   pragma Export (C, u00254, "gnat__byte_swappingB");
   u00255 : constant Version_32 := 16#3eb0cb0a#;
   pragma Export (C, u00255, "gnat__byte_swappingS");
   u00256 : constant Version_32 := 16#df420fa3#;
   pragma Export (C, u00256, "system__byte_swappingS");
   u00257 : constant Version_32 := 16#25a43d5d#;
   pragma Export (C, u00257, "gnat__secure_hashes__sha2_commonB");
   u00258 : constant Version_32 := 16#21653399#;
   pragma Export (C, u00258, "gnat__secure_hashes__sha2_commonS");
   u00259 : constant Version_32 := 16#2b70b149#;
   pragma Export (C, u00259, "system__concat_3B");
   u00260 : constant Version_32 := 16#248a0db1#;
   pragma Export (C, u00260, "system__concat_3S");
   u00261 : constant Version_32 := 16#932a4690#;
   pragma Export (C, u00261, "system__concat_4B");
   u00262 : constant Version_32 := 16#519e7a34#;
   pragma Export (C, u00262, "system__concat_4S");
   u00263 : constant Version_32 := 16#eca5ecae#;
   pragma Export (C, u00263, "system__memoryB");
   u00264 : constant Version_32 := 16#76873720#;
   pragma Export (C, u00264, "system__memoryS");

   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  ada.characters%s
   --  ada.characters.latin_1%s
   --  interfaces%s
   --  system%s
   --  system.address_operations%s
   --  system.address_operations%b
   --  system.atomic_counters%s
   --  system.atomic_counters%b
   --  system.byte_swapping%s
   --  system.float_control%s
   --  system.float_control%b
   --  system.img_int%s
   --  system.img_lli%s
   --  system.img_llli%s
   --  system.io%s
   --  system.io%b
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  interfaces.c_streams%s
   --  interfaces.c_streams%b
   --  system.powten_flt%s
   --  system.powten_lflt%s
   --  system.powten_llf%s
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.stack_checking%s
   --  system.stack_checking%b
   --  system.string_hash%s
   --  system.string_hash%b
   --  system.htable%s
   --  system.htable%b
   --  system.strings%s
   --  system.strings%b
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  system.unsigned_types%s
   --  system.img_biu%s
   --  system.img_llb%s
   --  system.img_lllb%s
   --  system.img_lllw%s
   --  system.img_llu%s
   --  system.img_llw%s
   --  system.img_uns%s
   --  system.img_util%s
   --  system.img_util%b
   --  system.img_wiu%s
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%s
   --  system.wch_cnv%b
   --  system.compare_array_unsigned_8%s
   --  system.compare_array_unsigned_8%b
   --  system.concat_2%s
   --  system.concat_2%b
   --  system.concat_3%s
   --  system.concat_3%b
   --  system.concat_4%s
   --  system.concat_4%b
   --  system.exn_flt%s
   --  system.exn_lflt%s
   --  system.exn_llf%s
   --  system.traceback%s
   --  system.traceback%b
   --  ada.characters.handling%s
   --  system.case_util%s
   --  system.os_lib%s
   --  system.secondary_stack%s
   --  system.standard_library%s
   --  ada.exceptions%s
   --  system.exceptions_debug%s
   --  system.exceptions_debug%b
   --  system.soft_links%s
   --  system.val_util%s
   --  system.val_util%b
   --  system.val_llu%s
   --  system.val_lli%s
   --  system.wch_stw%s
   --  system.wch_stw%b
   --  ada.exceptions.last_chance_handler%s
   --  ada.exceptions.last_chance_handler%b
   --  ada.exceptions.traceback%s
   --  ada.exceptions.traceback%b
   --  system.address_image%s
   --  system.address_image%b
   --  system.bit_ops%s
   --  system.bit_ops%b
   --  system.bounded_strings%s
   --  system.bounded_strings%b
   --  system.case_util%b
   --  system.exception_table%s
   --  system.exception_table%b
   --  ada.containers%s
   --  ada.io_exceptions%s
   --  ada.strings%s
   --  ada.strings.maps%s
   --  ada.strings.maps%b
   --  ada.strings.maps.constants%s
   --  interfaces.c%s
   --  interfaces.c%b
   --  system.exceptions%s
   --  system.exceptions.machine%s
   --  system.exceptions.machine%b
   --  system.win32%s
   --  ada.characters.handling%b
   --  system.exception_traces%s
   --  system.exception_traces%b
   --  system.memory%s
   --  system.memory%b
   --  system.mmap%s
   --  system.mmap.os_interface%s
   --  system.mmap.os_interface%b
   --  system.mmap%b
   --  system.object_reader%s
   --  system.object_reader%b
   --  system.dwarf_lines%s
   --  system.dwarf_lines%b
   --  system.os_lib%b
   --  system.secondary_stack%b
   --  system.soft_links.initialize%s
   --  system.soft_links.initialize%b
   --  system.soft_links%b
   --  system.standard_library%b
   --  system.traceback.symbolic%s
   --  system.traceback.symbolic%b
   --  ada.exceptions%b
   --  ada.characters.conversions%s
   --  ada.characters.conversions%b
   --  ada.command_line%s
   --  ada.command_line%b
   --  ada.containers.prime_numbers%s
   --  ada.containers.prime_numbers%b
   --  ada.strings.hash%s
   --  ada.strings.hash%b
   --  ada.strings.search%s
   --  ada.strings.search%b
   --  ada.strings.fixed%s
   --  ada.strings.fixed%b
   --  ada.strings.utf_encoding%s
   --  ada.strings.utf_encoding%b
   --  ada.strings.utf_encoding.wide_strings%s
   --  ada.strings.utf_encoding.wide_strings%b
   --  ada.strings.utf_encoding.wide_wide_strings%s
   --  ada.strings.utf_encoding.wide_wide_strings%b
   --  ada.tags%s
   --  ada.tags%b
   --  ada.strings.text_buffers%s
   --  ada.strings.text_buffers%b
   --  ada.strings.text_buffers.utils%s
   --  ada.strings.text_buffers.utils%b
   --  gnat%s
   --  gnat.byte_swapping%s
   --  gnat.byte_swapping%b
   --  gnat.io%s
   --  gnat.io%b
   --  gnat.os_lib%s
   --  interfaces.c.strings%s
   --  interfaces.c.strings%b
   --  ada.environment_variables%s
   --  ada.environment_variables%b
   --  system.arith_64%s
   --  system.arith_64%b
   --  system.fat_flt%s
   --  system.fat_lflt%s
   --  system.fat_llf%s
   --  system.img_flt%s
   --  system.img_lflt%s
   --  system.img_llf%s
   --  system.put_images%s
   --  system.put_images%b
   --  ada.streams%s
   --  ada.streams%b
   --  system.file_control_block%s
   --  system.finalization_root%s
   --  system.finalization_root%b
   --  ada.finalization%s
   --  ada.containers.helpers%s
   --  ada.containers.helpers%b
   --  ada.containers.hash_tables%s
   --  system.file_io%s
   --  system.file_io%b
   --  system.storage_pools%s
   --  system.storage_pools%b
   --  system.finalization_masters%s
   --  system.finalization_masters%b
   --  system.storage_pools.subpools%s
   --  system.storage_pools.subpools.finalization%s
   --  system.storage_pools.subpools.finalization%b
   --  system.storage_pools.subpools%b
   --  system.stream_attributes%s
   --  system.stream_attributes.xdr%s
   --  system.stream_attributes.xdr%b
   --  system.stream_attributes%b
   --  ada.strings.unbounded%s
   --  ada.strings.unbounded%b
   --  system.task_lock%s
   --  system.task_lock%b
   --  gnat.task_lock%s
   --  system.val_fixed_64%s
   --  system.val_flt%s
   --  system.val_lflt%s
   --  system.val_llf%s
   --  system.val_lllu%s
   --  system.val_llli%s
   --  system.val_uns%s
   --  system.val_int%s
   --  system.win32.ext%s
   --  system.os_primitives%s
   --  system.os_primitives%b
   --  ada.calendar%s
   --  ada.calendar%b
   --  ada.calendar.time_zones%s
   --  ada.calendar.time_zones%b
   --  ada.calendar.formatting%s
   --  ada.calendar.formatting%b
   --  ada.text_io%s
   --  ada.text_io%b
   --  ada.text_io.generic_aux%s
   --  ada.text_io.generic_aux%b
   --  ada.float_text_io%s
   --  ada.float_text_io%b
   --  ada.integer_text_io%s
   --  ada.integer_text_io%b
   --  gnat.secure_hashes%s
   --  gnat.secure_hashes%b
   --  gnat.secure_hashes.sha2_common%s
   --  gnat.secure_hashes.sha2_common%b
   --  gnat.secure_hashes.sha2_32%s
   --  gnat.secure_hashes.sha2_32%b
   --  gnat.sha256%s
   --  gnat.sha256%b
   --  system.strings.stream_ops%s
   --  system.strings.stream_ops%b
   --  gnatcoll%s
   --  bitcoin%s
   --  bitcoin%b
   --  gnatcoll.os%s
   --  gnatcoll.os.win32%s
   --  gnatcoll.os.win32.strings%s
   --  gnatcoll.os.win32.strings%b
   --  gnatcoll.os.win32%b
   --  gnatcoll.os.win32.process%s
   --  gnatcoll.string_builders%s
   --  gnatcoll.string_builders%b
   --  gnatcoll.wstring_builders%s
   --  gnatcoll.wstring_builders%b
   --  gnatcoll.os.fs%s
   --  gnatcoll.os.win32.files%s
   --  gnatcoll.os.win32.files%b
   --  gnatcoll.os.fs%b
   --  gnatcoll.wstring_list_builders%s
   --  gnatcoll.wstring_list_builders%b
   --  gnatcoll.os.process_types%s
   --  gnatcoll.os.process_types%b
   --  gnatcoll.os.process%s
   --  gnatcoll.os.process%b
   --  fetch_bitcoin_info%s
   --  fetch_bitcoin_info%b
   --  fetch_nostr_info%s
   --  fetch_nostr_info%b
   --  main%b
   --  END ELABORATION ORDER

end ada_main;
