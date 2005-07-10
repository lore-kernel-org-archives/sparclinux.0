From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 10 Jul 2005 20:06:11 +0000
Subject: sparc32 build failures with gcc-4.0
Message-Id: <Pine.LNX.4.61.0507101557330.3678@bobcat>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I've started testing sparc kernels builds with gcc-4.0. While sparc64 
appears to be fine, sparc32 build fails (tested 2.6.12 and the current 
Linus' git tree) with following messages:

   CC      arch/sparc/kernel/sparc_ksyms.o
arch/sparc/kernel/sparc_ksyms.c:104: error: 'div' aliased to undefined symbol '.div'
arch/sparc/kernel/sparc_ksyms.c:105: error: 'mul' aliased to undefined symbol '.mul'
arch/sparc/kernel/sparc_ksyms.c:106: error: 'rem' aliased to undefined symbol '.rem'
arch/sparc/kernel/sparc_ksyms.c:107: error: 'udiv' aliased to undefined symbol '.udiv'
arch/sparc/kernel/sparc_ksyms.c:108: error: 'umul' aliased to undefined symbol '.umul'
arch/sparc/kernel/sparc_ksyms.c:109: error: 'urem' aliased to undefined symbol '.urem'
make[2]: *** [arch/sparc/kernel/sparc_ksyms.o] Error 1
make[1]: *** [arch/sparc/kernel] Error 2
make[1]: Leaving directory `/home/jurij/linus-git'
make: *** [stamp-build] Error 2

Offending fragment of sparc_ksyms.c is

/* Alias functions whose names begin with "." and export the aliases.
  * The module references will be fixed up by module_frob_arch_sections.
  */
#define DOT_ALIAS2(__ret, __x, __arg1, __arg2) \
         extern __ret __x(__arg1, __arg2) \
                      __attribute__((weak, alias("." # __x)));

DOT_ALIAS2(int, div, int, int)
DOT_ALIAS2(int, mul, int, int)
DOT_ALIAS2(int, rem, int, int)
DOT_ALIAS2(unsigned, udiv, unsigned, unsigned)
DOT_ALIAS2(unsigned, umul, unsigned, unsigned)
DOT_ALIAS2(unsigned, urem, unsigned, unsigned)

It looks like the aliasing is required supply the correct div/mul/rem 
stuff depending on subarchitecture, so fixing this might be a bit hairy... 
Is anyone working or plans to work on this problem? I might give it a 
shot, but I would definitely need some guidance.

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
