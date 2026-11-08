Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177368;
	b=fDpSDIE4A18IpVhAoZoLtnfhjAudjfFlcXmMkv8l8czQkaQ5ZDJsMNZhasbhYcLiHU3f
	 R4EeUvnSL1MlUOqG++XRccF7DFpj5GUiy/pD8sfD+bnnfbI1gfXfUcRh0ANAFr10wKDX8
	 qTAcYglyujE6IL6y7yArStlr6aCpx8IoQCuzBKKJasfOXJGmq4mi8c5OxbKfQp9cSMK5S
	 KTBOl0DhAgeGWKaoDjZbyzua5w2dJAU8GRt3K9doyWG2lZTg57+21GpOXmEirkFtPEJP6
	 SiUiL3J9DjS14Vigg9ex+h5jW+beCjVklD0gLldFblFSZ6WMpb2+Fm8g37N/vx8EXBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0B84fgUAvEG0Glyv3A7RkeExOVAqdU6JtDjEommuU5s=;
	b=UQATEeEeGSPeUNMmnWBHK8+kAWG8yHWrNb5jtok2EGkCIUXogXlEnS/FWGNQDRswrkT9
	 d69cbsVTiZvJwbpqkRKllQkh/TXfp7TqcgfNfTlfTGVHEjTjscfOXZPOTKyYlu951Ae/N
	 vKE8wMLSRJTWyqo9pynFc0M8ds3o+8GSdTpbSIXDF8rEnF4STSwHRiR6fZv0lGWwWn11g
	 LXyWfagIPIFRy0Lr6lNOlTBsv34u19Lyy2a6qHj78WiegJl07Sxid7t99ByXDPO70lySB
	 QCfLBfdNugCAVe9/YDYmz0fb14zBGexrUbU7uWKCUqN9tS0QQs6FSQ2opiTMoyaukxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o0myVGUE;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2733C606EE99
	for <sparclinux@vger.kernel.org>; Sun,  8 Nov 2026 22:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2733C606EE99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o0myVGUE
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b633ddfad6so384470a12.3
        for <sparclinux@vger.kernel.org>; Sun, 08 Nov 2026 14:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177366; x=1794782166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0B84fgUAvEG0Glyv3A7RkeExOVAqdU6JtDjEommuU5s=;
        b=o0myVGUETIrYhSDiGMzAzUwj64MUtklp2Y9qAfc1GvUrFIIhzzPaL7EoavTacrJgIP
         VtmRTdUUic1gqHV0eLCEOcvw+/ydUgxQW18x+xkiqXNQzYUmA6dxGyJCylpe8BLrTa/S
         UlFpRYM32XnHsAUc6ov6VZs5So2lE60b7ojcDwodbhMXN1EkDfcR4gDK85xZqlks0BDG
         ecq0Va+T6sHti1Mr8AmFbgkjw7IPD7uixvMzKwTIXVN4Afin3AS9rgTDK++vQx1Hukxb
         tcVlyXE9iKNw5Iem6qjV5zK864QtDmNSzIyzVbdd16z3YincCLylWneKTvNp2lFBaslg
         kG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177366; x=1794782166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0B84fgUAvEG0Glyv3A7RkeExOVAqdU6JtDjEommuU5s=;
        b=va6XZaazvZtGClrRN4a0SiYBGv6rtUWNylnPZQIx+m6VrAKcWT9YBZYf/IwS/8nIuM
         JZWlgvunN0D4+8+XUjLZIKnlRKMQQ9EBPHB8tw7S+cfNbjB7LlhBkZGyk7wciGPoBKFu
         js/nI2kQBuQAzvgmA3dxHABT3ROuuaKuikV3CPC3mcexfaqpRgx8+HG759Z4fYNrtrOu
         vPNYXGlx+REWO1kErpADZXGFf7EAjIcnjLsWvFe/Ufh4FQ/pE7aooOdIhTRNEr60TiHA
         lL91n8WmxvAxrHVfr/x68IsTTdsA/Spy6pzMN6oBFSECO9EgYnlmJS9dDNIdBgaUXZQi
         DhSw==
