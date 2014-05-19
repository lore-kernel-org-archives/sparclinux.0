From: =?UTF-8?q?Toralf=20F=C3=B6rster?= <toralf.foerster@gmx.de>
Date: Mon, 19 May 2014 08:26:31 +0000
Subject: [PATCH] fix format string mismatch in arch/sparc/kernel/sysfs.c
Message-Id: <1400487991-8857-1-git-send-email-toralf.foerster@gmx.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20140518185256.GB6194@ravnborg.org>
In-Reply-To: <20140518185256.GB6194@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

found by cppcheck

Signed-off-by: Toralf F=C3=B6rster <toralf.foerster@gmx.de>
---
 arch/sparc/kernel/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/sysfs.c b/arch/sparc/kernel/sysfs.c
index a364000..7f41d40 100644
--- a/arch/sparc/kernel/sysfs.c
+++ b/arch/sparc/kernel/sysfs.c
@@ -151,7 +151,7 @@ static ssize_t store_mmustat_enable(struct device *s,
 			size_t count)
 {
 	unsigned long val, err;
-	int ret =3D sscanf(buf, "%ld", &val);
+	int ret =3D sscanf(buf, "%lu", &val);
=20
 	if (ret !=3D 1)
 		return -EINVAL;
--=20
1.9.3

