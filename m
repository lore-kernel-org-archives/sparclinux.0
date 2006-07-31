From: David Miller <davem@davemloft.net>
Date: Mon, 31 Jul 2006 20:47:08 +0000
Subject: Re: serial console broken on Ultra 5
Message-Id: <20060731.134708.63997744.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 31 Jul 2006 15:43:22 +0300 (EEST)

> Linux version 2.6.18-rc3 (mroos@mandariin) (gcc version 4.1.2 20060715 (prerelease) (Debian 4.1.1-9)) #137 Mon Jul 31 15:09:20o6

Retry with gcc-4.0.x please.

Debian's 4.1.x sparc gcc couldn't even build the sun partition
handling code corrently just a few months ago.

Therefore, my confidence in Debian's 4.1.x compiler is basically nil.
