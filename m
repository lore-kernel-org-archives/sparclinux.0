From: David Miller <davem@davemloft.net>
Date: Fri, 24 Apr 2009 15:44:52 +0000
Subject: Re: SunFire V240 hangs
Message-Id: <20090424.084452.105990378.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090408200711.GA1142@frankengul.org>
In-Reply-To: <20090408200711.GA1142@frankengul.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I notice in your kernel logs that you're using an Ubuntu gcc version
4.3.x.

How in the world is that possible?

Ubuntu sparc support stopped after Ubuntu version 7.10 and that
shipped with gcc-4.1.x as the default compiler.  That's what I use
for most of my testing FWIW.  On my debian boxes I use the
default gcc-4.3.2 based compiler.

If you're using a custom built compiler, we're going to have to do
some tests to rule that out as the cause of your problems I think.
