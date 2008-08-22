From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date: Fri, 22 Aug 2008 16:13:16 +0000
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
Message-Id: <20080822161316.GB22903@yoda.jdub.homelinux.org>
List-Id: <sparclinux.vger.kernel.org>
References: <48AE4093.8050504@firmworks.com> <fa686aa40808212130l365c6f5eu767b9969c8171e2@mail.gmail.com> <48AE4C4A.8040804@firmworks.com> <9696D7A991D0824DBA8DFAC74A9C5FA304461060@az33exm25.fsl.freescale.net>
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA304461060@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoder Stuart <stuart.yoder@freescale.com>
Cc: Mitch Bradley <wmb@firmworks.com>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org, WOOD SCOTT <scottwood@freescale.com>

On Fri, Aug 22, 2008 at 09:00:09AM -0700, Yoder Stuart wrote:
>There are a few bindings specified in the ePAPR, based on the old
>Open Firmware working group stuff:
>   -cpu
>   -interrupt controllers
>   -PCI
>   -network devices
>   -DCR devices

Er, I don't think that one is based on the old workgroup.  DCR is only
applicable to PowerPC 4xx devices, and those have never had open firmware.

>The best way to publish bindings will be on the web.  I've been
>looking into getting power.org to host a wiki-based site
>that could be used as a repository for bindings.  We could have
>both an area for general bindings and company specific ones.
>I've made some progress here and actually have a sandbox wiki
>that I'm playing with.

That sounds good, but I have one suggestion.  Use the wiki for
submission and discussion of new binding proposals, but once they
are agreed upon put them in a static webpage somewhere until they
are incorporated into the next ePAPR revision.  Wikis are awesome
for changing stuff, but you don't want people to go back and change
a binding that has already been approved (for whatever definition
of approved we come up with.)

Also, you might want to have some kind of Licensing or copyright
assignment for all wiki contributions.  Talk to your legal team or
the power.org legal team about that if you haven't already.

josh
