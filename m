From: David Miller <davem@davemloft.net>
Date: Sun, 16 Jan 2011 05:06:46 +0000
Subject: Re: silo fails to build with e2fsprogs-1.41.14 (undefined
Message-Id: <20110115.210646.183046857.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4D2B59AC.8040203@gentoo.org>
In-Reply-To: <4D2B59AC.8040203@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alex Buell <alex.buell@munted.org.uk>
Date: Sat, 15 Jan 2011 12:57:09 +0000

> I think there is a bug in e2fsprogs as it doesn't seem to properly
> handle error codes returned by the posix_memalign() function. It's
> either that or a proper implementation of posix_memalign() function
> needs to be detected through the configure scripts.

I think it requires a real properly functioning posix_memalign().

The issue is that the detection occurs when the e2fsprogs package
is built, and in userland's libc there is in fact a full and
functioning posix_memalign().  So e2fsprogs is doing nothing wrong.

The problem is that SILO is linking e2fsprogs into it's limited
environment, and we have to bolt on hacks over time as e2fsprogs
depends upon newer facilities in userland.

I'll try to fix this.
