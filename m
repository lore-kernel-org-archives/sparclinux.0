From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 09 Dec 2004 05:01:29 +0000
Subject: Re: [PATCH] updated asm-sparc/{processor,signal,sigcontext}.h to
Message-Id: <20041208210129.466f6104.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1102503203.20234.7.camel@cid.outersquare.org>
In-Reply-To: <1102503203.20234.7.camel@cid.outersquare.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 08 Dec 2004 02:53:23 -0800
Jeremy Huddleston <eradicator@gentoo.org> wrote:

> On Fri, 2004-12-03 at 17:34 -0800, Jeremy Huddleston wrote:
> > asm-sparc/signal.h needs:
> > 
> > #include <linux/compiler>
> > 
> > because it uses __user around line 214.  Without this include, userland
> > code including asm/signal.h will fail to compile.
> 
> I've updated the patch to fix a few more problems with redefined
> structs, etc when using they are included after glibc headers.

Please use __KERNEL__ instead of things like _SIGNAL_H
Thanks.
