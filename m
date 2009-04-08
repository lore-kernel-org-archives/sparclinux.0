From: David Miller <davem@davemloft.net>
Date: Wed, 08 Apr 2009 23:27:49 +0000
Subject: Re: SunFire V240 hangs
Message-Id: <20090408.162749.159628895.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090408200711.GA1142@frankengul.org>
In-Reply-To: <20090408200711.GA1142@frankengul.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: seb@frankengul.org
Date: Thu, 9 Apr 2009 01:25:42 +0200

> Here's the last known output of the kernel.
...
> [   49.357879] initcall cpu_type_probe+0x0/0x274 returned 0 after 0 usecs
> [   49.357885] calling  pcr_arch_init+0x0/0x14c @ 1
> [   55.

It looks like it's trying to print the timeout message but
hangs doing so :-)

This really should work, especially with the cpus you have
in that machine.

I'll try to find some time to put together some debugging
patches, but that's not going to happen any time soon as
I'm busy with several other tasks at the moment.
