# synergy -- mouse and keyboard sharing utility
# Copyright (C) 2012 Synergy Si Ltd.
# Copyright (C) 2011 Nick Bolton
# 
# This package is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# found in the file LICENSE that should have accompanied this file.
# 
# This package is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# https://cmake.org/pipermail/cmake/2010-October/040122.html
if(NOT DEFINED PROCESSOR_COUNT)
  # Unknown:
  set(PROCESSOR_COUNT 0)

  # Linux:
  set(cpuinfo_file "/proc/cpuinfo")
  if(EXISTS "${cpuinfo_file}")
    file(STRINGS "${cpuinfo_file}" procs REGEX "^processor.: [0-9]+$")
    list(LENGTH procs PROCESSOR_COUNT)
  endif()

  # Mac:
  if(APPLE)
    find_program(cmd_sys_pro "system_profiler")
    if(cmd_sys_pro)
      execute_process(COMMAND ${cmd_sys_pro} OUTPUT_VARIABLE info)
      string(REGEX REPLACE "^.*Total Number Of Cores: ([0-9]+).*$" "\\1"
        PROCESSOR_COUNT "${info}")
    endif()
  endif()

  # Windows:
  if(WIN32)
    set(PROCESSOR_COUNT "$ENV{NUMBER_OF_PROCESSORS}")
  endif()
endif()

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP${PROCESSOR_COUNT}")

add_subdirectory(lib)
add_subdirectory(cmd)
add_subdirectory(micro)

if (NOT ${CMAKE_SYSTEM_NAME} MATCHES "IRIX")
	add_subdirectory(test)
endif()
