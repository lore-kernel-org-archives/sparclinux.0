From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 29 Jul 2005 03:01:03 +0000
Subject: Re: fd0 not found
Message-Id: <20050728.200103.115906328.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <42E61753.8050502@cpttm.org.mo>
In-Reply-To: <42E61753.8050502@cpttm.org.mo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kumba <kumba@gentoo.org>
Date: Thu, 28 Jul 2005 22:16:28 -0400

> I don't suppose any of the kludges found in OpenSolaris code are
> portable into linux sources to address some of the design
> flaws/oddities? (Portable meaning license friendly, etc..)

Solaris uses interrupt threads, which can thus block in interrupt
context, which is how they are able to kludge around this.

So they just make the interrupt thread block when an I/O port
access is attempted on any of the ISA bus devices while a DMA
transfer is running.

Linux doesn't have interrupt threads, so we can't deal with it that
way.

Furthermore, anyone planning to "learn something" from opensolaris and
then incorporate such things into Linux had better well explicitly
implement and properly document a closed room implementation where one
person reads the OpenSolaris code, explains what is happening to
another person, who in turn implements the Linux version.

Otherwise there are grave contamination and copyright infringement
issues possible.  One would, in addition to the properly documented
closed room implementation, need to do a patent check on the ideas
being copied over as well.

As a result of all that, looking to OpenSolaris for information to
help out the Linux sparc port is a bad idea.
