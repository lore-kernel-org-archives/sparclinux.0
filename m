From: Kirill Tkhai <tkhai@yandex.ru>
Date: Thu, 23 May 2013 10:30:59 +0000
Subject: [sparc64] QEMU emulation
Message-Id: <890661369305059@web30d.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi, everyone!

Artyom Tarasenko, QEMU developer, has just fixed last known functional bug of sparc64 emulation:

http://wiki.qemu.org/ChangeLog/1.5

Now it's possible to use QEMU to test and develop kernel. It's possible to use instruction trace and
other useful functions.

The only exception is the fact hard disks are not supported (by openbios?), so it's necessary to use
virtual disks (CONFIG_VIRTIO_PCI and CONFIG_VIRTIO_BLK). Instruction to do this:

http://tyom.blogspot.ru/2013/03/debiansparc64-wheezy-under-qemu-how-to.html

Best wishes,
Kirill
