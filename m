From: Kyle McMartin <kyle@infradead.org>
Date: Wed, 14 Jan 2009 01:29:27 +0000
Subject: Re: pcf50663 MFD driver modular build failure
Message-Id: <20090114012927.GK25103@bombadil.infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090112.210501.215941396.davem@redhat.com> <20090113065159.GB3218@fedora.yogi>
In-Reply-To: <20090113065159.GB3218@fedora.yogi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Balaji Rao <balajirrao@openmoko.org>
Cc: David Miller <davem@redhat.com>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, andy@openmoko.com, sameo@openedhand.com, mingo@elte.hu, yinghai@kernel.org, akpm@linux-foundation.org, sfr@canb.auug.org.au

On Tue, Jan 13, 2009 at 12:22:02PM +0530, Balaji Rao wrote:
> On Mon, Jan 12, 2009 at 09:05:01PM -0800, David Miller wrote:
> > 
> > This started happening with Linus's pull from today for
> > sparc64 allmodconfig:
> > 
> > ERROR: "__set_irq_handler" [drivers/mfd/pcf50633-core.ko] undefined!
> > ERROR: "handle_level_irq" [drivers/mfd/pcf50633-core.ko] undefined!
> > 
> > Sure we can export __set_irq_handler() and handle_level_irq() to
> > modules to fix this, but that looks like some hokey stuff for
> > a MFD driver to be doing :-)
> 
> Yes, right! It's really not necessary. I've sent a patch to remove it.
> 

Thanks, I just hit this on a rawhide build as well...
