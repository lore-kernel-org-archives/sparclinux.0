From: Jan Engelhardt <jengelh@medozas.de>
Date: Fri, 02 Jul 2010 19:29:28 +0000
Subject: Re: Checking for v9v/64v capability
Message-Id: <alpine.LSU.2.01.1007022126230.32678@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912220054220.25079@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912220054220.25079@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Friday 2010-07-02 21:20, David Miller wrote:
>
>> But is there a C-programmatical way that does not rely on external
>> files? /proc may not be mounted. auxv is usually not accessible,
>> and forking is a sin too. OpenSSL uses assembler tricks and traps
>> to determine if something has 4v or not, which leaves the realm of C.
>> But it looks like it's okay, given x86 programs also do asm/cpuid
>> to determine SSE availability.
>
>I would really prefer that people use the AUXV information.
>
>Right now this is what GLIBC uses to determine which optimized
>memset/memcpy/etc. routines to use.  And this is also the case
>when STT_GNU_IFUNC is used.

Sure, sure... the question here was: how does one _use_ auxv?
dlsym(NULL, "magic_auxv_array")? Or some glibc function?
glibc.info is completely silent on auxv.

crt0 calls main with envp as a bonus, but usually not auxv.

Are you saying libraries like openssl should rely on
dlopen("openssl-core.so") to pick the right one
out of /lib/<platform>? That may work, but only as long
as it's in the search path, does it not?


thanks,
Jan
