#CMake Version required version of CMake needed. 
cmake_minimum_required(VERSION 3.0.0)

#Declare vars
set(PROJECT_NAME "git_helper")
set(PROJECT_DESCRIPTION  "git_helper is a helper for git if yuu are beginner.")
set(PROJECT_COPYRIGHT    "Copyright (C) 2001-2014 Ing. Armando Ibarra")
set(PROJECT_CONTACT      "armandoibarra1@gmail.com")
set(PROJECT_VENDOR       "Ing. Armando Ibarra")
set(WEBSITE          "https://github.com/flaketill")
set(PACKAGE_VERSION "0.0.1")

#PROJECT deps
set(REQUIRED_PYTHON_VERSION "2.7")

set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_LIST_DIR}/cmake )

#Package name
project(PROJECT_NAME)

IF(NOT CMAKE_BUILD_TYPE)
  SET(CMAKE_BUILD_TYPE "DEBUG")
ENDIF()

if(CMAKE_SYSTEM_NAME MATCHES "Linux")
	# RPM packages
	#include(cmake/RpmBuild.cmake)
	# DEB packages

	#tar
endif()

# Mac Bundle
if(APPLE)

elseif(UNIX AND NOT APPLE)

	
endif()



# Detect source directory
set(_landmark "run_cmake.sh") # CMake will look for this file.
if(EXISTS ${CMAKE_SOURCE_DIR}/${_landmark})
    set(SRC_DIR ${CMAKE_SOURCE_DIR})
elseif(NOT "${SRC_DIR}" STREQUAL "" AND EXISTS ${SRC_DIR}/${_landmark})
    # Do nothing - SRC_DIR is already set.
else()
    foreach(dirname
        cpython-${PY_VERSION_MAJOR}.${PY_VERSION_MINOR}.${PY_VERSION_PATCH}
        Python-${PY_VERSION_MAJOR}.${PY_VERSION_MINOR}.${PY_VERSION_PATCH}
    )
        set(SRC_DIR "${CMAKE_CURRENT_BINARY_DIR}/../${dirname}")
        if(EXISTS ${SRC_DIR}/${_landmark})
            break()
        endif()
    endforeach()
endif()

enable_testing()

# #${PACKAGE_VERSION}

# #Finding Dependent CMake Packages
# # find_package(REQUIRED_PYTHON_VERSION 2.7 REQUIRED)
# find_package(OpenGL)
# find_package ( PythonLibs REQUIRED )
# find_package ( PythonInterp REQUIRED )

# if ( PYTHON_VERSION_STRING AND PYTHONLIBS_VERSION_STRING )
#   if ( NOT PYTHON_VERSION_STRING VERSION_EQUAL PYTHONLIBS_VERSION_STRING )
#     message ( FATAL_ERROR
#             "Version mismatch between python interpreter and libraries" )
#   endif ( NOT PYTHON_VERSION_STRING VERSION_EQUAL
# PYTHONLIBS_VERSION_STRING )
# endif ( PYTHON_VERSION_STRING AND PYTHONLIBS_VERSION_STRING )

# include_directories ( ${PYTHON_INCLUDE_DIRS} )

# execute_process (
#   COMMAND ${PYTHON_EXECUTABLE} -c
#         "import site, sys; sys.stdout.write(site.**PREFIXES[-1])"
#   OUTPUT_VARIABLE PYTHON_PREFIX
# )
# file ( TO_CMAKE_PATH "${PYTHON_PREFIX}" PYTHON_PREFIX )
# execute_process (
#   COMMAND ${PYTHON_EXECUTABLE} -c
#         "import site, sys; sys.stdout.write(site.**getsitepackages()[-1])"
#   OUTPUT_VARIABLE PYTHON_SITE_DIR
# )
# file ( TO_CMAKE_PATH "${PYTHON_SITE_DIR}" PYTHON_SITE_DIR )
# string ( REGEX REPLACE "^${PYTHON_PREFIX}/" ""
#   PYTHON_SITE_DIR "${PYTHON_SITE_DIR}"
# )

# install ( TARGETS ${SWIG_MODULE_obexftp-python_**REAL_NAME}
#   LIBRARY
#     DESTINATION ${PYTHON_SITE_DIR}
#     COMPONENT library
# )

# find_package(Boost 1.45.0)

# IF(Boost_FOUND)
#   INCLUDE_DIRECTORIES("${Boost_INCLUDE_DIRS}" "/usr/include/python2.6")
  

#   #ADD_LIBRARY(yay SHARED yay.cxx)
#   #TARGET_LINK_LIBRARIES(yay ${Boost_LIBRARIES})
# ELSEIF(NOT Boost_FOUND)
#   MESSAGE(FATAL_ERROR "Unable to find correct Boost version. Did you set BOOST_ROOT?")
# ENDIF()

# IF(CMAKE_COMPILER_IS_GNUCXX)
#   ADD_DEFINITIONS("-Wall")
# ELSE()
#   MESSAGE(FATAL_ERROR "CMakeLists.txt has not been tested/written for your compiler.")
# ENDIF()


#set(CMAKE_CXX_FLAGS "-g -Wall")

# install(CODE "execute_process(COMMAND python setup.py install -f
# --prefix=${CMAKE_INSTALL_PREFIX} WORKING_DIRECTORY
# ../source/libmoleculizer-1.1.2/python-src/language_parser)")

#install(DIRECTORY include/${PROJECT_NAME}/
#  DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
#  PATTERN ".svn" EXCLUDE
#)





