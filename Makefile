#############################

BSC      = bsc
SRC_DIR  = src_bsv
OUT_DIR  = verilog
SIM_DIR  = sim_files

# List of BSV files (without extension)
FILE_NAMES = PC RegisterFile Alu Decoder ControlUnit # Add more as needed

# Generate source/target file lists
BSV_FILES       = $(addprefix $(SRC_DIR)/,$(addsuffix .bsv,$(FILE_NAMES)))
V_FILES         = $(addprefix $(OUT_DIR)/,$(addsuffix .v,$(FILE_NAMES)))
BA_FILES        = $(addprefix $(SRC_DIR)/mk,$(addsuffix .ba,$(FILE_NAMES)))
SIM_EXEC_FILES  = $(addprefix $(SIM_DIR)/mk,$(FILE_NAMES))

all: translate

# Create output directory
$(OUT_DIR):
	@mkdir -p $(OUT_DIR)
	@echo "Created output directory: $(OUT_DIR)"

####################################
# BSV to Verilog rule and target

$(OUT_DIR)/%.v: $(SRC_DIR)/%.bsv | $(OUT_DIR)
	@echo "Source file: $<"
	@echo "Target file: $@"
	@echo "Running: $(BSC) -u -verilog -g mk$* $<"
	$(BSC) -u -verilog -g mk$* $<
	rm -f $(SRC_DIR)/$*.bo
	@if [ -f $(SRC_DIR)/mk$*.v ]; then \
		mv $(SRC_DIR)/mk$*.v $@; \
		echo "Moved $(SRC_DIR)/mk$*.v -> $@"; \
		ls -l $@; \
	else \
		echo "Error: Failed to generate $(SRC_DIR)/mk$*.v"; \
		pwd; \
		ls -ld $(OUT_DIR); \
		exit 1; \
	fi

translate: $(V_FILES)
	@echo "BSV to Verilog conversion complete"

####################################
# Simulation build (BA + Executable)

$(SIM_DIR):
	@mkdir -p $(SIM_DIR)
	@echo "Created simulation directory: $(SIM_DIR)"

# 1) Generate .ba file in src_bsv
$(SRC_DIR)/mk%.ba: $(SRC_DIR)/%.bsv
	@echo "Generating .ba file from $u"
	$(BSC) -u -sim -g mk$* $<
	
# 2) Generate simulation artifacts, then move them into sim_files/.
$(SIM_DIR)/mk%: $(SRC_DIR)/mk%.ba | $(SIM_DIR)
	@echo "Generating simulation binary from $<"
	$(BSC) -sim -e mk$* $<
	rm -f $(SRC_DIR)/$*.bo
	@echo "Moving all mk$* simulation artifacts to $(SIM_DIR)/"
	@for f in mk$* mk$*.* model_mk$* model_mk$*.* a.out a.out.so; do \
	  if [ -f "$$f" ]; then \
	    mv "$$f" $(SIM_DIR)/; \
	    echo "Moved $$f -> $(SIM_DIR)/"; \
	  fi; \
	done

sim: $(SIM_EXEC_FILES)
	@echo "All simulation artifacts are in $(SIM_DIR)/"

####################################
# Clean up

clean:
	@rm -rf $(OUT_DIR)
	@rm -rf $(SIM_DIR)
	@rm -f  $(SRC_DIR)/mk*.v
	@echo "Cleaned up build outputs"

.PHONY: all run clean debug sim

debug:
	@echo "BSV_FILES:       $(BSV_FILES)"
	@echo "V_FILES:         $(V_FILES)"
	@echo "BA_FILES:        $(BA_FILES)"
	@echo "SIM_EXEC_FILES:  $(SIM_EXEC_FILES)"

