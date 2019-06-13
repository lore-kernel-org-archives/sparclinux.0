From: David Miller <davem@davemloft.net>
Date: Thu, 13 Jun 2019 21:05:27 +0000
Subject: Re: [PATCH] sunhv: Fix device naming inconsistency between sunhv_console and sunhv_reg
Message-Id: <20190613.140527.636416300482814151.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190611153836.18950-1-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20190611153836.18950-1-glaubitz@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 11 Jun 2019 17:38:37 +0200

> In d5a2aa24, the name in struct console sunhv_console was changed from "ttyS"
> to "ttyHV" while the name in struct uart_ops sunhv_pops remained unchanged.
> 
> This results in the hypervisor console device to be listed as "ttyHV0" under
> /proc/consoles while the device node is still named "ttyS0":
> 
> root@osaka:~# cat /proc/consoles
> ttyHV0               -W- (EC p  )    4:64
> tty0                 -WU (E     )    4:1
> root@osaka:~# readlink /sys/dev/char/4:64
> ../../devices/root/f02836f0/f0285690/tty/ttyS0
> root@osaka:~#
> 
> This means that any userland code which tries to determine the name of the
> device file of the hypervisor console device can not rely on the information
> provided by /proc/consoles. In particular, booting current versions of debian-
> installer inside a SPARC LDOM will fail with the installer unable to determine
> the console device.
> 
> After renaming the device in struct uart_ops sunhv_pops to "ttyHV" as well,
> the inconsistency is fixed and it is possible again to determine the name
> of the device file of the hypervisor console device by reading the contents
> of /proc/console:
> 
> root@osaka:~# cat /proc/consoles
> ttyHV0               -W- (EC p  )    4:64
> tty0                 -WU (E     )    4:1
> root@osaka:~# readlink /sys/dev/char/4:64
> ../../devices/root/f02836f0/f0285690/tty/ttyHV0
> root@osaka:~#
> 
> With this change, debian-installer works correctly when installing inside
> a SPARC LDOM.
> 
> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Applied and queued up for -stable, thanks.
