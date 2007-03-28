From: Robert Reif <reif@earthlink.net>
Date: Wed, 28 Mar 2007 23:07:27 +0000
Subject: [PATCH] fix sparse warning in of_device.c
Message-Id: <460AF52F.1080204@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040805020405080406030905"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------040805020405080406030905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix sparse warning:

arch/sparc/kernel/of_device.c:439:46: warning: incorrect type in 
argument 3 (different signedness)
arch/sparc/kernel/of_device.c:439:46:    expected int *lenp
arch/sparc/kernel/of_device.c:439:46:    got unsigned int *<noident>

Signed-off-by: Robert Reif <reif@erathlink.net>


--------------040805020405080406030905
Content-Type: text/plain;
 name="of_device.c.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="of_device.c.diff.txt"

diff --git a/arch/sparc/kernel/of_device.c b/arch/sparc/kernel/of_device.c
index 48c24f7..8c81689 100644
--- a/arch/sparc/kernel/of_device.c
+++ b/arch/sparc/kernel/of_device.c
@@ -433,7 +433,7 @@ static int __init build_one_resource(str
 				     int na, int ns, int pna)
 {
 	u32 *ranges;
-	unsigned int rlen;
+	int rlen;
 	int rone;
 
 	ranges = of_get_property(parent, "ranges", &rlen);

--------------040805020405080406030905--

