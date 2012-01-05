From: David Miller <davem@davemloft.net>
Date: Thu, 05 Jan 2012 19:27:02 +0000
Subject: Re: SPARC32: forced setting of mode of SUN4M per-cpu timers
Message-Id: <20120105.142702.330568223366195283.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1325727738.1385.3.camel@hp>
In-Reply-To: <1325727738.1385.3.camel@hp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Thu, 05 Jan 2012 05:42:18 +0400

> I had this problem with OpenBIOS. Timers don't tick and kernel fails on
> QEMU, when it's compiled with SMP support. The path fixes problem.

This means that OpenBIOS does not provide the hardware to the client
program in the same state that OpenFirmware does, which in my opinion
is a bug.

We can still apply a patch like this, but I'd like to see it tested
on real hardware and OpenFirmware machines.
