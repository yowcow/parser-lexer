BIN := bin
BUILD := build

NAMES = $(basename $(notdir $(shell find src -type f -name '*.l' | sort)))
TARGET := $(foreach name,$(NAMES),$(BIN)/$(name))

all: $(BIN) $(BUILD) $(TARGET)

$(BIN):
	mkdir -p $@

$(BUILD):
	mkdir -p $@

$(BIN)/example4: $(BUILD)/example4.yy.c $(BUILD)/example4.tab.c
	cc -Wall -I $(BUILD) -o $@ $^

$(BIN)/%: $(BUILD)/%.yy.c
	cc -Wall $< -o $@ -ll

$(BUILD)/%.tab.c: src/%.y
	yacc -b $(dir $@)$* -d $<

$(BUILD)/%.yy.c: src/%.l
	lex -o $@ $<

clean:
	rm -rf $(BIN) $(BUILD)

.PRECIOUS: $(BUILD)/%.yy.c $(BUILD)/%.tab.c
.PHONY: all clean
