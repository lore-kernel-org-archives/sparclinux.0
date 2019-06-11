From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 11 Jun 2019 15:38:37 +0000
Subject: [PATCH] sunhv: Fix device naming inconsistency between sunhv_console and sunhv_reg
Message-Id: <20190611153836.18950-1-glaubitz@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

In d5a2aa24, the name in struct console sunhv_console was changed from "ttyS"
to "ttyHV" while the name in struct uart_ops sunhv_pops remained unchanged.

This results in the hypervisor console device to be listed as "ttyHV0" under
/proc/consoles while the device node is still named "ttyS0":

root@osaka:~# cat /proc/consoles
ttyHV0               -W- (EC p  )    4:64
tty0                 -WU (E     )    4:1
root@osaka:~# readlink /sys/dev/char/4:64
../../devices/root/f02836f0/f0285690/tty/ttyS0
root@osaka:~#

This means that any userland code which tries to determine the name of the
device file of the hypervisor console device can not rely on the information
provided by /proc/consoles. In particular, booting current versions of debian-
installer inside a SPARC LDOM will fail with the installer unable to determine
the console device.

After renaming the device in struct uart_ops sunhv_pops to "ttyHV" as well,
the inconsistency is fixed and it is possible again to determine the name
of the device file of the hypervisor console device by reading the contents
of /proc/console:

root@osaka:~# cat /proc/consoles
ttyHV0               -W- (EC p  )    4:64
tty0                 -WU (E     )    4:1
root@osaka:~# readlink /sys/dev/char/4:64
../../devices/root/f02836f0/f0285690/tty/ttyHV0
root@osaka:~#

With this change, debian-installer works correctly when installing inside
a SPARC LDOM.

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 drivers/tty/serial/sunhv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index 63e34d868de8..f8503f8fc44e 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -397,7 +397,7 @@ static const struct uart_ops sunhv_pops = {
 static struct uart_driver sunhv_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "sunhv",
-	.dev_name		= "ttyS",
+	.dev_name		= "ttyHV",
 	.major			= TTY_MAJOR,
 };
 
-- 
2.21.0
