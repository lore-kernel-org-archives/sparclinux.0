From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Sat, 10 Sep 2005 19:50:46 +0000
Subject: Re: sparc family optimising support
Message-Id: <1126381846.25031.29.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20050910134013.GB7072@inskipp.digriz.org.uk>
In-Reply-To: <20050910134013.GB7072@inskipp.digriz.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 2005-09-10 at 14:40 +0100, Alexander Clouter wrote:
> Hi All,
> 
> Digging around I cannot see any reference to someone having done this before, 
> and not to come over as a Gentoo Ricer ;) but I rolled out the following 
> patch which does give me a bit more umpft from my old Sun 50Mhz Lunchbox[1].

This has been brought up before (my archives show a reference back in
March of 2004), and the answer was that doing this is pointless. The
sparc kernel patches in the hw versions of the muldiv functions at
kernel startup anyway, so passing -mcpu=v8 is just a waste.

So, any improvement that you see from -mcpu=v8 should be
psychosomatic... instead, I suspect the real valuable speed-up will come
from compiling the userspace applications with v8 opt.

Now, if you've got solid benchmark data showing repeatable performance
improvement by using some set of compiler opts on a sparc32 kernel, that
might be more interesting. ;)

~spot
-- 
Tom "spot" Callaway: Red Hat Senior Sales Engineer || GPG ID: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

