From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 27 Apr 2016 20:49:11 +0000
Subject: Re: Bisected: RED State Exception in 4.5 on E420R
Message-Id: <20160427204911.GA27058@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Apr 27, 2016 at 04:22:42PM -0400, David Miller wrote:
> From: Rob Gardner <rob.gardner@oracle.com>
> Date: Wed, 27 Apr 2016 14:06:04 -0600
> 
> > Also, perhaps think about a way to make the assembler emit something
> > fatal instead of a warning when this situation occurs? People tend to
> > ignore warnings. ;)
> 
> Yeah, good idea, I'll try to come up with something.
> 
> I think you can put asserts into the linker script, and we should have
> added a test on swapper_tsb's address a very long time ago. :)

Something like this:

diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index f1a2f68..d0e87e7 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -155,3 +155,10 @@ SECTIONS

        DISCARDS
 }
+
+#ifdef CONFIG_SPARC64
+/* The ASSERT() sink to . is required by binutils 2.14  */
+. = ASSERT((swapper_tsb <= 0x408000),
+           "trap table alignment is not OK - see arch/sparc/kernel/head_64.S");
+#endif
+

copy'n'pasted. 5 minutes hack - nothing to attribute to me.

Would prefer somthing in the head_64.S file but did not know how to do that.

	Sam
