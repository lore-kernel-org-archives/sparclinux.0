From: Meelis Roos <mroos@linux.ee>
Date: Mon, 12 Apr 2004 08:01:56 +0000
Subject: smartctl & ioctl translation
Message-Id: <Pine.GSO.4.44.0404121100260.28876-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

smartctl -a does not work on 2.6.5 sparc64 (Debian unstable). Does the
kernel need some more ioctl32 translations or does smartmontools need a
recompile against newer headers?

ioctl32(smartctl:3717): Unknown cmd fd(3) cmd(0000031e){00} arg(effe0790) on /dev/hda

-- 
Meelis Roos (mroos@linux.ee)

