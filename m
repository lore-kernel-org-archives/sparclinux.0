From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 04 Jan 2011 11:41:34 +0000
Subject: [PATCH 6/7] APBUART: added raw AMBA vendor/device number to match against.
Message-Id: <1294141295-26584-6-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 drivers/serial/apbuart.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/apbuart.c b/drivers/serial/apbuart.c
index cc01c65..7160345 100644
--- a/drivers/serial/apbuart.c
+++ b/drivers/serial/apbuart.c
@@ -580,6 +580,9 @@ static struct of_device_id __initdata apbuart_match[] = {
 	{
 	 .name = "GAISLER_APBUART",
 	 },
+	{
+	 .name = "01_00c",
+	 },
 	{},
 };
 
-- 
1.5.4

