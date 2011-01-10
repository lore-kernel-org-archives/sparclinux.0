From: David Miller <davem@davemloft.net>
Date: Mon, 10 Jan 2011 19:29:07 +0000
Subject: Re: silo fails to build with e2fsprogs-1.41.14 (undefined
Message-Id: <20110110.112907.235685272.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4D2B59AC.8040203@gentoo.org>
In-Reply-To: <4D2B59AC.8040203@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Ra=FAl Porcel <armin76@gentoo.org>
Date: Mon, 10 Jan 2011 20:10:36 +0100

> Hi,
>=20
> SILO fails to build here with e2fsprogs-1.41.14 installed, i'm attaching
> the build log.

I really appreciate how they make libext2 harder and harder to link into
embedded self-contained things like bootloaders over time.

I just pushed the following fix for this:

--------------------
second: Add dummy posix_memalign stubb for libext2

Reported-by: Ra=FAl Porcel <armin76@gentoo.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 second/fs/ext2.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/second/fs/ext2.c b/second/fs/ext2.c
index 57f5e9a..12d00dc 100644
--- a/second/fs/ext2.c
+++ b/second/fs/ext2.c
@@ -163,3 +163,9 @@ void *realloc(void *p, int size)
 {
         return NULL;
 }
+
+int posix_memalign(void **memptr, size_t alignment, size_t size)
+{
+	*memptr =3D NULL;
+	return -1;
+}
--=20
1.7.3.4

