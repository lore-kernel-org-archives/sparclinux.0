From: David Miller <davem@davemloft.net>
Date: Thu, 05 Aug 2010 00:30:43 +0000
Subject: Re: parport on Sun Blade 2500 Red ?
Message-Id: <20100804.173043.116396197.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <19422.55728.571998.756336@pilspetsen.it.uu.se>
In-Reply-To: <19422.55728.571998.756336@pilspetsen.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Mon, 3 May 2010 16:12:00 +0200

> According to Sun's documentation, a Sun Blade 2500 Red includes
> a PC-style parallel port.
> 
> If I build a kernel (any recent 2.6 kernel) with plain parport
> support (PARPORT_PC=y), there are no kernel messages of any kind
> related to parport, indicating it didn't find one.

Just a missing device ID in the driver, give this patch a try:

--------------------
sparc64: Add missing ID to parport probing code.

SunBlade-2500 has 'parallel' device node with compatible
property "pnpALI,1533,3" so add that to the ID table.

Reported-by: Mikael Pettersson <mikpe@it.uu.se>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/parport.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/parport.h b/arch/sparc/include/asm/parport.h
index c333b8d..d21ad50 100644
--- a/arch/sparc/include/asm/parport.h
+++ b/arch/sparc/include/asm/parport.h
@@ -228,6 +228,10 @@ static const struct of_device_id ecpp_match[] = {
 		.name = "parallel",
 		.compatible = "ns87317-ecpp",
 	},
+	{
+		.name = "parallel",
+		.compatible = "pnpALI,1533,3",
+	},
 	{},
 };
 
-- 
1.7.1.1

