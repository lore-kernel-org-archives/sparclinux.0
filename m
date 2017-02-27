From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 27 Feb 2017 16:43:51 +0000
Subject: Re: [PATCH 0/3] tsb expansion for sun4v
Message-Id: <58B45747.9070707@oracle.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000804070602080101050306"
List-Id: <sparclinux.vger.kernel.org>
References: <20170201123823.6273-1-bob.picco@oracle.com>
In-Reply-To: <20170201123823.6273-1-bob.picco@oracle.com>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------000804070602080101050306
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

Hello, David.

On 02/23/2017 07:09 PM, David Miller wrote:
> From: Bob Picco <bob.picco@oracle.com>
> Date: Wed,  1 Feb 2017 07:38:20 -0500
> 
>> The program was built as:
>>
>> gcc -Wall -m64 -o test_with_mmap test_with_mmap.c -lrt -lm
> 
> Anything meauring performance should be built with optimizations
> enabled, at least -O2.

The test program was used mainly to show that the patches actually
increase the TSB size. We were not interested in absolute values
reported by the program, our interest was in the relative growth of the
numbers. Therefore, we did not use optimization options.

For example, if we look at Bob's cover letter at scenario
"1. T7-2 LDOM. 4 vCPU, 32GB RAM", we will see these numbers:

+-----------+--------+--------+--------+
|region_size|no patch| patch  | S11.3  |
+-----------+--------+--------+--------+
...
+-----------+--------+--------+--------+
|512m       | 1741.04| 1736.21| 1840.40|
+-----------+--------+--------+--------+
|576m       |10885.34| 1958.27| 2068.41|
+-----------+--------+--------+--------+
|640m       |20029.18| 2185.42| 2321.79|
+-----------+--------+--------+--------+
...

In theory, the potential TSB size to effectively hold a region > 512m
should be > 1m. So for the not patched kernel we should expect a
relative performance drop when working (page touching) with areas >
512m. The above numbers illustrate it, i.e. numbers grow linearly up to
512m, but once we step over 512m we observe a very significant
(exponential) increase of numbers.

As for the patched kernel and S11.3. Their TSBs are greater, so their
numbers increase almost linearly.

> 
> Also, this test program, if you're giving so much detailed information
> on how to use it and run it and what it's results mean, absolutely must
> be included in this series somehow.
> 
> We have a testing subdirectory, place it there and add it to the test
> build Makefile rules.  tools/testing/selftests/  You can create a
> sparc subdirectory there.
> 


test_with_mmap.c is not a self contained test. It requires know machines
conditions and significant effort on the testers part before drawing a
conclusion. It's just a tool we used for our experiment, and it's not
like other kernel tests in tools/testing/selftest. I don't think that
anyone may get a benefit if we put it there.

In an attempt to support this position and share the code I'm attaching
the *.c file and the README files to this message. Could you, please,
have a look at them? And having said above, will it work if we leave the
test program's source in the mailing list?

Thank you.

--------------000804070602080101050306
Content-Type: text/x-chdr;
 name="test_with_mmap.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="test_with_mmap.c"

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <time.h>
#include <unistd.h>
#include <math.h>

#define VERSION_NUM 8
#define NUM_RW_ITERS 5
#define NUM_TESTS (3 + 2*NUM_RW_ITERS)

static long get_time_nsec(void);
static int memory_fill(char *addr, size_t size, size_t blk_size, long pattern);
static int verify_memory_data(char *addr, size_t size, size_t blk_size,
			      long pattern);

static int parse_optarg(char *optarg, unsigned long *value);
static void help(char *options);

