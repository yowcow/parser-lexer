BIN := bin
BUILD := build

NAMES = $(basename $(notdir $(shell find src -type f -name '*.l' | sort)))
TARGET := $(foreach name,$(NAMES),$(BIN)/$(name))

all: $(BIN) $(BUILD) $(TARGET)

$(BIN):
	mkdir -p $@

$(BUILD):
	mkdir -p $@

$(BIN)/%: $(BUILD)/%.yy.c $(BUILD)/%.tab.c
	mkdir -p $(dir $@)
	cc -Wall -I src -I $(BUILD) -o $@ $^ -lfl

# No yacc for these
$(BUILD)/example1.tab.c:
	touch $@
$(BUILD)/example2.tab.c:
	touch $@
$(BUILD)/example3.tab.c:
	touch $@

$(BUILD)/%.tab.c: src/%.y
	mkdir -p $(dir $@)
	yacc -b $(dir $@)$* -d $<

$(BUILD)/%.yy.c: src/%.l
	mkdir -p $(dir $@)
	lex -o $@ $<

clean:
	rm -rf $(BIN) $(BUILD)

.PRECIOUS: $(BUILD)/%.yy.c $(BUILD)/%.tab.c
.PHONY: all clean
