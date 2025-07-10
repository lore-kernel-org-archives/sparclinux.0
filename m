Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A147B27056F;
	Thu, 10 Jul 2025 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158129; cv=none; b=Qlx1xt7rUd6Xv3wUmkF4DZ87PNDObcvHjxshrLu3dHijJuZrhhyAE9SMaD0bfhqb+CdXRjlVH0TGkaMhe1WAJ0u5lxHUdhv6qkY5AkjpLfYLU4aVSIoyCdDBniwKf4BfUwcTBffuVNkMTRl357boXYjo+XI9S6SyxKCPavO+LKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158129; c=relaxed/simple;
	bh=6zxzCuYF85h3tfkrzRPjOFJCd0GeTdtjDkdznuxiij0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frLjHifFhM1JmB3VOC9dE1mgmlJwJKfAN00is7sMOWsV+2u4oTVpnMsry3H4KUjoY028yM7GMOqooV5AJhMATXBleK77SSY9aznT4BxU4oxHa6shXFp1oqxw8Ld0u6duB3wf3mA3xB41QvlxuTa6AFVI9q39dbNbwuavyVrUOOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kmXsNvqi; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kmXsNvqi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OC+GVuXMGCg8iJofu+TyPOnqjqH8djL9Du9c1ioZ59A=; b=kmXsNvqi5XjDWj1mcb5AQuyK2d
	mWgTdTyorLNmbxFEHl53d2MvbGFfKtCDr2XbDo+PNYOva94ELnwGYteAc4Ll/PKiHkuPr6vuzkkfd
	YYk8Z50kRFoljtuSakw8bdYP4B1kdjt5Fbn9RKxNTG8bOgYWPDqnHs8kdQhwP14Gx3AxGoGRSuSbT
	qL2QHddDSQQ1Dskp0aZ0kkEm8nJI3n3EWsaARpkhmzhHJrsRjWVYNdFxKImB4tVua2Tei76b7mIgB
	XDoihbSZhlsWgDA06RpeaNRpPAuHGLIzrsfHhGn57YvUs+7SGLJ+LE5gPOZDwJMp7c/sWBp+9PWb8
	i8Yn3AcQ==;
