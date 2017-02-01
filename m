From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Wed, 01 Feb 2017 21:20:08 +0000
Subject: Re: [PATCH v3 0/4] sparc64: Jump to boot prom from console on panic
Message-Id: <271b7e7c-5e2f-eab6-d097-54145b777d73@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1485977680-203775-1-git-send-email-vijay.ac.kumar@oracle.com>
 <20170201.145031.295104986575080480.davem@davemloft.net>
In-Reply-To: <20170201.145031.295104986575080480.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, karl.volz@oracle.com, rob.gardner@oracle.com, linux-kernel@vger.kernel.org


On 2/1/2017 1:50 PM, David Miller wrote:
> From: Vijay Kumar <vijay.ac.kumar@oracle.com>
> Date: Wed,  1 Feb 2017 11:34:36 -0800
>
>> Currently Stop-A (L1A) does not make the kernel switch to OBP on panic.
> This is intentional, the kernel prints a message telling the user to
> press break (L1-A) if they want to drop out of the kernel and we force
> the break to be allowed by setting stop_a_enabled.
The problem is that pressing BRK after panic does not drop to OK prompt 
(when
stop_a_enabled is set).  So the kernel message to press Stop-A to return 
to boot
prom is  misleading in this case.
> I'm wondering why there is so much effort being directed into BRK
> behavior.
User can drop into ok prompt from the running kernel and as well as from the
panicked kernel. Pressing single break to jump to ok prompt conflicts with
sysrq key combination (from console, BRK + sysrq_key). To be consistent
across both the cases,  user will have to send BRK twice in order to drop to
ok prompt.  Does this sound reasonable?
>
> If you want to break into the OK prompt, have the reboot-cmd
> environment variable set appropriately, and simply hit BRK and it will
> work in both ldom and non-ldom environments.
Kernel does not print message "Press Stop-A (L1-A) to ..." for the case 
when it is
expected to reboot on panic. Rather, it goes through different path in 
panic() when
kernel.panic is _not_ set to 0. Here, patch is addressing the case when
kernel.panic=0 (i.e not to reboot on panic).

Thanks,
Vijay
