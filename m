From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 04 Jun 2020 09:38:38 +0000
Subject: Re: [PATCH] arch/{mips,sparc,microblaze,powerpc}: Don't enable pagefault/preempt twice
Message-Id: <784aacd2-663f-cc82-39be-c46fa6bafd6e@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200518184843.3029640-1-ira.weiny@intel.com>
 <20200519165422.GA5838@roeck-us.net>
 <20200519184031.GB3356843@iweiny-DESK2.sc.intel.com>
 <20200519194215.GA71941@roeck-us.net>
 <20200520051315.GA3660833@iweiny-DESK2.sc.intel.com>
 <d86dba19-4f4b-061e-a2c7-4f037e9e2de2@roeck-us.net>
 <20200521174250.GB176262@iweiny-DESK2.sc.intel.com>
 <20200603135736.e7b5ded0082a81ae6d9067a0@linux-foundation.org>
 <20200603211416.GA1740285@iweiny-DESK2.sc.intel.com>
 <3538c8ad-674e-d310-d870-4ef6888092ed@roeck-us.net>
 <20200604062226.GA1740345@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20200604062226.GA1740345@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ira Weiny <ira.weiny@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, Mike Rapoport <rppt@kernel.org>

On 6/3/20 11:22 PM, Ira Weiny wrote:
[ ... ]
> 
> s390: (does not compile)
> 
> <stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> In file included from ./arch/sparc/include/asm/bug.h:6:0,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/mmdebug.h:5,
>                  from ./include/linux/mm.h:9,
>                  from mm/huge_memory.c:8:
> mm/huge_memory.c: In function 'hugepage_init':
> ./include/linux/compiler.h:403:38: error: call to '__compiletime_assert_127' declared with attribute error: BUILD_BUG_ON failed: ((13 + (13-3))-13) >= 9
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                       ^
> ./include/linux/compiler.h:384:4: note: in definition of macro '__compiletime_assert'
>     prefix ## suffix();    \
>     ^~~~~~
> ./include/linux/compiler.h:403:2: note: in expansion of macro '_compiletime_assert'
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>   ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                      ^~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>   BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>   ^~~~~~~~~~~~~~~~
> ./include/linux/bug.h:24:4: note: in expansion of macro 'BUILD_BUG_ON'
>     BUILD_BUG_ON(cond);             \
>     ^~~~~~~~~~~~
> mm/huge_memory.c:403:2: note: in expansion of macro 'MAYBE_BUILD_BUG_ON'
>   MAYBE_BUILD_BUG_ON(HPAGE_PMD_ORDER >= MAX_ORDER);
>   ^~~~~~~~~~~~~~~~~~
> make[1]: *** [scripts/Makefile.build:267: mm/huge_memory.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1735: mm] Error 2
> make: *** Waiting for unfinished jobs....
> ------------
> 
> 
> The s390 error is the same on Linus' master and linux-next.  So whatever is
> causing that has slipped into mainline and/or is something I've broken in the
> test scripts.
> 

Compiler version related. gcc version 8.x and later no longer work.
Bisect points to commit a148866489f ("sched: Replace rq::wake_list").
Oddly enough x86 images are broken as well. You'll have to use an
older version of gcc (or presumably clang) until this is fixed.

Guenter
