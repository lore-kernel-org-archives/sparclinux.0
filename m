From: David Miller <davem@davemloft.net>
Date: Sun, 27 Jul 2008 07:11:32 +0000
Subject: Re: sparc64 tracehook
Message-Id: <20080727.001132.91666326.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080726221221.DCF88154280@magilla.localdomain>
In-Reply-To: <20080726221221.DCF88154280@magilla.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Roland McGrath <roland@redhat.com>
Date: Sun, 27 Jul 2008 00:09:59 -0700 (PDT)

> > Did you build test this at all?
> 
> Nope!  (As previously advertised. ;-) These are serving suggestions for
> sparc, from someone without a sparc to dine on himself.  Season to taste.

Great, that's fine.

> > cc1: warnings being treated as errors
> > arch/sparc64/kernel/ptrace.c: In function ?syscall_trace?:
> > arch/sparc64/kernel/ptrace.c:1072: warning: ignoring return value of ?tracehook_report_syscall_entry?, declared with attribute warn_unused_result
> > make[1]: *** [arch/sparc64/kernel/ptrace.o] Error 1
> > make: *** [arch/sparc64/kernel] Error 2
> > make: *** Waiting for unfinished jobs....
> 
> I didn't realize you were using -Werror.  This very thing is the caveat I
> described in detail in a previous message.  Finishing the job requires a
> smidgen of assembly hacking, which I wasn't going to try when I wasn't
> prepared to test it.

Ok, I'll take care of this.

Thanks Roland.

