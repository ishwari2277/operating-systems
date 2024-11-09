#include <stdio.h>
#include <pthread.h>
#include <unistd.h>

#define NUM_READERS 5
#define NUM_WRITERS 3

pthread_mutex_t mutex;          // Mutex to protect the shared resource
pthread_cond_t reader_cond;     // Condition variable for readers
pthread_cond_t writer_cond;     // Condition variable for writers
int read_count = 0;             // Number of active readers
int write_count = 0;            // Number of active writers

// Shared resource (for demonstration purposes, a simple integer)
int shared_data = 0;

void* reader(void* arg) {
    int reader_id = *(int*)arg;
    
    // Request to read
    pthread_mutex_lock(&mutex);
    while (write_count > 0) {
        // Wait if a writer is active
        pthread_cond_wait(&reader_cond, &mutex);
    }
    read_count++;  // Increment reader count
    pthread_mutex_unlock(&mutex);

    // Reading from the shared resource
    printf("Reader %d: Reading shared data: %d\n", reader_id, shared_data);

    // Done reading, decrement the reader count
    pthread_mutex_lock(&mutex);
    read_count--;
    if (read_count == 0) {
        // If no readers are left, signal the writer
        pthread_cond_signal(&writer_cond);
    }
    pthread_mutex_unlock(&mutex);
    
    return NULL;
}

void* writer(void* arg) {
    int writer_id = *(int*)arg;

    // Request to write
    pthread_mutex_lock(&mutex);
    write_count++;  // Increment writer count
    while (read_count > 0) {
        // Wait if there are active readers
        pthread_cond_wait(&writer_cond, &mutex);
    }

    // Writing to the shared resource
    shared_data++;  // Increment shared data as a simple write operation
    printf("Writer %d: Writing shared data to: %d\n", writer_id, shared_data);

    write_count--;  // Decrement writer count
    pthread_cond_broadcast(&reader_cond);  // Wake up waiting readers
    pthread_cond_signal(&writer_cond);    // Signal next writer if any
    pthread_mutex_unlock(&mutex);
    
    return NULL;
}

int main() {
    pthread_t readers[NUM_READERS], writers[NUM_WRITERS];
    int reader_ids[NUM_READERS], writer_ids[NUM_WRITERS];

    // Initialize mutex and condition variables
    pthread_mutex_init(&mutex, NULL);
    pthread_cond_init(&reader_cond, NULL);
    pthread_cond_init(&writer_cond, NULL);

    // Create reader threads
    for (int i = 0; i < NUM_READERS; i++) {
        reader_ids[i] = i + 1;
        pthread_create(&readers[i], NULL, reader, &reader_ids[i]);
    }

    // Create writer threads
    for (int i = 0; i < NUM_WRITERS; i++) {
        writer_ids[i] = i + 1;
        pthread_create(&writers[i], NULL, writer, &writer_ids[i]);
    }

    // Wait for all reader and writer threads to complete
    for (int i = 0; i < NUM_READERS; i++) {
        pthread_join(readers[i], NULL);
    }
    for (int i = 0; i < NUM_WRITERS; i++) {
        pthread_join(writers[i], NULL);
    }

    // Destroy mutex and condition variables
    pthread_mutex_destroy(&mutex);
    pthread_cond_destroy(&reader_cond);
    pthread_cond_destroy(&writer_cond);

    return 0;
}
