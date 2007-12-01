From: David Miller <davem@davemloft.net>
Date: Sat, 01 Dec 2007 12:12:10 +0000
Subject: Re: [ANNOUNCE] Aurora SPARC Linux Build 2.99 (Beta 2 for 3.0)
Message-Id: <20071201.041210.193707521.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1196454535.3432.18.camel@localhost.localdomain>
In-Reply-To: <1196454535.3432.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Fri, 30 Nov 2007 15:28:55 -0500

> - Smartd seems to make systems using the esp.ko SCSI driver very very
> unhappy. If your system is esp based, we highly recommend that you
> disable the smartd service in single-user before fully booting after
> install.

Didn't we spend half of last year fixing this via my
completely rewritten new driver? :-)

> - Most IDE based SPARC systems need to boot with ide=nodma.
> Specifically, Ultra 5/10 and Sun Blade 100s need this for sure.

I'll try to hit this and fix it when I get back from Korea.

> - Systems that boot off qlogic attached disks are not supported, because 
> there is no working firmware loader in anaconda, and the qlogic driver 
> needs firmware.

That's very unfortunate, how are qlogic device handled on other
platforms?

