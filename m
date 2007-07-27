From: Meelis Roos <mroos@linux.ee>
Date: Fri, 27 Jul 2007 19:23:53 +0000
Subject: ioctl32 warning on framebuffer
Message-Id: <Pine.SOC.4.64.0707272220560.1678@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Maybe related to the just solved X debugging problem, maybe not: 

I booted todays git (d941cf5e) on my U5 and XOrg is set to autostart 
(the box is currently headless so I do not know whether it actually 
works). Anyway, XOrg startup gives these 2 lines to dmesg:

ioctl32(Xorg:1892): Unknown cmd fd(6) cmd(40584606){t:'F';sz:88} arg(ffdabb4c) on /dev/fb0 
ioctl32(Xorg:1892): Unknown cmd fd(6) cmd(40184600){t:'F';sz:24} arg(ffdabb54) on /dev/fb0

-- 
Meelis Roos (mroos@linux.ee)
