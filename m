From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 23 Jun 2012 11:43:56 +0000
Subject: Failure to detect CD-ROM in T5120
Message-Id: <20120623114356.GA4452@wooyd.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

Does anyone on this list run recent kernels on a T5120 (or 
similar) machine? We have received a report of Debian installation 
failure on it (http://bugs.debian.org/678264), caused by a failure to 
detect the CD-ROM drive. Apparently, on these machines CD-ROM is 
connected via USB, but simply loading usb_storage (USB mass storage) 
kernel module does not do the trick.

If you have such a machine and CD-ROM is working for you under Linux, 
I would appreciate if you could post the verbose output of lsusb and 
lsmod, as well as any udev recipes you might have to get this to work.

Thanks,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
