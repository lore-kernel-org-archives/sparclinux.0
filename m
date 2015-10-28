From: "Busch, Keith" <keith.busch@intel.com>
Date: Wed, 28 Oct 2015 13:59:23 +0000
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
Message-Id: <20151028135922.GA27909@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
 <20151027223643.GA25332@localhost.localdomain>
 <20151027.175443.140992924519172506.davem@davemloft.net>
In-Reply-To: <20151027.175443.140992924519172506.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Oct 27, 2015 at 05:54:43PM -0700, David Miller wrote:
> From: "Busch, Keith" <keith.busch@intel.com>
> Date: Tue, 27 Oct 2015 22:36:43 +0000
> 
> > If you're suggesting to compile-time break architectures that currently
> > work just fine with NVMe, let me stop you right there.
> 
> Silently "working" without the architecture maintainer having to explicity
> look at the new interface and make sure his platform is implementing it
> properly is an extremely bad practice.

It won't work if it's wrong. It'll BUG_ON, and I'll be assigned to help
fix it, like what's happened here (on a private bugzilla).

The "new" interface for all the other architectures is the same as the
old one we've been using for the last 5 years.

I welcome x86 maintainer feedback to confirm virtual and DMA addresses
have the same offset at 4k alignment, but I have to insist we don't
break my currently working hardware to force their attention.
