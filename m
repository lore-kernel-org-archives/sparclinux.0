From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 05 Jan 2009 21:51:06 +0000
Subject: Re: kill most of sparc_ksyms*
Message-Id: <20090105215106.GA8592@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105194431.GA4976@uranus.ravnborg.org>
In-Reply-To: <20090105194431.GA4976@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jan 05, 2009 at 10:05:29PM +0100, Sam Ravnborg wrote:
> On Mon, Jan 05, 2009 at 12:58:34PM -0800, David Miller wrote:
> > From: Sam Ravnborg <sam@ravnborg.org>
> > Date: Mon, 5 Jan 2009 21:36:46 +0100
> > 
> > > Disregard this serie. I bug sneaked in on sparc64.
> > > I will resubmit later this week.
> > 
> > If you tell me what the problem is, I might fix it up
> > myself :-)
> 
> So far I found a missing include:
> 
> diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
> index deb0bbb..faa8b4f 100644
> --- a/arch/sparc/kernel/sys_sparc_64.c
> +++ b/arch/sparc/kernel/sys_sparc_64.c
> @@ -5,6 +5,7 @@
>   * platform.
>   */
>  
> +#include <linux/module.h>
>  #include <linux/errno.h>
>  #include <linux/types.h>
>  #include <linux/sched.h>
> 
> 
> But it troubles me that I cannot explain why this happened.
> I did a rebase of the set and I may have just lost this change
> as I recall I made it once before.
> Or maybe I just lost is because I had commented out -Werror due
> to the branch_tracer issues.
> 
> Trying to build a vmlinux image from an allmodconfig at the moment.
> But it is getting late..

And there was more fallout...
I one had asm/xor.h included but this is a no-no as it define variables.
So I had to duplicate some extern definitions to build ksyms on sparc64.

diff --git a/arch/sparc/lib/ksyms.c b/arch/sparc/lib/ksyms.c
index afdb82e..352b1d5 100644
--- a/arch/sparc/lib/ksyms.c
+++ b/arch/sparc/lib/ksyms.c
@@ -11,6 +11,7 @@
 
 #include <asm/checksum.h>
 #include <asm/uaccess.h>
+#include <asm/ftrace.h>
 
 /* string functions */
 EXPORT_SYMBOL(strlen);
@@ -120,6 +121,24 @@ EXPORT_SYMBOL(_Udiv);
  * sparc64
  */
 #ifdef CONFIG_SPARC64
+
+/* copied from asm/xor.h. We cannot include that file as is define variables */
+extern void xor_vis_2(unsigned long, unsigned long *, unsigned long *);
+extern void xor_vis_3(unsigned long, unsigned long *, unsigned long *,
+                      unsigned long *);
+extern void xor_vis_4(unsigned long, unsigned long *, unsigned long *,
+                      unsigned long *, unsigned long *);
+extern void xor_vis_5(unsigned long, unsigned long *, unsigned long *,
+                      unsigned long *, unsigned long *, unsigned long *);
+
+extern void xor_niagara_2(unsigned long, unsigned long *, unsigned long *);
+extern void xor_niagara_3(unsigned long, unsigned long *, unsigned long *,
+                          unsigned long *);
+extern void xor_niagara_4(unsigned long, unsigned long *, unsigned long *,
+                          unsigned long *, unsigned long *);
+extern void xor_niagara_5(unsigned long, unsigned long *, unsigned long *,
+                          unsigned long *, unsigned long *, unsigned long *);
+
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
 EXPORT_SYMBOL(__csum_partial_copy_from_user);


I have not yet succeeded building a sparc64 vmlinux based on a allmodconfig.
But I am getting closer...

sparc also causes me some troubles due to the branch_tracer stuff...
And it has an ugly bug due to stripping of vmlinux too...

	Sam

