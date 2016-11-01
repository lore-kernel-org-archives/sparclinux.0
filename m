From: Don Zickus <dzickus@redhat.com>
Date: Tue, 01 Nov 2016 13:20:11 +0000
Subject: Re: [RFC PATCH 0/4] Clean up watchdog handlers
Message-Id: <20161101132011.GW35881@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1477497743-15357-1-git-send-email-babu.moger@oracle.com>
 <20161031210056.GT35881@redhat.com>
 <16049ab0-e309-8ea7-81d4-a855c666037a@oracle.com>
In-Reply-To: <16049ab0-e309-8ea7-81d4-a855c666037a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Babu Moger <babu.moger@oracle.com>
Cc: mingo@kernel.org, akpm@linux-foundation.org, ak@linux.intel.com, jkosina@suse.cz, baiyaowei@cmss.chinamobile.com, atomlin@redhat.com, uobergfe@redhat.com, tj@kernel.org, hidehiro.kawai.ez@hitachi.com, johunt@akamai.com, davem@davemloft.net, sparclinux@vger.kernel.org, bp@suse.de, bywxiaobai@163.com, cmetcalf@mellanox.com, keescook@chromium.org, ebiederm@xmission.com, huawei.libin@huawei.com, ralf@linux-mips.org, dvyukov@google.com, linux-kernel@vger.kernel.org, sam@ravnborg.org

On Mon, Oct 31, 2016 at 04:30:59PM -0500, Babu Moger wrote:
> 
> On 10/31/2016 4:00 PM, Don Zickus wrote:
> >On Wed, Oct 26, 2016 at 09:02:19AM -0700, Babu Moger wrote:
> >>This is an attempt to cleanup watchdog handlers. Right now,
> >>kernel/watchdog.c implements both softlockup and hardlockup detectors.
> >>Softlockup code is generic. Hardlockup code is arch specific. Some
> >>architectures don't use hardlockup detectors. They use their own watchdog
> >>detectors. To make both these combination work, we have numerous #ifdefs
> >>in kernel/watchdog.c.
> >>
> >>We are trying here to make these handlers independent of each other.
> >>Also provide an interface for architectures to implement their own
> >>handlers. watchdog_nmi_enable and watchdog_nmi_disable will be defined
> >>as weak such that architectures can override its definitions.
> >>
> >>Thanks to Don Zickus for his suggestions.
> >>Here is the previous discussion
> >>http://www.spinics.net/lists/sparclinux/msg16441.html
> >Hi Babu,
> >
> >I finally got some cycles to poke at this today.  Good work.  A couple of
> >suggestions.  For bisectability, I am thinking patch2 should be first and
> >patch1 and patch3 should be combined.  Also watchdog_hld.c is going to need
> >up top:
> >
> >#define pr_fmt(fmt) "NMI watchdog: " fmt
> >
> >otherwise the error messages miss the header.
> >
> >Though I don't think watchdog.c and watchdog_hld.c should have the same
> >header.  A good solution isn't coming to me right now.  I will try to run
> >some tests on this tomorrow.
> Don, Thanks for the feedback. Let me know if you run into problems with your
> tests.

Hi Babu,

My tests passed.  I just have to tweak the expected output lines as they
constantly change. :-(

I am going to play with different config options to see if things break from
a compile perspective.

> I will start working on the comments.

Great.

Cheers,
Don

> Thanks
> Babu
> 
> >
> >Cheers,
> >Don
> >
> >>Babu Moger (4):
> >>   watchdog: Remove hardlockup handler references
> >>   watchdog: Move shared definitions to nmi.h
> >>   watchdog: Move hardlockup detector in separate file
> >>   sparc: Implement watchdog_nmi_enable and watchdog_nmi_disable
> >>
> >>  arch/sparc/kernel/nmi.c |   44 ++++++++-
> >>  include/linux/nmi.h     |   19 ++++
> >>  kernel/Makefile         |    1 +
> >>  kernel/watchdog.c       |  276 ++---------------------------------------------
> >>  kernel/watchdog_hld.c   |  238 ++++++++++++++++++++++++++++++++++++++++
> >>  5 files changed, 312 insertions(+), 266 deletions(-)
> >>  create mode 100644 kernel/watchdog_hld.c
> >>
> 
