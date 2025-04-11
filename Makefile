# Compiler to use (full path)
BSC = bsc

# Source and output directories
SRC_DIR = src_bsv
OUT_DIR = verilog

# List of BSV files (without extension) to compile
FILE_NAMES = RegisterFile  # Add your file names here

# Generate source and target file lists
BSV_FILES = $(addprefix $(SRC_DIR)/,$(addsuffix .bsv,$(FILE_NAMES)))
V_FILES = $(addprefix $(OUT_DIR)/,$(addsuffix .v,$(FILE_NAMES)))

# Default target
all: run

# Create output directory
$(OUT_DIR):
	@mkdir -p $(OUT_DIR)
	@echo "Created output directory: $(OUT_DIR)"

# Rule to convert BSV to Verilog, move the file, and remove .bo
$(OUT_DIR)/%.v: $(SRC_DIR)/%.bsv | $(OUT_DIR)
	@echo "Source file: $<"
	@echo "Target file: $@"
	@echo "Running: $(BSC) -u -verilog -g mk$* $<"
	$(BSC) -u -verilog -g mk$* $<
	@if [ -f $(SRC_DIR)/mk$*.v ]; then \
		mv $(SRC_DIR)/mk$*.v $@; \
		echo "Moved $(SRC_DIR)/mk$*.v to $@"; \
		rm -f $(SRC_DIR)/$*.bo; \
		echo "Removed intermediate file: $(SRC_DIR)/$*.bo"; \
		ls -l $@; \
	else \
		echo "Error: Failed to generate $(SRC_DIR)/mk$*.v"; \
		pwd; \
		ls -ld $(OUT_DIR); \
		exit 1; \
	fi

# Main run target
run: $(V_FILES)
	@echo "BSV to Verilog conversion complete"

# Clean up
clean:
	@rm -rf $(OUT_DIR)
	@rm -f $(SRC_DIR)/*.bo
	@rm -f $(SRC_DIR)/mk*.v  # Remove any leftover mk*.v files
	@echo "Cleaned up $(OUT_DIR), removed .bo and mk*.v files from $(SRC_DIR)"

.PHONY: all run clean

# Debug target
debug:
	@echo "BSV_FILES: $(BSV_FILES)"
	@echo "V_FILES: $(V_FILES)"
