From: "Bjoern B. Brandenburg" <bbb@email.unc.edu>
Date: Fri, 09 May 2008 01:50:06 +0000
Subject: Re: enabling lockdep causes boot failure on a SUN T2000
Message-Id: <4823ADCE.4050009@email.unc.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <48238125.7040900@email.unc.edu>
In-Reply-To: <48238125.7040900@email.unc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: "Bjoern B. Brandenburg" <bbb@email.unc.edu>
>> I've been having a hard time getting Linux (vanilla 2.6.24 and 2.6.25) 
>> to boot on our Niagara box.
> 
> We know about this problem already.  Thanks for reporting.
> 
> This changeset below was meant to improve things, but t1000/t2000
> systems still get wedged.

Thanks for the pointer.

Based on your commit, I tried to disable stack trace support (with the 
intent to get at least some output in the event of deadlock) with the 
following patch:

diff --git a/kernel/lockdep.c b/kernel/lockdep.c
index e2c07ec..b468790 100644
--- a/kernel/lockdep.c
+++ b/kernel/lockdep.c
@@ -342,7 +342,9 @@ static int save_trace(struct stack_trace *trace)

         trace->skip = 3;

-       save_stack_trace(trace);
+       /* Work around: this doesn't work on the T2000.
+        * save_stack_trace(trace);
+        */

         trace->max_entries = trace->nr_entries;


I figured that if the flushes are the root cause, then this should take 
care of the problem. However, the kernel still doesn't boot.

Is there anything else that I can disable to get a partially working 
lockdep?

Thanks,
Bjoern