int main(int argc, char *argv[])
{
	unsigned long region_size = 0;
	unsigned long blk_size = 0;
	unsigned long num_iters = 0;
	unsigned long iter;
	int opt;
	double **time;
	double *mean, *cv;
	double mean_prev;
	char *addr;
	long s, e;
	int i, rc;
	long val;
	int mmap_flags;
#ifdef linux
	char valid_options[] = "i:b:r:h";
	int use_huge_pages = 0;
#else
	char valid_options[] = "i:b:r:p:";
	struct memcntl_mha mcmd;
	unsigned long page_size = 0;
#endif

	while ((opt = getopt(argc, argv, valid_options)) != -1) {
		switch (opt) {
		case 'i':
			if (parse_optarg(optarg, &num_iters)) {
				printf("-i: invalid format\n");
				return 1;
			}
			break;
		case 'b':
			if (parse_optarg(optarg, &blk_size)) {
				printf("-b: invalid format\n");
				return 1;
			}
			break;
		case 'r':
			if (parse_optarg(optarg, &region_size)) {
				printf("-r: invalid format\n");
				return 1;
			}
			break;
#ifdef linux
		case 'h':
			use_huge_pages = 1;
			break;
#else
		case 'p':
			if (parse_optarg(optarg, &page_size)) {
				printf("-p: invalid format\n");
				return 1;
			}
			break;
#endif
		}
	}

	if (!num_iters || !blk_size || !region_size) {
		printf("Please, specify the number of iterations, region size, block size\n");
		help(valid_options);
		return 1;
	}

#ifndef linux
	if (!page_size) {
		printf("Please, specify the page size\n");
		help(valid_options);
		return 1;
	}
#endif

	printf("region - %0.1f(GB), block size - %ld bytes, number of iterations - %ld\n",
	       (double)(region_size)/(1024 * 1024 * 1024), blk_size, num_iters);

	time = malloc(sizeof(double *) * NUM_TESTS);
	if (time == NULL) {
		perror("malloc");
		return 1;
	}

	for (i = 0; i < NUM_TESTS; i++) {
		time[i] = malloc(sizeof(double) * num_iters);
		if (time[i] == NULL) {
			perror("malloc(time)");
			return 1;
		}
	}

	mean = calloc(NUM_TESTS, sizeof(double));
	if (mean == NULL) {
		perror("calloc(mean)");
		return 1;
	}

	cv = calloc(NUM_TESTS, sizeof(double));
	if (cv == NULL) {
		perror("calloc(cv)");
		return 1;
	}

#ifdef linux
	mmap_flags = MAP_ANONYMOUS | MAP_SHARED;
	if (use_huge_pages) {
		printf("The region will be allocated using Huge Pages\n");
		mmap_flags |= MAP_HUGETLB;
	}
#else
	mmap_flags = MAP_ANON | MAP_SHARED;
	printf("The region will be allocated using %ld-byte pages\n",
		page_size);
#endif

	for (iter = 0; iter < num_iters; iter++) {
		s = get_time_nsec();
		addr = mmap(NULL, region_size, PROT_READ | PROT_WRITE,
			    mmap_flags, -1, 0);
		e = get_time_nsec();
		if (addr == MAP_FAILED) {
			perror("mmap");
			return 1;
		}
		time[0][iter] = (e - s) / 1000.0;

#ifdef linux
		time[1][iter] = 0;
#else
		mcmd.mha_cmd = MHA_MAPSIZE_VA;
		mcmd.mha_flags = 0;
		mcmd.mha_pagesize = page_size;

		s = get_time_nsec();
		rc = memcntl(addr, region_size, MC_HAT_ADVISE,
			     (caddr_t)&mcmd, 0, 0);
		e = get_time_nsec();
		if (rc) {
			perror("memcntl");
			return 1;
		}
		time[1][iter] = (e - s) / 1000.0;
#endif

		for (i = 0; i < NUM_RW_ITERS; i++) {
			val = 0x123456789abcdef0 + i;

			s = get_time_nsec();
			memory_fill(addr, region_size, blk_size, val);
			e = get_time_nsec();
			time[2*i + 2][iter] = (e - s) / 1000.0;

			s = get_time_nsec();
			rc = verify_memory_data(addr, region_size,
						blk_size, val);
			e = get_time_nsec();
			if (rc)
				return 1;
			time[2*i + 3][iter] = (e - s) / 1000.0;
		}

		s = get_time_nsec();
		rc = munmap(addr, region_size);
		e = get_time_nsec();
		if (rc) {
			perror("munmap");
			return 1;
		}
		time[NUM_TESTS - 1][iter] = (e - s) / 1000.0;
	}

	/*
	 * Calculating the mean using recurrence formula:
	 * M_k = M_k-1 + (x_k - M_k-1) / k
	 * and variance:
	 * V_k = V_k-1 + (x_k - M_k-1)*(x_k - M_k)
	 * sigma_k^2 = V_k/(k - 1) for k > 1
	 *
	 * CV = sigma / mean
	 */
	for (i = 0; i < NUM_TESTS; i++) {
		mean[i] = time[i][0];
		cv[i] = 0;

		for (iter = 1; iter < num_iters; iter++) {
			mean_prev = mean[i];
			mean[i] = mean[i] + (time[i][iter] - mean[i])/(iter + 1);

			cv[i] = cv[i] + (time[i][iter] - mean_prev)*(time[i][iter] - mean[i]);
		}

		if (num_iters >= 2) {
			cv[i] = sqrt(cv[i]/(num_iters - 1));
			cv[i] /= mean[i] / 100.0;
		}
	}

	printf("%8s%20s%20s\n", "test", "mean (us)", "cv (%)");
	printf("mmap    %20.2f%20.2f\n", mean[0], cv[0]);
	printf("memcntl %20.2f%20.2f\n", mean[1], cv[1]);
	for (i = 0; i < NUM_RW_ITERS; i++) {
		printf("write_%d %20.2f%20.2f\n",
		       i, mean[2*i + 2], cv[2*i + 2]);
		printf("read_%d  %20.2f%20.2f\n",
		       i, mean[2*i + 3], cv[2*i + 3]);
	}
	printf("munmap  %20.2f%20.2f\n",
	       mean[NUM_TESTS - 1], cv[NUM_TESTS - 1]);

	return 0;
}

