From: Mikael Pettersson <mikpe@it.uu.se>
Date: Sun, 09 Jul 2006 10:40:58 +0000
Subject: 2.6.18-rc1 fails to boot on Ultra 5
Message-Id: <200607091040.k69AewNu019891@harpo.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

2.6.17-git7 was the last development kernel to boot on my U5.
2.6.17-git8 to -git15 all hang immediately after being loaded.
2.6.17-git16 to 2.6.18-rc1 partially boot but crash and burn in
different places depending on kernel configuration: my standard
config got alignment exceptions in the floppy driver followed by
(sabre?) PCI errors and a hang; a minimal kernel gets further but
fails "su" probe and then oopses hard when the /dev/hda partition
table is about to be printed.

I'll try to capture the kernel messages soon, but I don't have
a null-modem serial cable to the U5 yet, and my attempts to use
a digital camera only resulted in blurry pictures of the screen :-(

/Mikael
