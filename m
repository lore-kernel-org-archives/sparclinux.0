From: David Miller <davem@davemloft.net>
Date: Sun, 14 Sep 2008 04:21:31 +0000
Subject: Re: 16550 serial support
Message-Id: <20080913.212131.74877304.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 13 Sep 2008 20:04:27 +0200

> On Sat, Sep 13, 2008 at 07:49:45PM +0200, Josip Rodin wrote:
> > After being put into the v240, they reliably stop working :/
> 
> Errrr, in another round of sparcs screwing with my mind :) I have almost
> accidentally gotten one combination to work - I plugged both ends of the
> cable into the Oxford card, and established communication between ttyS2 and
> ttyS3.
> 
> That can't be right...

That's perfectly correct, the first PCI card will get ttyS2 and ttyS3.

> Then I tried to experiment with plugging both ends of the cable into the
> (physical) Timedia card, and connecting minicoms via ttyS0 and ttyS1 -
> but that did not work.

Of course it won't work, ttyS0 and ttyS1 are the sunsu ports.

Try using ttyS4 and ttyS5 to get at the Timedia card.
