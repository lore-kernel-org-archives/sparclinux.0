From: Sunil Amitkumar Janki <devel.sjanki@gmail.com>
Date: Sun, 30 Sep 2007 23:44:42 +0000
Subject: SPARC64 2.6.23-rc8 binfmt_aout32 error
Message-Id: <470034EA.4060906@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

When I'm building 2.6.23-rc8 on SPARC64 (using a 64-bit CLFS
SVN tool chain consisting of GCC 4.2.1, Binutils 2.18 and Glibc
2.6.1) I get the following error:

>   CC      arch/sparc64/kernel/binfmt_aout32.o
> cc1: warnings being treated as errors
> arch/sparc64/kernel/binfmt_aout32.c: In function 'create_aout32_tables':
> arch/sparc64/kernel/binfmt_aout32.c:180: warning: cast from pointer to 
> integer of different size
> arch/sparc64/kernel/binfmt_aout32.c:180: warning: cast from pointer to 
> integer of different size
> arch/sparc64/kernel/binfmt_aout32.c:180: warning: cast from pointer to 
> integer of different size
> arch/sparc64/kernel/binfmt_aout32.c:180: warning: cast from pointer to 
> integer of different size
> arch/sparc64/kernel/binfmt_aout32.c:189: warning: cast from pointer to 
> integer of different size
> arch/sparc64/kernel/binfmt_aout32.c:189: warning: cast from pointer to 
> integer of different size
> arch/sparc64/kernel/binfmt_aout32.c:189: warning: cast from pointer to 
> integer of different size
> arch/sparc64/kernel/binfmt_aout32.c:189: warning: cast from pointer to 
> integer of different size
> make[1]: *** [arch/sparc64/kernel/binfmt_aout32.o] Error 1
> make: *** [arch/sparc64/kernel] Error 2

I don't know what the solution is (I don't know much about
kernel internals yet) but I hope this is enough to solve this
particular error. Otherwise I could also send my kernel config.

Sunil




