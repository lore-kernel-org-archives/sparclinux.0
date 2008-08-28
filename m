From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 02:04:09 +0000
Subject: Re: sparc build failure
Message-Id: <20080827.190409.80969099.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080828114602.6c6df4a2.sfr@canb.auug.org.au>
In-Reply-To: <20080828114602.6c6df4a2.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sfr@canb.auug.org.au
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, wli@holomorphy.com

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 28 Aug 2008 11:46:02 +1000

> Linus' tree fails to build for sparc32 allmodconfig:
> 
> kernel/relay.c:701: undefined reference to `smp_call_function_single'
> 
> This is because it has CONFIG_SMP but not CONFIG_USE_GENERIC_SMP_HELPERS.
> 
> I am not sure what to do about this.

I'll try to come up with a fix for this, thanks.
