From: Bob Breuer <breuerr@mc.net>
Date: Fri, 04 Mar 2005 05:21:54 +0000
Subject: [PATCH 2.6] enable sun logo on sparc32
Message-Id: <4227F072.1040606@mc.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080601000905030201080300"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------080601000905030201080300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This enables the sun linux logo to be selected on sparc32.

Signed-off-by: Bob Breuer <breuerr@mc.net>

Bob

--------------080601000905030201080300
Content-Type: text/plain;
 name="sparc32_sun_logo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sparc32_sun_logo.patch"

--- linux-2.6.11-clean/drivers/video/logo/Kconfig	2005-03-03 08:24:12.000000000 -0600
+++ linux-2.6.11/drivers/video/logo/Kconfig	2005-03-03 23:01:47.336863000 -0600
@@ -45,7 +45,7 @@
 
 config LOGO_SUN_CLUT224
 	bool "224-color Sun Linux logo"
-	depends on LOGO && (SPARC || SPARC64)
+	depends on LOGO && (SPARC32 || SPARC64)
 	default y
 
 config LOGO_SUPERH_MONO

--------------080601000905030201080300--
