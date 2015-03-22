From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sun, 22 Mar 2015 22:02:50 +0000
Subject: Re: Generic IOMMU pooled allocator
Message-Id: <1427061770.4770.203.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20150318.222517.1444725543017433108.davem@davemloft.net>
 <201503222036.02669.arnd@arndb.de>
In-Reply-To: <201503222036.02669.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: sparclinux@vger.kernel.org, sowmini.varadhan@oracle.com, linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>, paulus@samba.org

On Sun, 2015-03-22 at 20:36 +0100, Arnd Bergmann wrote:

> How does this relate to the ARM implementation? There is currently
> an effort going on to make that one shared with ARM64 and possibly
> x86. Has anyone looked at both the PowerPC and ARM ways of doing the
> allocation to see if we could pick one of the two to work on
> all architectures?

What I see in ARM is horribly complex, I can't quite make sense of it
in a couple of minutes of looking at it, and doesn't seem to address the
basic issue we are addressing here which is the splitting of the iommu
table lock.

I think we are looking at two very different approaches here. One is
to deal with horrendously broken HW which is an ARM SoC vendors
signature :) The other one is about performances and scalability on sane
HW.

Cheers,
Ben.

