From: Adrian Bunk <bunk@stusta.de>
Date: Sat, 17 Dec 2005 14:10:49 +0000
Subject: [2.6 patch] on sparc{,64}, RTC must depend on PCI
Message-Id: <20051217141049.GP23349@stusta.de>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0512160832350.995@innerfire.net> <20051216222154.GK23349@stusta.de> <Pine.LNX.4.64.0512161908460.20531@innerfire.net>
In-Reply-To: <Pine.LNX.4.64.0512161908460.20531@innerfire.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gerhard Mack <gmack@innerfire.net>, wli@holomorphy.com, davem@davemloft.net, ecd@brainaid.de, jj@sunsite.ms.mff.cuni.cz, anton@samba.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Fri, Dec 16, 2005 at 07:10:05PM -0500, Gerhard Mack wrote:
> 
> I always forget that for some reason.
> If I disable CONFIG_RTC it compiles cleanly.

That's expected since this is the driver that breaks the build.

The patch below adds the dependency of CONFIG_RTC on CONFIG_PCI on the 
sparc architecture.

> 	Gerhard

cu
Adrian

BTW: @sparc maintainers:
     Is there any reason against introducing a SPARC Kconfig symbol
     that is set on both the sparc and sparc64 architectures?


<--  snip  -->


On sparc and sparc64, the rtc driver doesn't compile with PCI support 
disabled.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14.4/drivers/char/Kconfig.old	2005-12-17 15:03:06.000000000 +0100
+++ linux-2.6.14.4/drivers/char/Kconfig	2005-12-17 15:03:33.000000000 +0100
@@ -687,7 +687,7 @@
 
 config RTC
 	tristate "Enhanced Real Time Clock Support"
-	depends on !PPC32 && !PARISC && !IA64 && !M68K
+	depends on !PPC32 && !PARISC && !IA64 && !M68K && (!(SPARC32 || SPARC64) || PCI)
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you

