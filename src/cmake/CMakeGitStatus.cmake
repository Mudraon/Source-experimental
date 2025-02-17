# Git revision checker
SET (GITHASH_VAL "N/A")
SET (GITREV_VAL  0)

find_package(Git)
IF (GIT_FOUND)
	SET (GIT_CMD git)
	SET (GIT_ARGS rev-parse HEAD)
	SET (GIT_REV_CMD git rev-list --count HEAD)

	MESSAGE (STATUS "Checking git revision...")
	EXECUTE_PROCESS (COMMAND ${GIT_REV_CMD}
		WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
		OUTPUT_VARIABLE GITREV_CMD
		OUTPUT_STRIP_TRAILING_WHITESPACE
	)
	MATH (EXPR GITREV_CMD "${GITREV_CMD}")
	
	IF ("${GITREV_CMD}" STREQUAL "")
		MESSAGE (WARNING "Git revision not available!")
		
	ELSE ("${GITREV_CMD}" STREQUAL "")
		MESSAGE (STATUS "Git revision ${GITREV_CMD}")
		SET (GITREV_VAL ${GITREV_CMD})
		
		MESSAGE (STATUS "Checking git revision hash...")
		EXECUTE_PROCESS (COMMAND ${GIT_CMD} ${GIT_ARGS}
			WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
			OUTPUT_VARIABLE GITHASH_CMD
			OUTPUT_STRIP_TRAILING_WHITESPACE
		)
		MESSAGE (STATUS "Git revision hash ${GITHASH_CMD}")
		SET (GITHASH_VAL ${GITHASH_CMD})
		
	ENDIF ("${GITREV_CMD}" STREQUAL "")
	
ELSE()
	MESSAGE (WARNING "Git not found! Revision number and hash will not be available.")
	
ENDIF()

CONFIGURE_FILE (
 "${CMAKE_SOURCE_DIR}/src/common/version/GitRevision.h.in"
 "${CMAKE_SOURCE_DIR}/src/common/version/GitRevision.h"
)