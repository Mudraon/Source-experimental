SET (TOOLCHAIN 1)

function (toolchain_after_project)
	MESSAGE (STATUS "Toolchain: Windows-GNU-native.cmake.")

	SET(CMAKE_SYSTEM_NAME	"Windows"      PARENT_SCOPE)

	IF (CMAKE_SIZEOF_VOID_P EQUAL 8)
        MESSAGE (STATUS "Detected 64 bits architecture")
		SET(ARCH_BITS	64	PARENT_SCOPE)
		SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin64"	PARENT_SCOPE)
		LINK_DIRECTORIES ("lib/bin/x86_64/mariadb/")
	ELSE (CMAKE_SIZEOF_VOID_P EQUAL 8)
		MESSAGE (STATUS "Detected 32 bits architecture")
		SET(ARCH_BITS	32	PARENT_SCOPE)
		SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"	PARENT_SCOPE)
		LINK_DIRECTORIES ("lib/bin/x86/mariadb/")
	ENDIF (CMAKE_SIZEOF_VOID_P EQUAL 8)
	
	ENABLE_LANGUAGE(RC)
endfunction()


function (toolchain_exe_stuff)
    INCLUDE("cmake/toolchains/Windows-GNU_common.inc.cmake")
    
	SET (C_ARCH_OPTS	"-march=native")
	SET (CXX_ARCH_OPTS	"-march=native")

	toolchain_exe_stuff_common()
	
	# Propagate variables set in toolchain_exe_stuff_common to the upper scope
	SET (CMAKE_C_FLAGS			"${CMAKE_C_FLAGS} ${C_ARCH_OPTS}"       PARENT_SCOPE)
	SET (CMAKE_CXX_FLAGS        "${CMAKE_CXX_FLAGS} ${CXX_ARCH_OPTS}"	PARENT_SCOPE)
	SET (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS}" 			PARENT_SCOPE)
	SET (CMAKE_RC_FLAGS			"${CMAKE_RC_FLAGS}"						PARENT_SCOPE)

	
	IF (TARGET spheresvr_release)
		TARGET_LINK_LIBRARIES ( spheresvr_release	ws2_32 mariadb )
	ENDIF (TARGET spheresvr_release)
	IF (TARGET spheresvr_nightly)
		TARGET_LINK_LIBRARIES ( spheresvr_nightly	ws2_32 mariadb )
	ENDIF (TARGET spheresvr_nightly)
	IF (TARGET spheresvr_debug)
		TARGET_LINK_LIBRARIES ( spheresvr_debug		ws2_32 mariadb )
	ENDIF (TARGET spheresvr_debug)

endfunction()
