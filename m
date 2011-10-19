From: David Miller <davem@davemloft.net>
Date: Wed, 19 Oct 2011 23:29:17 +0000
Subject: Re: [PATCH] sparc: Add alignment flag to PCI expansion resources
Message-Id: <20111019.192917.744226914732883492.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1110162056340.25694@oizys.tordivel.org>
In-Reply-To: <Pine.LNX.4.64.1110162056340.25694@oizys.tordivel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kjetil Oftedal <oftedal@gmail.com>
Date: Sun, 16 Oct 2011 21:12:00 +0200 (CEST)

> Currently no type of alignment is specified for PCI expansion roms while 
> parsing the openfirmware tree. This causes calls to pci_map_rom() to fail.
> IORESOURCE_SIZEALIGN is the default alignment used for rom resouces in 
> pci/probe.c, and has been verified to work with various cards on a ultra 10.
> 
> Signed-Off-By: Kjetil Oftedal <oftedal@gmail.com>

Applied, thanks.
