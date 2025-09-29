add_library(codequality
    SHARED
    CodeQualityTidyModule.cpp
    NoFflushStdinCheck.cpp
    NoGlobalVariablesCheck.cpp
    NoHeaderGuardCheck.cpp
    NoPublicMemberVariablesCheck.cpp
    UncheckedMallocResultCheck.cpp
    )

# Set the include directories
target_include_directories(codequality PRIVATE 
    ${LLVM_INCLUDE_DIRS}
    ${CLANG_INCLUDE_DIRS}
)

# Link against the required Clang libraries
target_link_libraries(codequality
    clangTidy
    clangTidyUtils
    clangAST
    clangASTMatchers
    clangBasic
    clangFrontend
    clangTooling
)

# Also link against required LLVM libraries
set(LLVM_COMPONENTS
    Support
    Core
)

# Map LLVM components to libraries and link them
llvm_map_components_to_libnames(LLVM_LIBRARIES ${LLVM_COMPONENTS})
target_link_libraries(codequality ${LLVM_LIBRARIES} ${LLVM_LDFLAGS})
