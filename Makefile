BIN := bin
BUILD := build

NAMES = $(basename $(notdir $(shell find src -type f -name '*.l' | sort)))
TARGET := $(foreach name,$(NAMES),$(BIN)/$(name))

all: $(BIN) $(BUILD) $(TARGET)

$(BIN):
	mkdir -p $@

$(BUILD):
	mkdir -p $@

$(BIN)/example6: $(BUILD)/example6.yy.c $(BUILD)/example6.tab.c
	cc -Wall -I src -I $(BUILD) -o $@ $^ src/example6.c -lfl

$(BIN)/example5: $(BUILD)/example5.yy.c $(BUILD)/example5.tab.c
	cc -Wall -I $(BUILD) -o $@ $^ -lfl

$(BIN)/example4: $(BUILD)/example4.yy.c $(BUILD)/example4.tab.c
	cc -Wall -I $(BUILD) -o $@ $^ -lfl

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
