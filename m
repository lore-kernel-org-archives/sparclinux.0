From: Marc Zyngier <maz@misterjones.org>
Date: Sat, 05 Aug 2006 13:07:36 +0000
Subject: Re: [PATCH] Fix E250 console with RSC
Message-Id: <wrpu04rib53.fsf@wild-wind.fr.eu.org>
List-Id: <sparclinux.vger.kernel.org>
References: <wrpwt9nk17j.fsf_-_@wild-wind.fr.eu.org>
In-Reply-To: <wrpwt9nk17j.fsf_-_@wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>>>>> "Daniel" = Daniel Smolik <marvin@mydatex.cz> writes:

Daniel> Thanks Marc for patch. It works great for me. No crash and my
Daniel> E250 now boots.

Thanks for testing.

Daniel> But in dmesg i found this:
Daniel>  se@14,200000: ttyS3 at MMIO 0x1fff1200040 (irq = 8) is a SAB82532 V3.2
Daniel> I mean that my E250 have only 2 ports + RSC console. Am I right ?

That's expected.

The E250 contains two SAB82532. One is wired to ttya and ttyb
(resp. ttyS0 and ttyS1), and the other has its first port wired to the
RSC (ttyS2). The last port, detected as ttyS3 is probably used to
manage the RSC itself (creating users and such, using the Solaris
tools):

maz@positive:/proc/openprom/aliases$ cat tty[cd]
/pci@1f,4000/ebus@1/se@14,200000:ssp
/pci@1f,4000/ebus@1/se@14,200000:sspctl

Would be nice to understand the protocol between the E250 and the RSC
(so we could have proper Linux tools to manage it), but I'm not sure
Sun ever made it public...

	M.
-- 
And if you don't know where you're going, any road will take you there...
