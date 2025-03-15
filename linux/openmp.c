#include <omp.h>
#include <stdio.h>

static long num_steps = 100000;
double step;
#define NUM_THREADS 8

void ex1()
{
    int i; double pi;
    double x;
    step = 1.0/(double) num_steps;

    double t_start = omp_get_wtime();

    for (i = 0; i < num_steps; i++) {
        x = (i + 0.5) * step;
        pi += (4.0 / (1.0 + x * x)) * step;
    }

    printf("Time spent: %f\n", omp_get_wtime() - t_start);
    printf("pi = %f\n", pi);

}

void ex2()
{
    int i, nthreads; double pi, sum[NUM_THREADS];
    step = 1.0/(double) num_steps;

    omp_set_num_threads(NUM_THREADS);

    double t_start = omp_get_wtime();

#pragma omp parallel
    {
        int i, id, nthrds;
        double x;

        id = omp_get_thread_num();
        nthrds = omp_get_num_threads();
        if(id==0) nthreads = nthrds;

        for (i = id, sum[id]=0.0; i < num_steps; i = i+nthrds)
        {
            x = (i + 0.5) * step;
            sum[id] += 4.0 / (1.0 + x * x);
        }
    }
    for(i=0, pi=0.0; i < nthreads; i++)
    {
        pi += sum[i]*step;
    }

    printf("Time spent [threads %d]: %f\n", omp_get_wtime() - t_start, nthreads);
    printf("pi = %f\n", pi);

}

void ex3()
{
    int nthrds;
    double pi = 0.0, step = 1.0/(double) num_steps;

    omp_set_num_threads(NUM_THREADS);

    double t_start = omp_get_wtime();

    #pragma omp parallel
    {
        double x, sum;
        int i = 0, id;

        id = omp_get_thread_num();
        nthrds = omp_get_num_threads();

        for (i = id, sum = 0.0; i < num_steps; i = i+nthrds)
        {
            x = (i + 0.5) * step;
            sum += 4.0/(1.0+x*x);
        }

        #pragma omp critical
        pi += sum * step;
    }

    printf("Time spent [threads %d]: %f\n", omp_get_wtime() - t_start, nthrds);
    printf("pi = %f\n", pi);

}

void ex4()
{
    int nthrds;
    double pi = 0.0, step = 1.0/(double) num_steps;

    omp_set_num_threads(NUM_THREADS);

    double t_start = omp_get_wtime();

#pragma omp parallel
    {
        double x, sum;
        int i = 0, id;

        id = omp_get_thread_num();
        nthrds = omp_get_num_threads();

        for (i = id, sum = 0.0; i < num_steps; i = i+nthrds)
        {
            x = (i + 0.5) * step;
            sum += 4.0/(1.0+x*x);
        }

#pragma omp atomic
        pi += sum * step;
    }

    printf("Time spent [threads %d]: %f\n", omp_get_wtime() - t_start, nthrds);
    printf("pi = %f\n", pi);

}

void ex5(int id)
{
    double x, pi, sum = 0.0;

    step = 1.0/(double) num_steps;

    double t_start = omp_get_wtime();

    #pragma omp parallel
    {
        double x;
        int i;

        printf("omp_get_max_threads()=%d, id=%d\n", omp_get_max_threads(), id);

#pragma omp for reduction(+:sum)
        for (i = 0; i < num_steps; i++) {
            x = (i + 0.5) * step;
            sum = sum + 4.0 / (1.0 + x * x);
        }
    }

    pi = step * sum;

    printf("Time spent (id = %d): %f, pi = %f\n", id, omp_get_wtime() - t_start, pi);

}

void ex6()
{
 /*   double x, pi, sum = 0.0;

    step = 1.0/(double) num_steps;

    double t_start = omp_get_wtime();

    omp_set_schedule("dynamic", AUTO);

    #pragma omp parallel
    {
        double x;
        int i;

        #pragma omp for reduction(+:sum) schedule(runtime)
        for (i = 0; i < num_steps; i++) {
            x = (i + 0.5) * step;
            sum = sum + 4.0 / (1.0 + x * x);
        }
    }

    pi = step * sum;

    printf("Time spent: %f\n", omp_get_wtime() - t_start);
    printf("pi = %f\n", pi);
*/
}

// pragma omp parallel shared (A,B,C) private (id)
// pragma omp barrier - wait other threads to join
// pragma omp for
// pragma omp for nowait - do not wait other thread, do other job
// pragma omp master - only master thread do this block (it requires to put barrier in the end of the block)
// pragma omp single - any, only one thread will do the work in next block (it is work sharing construct, it implies that there is a barrier)
// pragma omp single nowait - also possible

// pragma omp parallel
// pragma omp sections - start of block with sections
// pragma omp section - start of single section

// pragma omp parallel
// omp_init_lock()
// opm_set_lock()
// opm_unset_lock()
// omp_destroy_lock()

// opm_set_num_threads()
// omp set_num_threads()
// omp get_thread_num()
// omp_get_max_threads() - I won't give you more than this

// omp_in_parallel() - Am I inside of parallel region
// omp_set_dynamic() - Set dynamic mode
// omp_get_dynamic() - Am I in dynamic mode?

// omp_num_proc() - get number of processors at runtime

void ex7()
{
    int num_threads;
    omp_set_dynamic(0);
    omp_set_num_threads(omp_get_num_procs());

    printf("omp_get_num_procs() = %d\n", omp_get_num_procs());
    printf("omp_get_max_threads()=%d\n", omp_get_max_threads());

#pragma omp parallel
    {
        int id=omp_get_thread_num();
#pragma omp single
        num_threads = omp_get_num_threads();
        ex5(id);
    }

}

// Environment variables
// OMP_NUM_THREADS
// OMP_STACKSIZE
// OMP_WAIT_POLICY (ACTIVE | PASSIVE) - spin actively and wait for job or sleep and suspend later
// OMP_PROC_BIND (TRU | FALSE) - bing thread to particular processor or not when creating
// OMP - Shared Memory Programming Model
// Global variables are shared among threads (File scope variables, static)
// Stack variables in functions, automatic variables withing statement block are PRIVATE

// Changing Storage Attribute
// SHARED, PRIVATE, FIRSTPRIVATE, LASTPRIVATE
// DEFAULT (PRIVATE | SHARED | NONE)
// NONE -I, as compiler, require that you explicitly define
// SHARED - what you have by default
// PRIVATE - is illigal for C, but FORTRAN

// #pragma omp parallel for firstprivate(tmp) - it will initialize tmp with its' value before creating private copy for each thread
// if you do just ... for private(tmp) tmp will be uninitialized and during last itteration it will take value of global tmp

// lastprivate(tmp) - for last itterration of whatever thread it does it copies tmp to global scope

int main()
{
   /* ex1();
    ex2();
    ex3();
    ex4();
    ex5();*/
    ex7();

}