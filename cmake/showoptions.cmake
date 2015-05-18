# output generic information about the core and buildtype chosen
message("")
message("* TrinityCore revision   : ${rev_hash} ${rev_date} (${rev_branch} branch)")
if( UNIX )
  message("* TrinityCore buildtype  : ${CMAKE_BUILD_TYPE}")
endif()
message("")

# output information about installation-directories and locations

message("* Install core to        : ${CMAKE_INSTALL_PREFIX}")
if( UNIX )
  message("* Install libraries to   : ${LIBSDIR}")
  message("* Install configs to     : ${CONF_DIR}")
endif()
message("")

# Show infomation about the options selected during configuration

if( SERVERS )
  message("* Build world/auth       : Yes (default)")
else()
  message("* Build world/authserver : No")
endif()

if( SCRIPTS )
  message("* Build with scripts     : Yes (default)")
  add_definitions(-DSCRIPTS)
else()
  message("* Build with scripts     : No")
endif()

if( ELUNA )
  message("* Build Eluna LuaEngine   : Yes (default)")
  add_definitions(-DELUNA)
else()
  message("* Build Eluna LuaEngine   : No")
endif()

if( TOOLS )
  message("* Build map/vmap tools   : Yes")
  add_definitions(-DNO_CORE_FUNCS)
else()
  message("* Build map/vmap tools   : No  (default)")
endif()

if( USE_COREPCH )
  message("* Build core w/PCH       : Yes (default)")
else()
  message("* Build core w/PCH       : No")
endif()

if( USE_SCRIPTPCH )
  message("* Build scripts w/PCH    : Yes (default)")
else()
  message("* Build scripts w/PCH    : No")
endif()

if( WITH_WARNINGS )
  message("* Show all warnings      : Yes")
else()
  message("* Show compile-warnings  : No  (default)")
endif()

if( WITH_COREDEBUG )
  message("* Use coreside debug     : Yes")
  add_definitions(-DTRINITY_DEBUG)
else()
  message("* Use coreside debug     : No  (default)")
endif()

if( WITH_SOURCE_TREE STREQUAL "flat" OR WITH_SOURCE_TREE STREQUAL "hierarchical" )
  # TODO: Remove this after Debian 8 is released and set general required version to 2.8.12
  #       Debian 7 is shipped with CMake 2.8.9 . But DIRECTORY flag of get_filename_component requires 2.8.12 .
  if (NOT CMAKE_VERSION VERSION_LESS 2.8.12)
    message("* Show source tree       : Yes - ${WITH_SOURCE_TREE}")
    set(_WITH_SOURCE_TREE ${WITH_SOURCE_TREE} CACHE INTERNAL "WITH_SOURCE_TREE support enabled.")
  else()
    message("* Show source tree       : No  (default)")

    message("")
    message(" *** WITH_SOURCE_TREE - WARNING!")
    message(" *** This functionality is ONLY supported on CMake 2.8.12 or higher.")
    message(" *** You are running ${CMAKE_VERSION}, which does not have the functions needed")
    message(" *** to create a sourcetree - this option is thus forced to disabled!")
    message("")

    set(_WITH_SOURCE_TREE "" CACHE INTERNAL "WITH_SOURCE_TREE support disabled.")
  endif()
else()
  message("* Show source tree       : No  (default)")
  set(_WITH_SOURCE_TREE "" CACHE INTERNAL "WITH_SOURCE_TREE support disabled.")
endif()

if ( WITHOUT_GIT )
  message("* Use GIT revision hash  : No")
  message("")
  message(" *** WITHOUT_GIT - WARNING!")
  message(" *** By choosing the WITHOUT_GIT option you have waived all rights for support,")
  message(" *** and accept that or all requests for support or assistance sent to the core")
  message(" *** developers will be rejected. This due to that we will be unable to detect")
  message(" *** what revision of the codebase you are using in a proper way.")
  message(" *** We remind you that you need to use the repository codebase and a supported")
  message(" *** version of git for the revision-hash to work, and be allowede to ask for")
  message(" *** support if needed.")
else()
  message("* Use GIT revision hash  : Yes")
endif()

if ( NOJEM )
  message("")
  message(" *** NOJEM - WARNING!")
  message(" *** jemalloc linking has been disabled!")
  message(" *** Please note that this is for DEBUGGING WITH VALGRIND only!")
  message(" *** DO NOT DISABLE IT UNLESS YOU KNOW WHAT YOU'RE DOING!")
endif()

if ( HELGRIND )
  message("")
  message(" *** HELGRIND - WARNING!")
  message(" *** Please specify the valgrind include directory in VALGRIND_INCLUDE_DIR option if you get build errors")
  message(" *** Please note that this is for DEBUGGING WITH HELGRIND only!")
  add_definitions(-DHELGRIND)
endif()

message("")

