From: Ben Collins <bcollins@debian.org>
Date: Sat, 05 Jun 2004 12:57:39 +0000
Subject: Re: new debian-installer images for sparc
Message-Id: <20040605125739.GA6370@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040531034458.GF2384@triplehelix.org>
In-Reply-To: <20040531034458.GF2384@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

FYI, someone reported that adding rootfstype=ext2 made the images
bootable. Looks like something in the kernel isn't checking the initrd
for ext2. So this may not be a SILO problem (I know Josh is already
aware of this, but others are probably interested in the results here).

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
