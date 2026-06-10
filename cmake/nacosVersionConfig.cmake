# cmake/nacosVersionConfig.cmake

configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/version.h.in"
    "${CMAKE_CURRENT_BINARY_DIR}/include/nacos/version.h"
    @ONLY
)

# ✅ 为所有需要版本信息的目标添加 include 路径
foreach(_target nacos-cli nacos-cli-static nacos-cli.out)
    if(TARGET ${_target})
        target_include_directories(${_target} PUBLIC
            $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include>
            $<INSTALL_INTERFACE:include>
        )
    endif()
endforeach()

# 3️⃣ 别忘了安装生成的头文件，否则 find_package() 后别人用不了
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/include/nacos/version.h"
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/nacos
)