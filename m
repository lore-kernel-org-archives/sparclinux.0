From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 17 Jun 2019 14:36:12 +0000
Subject: [PATCH] sparc64: Add missing newline at end of file
Message-Id: <20190617143612.4810-1-geert+renesas@glider.be>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "David S . Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

"git diff" says:

    \ No newline at end of file

after modifying the file.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sparc/lib/NG4clear_page.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/lib/NG4clear_page.S b/arch/sparc/lib/NG4clear_page.S
index 97e2678d042a3390..d91d6b5f2444aef6 100644
--- a/arch/sparc/lib/NG4clear_page.S
+++ b/arch/sparc/lib/NG4clear_page.S
@@ -27,4 +27,4 @@ NG4clear_user_page:	/* %o0=DEst, %o1=3Dvaddr */
 	retl
 	 nop
 	.size		NG4clear_page,.-NG4clear_page
-	.size		NG4clear_user_page,.-NG4clear_user_page
\ No newline at end of file
+	.size		NG4clear_user_page,.-NG4clear_user_page
--=20
2.17.1