X-Gm-Message-State: APuU4Z+MXaJ+MbocDZbTJYDrGEAc4tBUvgSNX8gJp1ucR4Q7YjmKVoGe
	LAQstZywoVNc6fvAyYdoDywENNf4tLknKJ+efKaZg7UNU8KJeHxoTL0F
X-Gm-Gg: AYBFou3MmvGm9fBHD/CHd34LvH+POPYOuGbBWAgL3CGryRCU/1lW1wc4O+eLhEaMF+t
	+PRSzREYTQ1BZV0tRowcszYLSVGhJaVzivHJ3LLjUraXBt9w87tMRxE968l3BZTnCNCHVGcOcSj
	wwvT/pKvBPHchiodq+zPmEfiaUtD1PCuYUH+ob0unEBEN3fO9rSqXqYvNm+WNDfk5lrLm88fQaO
	9woYaR30pXSRDt8KIGsJq9igem8tclZoGDtiPhq8zVknRln8J3pxf5ASV2CNeJLWR9aqAyFfnnb
	8P8xaxnvEtx42d8/CT/PtwV1jyEQeNDs1Wau/U84auRwYhWX6EHCcyR5jkleEuXqCPtjry3ebSM
	5qWUuEcQm8MVmV+r6u1Aol767qNS+5od55SBdKCmGhRSuSElbk2ccEuhCzYdHVEn+fHP9QEEE02
	Zs9QNA2QLUGnx2L8WoPZvwrm8B4qCNVgYUXoGr9p1Ixi1n7zZCjvDZpVirzizdUPYWOf4D6gePC
	DA81PjLQso5hYTtnyttsWi3Y5sVN+gCWVPFf1v7b7qgQzKLa5zD/EqzQ4B2al9VyjQW/7/rgU2y
	jpcIBY4pzkyRffbVfLojYYEGkgdRvC+z6ayO5NwSZs52bJ6Bqu71Z09f02TLB9wAIeAE5o6dmj1
	/Udyq+G1MPkY0Vl1m
X-Received: by 2002:a05:6402:1d55:b0:6b7:6f9:2ef7 with SMTP id 4fb4d7f45d1cf-6b722456828mr1336914a12.11.1794177366393;
        Sun, 08 Nov 2026 14:36:06 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ebc7b0sm859272a12.14.2026.11.08.14.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:36:05 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 8/9] sparc32: retain mm_cpumask across TLB shootdowns
Date: Sun,  8 Nov 2026 23:34:18 +0100
Message-ID: <20261108223516.1125534-9-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108223516.1125534-1-linmag7@gmail.com>
References: <20261108223516.1125534-1-linmag7@gmail.com>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smp_flush_tlb_mm() narrows mm_cpumask to the current CPU when mm_users is
one and current->active_mm matches. That snapshot does not exclude another
task obtaining a reference with mmget_not_zero() and using the address
space through kthread_use_mm(). Clearing its CPU bit can make subsequent
shootdowns miss translations on that CPU. Testing current->mm instead does
not serialize against that race.

Remove the narrowing. This follows the SPARC64 fix in commit bafb056ce279
("sparc64: remove mm_cpumask clearing to fix kthread_use_mm race"). Retain
the accumulated CPU mask until normal address-space teardown.

A single-threaded mm that has migrated can consequently need remote
shootdowns for the remainder of its lifetime; sun4m broadcasts them to
online peers. This trades extra cross-calls for correct coverage.

Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/mm/srmmu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index aa53ec10cd8a..d3634bcb048d 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1624,12 +1624,8 @@ static void smp_flush_cache_mm(struct mm_struct *mm)
 static void smp_flush_tlb_mm(struct mm_struct *mm)
 {
 	if (mm->context != NO_CONTEXT) {
-		if (any_other_mm_cpus(mm)) {
+		if (any_other_mm_cpus(mm))
 			xc1(local_ops->tlb_mm, (unsigned long)mm);
-			if (atomic_read(&mm->mm_users) == 1 && current->active_mm == mm)
-				cpumask_copy(mm_cpumask(mm),
-					     cpumask_of(smp_processor_id()));
-		}
 		local_ops->tlb_mm(mm);
 	}
 }
-- 
2.43.0

