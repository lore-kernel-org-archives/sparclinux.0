From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 23 Mar 2005 02:11:24 +0000
Subject: Re: sunqe driver does not recognize the card
Message-Id: <20050322181124.5ff2a56e.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0503221048210.29185@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0503221048210.29185@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 22 Mar 2005 17:46:59 -0800
Eric Brower <ebrower@gmail.com> wrote:

> On Tue, 22 Mar 2005 10:51:26 +0200 (EET), Meelis Roos <mroos@linux.ee> wrote:
> > I have a Sparcstation 20 with qec/be card (Sun FastEthernet). I have
> > compiled the sunqe module in 2.6.12-rc1 and it does not load - complains
> > about no such device:
> > FATAL: Error inserting sunqe (/lib/modules/2.6.12-rc1/kernel/drivers/net/sunqe.ko): No such device
> > Nothing is in the dmesg.
> > 
> > This is the info about the card - should it be supported?
> 
> Have you tried the sunbmac driver instead?

Yes, that is the correct driver for the "be" device.
The sunqe driver is for qec/qe cards.
