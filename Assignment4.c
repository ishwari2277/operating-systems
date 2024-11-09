#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

// Function to perform bubble sort on an array
void bubblesort(int arr[], int n)
{
   int i;
int j;
    for (i = 0; i < n-1; i++)
{
        for (j = 0; j < n-1-i; j++)
{
            if (arr[j] > arr[j+1])
{
                int temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;
            }
        }
    }
}

// Function to reverse an array
void reverse(int arr[], int n)
{
int i;
    for (i = 0; i < n / 2; i++) {
        int temp = arr[i];
        arr[i] = arr[n - i - 1];
        arr[n - i - 1] = temp;
    }
}

int main() {
    int n;
int i;
    printf("Enter size of Array: ");
    scanf("%d", &n);

    int arr[n];
    printf("Enter array elements:\n");
    for ( i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }

    // Sort the array
    bubblesort(arr, n);

    printf("Sorted array: \n");
    for ( i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    // Fork a new process
    pid_t cpid = fork();

    if (cpid > 0) {
        // Parent process
        printf("\nParent is running:\nParent ID: %d\nChild ID: %d\n", getppid(), getpid());
        printf("Parent is waiting for child to complete\n");
        wait(NULL);
        printf("\nParent is exiting\n");
    } else if (cpid == 0) {
        // Child process
        printf("\n\nChild is running:\nParent ID: %d\nchild ID: %d\n", getppid(), getpid());
       
        // Reverse the array
        reverse(arr, n);

        printf("Reversed sorted array: \n");
        for (i = 0; i < n; i++) {
            printf("%d ", arr[i]);
        }
        printf("\n");
        exit(0);
    } else {
        perror("fork failed");
        exit(1);
    }

    return 0;
}
