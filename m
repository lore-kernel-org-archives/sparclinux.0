Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585CE3DAAAE
	for <sparclinux@vger.kernel.org>; Sun, 16 Aug 2026 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786866811; cv=none; b=flaFV5BxfG3pL0mvZiv4SvsYzHdGMDhTdCNqyoEk/rvtAhi+VwFYNCV0Kg4r24UMVd+Ff60XfJUkT0Y1TGjAcz7StkpMPb0Vp/+IfFebCXgDLQzywzctclQlJRg4SATrfyaFAJep58aMRcnQxbld5NHJ+eZ96pK0gR5TVRhGhNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786866811; c=relaxed/simple;
	bh=0TcYhUzI4IMVkqeFHXfxvRTGCNZfF/6uhQKiYamoYlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXGSZILGGMFPSfb2tnRm6X9ycMUaF/OGk7n2mJcxzs3JHuhfEEXqD96unp5YB8JI+HCBOr8DONodtZ1KoDMrP5BAkUzXXUZ7edAWs4tzWtHDWPcm8/7qegrC31i7ZcviKlb7k2YdSX2dSYeJu8nZ3msltN71BELFKrwNuh2q5AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2ge4uB9; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2ge4uB9"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso2144222e87.3
        for <sparclinux@vger.kernel.org>; Sun, 16 Aug 2026 00:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786866808; x=1787471608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wAFXU8BCP3FG3ExmAfyGZH7qD9NR4+adUEltJcyXz8o=;
        b=V2ge4uB9anlTABLL7sgqpp6THBrMwGW945ngfZcOyvLfSvV3ZniwzhVFnzDRjcTdXA
         cp4dDbwNPVwzLDIW30EOLM8+gUUPSShPvmkZyeYR++a1dWTjohlrPgqZBa0kLuvTTDpu
         CGf3YOR7Z6rT/MZYzElm5AxT7PNFFIlxxse35B5npcwPWB5JN5NqIarNwsr6kH5ugLWN
         HzZSmF2Wf4CYHlLH2ec7x3IIGigqZqjzuan4DBOhK8QL1tOTtAQMyq3aXwyYM9JMYa5M
         4FmKRwGo5FHandAa4VtTTK/wfGdMNNkmaB4S+juR0QE5qIaYhi2rrrMMuTQXU3oAhhVF
         Hq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786866808; x=1787471608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wAFXU8BCP3FG3ExmAfyGZH7qD9NR4+adUEltJcyXz8o=;
        b=dbOlJzo1QFitbZw6cOew1U24sk2Eco5diX5AoT7lbF+QqshUIyfAkwStLYP9Y6s1e3
         jeRrXepVk/6FHUozBdgaIGysx/ZJU43NM+6aDabgx4ajL6NJdLMDILVxZECq8THbC6nZ
         Lq3sYihoMU2nMbw0QRKuly7LRtObry+6TDjqY+ARKi/L3zz6j+BaTu23RBsklO0yajZT
         jAUfrT3KEls4/3X28og2jLkOfVUiLK/BpfpJVgWgrpKIops9Gh8zqvoScIPAA8tEraUU
         oi3N2X1zB57cjuvakF4wXTVvh39sI9TdkOD8AQD6vG8BMaWEqUc1Pb8bYn/zI3NhlroR
         9vFg==
X-Gm-Message-State: AOJu0YzgO+nERIcvucBpej7H74EhCcW+HE3+1VFSsPBvCk9EBv6n/mPU
	1G7n5LPYZXUibvZ69bnq7nYnm72SfTRBju0i0ASpKmwdS/YCy/fVU9Qs8YKuUA==
X-Gm-Gg: AR+sD12XXWZCyXfU/yGYpMneQA97vco4aN25Neg5vXXD4lp+GKDW84EUS7YiXPYgdqV
	1KNhizxiS2HtDjBeOITtMdjdQfBH0Ravuss2l6K8sSXgMLqPvkk01YfPp3EL9wQjiFCL+o4wX7+
	QVOaeVb8Mi3u1IssYtYyRnp09JRejRYRQlKUXJ3vjMHiG85gFUNwFrtZd66uLSQqRm3Swxd7go3
	J/L/oBQVJP+SwriNTGuG5bEsREmKBkhtdG2YKaH1RIYq/b7WwWGKVdeLCCbGoU38/baPYHNWFe2
	osGUGcuMlW2DxeGpl3nkwS0e1NkJfLuHZGOjVLRIIdRUUG8wnoXz+Sag+U5UdjXymMqgrz7t1vE
	AEpUGd1m/xnJ5fmhOlrXkHo35BT0KUO4bQ8z02pIBvjPVC9pTCOGe3xkdw6E/SfuYHRrTazo1vS
	NnEJdxxZgOUXkZXzTALZo4uXHIynip5bpTj4mREjDDCXYm3IkgNxop1fZGphdRl28yDmv1xXDp8
	IAGndhQa6+LtoO6+FXRpml6ZkXCfbc=
X-Received: by 2002:a05:6512:8394:b0:5b0:c95:cdb9 with SMTP id 2adb3069b0e04-5b4591733e2mr1842974e87.23.1786866808267;
        Sun, 16 Aug 2026 00:53:28 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b458b9a8d4sm1631136e87.15.2026.08.16.00.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 00:53:27 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2 3/3] sparc32: advertise relocatable kernel with HdrS 0x0300
Date: Sun, 16 Aug 2026 09:50:17 +0200
Message-ID: <20260816075141.3489194-4-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816075141.3489194-1-linmag7@gmail.com>
References: <20260816075141.3489194-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HdrS version 0x0300 tells the boot loader that the kernel supports being
located somewhere other than physical 0x4000, which is where SILO places
the image on the traditional path. Anything older is copied back down
there, and refused outright when it no longer fits.

sparc32 could not make that claim before, because setup_arch() took
phys_base from the lowest memory bank rather than from what PAGE_OFFSET
maps to. It can now, so say so.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/head_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 8c320fa25a67..11a1746829a4 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -69,7 +69,7 @@ sun4e_notsup:
  */
 	.ascii	"HdrS"
 	.word	LINUX_VERSION_CODE
-	.half	0x0203		/* HdrS version */
+	.half	0x0300		/* HdrS version */
 root_flags:
 	.half	1
 root_dev:
-- 
2.43.0

