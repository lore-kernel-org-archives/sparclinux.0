From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 20 Jul 2017 18:11:24 +0000
Subject: Re: [RESEND PATCH] sparc: defconfig: Cleanup from old Kconfig options
Message-Id: <20170720181124.GA2874@kozik-book>
List-Id: <sparclinux.vger.kernel.org>
References: <1500526855-4132-1-git-send-email-krzk@kernel.org>
 <20170720123633.GA7465@ravnborg.org>
In-Reply-To: <20170720123633.GA7465@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On Thu, Jul 20, 2017 at 02:36:33PM +0200, Sam Ravnborg wrote:
> On Thu, Jul 20, 2017 at 07:00:55AM +0200, Krzysztof Kozlowski wrote:
> > Remove old, dead Kconfig options (in order appearing in this commit):
> >  - EXPERIMENTAL is gone since v3.9;
> >  - INET_LRO: commit 7bbf3cae65b6 ("ipv4: Remove inet_lro library");
> >  - AUTOFS_FS: commit 561c5cf9236a ("staging: Remove autofs3");
> >  - RCU_CPU_STALL_DETECTOR: commit a00e0d714fbd ("rcu: Remove conditional
> >    compilation for RCU CPU stall warnings");
> >  - USB_DEVICE_CLASS: commit 007bab91324e ("USB: remove
> >    CONFIG_USB_DEVICE_CLASS");
> >  - SYSCTL_SYSCALL_CHECK: commit 7c60c48f58a7 ("sysctl: Improve the
> >    sysctl sanity checks");
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Acked-by: David S. Miller <davem@davemloft.net>
> 
> Hi Krzysztof.
> 
> This looks like a manually edited defconfig.
> A better approch would be to do:
> $ make ARCH=sparc64 sparc64_defconfig
> $ make ARCH=sparc64 savedefconfig
> 
> And then to check the generated defconfig.
> Same for sparc32.

Actually this was generated with sed instead of defconfig on purpose -
as part of my bigger cleanup starting from ARM [1]. In case of
defconfigs for my platform we wanted to preserve the explanation why
things are disappearing, not only to savedefconfig. Indeed this brought
up that few items from savedefconfig would be gone but should be
replaced with different (new) items.

Anyway this way you have a full control and explanation why things are
being changed. After this you can always run defconfig to reorganize and
clean up.

[1] https://www.linux-mips.org/archives/linux-mips/2017-06/msg00255.html

Best regards,
Krzysztof

