From: David Miller <davem@davemloft.net>
Date: Tue, 30 Oct 2007 02:11:41 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071029.191141.193985060.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bernd Zeimetz <bernd@bzed.de>
Date: Tue, 30 Oct 2007 02:54:14 +0100

> Ok. Do you have a .deb with a kernel for me? If not - would you like to
> have any specific options enabled - I have to build one then.

I usually just "cp arch/sparc64/defconfig ./.config" in a fresh
vanilla kernel tree and tweak from there.

For my 280R I enabled SMP, accepted the NR_CPUS default value (64),
set SERIAL_SUNSAB to "y" and enabled console support, and then enabled
the qlogic fibrechannel driver and the SUNGEM driver as modules.

Oh yes, I also enabled INITRD support so I can use initramfs to get
the firmware loaded properly in the qlogic FC card.

Really, I don't use anything fancy, just enough to get the machine
functional.
