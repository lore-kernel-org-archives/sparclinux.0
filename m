From: David Miller <davem@davemloft.net>
Date: Thu, 11 Mar 2010 02:24:05 +0000
Subject: Re: XVR-500 additional pci ids
Message-Id: <20100310.182405.34616892.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201002251955.23519.dennis@ausil.us>
In-Reply-To: <201002251955.23519.dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans van Berckel <fberckel@xs4all.nl>
Date: Tue, 02 Mar 2010 09:20:39 +0100

> But I wanne get my XVR-1200 supported by the kernel.

Can you get me "prtconf -pv" or "lspci" output with the card
installed?

I think just adding the matching PCI device ID to the driver should
allow the card to work just fine.

So if someone can get me the PCI device ID for these other XVR-*
cards, I can add them to the driver.
