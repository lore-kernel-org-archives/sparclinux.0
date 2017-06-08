From: David Miller <davem@davemloft.net>
Date: Thu, 08 Jun 2017 18:08:34 +0000
Subject: Re: [PATCH 10/35] sparc: defconfig: Cleanup from old Kconfig options
Message-Id: <20170608.140834.1461008991403588496.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170608160836.12196-1-krzk@kernel.org>
        <20170608161049.12421-10-krzk@kernel.org>
In-Reply-To: <20170608161049.12421-10-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: krzk@kernel.org
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, sparclinux@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu,  8 Jun 2017 18:10:21 +0200

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

Acked-by: David S. Miller <davem@davemloft.net>
