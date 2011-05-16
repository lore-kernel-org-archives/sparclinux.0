From: David Miller <davem@davemloft.net>
Date: Mon, 16 May 2011 20:01:30 +0000
Subject: Re: [PATCH 0/2] sparc32,leon: PCI patches
Message-Id: <20110516.130130.226775028.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4DB68838.1020304@gaisler.com>
In-Reply-To: <4DB68838.1020304@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 26 Apr 2011 10:54:16 +0200

> There is no BIOS or bootloader initializing PCI for use in comparison
> to the PCIC-SPARC32 code. LEON rely on the Linux generic resource &

Well since the kernel doesn't support Leon/PCI yet you still have
an opportunity to "fix" this.

This is going to create an enormous huge inconsistency between
Leon and other SPARC PCI implementations, so please avoid this
special case.

Create the device tree nodes, via whatever means possible, and that
way you won't have to implement anything special in the kernel.

I'm not applying these patches.
