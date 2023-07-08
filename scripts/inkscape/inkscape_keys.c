#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <linux/input.h>

#define INKSCAPE_KEYS "/tmp/inkscape_keys"

int main(void) {
    setbuf(stdin, NULL), setbuf(stdout, NULL);

    struct input_event event;
    while (fread(&event, sizeof(event), 1, stdin) == 1) {

        if (access(INKSCAPE_KEYS, F_OK) == 0 && event.type == EV_KEY) {
            switch(event.code) {
                case KEY_J:
                    event.code = KEY_DOWN;
                    break;
                case KEY_K:
                    event.code = KEY_UP;
                    break;
                case KEY_H:
                    event.code = KEY_LEFT;
                    break;
                case KEY_L:
                    event.code = KEY_RIGHT;
                    break;
            }
        }

        fwrite(&event, sizeof(event), 1, stdout);
    }
}
