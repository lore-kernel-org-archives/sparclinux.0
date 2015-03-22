From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Sun, 22 Mar 2015 22:07:08 +0000
Subject: Re: Generic IOMMU pooled allocator
Message-Id: <20150322220708.GA14061@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150318.222517.1444725543017433108.davem@davemloft.net>
 <201503222036.02669.arnd@arndb.de>
 <1427061770.4770.203.camel@kernel.crashing.org>
In-Reply-To: <1427061770.4770.203.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: sparclinux@vger.kernel.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>

On (03/23/15 09:02), Benjamin Herrenschmidt wrote:
> > How does this relate to the ARM implementation? There is currently
> > an effort going on to make that one shared with ARM64 and possibly
> > x86. Has anyone looked at both the PowerPC and ARM ways of doing the
> > allocation to see if we could pick one of the two to work on
> > all architectures?
> 
> What I see in ARM is horribly complex, I can't quite make sense of it
> in a couple of minutes of looking at it, and doesn't seem to address the
> basic issue we are addressing here which is the splitting of the iommu
> table lock.

Amen to that.. I thought it was just me :-)

I plan to go through the code to see if/where the armd iommu code
does its locking and achieves its parallelism, but the mapping
between the sparc/powerpc approach and armd is not immediately obvious
to me.

--Sowmini

