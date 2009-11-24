From: David Miller <davem@davemloft.net>
Date: Tue, 24 Nov 2009 22:21:26 +0000
Subject: [PATCH 2/7]: sunsab: Do not set sunsab_reg.cons right before
Message-Id: <20091124.142126.58846336.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Other Sun serial drivers do not do this, and if we keep it this way
it ends up registering all serial devices as consoles rather than
just the one which we explicitly register via sunserial_console_match()
which uses add_preferred_console().

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/serial/sunsab.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/sunsab.c b/drivers/serial/sunsab.c
index d1ad341..8755de8 100644
--- a/drivers/serial/sunsab.c
+++ b/drivers/serial/sunsab.c
@@ -1116,7 +1116,6 @@ static int __init sunsab_init(void)
 		if (!sunsab_ports)
 			return -ENOMEM;
 
-		sunsab_reg.cons = SUNSAB_CONSOLE();
 		err = sunserial_register_minors(&sunsab_reg, num_channels);
 		if (err) {
 			kfree(sunsab_ports);
-- 
1.6.5.3

