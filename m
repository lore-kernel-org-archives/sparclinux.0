From: Don Zickus <dzickus@redhat.com>
Date: Tue, 18 Oct 2016 20:02:44 +0000
Subject: Re: [PATCH v3 0/2] Introduce arch specific nmi enable, disable handlers
Message-Id: <20161018200244.GB98438@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1476818050-117332-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1476818050-117332-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Babu Moger <babu.moger@oracle.com>
Cc: mingo@kernel.org, akpm@linux-foundation.org, ak@linux.intel.com, jkosina@suse.cz, baiyaowei@cmss.chinamobile.com, atomlin@redhat.com, uobergfe@redhat.com, tj@kernel.org, hidehiro.kawai.ez@hitachi.com, johunt@akamai.com, davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, sam@ravnborg.org

On Tue, Oct 18, 2016 at 12:14:08PM -0700, Babu Moger wrote:
> During our testing we noticed that nmi watchdogs in sparc could not be disabled or
> enabled dynamically using sysctl/proc interface. Sparc uses its own arch specific
> nmi watchdogs. There is a sysctl and proc interface(proc/sys/kernel/nmi_watchdog)
> to enable/disable nmi watchdogs. However, that is not working for sparc. There
> is no interface to feed this parameter to arch specific nmi watchdogs.
> 
> These patches extend the same sysctl/proc interface to enable or disable
> these arch specific nmi watchdogs dynamically. Introduced new functions
> arch_watchdog_nmi_enable and arch_watchdog_nmi_disable which can be implemented
> in arch specific handlers.
> If you think there is a better way to do this. Please advice.
> 
> Tested on sparc. Compile tested on x86.

Thanks Babu!

Tested-and-Reviewed-by: Don Zickus <dzickus@redhat.com>

> 
> v3:
>   Made one more change per Don Zickus comments.
>   Moved failure path messages to into generic code inside watchdog_nmi_enable.
>   Also added matching prints in sparc to warn about the failure.
> 
> v2:
>   a)Sam Ravnborg's comments about making the definitions visible.
>   With the new approach we dont need those definitions((NMI_WATCHDOG_ENABLED,
>   SOFT_WATCHDOG_ENABLED etc..) outside watchdog.c. So no action.
> 
>   b) Made changes per Don Zickus comments.
>   Don, I could not use your patches as is. Reason is sparc does not define
>   CONFIG_HARDLOCKUP_DETECTOR. So, defining default __weak function did not
>   work for me. However, I have used your idea to define __weak functions
>   arch_watchdog_nmi_enable and arch_watchdog_nmi_disable when CONFIG_HARDLOCKUP_DETECTOR
>   is not defined. I feel this should have very less impact on the races you are
>   concerned about. Please take a look. Feel free to suggest.
> 
>   Patch2 changes: I had to introduce new variable nmi_init_done to synchronize
>   watchdog thread and kernel init thread.
> 
> v1:
>  Initial version. Discussion thread here
>  http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1245427.html
> 
> Babu Moger (2):
>   watchdog: Introduce arch_watchdog_nmi_enable and
>     arch_watchdog_nmi_disable
>   sparc: Implement arch_watchdog_nmi_enable and
>     arch_watchdog_nmi_disable
> 
>  arch/sparc/kernel/nmi.c |   44 +++++++++++++++++++++++++++++-
>  kernel/watchdog.c       |   69 +++++++++++++++++++++++++++++++---------------
>  2 files changed, 89 insertions(+), 24 deletions(-)
> 
