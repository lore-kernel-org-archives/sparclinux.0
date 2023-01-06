Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFA9C678D6
	for <sparclinux@archiver.kernel.org>; Fri,  6 Jan 2023 21:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbjAFV7W (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 6 Jan 2023 16:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjAFV7T (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 6 Jan 2023 16:59:19 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9081676DE;
        Fri,  6 Jan 2023 13:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673042359; x=1704578359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YxmNblIsKqhfyJq7N8D9hjsKeTOrNyEjlTYDV33bZjo=;
  b=VXX7vg31fAd/2yeyvsuO2tyhbOQJHg914hhCBY9Eg765noFLqsG0A/YW
   xVa4i/hJFBXkzgoBoKVCq3yO4bJiWXmtZIlwNoOPCsEbCGXyTtD5ZR/NO
   /gZDFo8d++of32H43g4nSruw/rX3p0XwjSxUUCAEGy4roMiSrxB9uI1Ap
   mhnZsLbNpobq4LkSObZMNrhYaP5fFAkLq4eTjF0ywRYe2odObbm9aKSO9
   1TUY4Ia3fbGc+io6AKw76f6mKANiWpASX9VY6w8Aohg550kDj4RL/hclk
   IukSkqYYrXe27uOf/0RL7dEY27b6BgwYwmvhZvTECgIHxzv+Ddyhdb6eK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="387030707"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="387030707"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 13:59:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="763652885"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="763652885"
Received: from avenkata-desk0.sc.intel.com ([172.25.112.60])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jan 2023 13:59:16 -0800
From:   Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
To:     netdev@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: [PATCH net-next 3/7] powerpc: configs: Remove reference to CONFIG_CASSINI
Date:   Fri,  6 Jan 2023 14:00:16 -0800
Message-Id: <20230106220020.1820147-4-anirudh.venkataramanan@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230106220020.1820147-1-anirudh.venkataramanan@intel.com>
References: <20230106220020.1820147-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

An earlier patch removed the Sun Cassnini driver. Remove references to
CONFIG_CASSINI from the ppc6xx defconfig.

Cc: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 arch/powerpc/configs/ppc6xx_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 1102582..0eba1de 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -487,7 +487,6 @@ CONFIG_PCMCIA_SMC91C92=m
 CONFIG_EPIC100=m
 CONFIG_HAPPYMEAL=m
 CONFIG_SUNGEM=m
-CONFIG_CASSINI=m
 CONFIG_NIU=m
 CONFIG_TEHUTI=m
 CONFIG_TLAN=m
-- 
2.37.2

