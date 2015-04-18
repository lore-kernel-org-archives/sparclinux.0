From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Sat, 18 Apr 2015 10:59:17 +0000
Subject: Re: sparc64: Build failure due to commit f1600e549b94 (sparc: Make sparc64 use scalable lib/iommu-co
Message-Id: <20150418105917.GA1587@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150418054705.GA10746@roeck-us.net>
In-Reply-To: <20150418054705.GA10746@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On (04/17/15 22:47), Guenter Roeck wrote:
> #define DEFINE_PER_CPU_SECTION(type, name, sec)                         \
>         __PCPU_DUMMY_ATTRS char __pcpu_scope_##name;                    \
> 	extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;		\
> -->	__PCPU_DUMMY_ATTRS char __pcpu_unique_##name;			\
> 	extern __PCPU_ATTRS(sec) __typeof__(type) name;			\
> 	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES __weak                 \
> 					        __typeof__(type) name
> 
> if CONFIG_DEBUG_FORCE_WEAK_PER_CPU is configured, which is the case here.
> The marked line above shows that __pcpu_unique_iommu_pool_hash is declared as
> global variable, which explains the problem (and makes me wonder what the
> 'static' keyword in front of DEFINE_PER_CPU is supposed to accomplish).
> 
> I thought about fixing the problem by renaming one of the variables, but
> I am not sure if that is what is intended. Specifically, I am not sure if
> the variables are supposed to be different, as it looks like, or if they
> are supposed to be the same.

In this particular case, the intention is to have this variable only
be static to lib/iommu-common.c which tries to generalize the code
in arch/powerpc/kernel/iommu.c. So it would be fine to rename one
of those variables, but I'm not sure you can safely do that by
changing the macro above, as that would impact other uses of this.

> In case it is relevant, I use gcc version 4.6.3 for my build test.

Let me reproduce your error on my test machine and try to put
a fix together..

--Sowmini

