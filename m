From: Joel Stanley <joel@jms.id.au>
Date: Wed, 01 Apr 2015 07:16:48 +0000
Subject: [PATCH v2 3/3] powerpc/powernv: Reboot when requested by firmware
Message-Id: <1427871888-27331-3-git-send-email-joel@jms.id.au>
List-Id: <sparclinux.vger.kernel.org>
References: <1427871888-27331-1-git-send-email-joel@jms.id.au>
In-Reply-To: <1427871888-27331-1-git-send-email-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Cc: rusty@rustcorp.com.au, fabf@skynet.be, jk@ozlabs.org, akpm@linux-foundation.org, davem@davemloft.net

Use orderly_reboot so userspace will to shut itself down via the reboot
path. This is required for graceful reboot initiated by the BMC, such
as when a user uses ipmitool to issue a 'chassis power cycle' command.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/opal-power.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-power.c b/arch/powerpc/platforms/powernv/opal-power.c
index 48bf5b0..ac46c2c 100644
--- a/arch/powerpc/platforms/powernv/opal-power.c
+++ b/arch/powerpc/platforms/powernv/opal-power.c
@@ -29,8 +29,9 @@ static int opal_power_control_event(struct notifier_block *nb,
 
 	switch (type) {
 	case SOFT_REBOOT:
-		/* Fall through. The service processor is responsible for
-		 * bringing the machine back up */
+		pr_info("OPAL: reboot requested\n");
+		orderly_reboot();
+		break;
 	case SOFT_OFF:
 		pr_info("OPAL: poweroff requested\n");
 		orderly_poweroff(true);
-- 
2.1.4

