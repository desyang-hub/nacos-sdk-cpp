include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

# 1️⃣ 安装目标 + 导出集（合并为一个 install 命令）
install(TARGETS nacos-cli
	EXPORT nacosTargets
	LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
	ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
	RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
	INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}  # 👈 关键：自动设置导入目标的 include 路径
)

# 2️⃣ 安装头文件
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include/
	DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/nacos
	FILES_MATCHING PATTERN "*.h*"
)

# 3️⃣ 安装导出文件（生成 nacosTargets.cmake）
install(EXPORT nacosTargets
	FILE nacosTargets.cmake
	NAMESPACE nacos::
	DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/nacos
)

# 4️⃣ 生成并安装 Config.cmake
configure_package_config_file(
	"${CMAKE_CURRENT_SOURCE_DIR}/cmake/nacosConfig.cmake.in"
	"${CMAKE_CURRENT_BINARY_DIR}/nacosConfig.cmake"
	INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/nacos
)

# 5️⃣ 生成并安装 ConfigVersion.cmake（支持版本检查）
write_basic_package_version_file(
	"${CMAKE_CURRENT_BINARY_DIR}/nacosConfigVersion.cmake"
	VERSION ${PROJECT_VERSION}
	COMPATIBILITY SameMajorVersion
)

install(FILES
	"${CMAKE_CURRENT_BINARY_DIR}/nacosConfig.cmake"
	"${CMAKE_CURRENT_BINARY_DIR}/nacosConfigVersion.cmake"
	DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/nacos
)
