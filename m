From: David Miller <davem@davemloft.net>
Date: Tue, 22 Dec 2009 01:44:04 +0000
Subject: Re: Checking for v9v/64v capability
Message-Id: <20091221.174404.104048717.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912220054220.25079@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912220054220.25079@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dennis Gilmore <dennis@ausil.us>
Date: Mon, 21 Dec 2009 18:19:37 -0600

> yum does this by checking /proc/cpuinfo look at /usr/lib/python2.6/site-
> packages/rpmUtils/arch.py on a F-12 box  and search for sun4v  rpm has a 
> similar check based on the same information. both will refuse to install a 
> sparcv9v package on hardware that is not capable of running it.

yum could also check the ELF startup flags, like glibc does,
for this purpose.
