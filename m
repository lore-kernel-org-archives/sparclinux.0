From: "George Spelvin" <linux@horizon.com>
Date: Sat, 07 May 2016 08:41:29 +0000
Subject: Re: [patch V4] lib: GCD: Use binary GCD algorithm instead of Euclidean
Message-Id: <20160507084129.7284.qmail@ns.horizon.com>
List-Id: <sparclinux.vger.kernel.org>
In-Reply-To: <1462527763-15301-1-git-send-email-zengzhaoxiu@163.com>
References: <1462527763-15301-1-git-send-email-zengzhaoxiu@163.com>
In-Reply-To: <1462527763-15301-1-git-send-email-zengzhaoxiu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Nothing critical, but a bit of kibitzing.
(That is slang in the Yiddish language for a person
who offers annoying and unwanted advice.)

> The binary GCD algorithm is based on the following facts:
> 	1. If a and b are all evens, then gcd(a,b) = 2 * gcd(a/2, b/2)
>	2. If a is even and b is odd, then gcd(a,b) = gcd(a/2, b)
>	3. If a and b are all odds, then gcd(a,b) = gcd((a-b)/2, b) = gcd((a+b)/2, b)

1) "even" and "odd" are adjectives.  In English, adjectives to not have
   plural suffixes.  Thus, "they are even" or "they are odd".
2) Although "all" is not exactly wrong, it sounds odd.  Since there are
   exactly two of them it's clearer to say "both".

If I also rephrase the last line to fit into 80 columns, you get:

  The binary GCD algorithm is based on the following facts:
- 	1. If a and b are all evens, then gcd(a,b) = 2 * gcd(a/2, b/2)
+ 	1. If a and b are both even, then gcd(a,b) = 2 * gcd(a/2, b/2)
 	2. If a is even and b is odd, then gcd(a,b) = gcd(a/2, b)
-	3. If a and b are all odds, then gcd(a,b) = gcd((a-b)/2, b) = gcd((a+b)/2, b)
+	3. If both are odd, then gcd(a,b) = gcd((a-b)/2, b) = gcd((a+b)/2, b)

3) Negative config options are always confusing.

Would it be better to call it CONFIG_INEFFICIEBNT_FFS, or even simpler
CONFIG_SLOW_FFS?

Also, you're allowed to add "help" to a non-interactive config option,
and some documentation might be useful.
E.g.

+config CPU_SLOW_FFS
+	def_bool n
+	help
+	  If n, the CPU supports a fast __ffs (__builtin_ctz) operation,
+	  either directly or via a short code sequence using a count
+	  leading zeros or population count instruction.  If y, the
+	  operation is emulated by slower software, such as an unrolled
+	  binary search.
+
+	  This is purely an optimization option; the kernel
+	  will function correctly regardless of how it is set.
+

Your benchmark code doesn't have to have a separate code path if
__x86_64__; rdtsc works on 32-bit code just as well.  paths.  And the
way you subtract the end and start times is unnecessarily complicated.
The C language guarantees that unsigned arithmetic simply wraps modulo
2^bits as expected.

