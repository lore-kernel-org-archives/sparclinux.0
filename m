From: Jan Engelhardt <jengelh@medozas.de>
Date: Tue, 22 Dec 2009 14:38:44 +0000
Subject: Re: fstat seems broken on sparc64
Message-Id: <alpine.LSU.2.01.0912221512520.26016@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912132357090.19051@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912132357090.19051@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


David Miller wrote:
>David Miller wrote:
>>Jan Engelhardt wrote:
>>
>>> It is because arch/sparc/include/stat.h does not define STAT_HAVE_NSEC 
>>> for 64-bit sparc, even though there's nsec in struct stat64.
>>> That leads to fs/stat.c not copying the subsecond parts to userspace (in 
>>> function cp_new_stat).
>>
>>cp_new_stat() handles "struct stat", not "struct stat64"
>>
>>cp_new_stat64() does that, and it unconditionally fills in
>>the nsec parts.
>
>BTW, did you ever resolve the 64-bit stat() issue?  Was it
>a bum build of Fedora's sparc64 glibc?

Seems Debian's glibc is also affected:

$ LD_LIBRARY_PATH=/dev/shm/d/lib64
  /dev/shm/d/lib64/ld-linux.so.2 ./stat64
1260745109.0

$ LD_LIBRARY_PATH=/dev/shm/d/lib64 /dev/shm/d/lib64/libc.so.6 

GNU C Library stable release version 2.7, by Roland McGrath et al.
Copyright (C) 2007 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
Compiled by GNU CC version 4.3.2.
Compiled on a Linux >>2.6.28.10<< system on 2009-10-20.
Available extensions:
        crypt add-on version 2.1 by Michael Glad and others
        GNU Libidn by Simon Josefsson
        Native POSIX Threads Library by Ulrich Drepper et al
        BIND-8.2.3-T5B
        software FPU emulation by Richard Henderson, Jakub Jelinek and others
For bug reporting instructions, please see:
<http://www.gnu.org/software/libc/bugs.html>.

Same for eglibc 2.10:

$ LD_LIBRARY_PATH=/dev/shm/d10/lib64 /dev/shm/d10/lib64/ld-linux.so.2 ./stat64
1260745109.0

$ LD_LIBRARY_PATH=/dev/shm/d10/lib64 /dev/shm/d10/lib64/libc.so.6

GNU C Library (EGLIBC) stable release version 2.10.2, by Roland McGrath et al.
Copyright (C) 2009 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
Compiled by GNU CC version 4.4.2.
Compiled on a Linux >>2.6.26-2-sparc64-smp<< system on 2009-11-24.
Available extensions:
        crypt add-on version 2.1 by Michael Glad and others
        GNU Libidn by Simon Josefsson
        Native POSIX Threads Library by Ulrich Drepper et al
        BIND-8.2.3-T5B
        software FPU emulation by Richard Henderson, Jakub Jelinek and others
For bug reporting instructions, please see:
<http://www.eglibc.org/issues/>.


>   Also, why are you
>building 64-bit binaries?  Just for testing?

Same reason koji builds sparc64... or:

Assume there's a scientific program needing >4GB address space, so I
need at least _a little_ 64-bit. It just so happens that I defaulted
to populate the buildroot with a 64-bit base, as using a 32-bit base
would have meant ugly changes to the build script I am using --
coexistence of, say, libacl-64bit (dependency of sci prog) and
libacl-32bit (dependency of a 32-bit coreutils).

Well yes, call it testing. Apparently, I found a bug.
So mission accomplished :-)
