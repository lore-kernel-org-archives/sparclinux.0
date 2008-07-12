From: Andrew Morton <akpm@linux-foundation.org>
Date: Sat, 12 Jul 2008 02:30:46 +0000
Subject: Re: Remove init_mm export as planned for 2.6.26
Message-Id: <20080711193046.89b4b68a.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080711201959.GA1007@redhat.com>
In-Reply-To: <20080711201959.GA1007@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Jones <davej@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Linux Kernel <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

On Fri, 11 Jul 2008 16:19:59 -0400 Dave Jones <davej@redhat.com> wrote:

> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
> index 46ece3f..5e89689 100644
> --- a/Documentation/feature-removal-schedule.txt
> +++ b/Documentation/feature-removal-schedule.txt
> @@ -270,18 +270,6 @@ Who:	Michael Buesch <mb@bu3sch.de>
>  
>  ---------------------------
>  
> -What:	init_mm export
> -When:	2.6.26
> -Why:	Not used in-tree. The current out-of-tree users used it to
> -	work around problems in the CPA code which should be resolved
> -	by now. One usecase was described to provide verification code
> -	of the CPA operation. That's a good idea in general, but such
> -	code / infrastructure should be in the kernel and not in some
> -	out-of-tree driver.
> -Who:	Thomas Gleixner <tglx@linutronix.de>
> -
> -----------------------------
> -
>  What:	usedac i386 kernel parameter
>  When:	2.6.27
>  Why:	replaced by allowdac and no dac combination
> diff --git a/arch/x86/kernel/init_task.c b/arch/x86/kernel/init_task.c
> index a4f93b4..d399180 100644
> --- a/arch/x86/kernel/init_task.c
> +++ b/arch/x86/kernel/init_task.c
> @@ -14,7 +14,6 @@ static struct fs_struct init_fs = INIT_FS;
>  static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
>  static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
>  struct mm_struct init_mm = INIT_MM(init_mm);
> -EXPORT_UNUSED_SYMBOL(init_mm); /* will be removed in 2.6.26 */
>  
>  /*
>   * Initial thread structure.
> 

grep -r init_mm include/asm-sparc64

This patch used to break stuff.  I'm not aware that anything was done
to prevent this.

