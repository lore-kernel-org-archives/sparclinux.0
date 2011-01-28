From: David Miller <davem@davemloft.net>
Date: Fri, 28 Jan 2011 23:09:23 +0000
Subject: Re: [PATCH] sparc: cleaned up FPU version probing
Message-Id: <20110128.150923.229751330.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1296126392-7536-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1296126392-7536-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 27 Jan 2011 20:36:03 +0100

> If we want to be more explicit we can do:
> 
> 	u32 psr;
> 
> 	psr = get_psr();
> 	psr_impl = (psr & PSR_IMPL) >> PSR_IMPL_SHIFT;
> 
> I assume gcc will generate equal code for this.
> But this looks like overkill.
> 
> The mixed use of unsigned int and int in this file also looks
> like something to be cleaned up...

Daniel, please respin your patch so that we explicitly use unsigned
variables here as Sam suggests, and thus avoid the sign-extension
issues during the right-shift operations.

Thanks.