Received: from 179-125-86-110-dinamico.pombonet.net.br ([179.125.86.110] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uZsMV-00Ey7U-P2; Thu, 10 Jul 2025 16:35:00 +0200
Date: Thu, 10 Jul 2025 11:34:54 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
	Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: Re: [PATCH v5 2/8] char: misc: Adapt and add test cases for simple
 minor space division
Message-ID: <aG_Pjl4Jl7QJxl8f@quatroqueijos.cascardo.eti.br>
References: <20250710-rfc_miscdev-v5-0-b3940297db16@oss.qualcomm.com>
 <20250710-rfc_miscdev-v5-2-b3940297db16@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-rfc_miscdev-v5-2-b3940297db16@oss.qualcomm.com>

On Thu, Jul 10, 2025 at 07:56:45PM +0800, Zijun Hu wrote:
> From: Zijun Hu <zijun.hu@oss.qualcomm.com>
> 
> Adapt and add test cases for next change which regards minor whose
> value > macro MISC_DYNAMIC_MINOR as invalid parameter when register
> miscdevice, hence get a simple minor space division below:
> 
> <  MISC_DYNAMIC_MINOR: fixed minor code
> == MISC_DYNAMIC_MINOR: indicator to request dynamic minor code
> >  MISC_DYNAMIC_MINOR: dynamic minor code requested
> 
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
>  drivers/char/misc_minor_kunit.c | 51 +++++++++++++++++------------------------
>  1 file changed, 21 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/char/misc_minor_kunit.c b/drivers/char/misc_minor_kunit.c
> index 30eceac5f1b6402b0f918af6f56602ed1a6c14ec..3184f383bea8c77cbca69ff5e315ea5de2d5512e 100644
> --- a/drivers/char/misc_minor_kunit.c
> +++ b/drivers/char/misc_minor_kunit.c
> @@ -7,12 +7,6 @@
>  #include <linux/file.h>
>  #include <linux/init_syscalls.h>
>  
> -/* dynamic minor (2) */
> -static struct miscdevice dev_dynamic_minor = {
> -	.minor  = 2,
> -	.name   = "dev_dynamic_minor",
> -};
> -
>  /* static minor (LCD_MINOR) */
>  static struct miscdevice dev_static_minor = {
>  	.minor  = LCD_MINOR,
> @@ -25,16 +19,6 @@ static struct miscdevice dev_misc_dynamic_minor = {
>  	.name   = "dev_misc_dynamic_minor",
>  };
>  
> -static void kunit_dynamic_minor(struct kunit *test)
> -{
> -	int ret;
> -
> -	ret = misc_register(&dev_dynamic_minor);
> -	KUNIT_EXPECT_EQ(test, 0, ret);
> -	KUNIT_EXPECT_EQ(test, 2, dev_dynamic_minor.minor);
> -	misc_deregister(&dev_dynamic_minor);
> -}
> -
>  static void kunit_static_minor(struct kunit *test)
>  {
>  	int ret;
> @@ -157,13 +141,7 @@ static bool is_valid_dynamic_minor(int minor)
>  {
>  	if (minor < 0)
>  		return false;
> -	if (minor == MISC_DYNAMIC_MINOR)
> -		return false;
> -	if (minor >= 0 && minor <= 15)
> -		return false;
> -	if (minor >= 128 && minor < MISC_DYNAMIC_MINOR)
> -		return false;
> -	return true;
> +	return minor > MISC_DYNAMIC_MINOR;
>  }
>  
>  static int miscdev_test_open(struct inode *inode, struct file *file)
> @@ -557,7 +535,7 @@ static void __init miscdev_test_conflict(struct kunit *test)
>  	 */
>  	miscstat.minor = miscdyn.minor;
>  	ret = misc_register(&miscstat);
> -	KUNIT_EXPECT_EQ(test, ret, -EBUSY);
> +	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
>  	if (ret == 0)
>  		misc_deregister(&miscstat);
>  
> @@ -590,8 +568,9 @@ static void __init miscdev_test_conflict_reverse(struct kunit *test)
>  	misc_deregister(&miscdyn);
>  
>  	ret = misc_register(&miscstat);
> -	KUNIT_EXPECT_EQ(test, ret, 0);
> -	KUNIT_EXPECT_EQ(test, miscstat.minor, miscdyn.minor);
> +	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
> +	if (ret == 0)
> +		misc_deregister(&miscstat);
>  
>  	/*
>  	 * Try to register a dynamic minor after registering a static minor
> @@ -601,20 +580,32 @@ static void __init miscdev_test_conflict_reverse(struct kunit *test)
>  	miscdyn.minor = MISC_DYNAMIC_MINOR;
>  	ret = misc_register(&miscdyn);
>  	KUNIT_EXPECT_EQ(test, ret, 0);
> -	KUNIT_EXPECT_NE(test, miscdyn.minor, miscstat.minor);
> +	KUNIT_EXPECT_EQ(test, miscdyn.minor, miscstat.minor);
>  	KUNIT_EXPECT_TRUE(test, is_valid_dynamic_minor(miscdyn.minor));
>  	if (ret == 0)
>  		misc_deregister(&miscdyn);
> +}
>  
> -	miscdev_test_can_open(test, &miscstat);
> +/* Take minor(> MISC_DYNAMIC_MINOR) as invalid when register miscdevice */
> +static void miscdev_test_invalid_input(struct kunit *test)
> +{
> +	struct miscdevice misc_test = {
> +		.minor = MISC_DYNAMIC_MINOR + 1,
> +		.name = "misc_test",
> +		.fops = &miscdev_test_fops,
> +	};
> +	int ret;
>  
> -	misc_deregister(&miscstat);
> +	ret = misc_register(&misc_test);
> +	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
> +	if (ret == 0)
> +		misc_deregister(&misc_test);
>  }
>  

These tests will fail if applied before patch 3 "char: misc: Disallow registering miscdevice whose minor > MISC_DYNAMIC_MINOR".

One option is just merge the two commits.

I have worked on a different option, which would be the two patches above,
before applying patch 3. Then, we can either support the two different
behaviors in the test case, or remove the support for the old behavior
after patch 3 is applied.


>  static struct kunit_case test_cases[] = {
> -	KUNIT_CASE(kunit_dynamic_minor),
>  	KUNIT_CASE(kunit_static_minor),
>  	KUNIT_CASE(kunit_misc_dynamic_minor),
> +	KUNIT_CASE(miscdev_test_invalid_input),
>  	KUNIT_CASE_PARAM(miscdev_test_twice, miscdev_gen_params),
>  	KUNIT_CASE_PARAM(miscdev_test_duplicate_minor, miscdev_gen_params),
>  	KUNIT_CASE(miscdev_test_duplicate_name),
> 
> -- 
> 2.34.1
> 


From 12e05f189745ce38bf792a448ff8d7117f20a3c0 Mon Sep 17 00:00:00 2001
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Thu, 26 Jun 2025 10:32:03 -0300
Subject: [PATCH 1/3] allow static register to fail

---
 drivers/misc/misc_minor_kunit.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/misc_minor_kunit.c b/drivers/misc/misc_minor_kunit.c
index 30eceac5f1b6..2ef92ce3d053 100644
--- a/drivers/misc/misc_minor_kunit.c
+++ b/drivers/misc/misc_minor_kunit.c
@@ -569,6 +569,7 @@ static void __init miscdev_test_conflict(struct kunit *test)
 static void __init miscdev_test_conflict_reverse(struct kunit *test)
 {
 	int ret;
+	bool stat_registered = false;
 	struct miscdevice miscdyn = {
 		.name = "miscdyn",
 		.minor = MISC_DYNAMIC_MINOR,
@@ -592,6 +593,8 @@ static void __init miscdev_test_conflict_reverse(struct kunit *test)
 	ret = misc_register(&miscstat);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 	KUNIT_EXPECT_EQ(test, miscstat.minor, miscdyn.minor);
+	if (ret == 0)
+		stat_registered = true;
 
 	/*
 	 * Try to register a dynamic minor after registering a static minor
@@ -606,9 +609,10 @@ static void __init miscdev_test_conflict_reverse(struct kunit *test)
 	if (ret == 0)
 		misc_deregister(&miscdyn);
 
-	miscdev_test_can_open(test, &miscstat);
-
-	misc_deregister(&miscstat);
+	if (stat_registered) {
+		miscdev_test_can_open(test, &miscstat);
+		misc_deregister(&miscstat);
+	}
 }
 
 static struct kunit_case test_cases[] = {
-- 
2.47.2


From c9974a5b2cb59ad3ee5e371cb42c5969a46128b2 Mon Sep 17 00:00:00 2001
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Thu, 26 Jun 2025 15:43:31 -0300
Subject: [PATCH 2/3] support the case where registering on dynamic range is
 not valid

---
 drivers/misc/misc_minor_kunit.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/misc_minor_kunit.c b/drivers/misc/misc_minor_kunit.c
index 2ef92ce3d053..18f477b18562 100644
--- a/drivers/misc/misc_minor_kunit.c
+++ b/drivers/misc/misc_minor_kunit.c
@@ -557,7 +557,7 @@ static void __init miscdev_test_conflict(struct kunit *test)
 	 */
 	miscstat.minor = miscdyn.minor;
 	ret = misc_register(&miscstat);
-	KUNIT_EXPECT_EQ(test, ret, -EBUSY);
+	KUNIT_EXPECT_TRUE(test, ret == -EINVAL || ret == -EBUSY);
 	if (ret == 0)
 		misc_deregister(&miscstat);
 
@@ -591,10 +591,12 @@ static void __init miscdev_test_conflict_reverse(struct kunit *test)
 	misc_deregister(&miscdyn);
 
 	ret = misc_register(&miscstat);
-	KUNIT_EXPECT_EQ(test, ret, 0);
-	KUNIT_EXPECT_EQ(test, miscstat.minor, miscdyn.minor);
-	if (ret == 0)
+	if (ret == 0) {
+		KUNIT_EXPECT_EQ(test, miscstat.minor, miscdyn.minor);
 		stat_registered = true;
+	} else {
+		KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+	}
 
 	/*
 	 * Try to register a dynamic minor after registering a static minor
@@ -604,7 +606,8 @@ static void __init miscdev_test_conflict_reverse(struct kunit *test)
 	miscdyn.minor = MISC_DYNAMIC_MINOR;
 	ret = misc_register(&miscdyn);
 	KUNIT_EXPECT_EQ(test, ret, 0);
-	KUNIT_EXPECT_NE(test, miscdyn.minor, miscstat.minor);
+	if (stat_registered)
+		KUNIT_EXPECT_NE(test, miscdyn.minor, miscstat.minor);
 	KUNIT_EXPECT_TRUE(test, is_valid_dynamic_minor(miscdyn.minor));
 	if (ret == 0)
 		misc_deregister(&miscdyn);
-- 
2.47.2

