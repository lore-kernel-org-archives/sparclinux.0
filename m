From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Mon, 09 Jan 2006 22:00:21 +0000
Subject: Re: strace broken on SPARC64
Message-Id: <1136844021.9208.21.camel@duncow>
List-Id: <sparclinux.vger.kernel.org>
References: <1136767843.9208.15.camel@duncow>
In-Reply-To: <1136767843.9208.15.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2006-01-09 at 12:53 -0800, David S. Miller wrote:
> From: "Richard Mortimer" <richm@oldelvet.org.uk>
> Date: Mon, 9 Jan 2006 16:03:31 -0000

> Yeah, I have to certainly do the fix differently.  Thanks for
> testing :-)
> 
> I'll cook up a better fix.

I tried using %l2 as suggested by Luis and that works for me.

Looking at the code I wonder if it makes sense to simplify the code
a little bit. The following works for me but I'm not sure how to
exercise the "NOERROR" codepath.

Richard

diff --git a/arch/sparc64/kernel/entry.S b/arch/sparc64/kernel/entry.S
index 11a8484..d9b9f32 100644
--- a/arch/sparc64/kernel/entry.S
+++ b/arch/sparc64/kernel/entry.S
@@ -1657,13 +1657,10 @@ ret_sys_call:
        /* Check if force_successful_syscall_return()
         * was invoked.
         */
-       ldub            [%curptr + TI_SYS_NOERROR], %l0
-       brz,pt          %l0, 1f
-        nop
-       ba,pt           %xcc, 80f
+       ldub            [%curptr + TI_SYS_NOERROR], %l2
+       brnz,a,pn       %l2, 80f
         stb            %g0, [%curptr + TI_SYS_NOERROR]

-1:
        cmp             %o0, -ERESTART_RESTARTBLOCK
        bgeu,pn         %xcc, 1f
         andcc          %l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT), %l6



-- 
Richard Mortimer <richm@oldelvet.org.uk>

