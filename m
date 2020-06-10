From: Corentin Labbe <clabbe@baylibre.com>
Date: Wed, 10 Jun 2020 07:55:19 +0000
Subject: [PATCH] sparc: piggyback: handle invalid image
Message-Id: <1591775719-28390-1-git-send-email-clabbe@baylibre.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>

With an old elftoaout, the generation of tftpboot.img fail with "lseek:
invalid argument".
This is due to offset being negative.

Instead of printing this error message, let's print a better one.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/sparc/boot/piggyback.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sparc/boot/piggyback.c b/arch/sparc/boot/piggyback.c
index a7a38fb4ece0..613e23a1016e 100644
--- a/arch/sparc/boot/piggyback.c
+++ b/arch/sparc/boot/piggyback.c
@@ -154,6 +154,10 @@ static off_t get_hdrs_offset(int kernelfd, const char *filename)
 		offset -= LOOKBACK;
 		/* skip a.out header */
 		offset += AOUT_TEXT_OFFSET;
+		if (offset < 0) {
+			errno = -EINVAL;
+			die("Calculated a negative offset, probably elftoaout generated an invalid image. Did you use a recent elftoaout ?");
+		}
 		if (lseek(kernelfd, offset, SEEK_SET) < 0)
 			die("lseek");
 		if (read(kernelfd, buffer, BUFSIZE) != BUFSIZE)
-- 
2.26.2
