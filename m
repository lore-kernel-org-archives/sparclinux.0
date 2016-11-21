From: David Miller <davem@davemloft.net>
Date: Mon, 21 Nov 2016 18:42:47 +0000
Subject: Re: [PATCH v2 0/3] Clean up watchdog handlers
Message-Id: <20161121.134247.2230825072060895605.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1478034826-43888-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1478034826-43888-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: babu.moger@oracle.com
Cc: mingo@kernel.org, akpm@linux-foundation.org, ak@linux.intel.com, jkosina@suse.cz, baiyaowei@cmss.chinamobile.com, dzickus@redhat.com, atomlin@redhat.com, uobergfe@redhat.com, tj@kernel.org, hidehiro.kawai.ez@hitachi.com, johunt@akamai.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, sam@ravnborg.org

From: Babu Moger <babu.moger@oracle.com>
Date: Tue,  1 Nov 2016 14:13:43 -0700

> This is an attempt to cleanup watchdog handlers. Right now,
> kernel/watchdog.c implements both softlockup and hardlockup detectors.
> Softlockup code is generic. Hardlockup code is arch specific. Some
> architectures don't use hardlockup detectors. They use their own watchdog
> detectors. To make both these combination work, we have numerous #ifdefs
> in kernel/watchdog.c.
> 
> We are trying here to make these handlers independent of each other.
> Also provide an interface for architectures to implement their own
> handlers. watchdog_nmi_enable and watchdog_nmi_disable will be defined
> as weak such that architectures can override its definitions.
> 
> Thanks to Don Zickus for his suggestions.
> Here are our previous discussions
> http://www.spinics.net/lists/sparclinux/msg16543.html
> http://www.spinics.net/lists/sparclinux/msg16441.html

This touches a bunch of generic code, only the third patch is sparc
specific.

Anyways have any plans to merge this via another tree or should I
take it via sparc?  If I take it via sparc I want some ACKs.

Thanks.
