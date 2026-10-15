#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define REQUIRED_CONTENT "ckssdkvosajre"
#define ENV_NAME "SUPER_SECRET_VARIABLE"
int check_file() {
    FILE *f = fopen("./secret/input_file.txt", "r");
    if (!f) return 0;

    char buffer[256] = {0};
    if (!fgets(buffer, sizeof(buffer), f)) {
        fclose(f);
        return 0;
    }
    fclose(f);

    // Remove newline if present
    buffer[strcspn(buffer, "\n")] = '\0';

    return strcmp(buffer, REQUIRED_CONTENT) == 0;
}

int check_env() {
    char *env = getenv(ENV_NAME);
    if (!env) return 0;

    return atoi(env) == 117;
}

void write_flag() {
    char flag[] = "";
    char *home = getenv("HOME");
    if (!home) return;

    char path[512];
    snprintf(path, sizeof(path), "%s/.cache/.sys_%d", home, getuid());

    FILE *f = fopen(path, "w");
    if (!f) return;

    fprintf(f, "%s\n", flag);
    fclose(f);
}

int main() {
    if (check_file() && check_env()) {
        write_flag();
    } else {
        printf("Nope.\n");
    }

    return 0;
}
