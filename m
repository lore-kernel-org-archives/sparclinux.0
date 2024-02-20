Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2769C15B1
	for <sparclinux@vger.kernel.org>; Tue, 20 Feb 2024 00:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708389285; cv=none; b=kEGoKo2pgCLAl3q3KLhdC+UmoX2CExxveqilO1f/WVDftoGD38sAkUbhVP5EuQzpcofDuVWLZ/htBZntNRNEMfmCIpRk9rV3odi6CT3DTHxdUkOA5TQZLr4nVAGlaOS1L+YqZYL1T10YSUTuLGMwhuo8WAMKIbbTp5WeUawGstA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708389285; c=relaxed/simple;
	bh=twysEfuQ4T/0w/2qh6F2Tm91ScgbJMClrcyBk8mU50U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u6HFdERR4i4jHEl8hQ7kQoteo8vAVD68tf77jWJHOUCauL8wYs/+aOY6fEa0GV+nQofN1Tuz4Ftus6Wu+/dOccqHH1AWRLFcIY04MgdkOlgJxHQyaOghBz6XeZoP71L1QaywerkyyDk3/Q6NwvG85ITcpcTShu0rakqt6C1E0W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GGzfbLC+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGzfbLC+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708389282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uJszGoDmcJ/e3cfaUrhP/NITyUlid6+ei0fLVW+ftlI=;
	b=GGzfbLC+1X24+QZZYquyVj9SapqI4RKWoorq9e0UQGzeIiUy80wOeSqS1e1W46XzpTvbpf
	PgIrkg+Q1ee3UcHNI5pYNj4b2rd2sdoz3E1Gz77mHm1X2H3SRMHStF1qQQuN9gJd7esLI7
	Y/41qUSftk9Jf1qkzpKXNFE5ofW/moA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-yf9UxQXbOV25kxQsuibbUw-1; Mon, 19 Feb 2024 19:34:41 -0500
X-MC-Unique: yf9UxQXbOV25kxQsuibbUw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41225d3b3d1so23871805e9.0
        for <sparclinux@vger.kernel.org>; Mon, 19 Feb 2024 16:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708389280; x=1708994080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJszGoDmcJ/e3cfaUrhP/NITyUlid6+ei0fLVW+ftlI=;
        b=TpORKnYv6o/pDkB3qe0cesTMZRcpouFRv4atQnqDnGvwOMTc0ufKliDFXrBFAuUUUT
         3f14pfmUOeyJOPkDyluZZ1FjsY6YannDjSBGfHxpHnGc+AcqzCMr6UviDWBXexyRnqsr
         sVCiZn3zBKAtGJSKuVtc3MJ9cXu728U6BO2nI6qQZkC43Yk3ZrX4Hc4ZFx+SeWgn3NTZ
         iYiwgqBJgQHYUemu495n7b5VcGIeYYZyO5RaKafGx4DP+uqURUwkYjy5zYbL5awxPJJO
         wE7Y2fiYYdm2yBa/9JskChOQ4KLQShUl/0dzd+xQUpp+uTGrd4X58W2sQ57Nps6PrZQ4
         Qx7w==
X-Forwarded-Encrypted: i=1; AJvYcCXeArdMQCLPcFN8UDSPRNSAG4ZB2uKrPIsteh9cfccH7348ghyzG0Muf7JmXiyENgBp9hSN+PH0blYMfTB7BHoI7NiqAzBHHaaJsw==
X-Gm-Message-State: AOJu0YypLPp3QL8j4ieBkFz8tM+DXiBGOc3uR7htMG04TQjZ+SB3WEVf
	E83TwngNKR36fUFZ9XWMtxaShIMYQQNIt0+UXlIzZCOAHElgwdLBgaN+ejS9c1+Dpgq/4eWDIeK
	At5kywnva0QIfrxrh0Oa8QpFTcNCfMdHDF8avFJgt0+lbNwaeWkM1fP/FZTs=
X-Received: by 2002:a05:600c:198f:b0:412:6d41:920d with SMTP id t15-20020a05600c198f00b004126d41920dmr434590wmq.38.1708389280277;
        Mon, 19 Feb 2024 16:34:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGscKC/h+165pWPIQGiFVK1k+j+cPntLp690DOup1A66feMphWpMObuy7g/A9wibrQFwsUJhA==
X-Received: by 2002:a05:600c:198f:b0:412:6d41:920d with SMTP id t15-20020a05600c198f00b004126d41920dmr434581wmq.38.1708389279984;
        Mon, 19 Feb 2024 16:34:39 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l12-20020a05600c4f0c00b004122b7a680dsm12803198wmq.21.2024.02.19.16.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 16:34:39 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
	oe-kbuild-all@lists.linux.dev,
	Javier Martinez Canillas <javierm@redhat.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	sparclinux@vger.kernel.org
Subject: [PATCH] sparc: Fix undefined reference to fb_is_primary_device
Date: Tue, 20 Feb 2024 01:34:30 +0100
Message-ID: <20240220003433.3316148-1-javierm@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 55bffc8170bb ("fbdev: Split frame buffer support in FB and FB_CORE
symbols") added a new FB_CORE Kconfig symbol, that can be enabled to only
have fbcon/VT and DRM fbdev emulation, but without support for any legacy
fbdev driver.

Unfortunately, it missed to change a CONFIG_FB in arch/sparc/Makefile and
that leads to the following linking error in some sparc64 configurations:

   sparc64-linux-ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_fb_registered':
>> fbcon.c:(.text+0x4f60): undefined reference to `fb_is_primary_device'

Fixes: 55bffc8170bb ("fbdev: Split frame buffer support in FB and FB_CORE symbols")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202401290306.IV8rhJ02-lkp@intel.com/
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

I don't have a sparc64 toolchain to test this patch, but I'm pretty sure
that this is the correct fix for the linking error reported by the robot.

 arch/sparc/video/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/video/Makefile b/arch/sparc/video/Makefile
index 6baddbd58e4d..d4d83f1702c6 100644
--- a/arch/sparc/video/Makefile
+++ b/arch/sparc/video/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_FB) += fbdev.o
+obj-$(CONFIG_FB_CORE) += fbdev.o
-- 
2.43.0

