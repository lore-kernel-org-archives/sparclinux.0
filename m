From: Meelis Roos <mroos@linux.ee>
Date: Thu, 01 Apr 2004 06:06:50 +0000
Subject: ioctl32 translations for clock
Message-Id: <Pine.GSO.4.44.0404010904270.8073-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is 2.6.5-rc1 on an Ultra 5 running Debian unstable up-to-date (with
udev 0.23-3).

ioctl32(hwclock:451): Unknown cmd fd(3) cmd(00004b50){00} arg(effffc58) on /dev/tty1
ioctl32(hwclock:454): Unknown cmd fd(3) cmd(00004b50){00} arg(effffc48) on /dev/tty1
ioctl32(hwclock:455): Unknown cmd fd(3) cmd(00004b50){00} arg(effffc58) on /dev/tty1

and hwclock tells at the same time
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access method.
System time was Thu Apr  1 06:01:10 UTC 2004.
Setting the System Clock using the Hardware Clock as reference...
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access method.
System Clock set. System local time is now Thu Apr  1 06:01:11 UTC 2004.

Looks like a missing ioctl32 translation?

-- 
Meelis Roos (mroos@linux.ee)

