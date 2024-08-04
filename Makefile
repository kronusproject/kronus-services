BUILD_DIR = build

vpath %.dtso dts

all: $(BUILD_DIR)/kronus-fabric.dtbo $(BUILD_DIR)/kronus-can.dtbo

$(BUILD_DIR):
	mkdir -p $@

$(BUILD_DIR)/%.dtbo: %.dtso | $(BUILD_DIR)
	dtc -@ -O dtb -o $@ $<

.PHONY: clean
clean:
	-$(RM) -r $(BUILD_DIR)
