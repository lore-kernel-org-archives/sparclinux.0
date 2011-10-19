From: Kjetil Oftedal <oftedal@gmail.com>
Date: Wed, 19 Oct 2011 21:11:29 +0000
Subject: Re: [PATCH 3/4] sparc32: return destination pointer on return from
Message-Id: <Pine.LNX.4.64.1110192258340.25694@oizys.tordivel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1318489205-315-4-git-send-email-konrad@gaisler.com>
In-Reply-To: <1318489205-315-4-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 19 Oct 2011, David Miller wrote:

> From: Konrad Eisele <konrad@gaisler.com>
> Date: Wed, 19 Oct 2011 10:33:25 +0200
> 
> > It seems to me that memcpy is tightly programmed. Is saving 2 lines of gdbstub.c
> > diff worth a memcpy rewrite?
> 
> You really can't find another register to save the initial %o0 value in?
> Have you even tried?

This might be considered a ugly hack. But what about using %y ? According 
to the V8 manual, %y might be destroyed across a procedure call, and none 
of the functions in memcpy.S use multiply/divide instructions. It is 
however not mentioned as a available register in the section dealing with 
leaf procedures. 

A quick test on a SS20 did not reveal any immediate side-effects, and 
the return value of memcpy is now the destination pointer.

---
diff --git a/arch/sparc/lib/memcpy.S b/arch/sparc/lib/memcpy.S
index 34fe657..0327309 100644
--- a/arch/sparc/lib/memcpy.S
+++ b/arch/sparc/lib/memcpy.S
@@ -23,8 +23,8 @@ x:
  * One should use macros in asm/string.h for that purpose.
  * We return 0, so that bugs are more apparent.
  */
-#define SETUP_RETL
-#define RETL_INSN      clr     %o0
+#define SETUP_RETL     mov     %o0, %y
+#define RETL_INSN      mov     %y, %o0
 
 #else



