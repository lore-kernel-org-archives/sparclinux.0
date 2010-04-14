From: David Miller <davem@davemloft.net>
Date: Wed, 14 Apr 2010 01:59:31 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100413.185931.244224837.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 16:56:39 -0700 (PDT)

> I'll dig further.

Ok Frederic, I think I figured it out.  We only save 128 bytes
of stack space in the mcount stubs, but that's not enough.

128 bytes is enough for the register window, but any function we call
is allowed to save the first six incoming arguments to pre-assigned
stack frame slots.

That means we have to allocate, at a minimum, 176 bytes of stack space
if we call any C functions.  (176 = 128 + (8 * 6))

These arg save stores only happen in functions where there is a
bit of register pressure, that's why we only sometimes see this.

The net result is that when we hit this, the parent's stack frame gets
writtenw ith garbage.  And that's why the crashes look so random.

I'll commit this to sparc-2.6 and push it out to Linus.  I'm beating
up a machine pretty hard with various tracers enabled and I haven't
see any suspicious symptoms yet :-)

--------------------
sparc64: Allocate sufficient stack space in ftrace stubs.

128 bytes is sufficient for the register window save area, but the
calling conventions allow the callee to save up to 6 incoming argument
registers into the stack frame after the register window save area.

This means a minimal stack frame is 176 bytes (128 + (6 * 8)).

This fixes random crashes when using the function tracer.

Reported-by: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/lib/mcount.S |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/lib/mcount.S b/arch/sparc/lib/mcount.S
index 3753e3c..3ad6cbd 100644
--- a/arch/sparc/lib/mcount.S
+++ b/arch/sparc/lib/mcount.S
@@ -34,7 +34,7 @@ mcount:
 	cmp		%g1, %g2
 	be,pn		%icc, 1f
 	 mov		%i7, %g3
-	save		%sp, -128, %sp
+	save		%sp, -176, %sp
 	mov		%g3, %o1
 	jmpl		%g1, %o7
 	 mov		%i7, %o0
@@ -56,7 +56,7 @@ mcount:
 	 nop
 5:	mov		%i7, %g2
 	mov		%fp, %g3
-	save		%sp, -128, %sp
+	save		%sp, -176, %sp
 	mov		%g2, %l0
 	ba,pt		%xcc, ftrace_graph_caller
 	 mov		%g3, %l1
@@ -85,7 +85,7 @@ ftrace_caller:
 	lduw		[%g1 + %lo(function_trace_stop)], %g1
 	brnz,pn		%g1, ftrace_stub
 	 mov		%fp, %g3
-	save		%sp, -128, %sp
+	save		%sp, -176, %sp
 	mov		%g2, %o1
 	mov		%g2, %l0
 	mov		%g3, %l1
@@ -120,7 +120,7 @@ ENTRY(ftrace_graph_caller)
 END(ftrace_graph_caller)
 
 ENTRY(return_to_handler)
-	save		%sp, -128, %sp
+	save		%sp, -176, %sp
 	call		ftrace_return_to_handler
 	 mov		%fp, %o0
 	jmpl		%o0 + 8, %g0
-- 
1.7.0.4

