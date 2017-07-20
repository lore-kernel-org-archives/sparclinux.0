From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 20 Jul 2017 12:36:33 +0000
Subject: Re: [RESEND PATCH] sparc: defconfig: Cleanup from old Kconfig options
Message-Id: <20170720123633.GA7465@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1500526855-4132-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1500526855-4132-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On Thu, Jul 20, 2017 at 07:00:55AM +0200, Krzysztof Kozlowski wrote:
> Remove old, dead Kconfig options (in order appearing in this commit):
>  - EXPERIMENTAL is gone since v3.9;
>  - INET_LRO: commit 7bbf3cae65b6 ("ipv4: Remove inet_lro library");
>  - AUTOFS_FS: commit 561c5cf9236a ("staging: Remove autofs3");
>  - RCU_CPU_STALL_DETECTOR: commit a00e0d714fbd ("rcu: Remove conditional
>    compilation for RCU CPU stall warnings");
>  - USB_DEVICE_CLASS: commit 007bab91324e ("USB: remove
>    CONFIG_USB_DEVICE_CLASS");
>  - SYSCTL_SYSCALL_CHECK: commit 7c60c48f58a7 ("sysctl: Improve the
>    sysctl sanity checks");
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: David S. Miller <davem@davemloft.net>

Hi Krzysztof.

This looks like a manually edited defconfig.
A better approch would be to do:
$ make ARCH=sparc64 sparc64_defconfig
$ make ARCH=sparc64 savedefconfig

And then to check the generated defconfig.
Same for sparc32.

This is more or less how the defconfig filws are generated in the first place.


Diffstat when I do the above:
defconfig |   62 ++++++++++++++++----------------------------------------------
 1 file changed, 16 insertions(+), 46 deletions(-)


	Sam
