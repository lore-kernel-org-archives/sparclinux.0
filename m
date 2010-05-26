From: David Miller <davem@davemloft.net>
Date: Wed, 26 May 2010 06:51:54 +0000
Subject: Re: Serial console issue with 2.6.32
Message-Id: <20100525.235154.189709335.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201003151809.27436.elendil@planet.nl>
In-Reply-To: <201003151809.27436.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans Pop <elendil@planet.nl>
Date: Wed, 17 Mar 2010 11:50:07 +0100

> Now that I know it's not a huge issue for me personally. It just means I 
> can no longer use my Sparc box for testing use of console= for Debian 
> installations, which is a pity as it's the most suitable box I have for 
> that.
> 
> I'm not sure how much this is going to throw off other users, but I suspect 
> the majority (except maybe for long time sparc sysadmins) would expect 
> console= to be honored.

Frans, is this patch enough to get the behavior you want?

--------------------
sunserial: Don't call add_preferred_console() when console= is specified.

Reported-by: Frans Pop <elendil@planet.nl>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/serial/suncore.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/suncore.c b/drivers/serial/suncore.c
index ed7d958..544f2e2 100644
--- a/drivers/serial/suncore.c
+++ b/drivers/serial/suncore.c
@@ -71,7 +71,9 @@ int sunserial_console_match(struct console *con, struct device_node *dp,
 
 	con->index = line;
 	drv->cons = con;
-	add_preferred_console(con->name, line, NULL);
+
+	if (!console_set_on_cmdline)
+		add_preferred_console(con->name, line, NULL);
 
 	return 1;
 }
-- 
1.7.0.4

