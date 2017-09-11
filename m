From: Nick Alcock <nick.alcock@oracle.com>
Date: Mon, 11 Sep 2017 14:34:47 +0000
Subject: Re: [PATCH V3] vDSO for SPARC
Message-Id: <8760cp2tiw.fsf@esperi.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1502400887-281290-1-git-send-email-nagarathnam.muthusamy@oracle.com>
In-Reply-To: <1502400887-281290-1-git-send-email-nagarathnam.muthusamy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Thank you very much for this!

On 10 Sep 2017, David Miller verbalised:

> From: David Miller <davem@davemloft.net>
> Date: Mon, 14 Aug 2017 22:35:53 -0700 (PDT)
>
>> From: Nick Alcock <nick.alcock@oracle.com>
>> Date: Fri, 11 Aug 2017 13:23:26 +0100
>> 
>>> unless you have a really serious linker bug,
>> 
>> Open your mind a little bit.
>
> Looking at the actual details, how did this ever work for anyone?

Probably chance. It did seem to work, though.

> The arch/sparc/vdso/vdso.lds file says:
>
> vvar_start = . -(1 << 12);
>
> And "1 << 12" is 4096, therefore a multiple of 4096 and not 8192.

Uh. Yeah. How the heck did I miss that? 50% chance it'll end up
correctly aligned *anyway*, of course, and I must have been lucky.

Blasted machine-variable page sizes. (You can tell this was derived from
the x86 code :/ )

> So, as requested, the object built gets:
>
> davem@patience:~/src/GIT/sparc-next$ nm -n arch/sparc/vdso/vdso64.so.dbg
> fffffffffffff000 a vvar_data
> fffffffffffff000 a vvar_start
>
> So why is vdso2c requiring an 8192 byte aligned value for the address
> of 'vvar_start'?

Because it has to be page-aligned. It's just, uh, the wrong alignment
for this architecture. Mea culpa.

> Nick, I will be honest and sat that I'm kinda irritated that I had to
> track this down and the best you could come up with was blaming the
> linker...  :-(

It's been two years since I looked at that code, and when Nagarathnam
sent his email I was at the wrong end of a high-latency satellite link
on holiday and then knee-deep in other time-critical stuff, I'm afraid.
I entirely forgot this thread was still alive.

On 11 Sep 2017, David Miller said:

> Breaking this down further, the linker scripts are written assuming
> they will be built by a host compiler that generates 64-bit target
> code by default.
>
> This is not a safe assumption.

One presumes it's not safe on x86-64 either, then.

> My system generates 32-bit binaries from gcc by default, and that's
> why you end up with a value of PAGE_SIZE which is 4096 propagating
> through all of the generated linker scripts.

*This* is down to distro variance, I'm afraid. (And yes, I think your
machine is correctly configured, and I should have tested on a
-m32-by-default GCC, but I didn't think of it.)
