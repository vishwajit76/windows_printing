cmake_minimum_required(VERSION 3.15)
set(ENV{PDFium_DIR} "${CMAKE_CURRENT_SOURCE_DIR}/pdfium")
set(PDFIUM_FOUND 1)
set(PROJECT_NAME "windows_printing")
project(${PROJECT_NAME} LANGUAGES CXX)
  find_file(PDFium_LIBRARY
        NAMES "pdfium.dll"
        PATHS "${CMAKE_CURRENT_SOURCE_DIR}/pdfium"
        PATH_SUFFIXES "x64/bin")

  find_file(PDFium_IMPLIB
        NAMES "pdfium.dll.lib"
        PATHS "${CMAKE_CURRENT_SOURCE_DIR}/pdfium"
        PATH_SUFFIXES "x64/lib")
set(PDFium_LIBRARY "${PDFium_LIBRARY}")
set(PDFium_IMPLIB "${PDFium_IMPLIB}")

file(COPY ${PDFium_LIBRARY}
     DESTINATION ${CMAKE_BINARY_DIR}/runner/Debug)
file(COPY ${PDFium_LIBRARY}
     DESTINATION ${CMAKE_BINARY_DIR}/runner/Release)	 
find_package(PDFium REQUIRED)
set(PLUGIN_NAME "${PROJECT_NAME}_plugin")

add_library(${PLUGIN_NAME} SHARED
  "${PLUGIN_NAME}.cpp"
)
apply_standard_settings(${PLUGIN_NAME})
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_link_libraries(${PLUGIN_NAME} PRIVATE flutter flutter_wrapper_plugin pdfium)

# List of absolute paths to libraries that should be bundled with the plugin
set(windows_printing_bundled_libraries
  ""
  PARENT_SCOPE
)
