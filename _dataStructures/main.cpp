#include <iostream>
#include <unordered_map>

static char *rand_string(char *str, size_t size)
{
    const char charset[] = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    if (size) {
        --size;
        for (size_t n = 0; n < size; n++) {
            int key = rand() % (int) (sizeof charset - 1);
            str[n] = charset[key];
        }
        str[size] = '\0';
    }
    return str;
}


int main() {
    std::unordered_map<char *, float *> map;

    int N = 1000;
    int M = 300;
    int Ms = 50;

    float *floats = new float[N*M];
    char *names = new char[N*Ms];

    int t;

    for (int i = 0; i < N; ++i) {
        float *arr = floats + i*M;
        char *name = names + i*Ms;
        for(int j=0; j < M; j++){
            arr[j] = j;
        }
        name = rand_string(name, Ms);
       // std::cout << name << std::endl;
    }

    std::cout << "Floats are initialized.";
    std::cin >> t;

    for (int i = 0; i < N; ++i) {
        char *n = names + i*Ms;
        float *arr = floats + i*M;
        map[n] = arr;
    }

    std::cout << "All elements are added to Map";

    std::cin >> t;

    delete(floats);

    return 0;
}

// do binary search with array and compare performance.
