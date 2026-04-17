Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0072D0C9D;
	Fri, 17 Apr 2026 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412509; cv=none; b=uhQedXIFtDxm/+0t+w48UAEn4cTUgocomiFCcF4g5dDfBkIPzkw8062NE70V7ihtfT/AstHXsBwC/hj//naRpxfX+auJaQtM5bwdEzEYQmsEyJGA5KhyctZF45qyznyQqaSD5mhski0bluSoeqxgWi34lxxDU4wl4mRkckrPr2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412509; c=relaxed/simple;
	bh=QJWOQg1OEDPm1eMtA9Ud52kmNM1YLJc4TL3itkN150Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iqxtHu5lUc9nimJMkTcVxJlMY7WBWcBtSO3M6F6PmwEyXJEy2aOvnw5UmFVYlYN4G/jODFSIbw+vOlg2eMLFzbfBXjR22O5yVhhnWr+fMUMII8Zfk4M+/m9W6iBdmSMT8x2KCxl5o1Fb4YnFYXmTvjTN4LF0GXkF5xAIK0AlXuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowADndwtU5+FpplzYDQ--.226S2;
	Fri, 17 Apr 2026 15:55:00 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] sparc32: prom: check OF console path formatting against the early buffer
Date: Fri, 17 Apr 2026 15:54:58 +0800
Message-ID: <20260417075458.31262-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADndwtU5+FpplzYDQ--.226S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4rGr48Kr1DXF48Kw48JFb_yoW5WF4fpr
	9xJF13Xr45ZF43WF4avr1kZr9Yva1rJ3W7Kws3tw47uFnxA3y8ua42yw4fZ3yDJFy3Gr1j
	ya90vFsxGF17AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUxcT
	PUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

of_console_init() allocates a fixed 256-byte buffer for the console path
and then formats "%pOF" into it with sprintf(), optionally appending
":a" or ":b" with strcat().

The full OF path is not bounded to fit in that early buffer, so the
console path formatting can overrun the allocation before the buffer is
published globally.

Use snprintf()/strlcat() and halt early if the console path does not fit
in the fixed early allocation.

Fixes: c73fcc846c91 ("[SPARC]: Fix serial console device detection.")
Fixes: a412c85aa82a ("sparc: Convert to using %pOF instead of full_name")

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/sparc/kernel/prom_32.c | 65 +++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index cd94f1e8d644..7bfede7e64d2 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -245,15 +245,23 @@ void __init of_console_init(void)
 		if (!dp) {
 			prom_printf("Cannot find PROM_V0 console node.\n");
 			prom_halt();
-		}
-		of_console_device = dp;
+			}
+			of_console_device = dp;
 
-		sprintf(of_console_path, "%pOF", dp);
-		if (!strcmp(type, "serial")) {
-			strcat(of_console_path,
-			       (skip ? ":b" : ":a"));
-		}
-		break;
+			if (snprintf(of_console_path, of_console_path_sz,
+				     "%pOF", dp) >= of_console_path_sz) {
+				prom_printf("PROM_V0 console path is too long.\n");
+				prom_halt();
+			}
+			if (!strcmp(type, "serial")) {
+				if (strlcat(of_console_path, skip ? ":b" : ":a",
+					    of_console_path_sz) >=
+				    of_console_path_sz) {
+					prom_printf("PROM_V0 console path options are too long.\n");
+					prom_halt();
+				}
+			}
+			break;
 
 	default:
 	case PROM_V2:
@@ -279,18 +287,35 @@ void __init of_console_init(void)
 			prom_halt();
 		}
 
-		of_console_device = dp;
-
-		if (prom_vers == PROM_V2) {
-			sprintf(of_console_path, "%pOF", dp);
-			switch (*romvec->pv_stdout) {
-			case PROMDEV_TTYA:
-				strcat(of_console_path, ":a");
-				break;
-			case PROMDEV_TTYB:
-				strcat(of_console_path, ":b");
-				break;
-			}
+			of_console_device = dp;
+
+			if (prom_vers == PROM_V2) {
+				if (snprintf(of_console_path, of_console_path_sz,
+					     "%pOF", dp) >=
+				    of_console_path_sz) {
+					prom_printf("PROM_V2 console path is too long.\n");
+					prom_halt();
+				}
+				switch (*romvec->pv_stdout) {
+				case PROMDEV_TTYA:
+					if (strlcat(of_console_path, ":a",
+						    of_console_path_sz) >=
+					    of_console_path_sz) {
+						prom_printf("%s",
+							    "PROM_V2 console path options are too long.\n");
+						prom_halt();
+					}
+					break;
+				case PROMDEV_TTYB:
+					if (strlcat(of_console_path, ":b",
+						    of_console_path_sz) >=
+					    of_console_path_sz) {
+						prom_printf("%s",
+							    "PROM_V2 console path options are too long.\n");
+						prom_halt();
+					}
+					break;
+				}
 		} else {
 			const char *path;
 
-- 
2.50.1 (Apple Git-155)

