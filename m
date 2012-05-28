From: David Miller <davem@davemloft.net>
Date: Mon, 28 May 2012 04:18:01 +0000
Subject: Re: [PATCH] sparc: fix bad merge of sparc Kconfig
Message-Id: <20120528.001801.201603926412931385.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120528134348.c934fef7360aa10683fc3a28@canb.auug.org.au>
In-Reply-To: <20120528134348.c934fef7360aa10683fc3a28@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sfr@canb.auug.org.au
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 28 May 2012 13:43:48 +1000

> Fixes this sparc32 defconfig build error:
> 
> timekeeping.c:(.text+0x277c4): undefined reference to `arch_gettimeoffset'
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/sparc/Kconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> Dave, I have been carrying this merge fix in linux-next for a while and
> now it is needed in Linus' tree.

I'll merge this in, thanks Stephen.