static void help(char *options)
{
	while (*options) {
		switch (*options) {
		case 'i':
			printf("-i Number of iterations\n");
			break;
		case 'b':
			printf("-b <block size>[kmg]\n");
			break;
		case 'r':
			printf("-r <region size>[kmg]\n");
			break;
		case 'h':
			printf("-h Allocate the region using Huge Pages\n");
			break;
		case 'p':
			printf("-p <page size>[kmg] Page size used for allocating the region\n");
			break;
		}

		options++;
	}
}

static int parse_optarg(char *optarg, unsigned long *value)
{
	char *s, *e;
	int base;
	int ret = -1;

	s = strstr(optarg, "0x");
	if (s != NULL) {
		base = 16;
		s += 2;
	} else {
		base = 10;
		s = optarg;
	}

	errno = 0;
	*value = strtoul(s, &e, base);

	/* conversion error */
	if (errno)
		goto out;

	/* no conversion at all */
	if (s == e)
		goto out;

	if (strlen(e) == 0) {
		ret = 0;
		goto out;
	}

	/*
	 * we allow only one character at the end,
	 * which is expected to be a multiplier
	 */

	if (strlen(e) > 1)
		goto out;

	switch (*e) {
	case 'g':
	case 'G':
		*value *= 1024 * 1024 * 1024UL;
		break;
	case 'm':
	case 'M':
		*value *= 1024 * 1024UL;
		break;
	case 'k':
	case 'K':
		*value *= 1024UL;
		break;
	default:
		/* invalid modifier */
		ret = 1;
		goto out;
	}

	ret = 0;
out:
	return ret;
}


static long get_time_nsec(void)
{
	struct timespec time;
	int errsv = errno;

	clock_gettime(CLOCK_MONOTONIC, &time);

	errno = errsv;
	return (time.tv_sec * 1e9 + time.tv_nsec);
}

static int memory_fill(char *addr, size_t size, size_t blk_size, long pattern)
{
	long i;

	for (i = 0; i < (size / blk_size); i++) {
		*((long *)addr) = pattern;
		addr += blk_size;
	}

	return 0;
}

static int verify_memory_data(char *addr, size_t size, size_t blk_size,
			      long pattern)
{
	long i;

	for (i = 0; i < (size / blk_size); i++) {
		if ((*(long *)addr) != pattern) {
			printf("verify_memory_data: DATA ERROR at addr = %p data = %lx, "
			       "expected data = %lx\n", addr, *((long *)addr), pattern);
			return -1;
		}
		addr += blk_size;
	}

	return 0;
}

--------------000804070602080101050306
Content-Type: text/plain; charset=UTF-8;
 name="README"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="README"

This is a test case for bug:

BUG 20510832 - TEST_WITH_MMAP: LOW READ/WRITE PERFORMANCE IF COMPARE TO SOLARIS

It works this way:
1) Allocates a memory region using mmap(MAP_ANONYMOUS)
2) Tries to write/read to this region using a specified block size
3) Deallocates this region using munmap()
4) Measures the time required for each of the above steps

The initial idea is to use this test case to verify whether the TSB size
on Linux is less than on Solaris. To check that you need to run:

on Linux:

./test_with_mmap -i 10 -r 16g -b 8k

on Solaris:

./test_with_mmap -i 10 -r 16g -b 8k -p 8k

and compare the results. They should be more-or-less the same.

We may also use this test case to track regressions between kernel versions.

On Linux, by default, the default page size is used for allocating the region.
However, you may allocate it with Huge Pages (-h). On Solaris the page size
for the region is selected by (-p).


--------------000804070602080101050306--
