From: David Miller <davem@davemloft.net>
Date: Tue, 03 Apr 2007 06:39:43 +0000
Subject: Re: [ANNOUNCE] Aurora SPARC Linux Build 2.98 (Beta 1 for 3.0)
Message-Id: <20070402.233943.115908716.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1175577171.3531.131.camel@localhost.localdomain>
In-Reply-To: <1175577171.3531.131.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Tue, 03 Apr 2007 00:12:51 -0500

> - Most IDE based SPARC systems need to boot with ide=nodma.
> Specifically, Ultra 5/10 and Sun Blade 100s need this for sure.
> - While all apps are compiled with support for SELinux, it is disabled
> in both sparc32 and sparc64 kernels, because it doesn't work right. At
> all. It prevents the system from booting. 

These two are the most troubling problems.  Especially the first one,
as I haven't seen any IDE problem whatsoever on any of my Ultra10 (I
have 2), Ultra5, SB150, and SB1500 boxes.

Let's hope maybe it has something to do with how you build the kernels
for Aurora. :-)
