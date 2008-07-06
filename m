From: David Miller <davem@davemloft.net>
Date: Sun, 06 Jul 2008 01:56:23 +0000
Subject: Re: [GIT PULL] unify sparc header files
Message-Id: <20080705.185623.241901905.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080628220235.GA3169@uranus.ravnborg.org>
In-Reply-To: <20080628220235.GA3169@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 6 Jul 2008 01:03:48 +0200

> Hmm, I was fooled by something else. My sparc64 gcc does NOT
> define the sparc64 symbol.

And it should not :-)

> I defines:
> __sparc_v9__
> and
> __arch64__
> 
> to say this is sparc64.
> 
> So I really need the output of:
> touch foo.c; cpp -dM foo.c
> 
> to select the right combination of options before I can
> proceed.

As I stated from the beginning, the correct test is
"__sparc__ && __arch64__" which is what you are using.

Of course, you want me to provide "cpp -m64..." not just "cpp" output.
Because otherwise it will produce a list of 32-bit CPP predefines.  As
you can see in the sparc64 Makefiles we add "-m64" to the CFLAGS.

Maybe that's the problem?  Normal CFLAGS are not being propagated to
the CPP's CFLAGS.  And you guys don't see it because you are using
cross compilers which default to 64-bit output.  That would explain
everything.

davem@sunset:~/src/GIT/net-2.6$ cpp -m64 -dM foo.c
#define __DBL_MIN_EXP__ (-1021)
#define __FLT_MIN__ 1.17549435e-38F
#define __CHAR_BIT__ 8
#define __WCHAR_MAX__ 2147483647
#define __DBL_DENORM_MIN__ 4.9406564584124654e-324
#define __FLT_EVAL_METHOD__ 0
#define __DBL_MIN_10_EXP__ (-307)
#define __FINITE_MATH_ONLY__ 0
#define __GNUC_PATCHLEVEL__ 3
#define sparc 1
#define __SHRT_MAX__ 32767
#define __LDBL_MAX__ 1.18973149535723176508575932662800702e+4932L
#define __UINTMAX_TYPE__ long unsigned int
#define __linux 1
#define __unix 1
#define __LDBL_MAX_EXP__ 16384
#define __linux__ 1
#define __SCHAR_MAX__ 127
#define __USER_LABEL_PREFIX__ 
#define __STDC_HOSTED__ 1
#define __LDBL_HAS_INFINITY__ 1
#define __DBL_DIG__ 15
#define __FLT_EPSILON__ 1.19209290e-7F
#define __LDBL_MIN__ 3.36210314311209350626267781732175260e-4932L
#define __unix__ 1
#define __DECIMAL_DIG__ 36
#define __gnu_linux__ 1
#define __LDBL_HAS_QUIET_NAN__ 1
#define __GNUC__ 4
#define __DBL_MAX__ 1.7976931348623157e+308
#define __DBL_HAS_INFINITY__ 1
#define __DBL_MAX_EXP__ 1024
#define __LONG_LONG_MAX__ 9223372036854775807LL
#define __sparc__ 1
#define __GXX_ABI_VERSION 1002
#define __FLT_MIN_EXP__ (-125)
#define __DBL_MIN__ 2.2250738585072014e-308
#define __LP64__ 1
#define __DBL_HAS_QUIET_NAN__ 1
#define __REGISTER_PREFIX__ 
#define __NO_INLINE__ 1
#define __FLT_MANT_DIG__ 24
#define __VERSION__ "4.1.3 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)"
#define __sparc 1
#define unix 1
#define __SIZE_TYPE__ long unsigned int
#define __ELF__ 1
#define __FLT_RADIX__ 2
#define __LDBL_EPSILON__ 1.92592994438723585305597794258492732e-34L
#define __LDBL_DIG__ 33
#define __FLT_HAS_QUIET_NAN__ 1
#define __FLT_MAX_10_EXP__ 38
#define __LONG_MAX__ 9223372036854775807L
#define __FLT_HAS_INFINITY__ 1
#define linux 1
#define __LDBL_MANT_DIG__ 113
#define _LONGLONG 1
#define __WCHAR_TYPE__ int
#define __FLT_DIG__ 6
#define __INT_MAX__ 2147483647
#define __FLT_MAX_EXP__ 128
#define __DBL_MANT_DIG__ 53
#define __WINT_TYPE__ unsigned int
#define __LDBL_MIN_EXP__ (-16381)
#define __LDBL_MAX_10_EXP__ 4932
#define __DBL_EPSILON__ 2.2204460492503131e-16
#define _LP64 1
#define __INTMAX_MAX__ 9223372036854775807L
#define __FLT_DENORM_MIN__ 1.40129846e-45F
#define __FLT_MAX__ 3.40282347e+38F
#define __FLT_MIN_10_EXP__ (-37)
#define __INTMAX_TYPE__ long int
#define __GNUC_MINOR__ 1
#define __DBL_MAX_10_EXP__ 308
#define __LDBL_DENORM_MIN__ 6.47517511943802511092443895822764655e-4966L
#define __STDC__ 1
#define __PTRDIFF_TYPE__ long int
#define __arch64__ 1
#define __LDBL_MIN_10_EXP__ (-4931)
#define __GNUC_GNU_INLINE__ 1
davem@sunset:~/src/GIT/net-2.6$ 
