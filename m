From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 11 Oct 2007 05:24:48 +0000
Subject: [PATCH] [SPARC/64] move of_platform_driver initialisations:
Message-Id: <20071011152448.c762f034.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

We no longer initialise the name field of the of_platform_driver, but
use the name field of the embedded device_driver's name field instead.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/sparc/kernel/time.c    |    4 +++-
 arch/sparc64/kernel/auxio.c |    4 +++-
 arch/sparc64/kernel/power.c |    4 +++-
 arch/sparc64/kernel/time.c  |    4 +++-
 4 files changed, 12 insertions(+), 4 deletions(-)

This depends on my previous patch "Prepare to remove of_platform_driver
name" for Sparc.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/sparc/kernel/time.c b/arch/sparc/kernel/time.c
index 6a25133..4bf78a5 100644
--- a/arch/sparc/kernel/time.c
+++ b/arch/sparc/kernel/time.c
@@ -347,9 +347,11 @@ static struct of_device_id clock_match[] = {
 };
 
 static struct of_platform_driver clock_driver = {
-	.name		= "clock",
 	.match_table	= clock_match,
 	.probe		= clock_probe,
+	.driver		= {
+		.name	= "clock",
+	},
 };
 
 
diff --git a/arch/sparc64/kernel/auxio.c b/arch/sparc64/kernel/auxio.c
index 7b37976..c55f029 100644
--- a/arch/sparc64/kernel/auxio.c
+++ b/arch/sparc64/kernel/auxio.c
@@ -148,9 +148,11 @@ static int __devinit auxio_probe(struct of_device *dev, const struct of_device_i
 }
 
 static struct of_platform_driver auxio_driver = {
-	.name		= "auxio",
 	.match_table	= auxio_match,
 	.probe		= auxio_probe,
+	.driver		= {
+		.name	= "auxio",
+	},
 };
 
 static int __init auxio_init(void)
diff --git a/arch/sparc64/kernel/power.c b/arch/sparc64/kernel/power.c
index 881a09e..850cdff 100644
--- a/arch/sparc64/kernel/power.c
+++ b/arch/sparc64/kernel/power.c
@@ -105,9 +105,11 @@ static struct of_device_id power_match[] = {
 };
 
 static struct of_platform_driver power_driver = {
-	.name		= "power",
 	.match_table	= power_match,
 	.probe		= power_probe,
+	.driver		= {
+		.name	= "power",
+	},
 };
 
 void __init power_init(void)
diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index 69cad1b..cd8c740 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -764,9 +764,11 @@ static struct of_device_id clock_match[] = {
 };
 
 static struct of_platform_driver clock_driver = {
-	.name		= "clock",
 	.match_table	= clock_match,
 	.probe		= clock_probe,
+	.driver		= {
+		.name	= "clock",
+	},
 };
 
 static int __init clock_init(void)
-- 
1.5.3.4

