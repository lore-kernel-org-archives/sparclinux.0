From: David Miller <davem@davemloft.net>
Date: Fri, 27 Nov 2009 07:30:05 +0000
Subject: Re: Boot problems on a V880
Message-Id: <20091126.233005.190980666.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200911262202.45791.pat@computer-refuge.org>
In-Reply-To: <200911262202.45791.pat@computer-refuge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Patrick Finnegan <pat@computer-refuge.org>
Date: Thu, 26 Nov 2009 22:02:45 -0500

> I seem to have a new/different problem with booting on a Sun V880.  I have 
> tried Debian/sarge, etch, and lenny installers, each fails.  After reading 
> through a bit of this list, I downloaded sparc-next-2.6 via git, and 
> compiled a kernel (based on Debian/lenny's 2.6.26-2-sparc64 kernel 
> config), and it still won't boot.  I also updated to the latest OpenBoot 
> image, hoping that would help, but I didn't see any difference.

sparc-next-2.6 doesn't have the bug fix, sparc-2.6 does