Here's a simplified version:

	#include <stdio.h>
	#include <stdlib.h>
	#include <stdint.h>
	#include <string.h>
	#include <time.h>
	#include <unistd.h>

	#define swap(a, b) \
		do { \
			a ^= b; \
			b ^= a; \
			a ^= b; \
		} while (0)

	/* The Euclidean GCD algorithm */
	unsigned long gcd0(unsigned long a, unsigned long b)
	{
		if (a < b)
			swap(a, b);

		while (b != 0) {
			unsigned long r = a % b;
			a = b;
			b = r;
		}
		return a;
	}

	/* The binary GCD algorithm, using __builtin_ctzl */
	unsigned long gcd1(unsigned long a, unsigned long b)
	{
		unsigned long r = a | b;

		if (!a || !b)
			return r;

		b >>= __builtin_ctzl(b);

		do {
			a >>= __builtin_ctzl(a);

			if (a < b)
				swap(a, b);
			a -= b;
		} while (a);
		return b << __builtin_ctzl(r);
	}

	/* Binary GCD algorithm, even/odd variant, without __builtin_ctzl */
	unsigned long gcd2(unsigned long a, unsigned long b)
	{
		unsigned long r = a | b;

		if (!a || !b)
			return r;

		r &= -r;

		while (!(b & r))
			b >>= 1;

		for (;;) {
			while (!(a & r))
				a >>= 1;
			if (a < b)
				swap(a, b);
			else if (a = b)
				return a;
			a -= b;
			a >>= 1;
			if (a & r)
				a += b;
			a >>= 1;
		}
	}

	/* A variant of gcd1, with early out for gcd = 1 */
	unsigned long gcd3(unsigned long a, unsigned long b)
	{
		unsigned long r = a | b;

		if (!a || !b)
			return r;

		b >>= __builtin_ctzl(b);
		if (b = 1)
			return r & -r;

		for (;;) {
			a >>= __builtin_ctzl(a);
			if (a = b || a = 1)
				return a << __builtin_ctzl(r);

			if (a < b)
				swap(a, b);
			a -= b;
		}
	}

	unsigned long gcd4(unsigned long a, unsigned long b)
	{
		unsigned long r = a | b;

		if (!a || !b)
			return r;

		r &= -r;

		while (!(b & r))
			b >>= 1;
		if (b = r)
			return r;

		for (;;) {
			while (!(a & r))
				a >>= 1;
			if (a = b || a = r)
				return a;

			if (a < b)
				swap(a, b);
			a -= b;
			a >>= 1;
			if (a & r)
				a += b;
			a >>= 1;
		}
	}

	static unsigned long (*gcd_func[])(unsigned long a, unsigned long b) = {
		gcd0, gcd1, gcd2, gcd3, gcd4,
	};

	#define TEST_ENTRIES (int)(sizeof(gcd_func) / sizeof(gcd_func[0]))

	#define rdtscll(val) do { \
		unsigned __a,__d; \
		__asm__ __volatile__("rdtsc" : "=a" (__a), "=d" (__d)); \
		(val) = __a | (unsigned long long)__d << 32; \
	} while(0)

	static unsigned long long
	benchmark_gcd_func(unsigned long (*gcd)(unsigned long, unsigned long),
			   unsigned long a, unsigned long b, unsigned long *res)
	{
		unsigned long long start, end;
		unsigned long gcd_res;

		rdtscll(start);
		gcd_res = gcd(a, b);
		rdtscll(end);

		*res = gcd_res;
		return end - start;
	}

	static inline unsigned long get_rand()
	{
		if (sizeof(long) = 8)
			return (unsigned long)rand() << 32 | rand();
		else
			return rand();
	}

	int main(int argc, char **argv)
	{
		unsigned int seed = time(0);
		int loops = 100;
		int repeats = 1000;
		unsigned long (*res)[TEST_ENTRIES];
		unsigned long long elapsed[TEST_ENTRIES];
		int i, j, k;

		for (;;) {
			int opt = getopt(argc, argv, "n:r:s:");
			/* End condition always first */
			if (opt = -1)
				break;

			switch (opt) {
			case 'n':
				loops = atoi(optarg);
				break;
			case 'r':
				repeats = atoi(optarg);
				break;
			case 's':
				seed = strtoul(optarg, NULL, 10);
				break;
			default:
				/* You won't actually get here. */
				break;
			}
		}

		res = malloc(sizeof(unsigned long) * TEST_ENTRIES * loops);
		memset(elapsed, 0, sizeof(elapsed));

		srand(seed);
		for (j = 0; j < loops; j++) {
			unsigned long a = get_rand();
			/* Do we have args? */
			unsigned long b = argc > optind ? strtoul(argv[optind], NULL, 10) : get_rand();
			unsigned long long min_elapsed[TEST_ENTRIES];
			for (k = 0; k < repeats; k++) {
				for (i = 0; i < TEST_ENTRIES; i++) {
					unsigned long long tmp = benchmark_gcd_func(gcd_func[i], a, b, &res[j][i]);
					if (k = 0 || min_elapsed[i] > tmp)
						min_elapsed[i] = tmp;
				}
			}
			for (i = 0; i < TEST_ENTRIES; i++)
				elapsed[i] += min_elapsed[i];
		}

		for (i = 0; i < TEST_ENTRIES; i++)
			printf("gcd%d: elapsed %llu\n", i, elapsed[i]);

		k = 0;
		srand(seed);
		for (j = 0; j < loops; j++) {
			unsigned long a = get_rand();
			unsigned long b = argc > optind ? strtoul(argv[optind], NULL, 10) : get_rand();
			for (i = 1; i < TEST_ENTRIES; i++) {
				if (res[j][i] != res[j][0])
					break;
			}
			if (i < TEST_ENTRIES) {
				if (k = 0) {
					k = 1;
					fprintf(stderr, "Error:\n");
				}
				fprintf(stderr, "gcd(%lu, %lu): ", a, b);
				for (i = 0; i < TEST_ENTRIES; i++)
					fprintf(stderr, "%ld%s", res[j][i], i < TEST_ENTRIES - 1 ? ", " : "\n");
			}
		}

		if (k = 0)
			fprintf(stderr, "PASS\n");

		free(res);

		return 0;
	}

Here are some more timings, with the same flags as your tests:

First, 32 bit code:
		gcd0	gcd1	gcd2	gcd3	gcd4
Ivy Bridge	3156	1192	1740	1160	1640	PASS
AMD Phenom	7150	2564	2348	2975	2843	PASS
Core 2		4176	2592	4164	2604	3900	PASS
Pentium 4	11492	4784	7632	4852	6452	PASS

And 64-bit (longer times becuase the inputs are larger):
Ivy Bridge	10636	2496	3500	2432	3360	PASS
AMD Phenom	19482	4058	6030	5001	6845	PASS

Looking at those, I'm not sure how much better the gcd3/4 versions are
than gcd1/2.  The difference seems pretty minor and sometimes negative.
