From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 09 Dec 2004 05:25:16 +0000
Subject: Re: [PATCH] updated asm-sparc/{processor,signal,sigcontext}.h to
Message-Id: <20041208212516.0aa286c4.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1102503203.20234.7.camel@cid.outersquare.org>
In-Reply-To: <1102503203.20234.7.camel@cid.outersquare.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 08 Dec 2004 21:25:51 -0800
Jeremy Huddleston <eradicator@gentoo.org> wrote:

> On Wed, 2004-12-08 at 21:01 -0800, David S. Miller wrote:
> > Please use __KERNEL__ instead of things like _SIGNAL_H
> > Thanks.
> 
> Ok, I'll keep that in mind for next time.  I was just copying the same
> behavior from asm-x86_64.  Do you want me to update/resend the patch? 

Please do, I'd like to apply your patch and have this fixed. :-)
