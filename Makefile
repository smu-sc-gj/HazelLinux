# Alternative GNU Make workspace makefile autogenerated by Premake

ifndef config
  config=debug
endif

ifndef verbose
  SILENT = @
endif

ifeq ($(config),debug)
  Premake_config = debug
  Box2D_config = debug
  GLFW_config = debug
  Glad_config = debug
  ImGui_config = debug
  yaml_cpp_config = debug
  Hazel_config = debug
  Sandbox_config = debug
  Hazelnut_config = debug

else ifeq ($(config),release)
  Premake_config = release
  Box2D_config = release
  GLFW_config = release
  Glad_config = release
  ImGui_config = release
  yaml_cpp_config = release
  Hazel_config = release
  Sandbox_config = release
  Hazelnut_config = release

else ifeq ($(config),dist)
  Premake_config = dist
  Box2D_config = dist
  GLFW_config = dist
  Glad_config = dist
  ImGui_config = dist
  yaml_cpp_config = dist
  Hazel_config = dist
  Sandbox_config = dist
  Hazelnut_config = dist

else
  $(error "invalid configuration $(config)")
endif

PROJECTS := Premake Box2D GLFW Glad ImGui yaml-cpp Hazel Sandbox Hazelnut

.PHONY: all clean help $(PROJECTS) Dependencies

all: $(PROJECTS)

Dependencies: Box2D GLFW Glad ImGui Premake yaml-cpp

Premake:
ifneq (,$(Premake_config))
	@echo "==== Building Premake ($(Premake_config)) ===="
	@${MAKE} --no-print-directory -C vendor/premake -f Makefile config=$(Premake_config)
endif

Box2D:
ifneq (,$(Box2D_config))
	@echo "==== Building Box2D ($(Box2D_config)) ===="
	@${MAKE} --no-print-directory -C Hazel/vendor/Box2D -f Makefile config=$(Box2D_config)
endif

GLFW:
ifneq (,$(GLFW_config))
	@echo "==== Building GLFW ($(GLFW_config)) ===="
	@${MAKE} --no-print-directory -C Hazel/vendor/GLFW -f Makefile config=$(GLFW_config)
endif

Glad:
ifneq (,$(Glad_config))
	@echo "==== Building Glad ($(Glad_config)) ===="
	@${MAKE} --no-print-directory -C Hazel/vendor/Glad -f Makefile config=$(Glad_config)
endif

ImGui:
ifneq (,$(ImGui_config))
	@echo "==== Building ImGui ($(ImGui_config)) ===="
	@${MAKE} --no-print-directory -C Hazel/vendor/imgui -f Makefile config=$(ImGui_config)
endif

yaml-cpp:
ifneq (,$(yaml_cpp_config))
	@echo "==== Building yaml-cpp ($(yaml_cpp_config)) ===="
	@${MAKE} --no-print-directory -C Hazel/vendor/yaml-cpp -f Makefile config=$(yaml_cpp_config)
endif

Hazel: Box2D GLFW Glad ImGui yaml-cpp
ifneq (,$(Hazel_config))
	@echo "==== Building Hazel ($(Hazel_config)) ===="
	@${MAKE} --no-print-directory -C Hazel -f Makefile config=$(Hazel_config)
endif

Sandbox: Hazel GLFW Glad ImGui
ifneq (,$(Sandbox_config))
	@echo "==== Building Sandbox ($(Sandbox_config)) ===="
	@${MAKE} --no-print-directory -C Sandbox -f Makefile config=$(Sandbox_config)
endif

Hazelnut: Hazel GLFW Glad ImGui yaml-cpp Box2D
ifneq (,$(Hazelnut_config))
	@echo "==== Building Hazelnut ($(Hazelnut_config)) ===="
	@${MAKE} --no-print-directory -C Hazelnut -f Makefile config=$(Hazelnut_config)
endif

clean:
	@${MAKE} --no-print-directory -C vendor/premake -f Makefile clean
	@${MAKE} --no-print-directory -C Hazel/vendor/Box2D -f Makefile clean
	@${MAKE} --no-print-directory -C Hazel/vendor/GLFW -f Makefile clean
	@${MAKE} --no-print-directory -C Hazel/vendor/Glad -f Makefile clean
	@${MAKE} --no-print-directory -C Hazel/vendor/imgui -f Makefile clean
	@${MAKE} --no-print-directory -C Hazel/vendor/yaml-cpp -f Makefile clean
	@${MAKE} --no-print-directory -C Hazel -f Makefile clean
	@${MAKE} --no-print-directory -C Sandbox -f Makefile clean
	@${MAKE} --no-print-directory -C Hazelnut -f Makefile clean

help:
	@echo "Usage: make [config=name] [target]"
	@echo ""
	@echo "CONFIGURATIONS:"
	@echo "  debug"
	@echo "  release"
	@echo "  dist"
	@echo ""
	@echo "TARGETS:"
	@echo "   all (default)"
	@echo "   clean"
	@echo "   Premake"
	@echo "   Box2D"
	@echo "   GLFW"
	@echo "   Glad"
	@echo "   ImGui"
	@echo "   yaml-cpp"
	@echo "   Hazel"
	@echo "   Sandbox"
	@echo "   Hazelnut"
	@echo ""
	@echo "For more information, see https://github.com/premake/premake-core/wiki"