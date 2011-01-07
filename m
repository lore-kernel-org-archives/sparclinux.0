From: Meelis Roos <mroos@linux.ee>
Date: Fri, 07 Jan 2011 16:47:44 +0000
Subject: 2.6.37 sparc64 test report: good!
Message-Id: <alpine.SOC.1.00.1101070930410.16983@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Since 2.6.37 release, I have managed to build and test (by running 
Debian unstable apt-get upgrade) the following sparc64 machines using 
2.6.37, all of them successfully(*). Now there are new sparc updates in 
git... :)

Ultra 1
E450
E3000 (SBus)
E3500 (SBus + PCI)
U5
Blade 100
Fire V100
Netra X1

(*) The known problem is ALi IDE DMA and that stays somewhat broken. 
Last I tried the old IDE driver, it hung quicky during bootup, in random 
places. Have been using libata pata_ali since. It works fine for seeky 
loads like dist-upgrade but just hangs with streaming write when more 
bandwidth is used (like copying a large file from network).

-- 
Meelis Roos (mroos@linux.ee)
