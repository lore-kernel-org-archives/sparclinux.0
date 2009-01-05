From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 05 Jan 2009 21:05:29 +0000
Subject: Re: kill most of sparc_ksyms*
Message-Id: <20090105210529.GA23798@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105194431.GA4976@uranus.ravnborg.org>
In-Reply-To: <20090105194431.GA4976@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jan 05, 2009 at 12:58:34PM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Mon, 5 Jan 2009 21:36:46 +0100
> 
> > Disregard this serie. I bug sneaked in on sparc64.
> > I will resubmit later this week.
> 
> If you tell me what the problem is, I might fix it up
> myself :-)

So far I found a missing include:

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index deb0bbb..faa8b4f 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -5,6 +5,7 @@
  * platform.
  */
 
+#include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/sched.h>


But it troubles me that I cannot explain why this happened.
I did a rebase of the set and I may have just lost this change
as I recall I made it once before.
Or maybe I just lost is because I had commented out -Werror due
to the branch_tracer issues.

Trying to build a vmlinux image from an allmodconfig at the moment.
But it is getting late..

	Sam
