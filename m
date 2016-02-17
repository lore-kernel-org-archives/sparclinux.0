From: David Miller <davem@davemloft.net>
Date: Wed, 17 Feb 2016 20:51:54 +0000
Subject: Re: Invalid SIGSEGV from sparc64_set_context ()
Message-Id: <20160217.155154.1318985721195192951.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CAK1sNPDEk0x4mdOfma97EyAkiBAuKc10dC-hhqb3XWSkWw=SZw@mail.gmail.com>
In-Reply-To: <CAK1sNPDEk0x4mdOfma97EyAkiBAuKc10dC-hhqb3XWSkWw=SZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Ilya Malakhov <ilmalakhovthefirst@gmail.com>
Date: Mon, 15 Feb 2016 12:21:51 +0300

>  It would make a process get an invalid SIGSEGV if, for a example, a
> "fast_data_access" exception were to happen while spilling window registers
> to a previously untouched page of the stack. I wonder if `synchronize_user
> _stack ()' should be used in place of `flush_user_windows ()' here to ensure
> that the registers are actually spilled to memory and thus successfully proceed
> with setcontext.

I think you are absolutely correct, we should use synchronize_user_stack()
here just like the sigrestore et al. code does elsewhere in this file.

Does the obvious patch below fix the problem for you?

diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index d88beff4..39aaec1 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -52,7 +52,7 @@ asmlinkage void sparc64_set_context(struct pt_regs *regs)
 	unsigned char fenab;
 	int err;
 
-	flush_user_windows();
+	synchronize_user_stack();
 	if (get_thread_wsaved()					||
 	    (((unsigned long)ucp) & (sizeof(unsigned long)-1))	||
 	    (!__access_ok(ucp, sizeof(*ucp))))


