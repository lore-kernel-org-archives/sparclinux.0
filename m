From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 28 May 2012 03:43:48 +0000
Subject: [PATCH] sparc: fix bad merge of sparc Kconfig
Message-Id: <20120528134348.c934fef7360aa10683fc3a28@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Mon__28_May_2012_13_43_48_+1000_l.JAEKkPijOlMt9W"
List-Id: <sparclinux.vger.kernel.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

--Signature=_Mon__28_May_2012_13_43_48_+1000_l.JAEKkPijOlMt9W
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fixes this sparc32 defconfig build error:

timekeeping.c:(.text+0x277c4): undefined reference to `arch_gettimeoffset'

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/sparc/Kconfig |    1 -
 1 file changed, 1 deletion(-)

Dave, I have been carrying this merge fix in linux-next for a while and
now it is needed in Linus' tree.

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 9be0dd2..35e08fe 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -39,7 +39,6 @@ config SPARC32
 	def_bool !64BIT
 	select GENERIC_ATOMIC64
 	select CLZ_TAB
-	select ARCH_USES_GETTIMEOFFSET
=20
 config SPARC64
 	def_bool 64BIT
--=20
1.7.10.280.gaa39

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Mon__28_May_2012_13_43_48_+1000_l.JAEKkPijOlMt9W
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPwvR0AAoJEECxmPOUX5FEJDYP/3qLmftAmkgtAYym0k4lfoTo
yNcVe1D/XHVOWg0123+ex5mh90iRmggqiCQkfc1+FOiCPrKNUYg5Ve5A1xEF3bdI
mm1JKxMFJhUyD0LFBRhbm8rAdMXxxwoswGW4ZBR29NdH8cZ2aPeWJJLiPa3pbcpy
k9ghz3xVSnQVsXV5a6KaoD+BHnhTx9N6IYKNupe7wdyWWW86wTkieRtgfphmx27X
VMVHxOOikdxo4vLIqWtReTBDGpKCX/reVJuqO/VAQUJfA2BNcCypWQrNScFzaWnB
lmqBiLhnTnVpSX5dvENy+JrFExKz/JM/wB9Wte5+xAEnyMh3j3OeSz+6novN1odt
z4whzbaH6Gt+nlRWFg613sRVm5MfHujJpUpifWdHE1BhqY/BgHjDEV6ve8HWrKYJ
aNCRAcZ97zjiOTchbudawGyDYtDabEmu8JRzHREkENs5GdphgFVSdLN3uU39rcH8
gGVRsA/+VU0YYD/VaThUc9RmPMb2NrhIND1GtkPk8yVcalcxNza2hLcrMSKuX6Lz
BCzGrtYU8ER6BLfCrgSHJz9mfE4WkzxxKFLCyQ1hOUtABHZhBqLQGvsL8VkJ/6yf
SDqG8tGSfxcRDfiNW5oEo7JD5irYrWl/yS2uwy8AAd4asA3RP80HsofuodVW5M65
YtSwUW0rTo68ZZcEWSae
=XC6/
-----END PGP SIGNATURE-----

--Signature=_Mon__28_May_2012_13_43_48_+1000_l.JAEKkPijOlMt9W--
