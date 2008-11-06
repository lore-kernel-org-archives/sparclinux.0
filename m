From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 06 Nov 2008 21:10:02 +0000
Subject: Re: sparc boot failure
Message-Id: <20081106211002.GB2972@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <49125E98.8070905@earthlink.net>
In-Reply-To: <49125E98.8070905@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Nov 05, 2008 at 08:10:30PM -0800, David Miller wrote:
> From: Robert Reif <reif@earthlink.net>
> Date: Wed, 05 Nov 2008 22:03:52 -0500
> 
> > sparc has failed to boot recently and I bisected it down to this patch:
>  ...
> >  sparc: correct section of current_pc()
>  ...
> > Reverting this patch gets current git booting again.
> 
> Thanks for tracking this down.  I'll take a look and if I
> can't figure it out I'll revert.

The commit looks like this:
--- a/arch/sparc/kernel/head.S
+++ b/arch/sparc/kernel/head.S
@@ -465,6 +465,7 @@ gokernel:
                mov     %o7, %g4                ! Save %o7

                /* Jump to it, and pray... */
+               __INIT
 current_pc:
                call    1f
                 nop

So the original code assumed that after executing "mov %o7, %g4"
it would execute "call 1f".
But chaning section breaks this assumption and the boot fails.

The code at the label gokernel: all looks like it belongs to __HEAD
but I do not know about the traptable just above it.

If we ignore the traptable I think the below is the more correct approach:

diff --git a/arch/sparc/kernel/head.S b/arch/sparc/kernel/head.S
index 2fe2c11..ae479a5 100644
--- a/arch/sparc/kernel/head.S
+++ b/arch/sparc/kernel/head.S
@@ -72,7 +72,7 @@ sun4e_notsup:
        .align 4

        /* The Sparc trap table, bootloader gives us control at _start. */
-       .text
+       __HEAD
        .globl  start, _stext, _start, __stext
        .globl  trapbase
 _start:   /* danger danger */
@@ -465,7 +465,6 @@ gokernel:
                mov     %o7, %g4                ! Save %o7

                /* Jump to it, and pray... */
-               __INIT
 current_pc:
                call    1f
                 nop

[Copy'n'paste so it will not apply - because I do not think it is enough]
But someone that knows this stuff should fix it.

I checked vmlinux.lds.S and I can see that sparc needs to have
.head.text added before we can use __HEAD in assembler.

I assume it is something like this:

diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index b1002c6..12d1be0 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -10,8 +10,11 @@ jiffies = jiffies_64 + 4;
 SECTIONS
 {
 	. = 0x10000 + SIZEOF_HEADERS;
-	.text 0xf0004000 :
-	{
+	.text.head 0xf0004000 : {
+		_text = .;                      /* Text and read-only data */
+		*(.text.head)
+	} : text = 0
+	.text : {
 		_text = .;
 		TEXT_TEXT
 		SCHED_TEXT


With this change we are then less dependent on link orderr which is a good thing.

	Sam
