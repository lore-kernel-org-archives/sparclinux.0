Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD59C4332F
	for <sparclinux@archiver.kernel.org>; Wed, 19 Oct 2022 10:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiJSKbv (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 19 Oct 2022 06:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJSKb2 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 19 Oct 2022 06:31:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E315353012;
        Wed, 19 Oct 2022 03:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666174225; x=1697710225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n5aFl9Mu8iuEfY2C1Fx3TcqbioaUsdGN3eCRbvIqKL4=;
  b=PZ5IislgviFNhdl9hIlTuCGjaryVnzk41jy8WJxLPG5q+O0aT1ISlTCc
   Jsgy2rAtDdzzlL+RpWDR5pARiynl6ty4XKG0DFK5iHJJgclRDsniKqNmI
   ExYKURM9P2Hy+1RtMVqKkbKCnvKpvSNsqKpWYs/K8MZXZ4HiV83IzVk6W
   E6FIRKjlN5EDe0zx1ZcNCpuA8kl9yFD3x4KUmJJhKuuOWYVIy+ksSKE6Y
   QlVW4N5E94uMQG5d4ocxPb3LJDly590bHdhosm9X3Ldb1gNkTMYPAiq8h
   NIezqKnFLINCEGOiL4uD6k66zpGpjXR/wbKc1Cr0ZuDHC8dFkg9y+FyX2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="368407271"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="368407271"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:14:26 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734119231"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734119231"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:14:17 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 35/44] serial: sunhv: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:42 +0300
Message-Id: <20221019091151.6692-36-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Take advantage of the new uart_xmit_advance() helper.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/sunhv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index 1938ba5e98c0..16c746a63258 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -47,8 +47,7 @@ static void transmit_chars_putchar(struct uart_port *port, struct circ_buf *xmit
 		if (status != HV_EOK)
 			break;
 
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
+		uart_xmit_advance(port, 1);
 	}
 }
 
@@ -63,8 +62,7 @@ static void transmit_chars_write(struct uart_port *port, struct circ_buf *xmit)
 		status = sun4v_con_write(ra, len, &sent);
 		if (status != HV_EOK)
 			break;
-		xmit->tail = (xmit->tail + sent) & (UART_XMIT_SIZE - 1);
-		port->icount.tx += sent;
+		uart_xmit_advance(port, sent);
 	}
 }
 
-- 
2.30.2

