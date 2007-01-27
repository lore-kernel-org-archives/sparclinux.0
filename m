From: David Miller <davem@davemloft.net>
Date: Sat, 27 Jan 2007 02:10:40 +0000
Subject: Re: Linux on Sun e10k
Message-Id: <20070126.181040.55506125.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1169241607.30406.19.camel@duo.jes.ee>
In-Reply-To: <1169241607.30406.19.camel@duo.jes.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 26 Jan 2007 16:15:30 -0600

> Warning: unable to open an initial console.

Enable PROM console, that should get you going at least
enough to boot into userspace, you won't be able to type
any input but it should get a /dev/console and be able to
thus boot past that point.

Adding proper support for the e10K console would be a nice
easy sparc64 kernel project for someone who wants to get
involved and has access to such a machine.

Don't bother with netconsole support.
