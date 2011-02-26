From: Kjetil Oftedal <oftedal@gmail.com>
Date: Sat, 26 Feb 2011 10:04:23 +0000
Subject: Re: [PATCH v3] Fix multiple RTC detections on SUN4D
Message-Id: <Pine.LNX.4.64.1102261057260.8080@oizys.tordivel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1010170628050.5462@oizys.tordivel.org>
In-Reply-To: <Pine.LNX.4.64.1010170628050.5462@oizys.tordivel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 25 Feb 2011, David Miller wrote:

> From: Kjetil Oftedal <oftedal@gmail.com>
> Date: Sun, 17 Oct 2010 06:38:57 +0200 (CEST)
> 
> 
> Fix the date on your computer, today is not Oct 17th 2010.
> 

Whoops. Resubmitting with the correct date in the e-mail header:

During the preparation for testing the recent changes made to the SUN4D
specific code in the kernel by Sam Ravnborg the following was discovered:

Since the removal of of_platform_bus_type (commit: eca3930163ba8884060ce9d9ff5ef0d9b7c7b00f )
multiboard SUN4Ds have not been able to boot. The kernel crashes due to a
zero-pointer error encountered when registering multiple M48T59 RTCs
(There is one on each board).

A patch for the was previously submitted, but the problem was not a
serious at that time, as it would only generate warnings. Now the kernel
will crash and stop executing before the serial console has been started.
(Crash output can be viewed by using the -p boot flag)

Signed-off-by: Kjetil Oftedal <oftedal@gmail.com>
---
 arch/sparc/kernel/time_32.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 9c743b1..ec8476d 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -150,6 +150,10 @@ static int __devinit clock_probe(struct platform_device *op, const struct of_dev
 	if (!model)
 		return -ENODEV;
 
+	/* Only the primary RTC has an address property */
+	if (!of_find_property(dp, "address", NULL))
+		return -ENODEV;
+
 	m48t59_rtc.resource = &op->resource[0];
 	if (!strcmp(model, "mk48t02")) {
 		/* Map the clock register io area read-only */
