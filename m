From: David Miller <davem@davemloft.net>
Date: Sun, 26 May 2013 04:25:03 +0000
Subject: Re: [sparc64] QEMU emulation
Message-Id: <20130525.212503.2061673629807494310.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <890661369305059@web30d.yandex.ru>
In-Reply-To: <890661369305059@web30d.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Thu, 23 May 2013 14:30:59 +0400

> Artyom Tarasenko, QEMU developer, has just fixed last known functional bug of sparc64 emulation:
> 
> http://wiki.qemu.org/ChangeLog/1.5
> 
> Now it's possible to use QEMU to test and develop kernel. It's possible to use instruction trace and
> other useful functions.
> 
> The only exception is the fact hard disks are not supported (by openbios?), so it's necessary to use
> virtual disks (CONFIG_VIRTIO_PCI and CONFIG_VIRTIO_BLK). Instruction to do this:
> 
> http://tyom.blogspot.ru/2013/03/debiansparc64-wheezy-under-qemu-how-to.html

This is great news!

Awesome work to everyone who worked on that.
