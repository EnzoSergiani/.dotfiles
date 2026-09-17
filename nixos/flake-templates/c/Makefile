CC = gcc
CFLAGS = -Wall -Wextra -std=c17 -g

SRC = src/main.c
OUT = build/main

$(OUT): $(SRC)
	mkdir -p build
	$(CC) $(CFLAGS) $(SRC) -o $(OUT)

run: $(OUT)
	./$(OUT)

clean:
	rm -rf build

.PHONY: run clean
