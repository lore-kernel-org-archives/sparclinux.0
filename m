From: David Miller <davem@davemloft.net>
Date: Sun, 03 Dec 2006 22:02:11 +0000
Subject: Re: [PATCH] Fix for sunhme failures on x86
Message-Id: <20061203.140211.48527890.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061203215522.GA4706@droopy.oc.cox.net>
In-Reply-To: <20061203215522.GA4706@droopy.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 3 Dec 2006 13:55:22 -0800

> Hi,
> 
> The following patch fixes the failure of sunhme drivers on x86 hosts
> due to missing pci_enable_device() and pci_set_master() calls, lost 
> during code refactoring. It has been filed as bugzilla bug #7502 [0] 
> and Debian bug #397460 [1].
> 
> [0] http://bugzilla.kernel.org/show_bug.cgi?idu02
> [1] http://bugs.debian.org/397460
> 
> Signed-off-by: Jurij Smakov <jurij@wooyd.org>

Thanks a lot for figuring this out Jurij, I'll apply this and
push to -stable later tonight.
