find_package(GLFW3 REQUIRED)

include_directories(${GLFW3_INCLUDE_DIR})
set(EXTERNAL_LIBRARIES
	${EXTERNAL_LIBRARIES}
	${GLFW3_LIBRARY}
)
