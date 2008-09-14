From: David Miller <davem@davemloft.net>
Date: Sun, 14 Sep 2008 18:25:12 +0000
Subject: Re: 16550 serial support
Message-Id: <20080914.112512.92853537.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Sun, 14 Sep 2008 13:01:16 +0200

> I do wonder, however, why did sunsu register two ports, when there is no
> matching hardware... or maybe there is a chip that provides it, but there
> are no physical ports.

The chips are there on the motherboard, just not hooked up to
anything.

Look at /usr/bin/prtconf -pv output, they are there, and those
device nodes are what make the device attach.
