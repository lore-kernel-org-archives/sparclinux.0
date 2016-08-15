From: Catalin Marinas <catalin.marinas@arm.com>
Date: Mon, 15 Aug 2016 15:41:14 +0000
Subject: Re: [PATCH] Documentation: kprobes: Document jprobes stack copying limitations
Message-Id: <20160815154114.GG22320@e104818-lin.cambridge.arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1471033484-2709-1-git-send-email-dave.long@linaro.org>
 <20160815082540.2b7a889b@lwn.net> <57B1D680.9030605@linaro.org>
 <20160815093243.4576258a@lwn.net>
In-Reply-To: <20160815093243.4576258a@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Aug 15, 2016 at 09:32:43AM -0600, Jonathan Corbet wrote:
> On Mon, 15 Aug 2016 10:49:36 -0400
> David Long <dave.long@linaro.org> wrote:
> 
> > On 08/15/2016 10:25 AM, Jonathan Corbet wrote:
> > > On Fri, 12 Aug 2016 16:24:44 -0400
> > > David Long <dave.long@linaro.org> wrote:
> > >  
> > >> Some architectures (i.e.: sparc64 and arm64) make reasonable partial stack
> > >> duplication for jprobes problematic. Document this.  
> > >
> > > Applied to the docs tree, thanks.
> > >
> > > jon
> > 
> > Was kind of hoping to see an ack (or critique) from a sparc maintainer.
> 
> So are you saying you don't want the patch applied at this point?

To avoid any doubt, for arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(and I want the patch applied)
