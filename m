Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177359;
	b=NE99sEVH9Ijh7eZGNxYeqA4OEk1m4rRiXO9PLzB8q4SrugUYPoQ04PWRCi9SPJ9jPiGc
	 Jd8skYwklcs4fWeKWFjIAOspwWx+4yz5HThouUfJaCYa04gAbrgKtcu7iAMPVPc2OFHxN
	 UABqnSRdFJmXKGKx98X7vsj5voY2PTjNlxZh07MejfYNXoJNWP6lCEWrGKPEugVfw2u9F
	 9/E9kZF3y1p9T6leU74d358m6ZWjE073nnS/OElM56fdwhh7KWI/evtC9QYF2GeEOf0Nz
	 xx6c5HjhROk0JqSjB074oVdSSd2nyYBSY3KgqRMtH7vM4vHmqaVPMR/UfaYqs/CqMAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5NOPjmUBERfG1JdXLBN4IOoecv+cO9goNy7l1WkTKWA=;
	b=1oBxzBcZu600txIRo+sBwXZjS/mfDiAPkP722nDQK8UBey8KLoJcUg7kBwjMhKawkuP7
	 FHGL2e30b6KRV2MfCH4LYTWMEvimofzWLoNtuqse13vP7vhwRJH3My0YXi0MRrRsRWk1O
	 lhYLot1f2jtmXZqwEqPaKrw3StY5hZdKiDYR2lEnHD2NSie8O8m5C2WQ0YpeRNr8XM8Ng
	 uX+xe1BoseEZFRaHQTUEV4AnSSVKOxLlBFgVX7ohXtN48xx+E4wF88nWwCNKMSG1do2gE
	 gWt8EvR+G1LLrCYezi0A/hNKIxEuqUnyL0Q/d/TwTBFNcRSyIc0f+t+9x9xvqhl2pcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A8JriAvH;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A629606A326
	for <sparclinux@vger.kernel.org>; Sun,  8 Nov 2026 22:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A629606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A8JriAvH
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so45385566b.2
        for <sparclinux@vger.kernel.org>; Sun, 08 Nov 2026 14:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177358; x=1794782158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5NOPjmUBERfG1JdXLBN4IOoecv+cO9goNy7l1WkTKWA=;
        b=A8JriAvHV/abs6G5nqD27gaqULltoJJTI4DeYI+q4pB7vLK0kRihCFrJFQA9T4twyI
         dDwW5o1dJCAJEyoYH3rWRd47ksRVzVl2qt5nRE+Obo3HxWopHiI9GcDYKQkhVNQ4hAL0
         HJStySiqzgE2zW9Z133uKgjHrjlqgRug5+XnHGhvO4FPV5skyLNU8yIMHmyd8hg6V17B
         PxO8muYQIjFWhJA8XraWNJVn3GREej/ysMvpixITAxN6nOVjUExOJaCp95vcwYXC2L7C
         gWVKOVxbuXPYl7YNOx0TnUvafeY1Hy/jkVLsd6VJeLMyPHnZGvkLIAYXo2yV+wEEQiom
         nkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177358; x=1794782158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5NOPjmUBERfG1JdXLBN4IOoecv+cO9goNy7l1WkTKWA=;
        b=uRcVMoDuE2Sxfgi7oaV1eImI83CBumUuK3M4FuJgcXMt9+xC9y2+SvcRWzoaWB+cR+
         NCoHbkSODLHyO8uPtgVh92LB6J4nzW49UokWOtmORHY1N1s1jMTeI4WLitySTths7tj+
         jUpQu7LfqhHoMlJVAnelP3qzfYSWDz+Ul4YQJj0IDFUq6I+bScI549nR7DiyWskmAXIr
         TS6Wttiuevt6fdcC5q38Dewr0LSLGYZKtqUDuYo2GXGb3pLXt7+vUtFGFIY9kQoft5qF
         CSUG6YBtWjWnIVhQLhLHF6MRTL4jM/vGGdiUJQOAJrXD/yYXwwpnLcHd02QU5VcKLbi0
         KyeA==
X-Gm-Message-State: APuU4Z8nEeoUbiDvpFxpxgnxFO+OTBtk06sY6AkfA+tH56mBum3dDoNW
	taKSbpmZlv7j3kTGWjQktkLlhZFLl5KccRWJrSi3QCZWjahhxd6klMEQ
X-Gm-Gg: AYBFou1iCwpoGj/VBYfoxV3vvFpeLDpxNYPl04+XCprFOkF1whypY6oKpNu23OsKsed
	YsZ2HNYKfKLObwpuqSBqx6wSmdTZwqe1QwBZVqYBFdxNz5/jBpNHsk7xKbhau+nAuLvC8Q1rmgE
	8X4xYm4ZYWNn1WxcF3dDb0l9ngga8lNLvR48VUgG1y6aK6JD+pD/9pOIEft5C8zFpf4lE4VfiwW
	kJwIbP8gKl8ODbMt7qdCwk/s/geo3htQoToXceNY0ayDwJzMntCKcmhH2ach8FBLJdCWtF0Xno1
	ANL+wPssrDossx5vWrC2cuaKUnZeWhq5tYs1GnYtcVfi1iqwJ1Sby1VCQY7g8QGKZEbt04n8eho
	JLRtASpOVy89mVAst9lwnHRcKdS6vIiFe/U7IIMb9e9ZkXlb7txRQcoTLgK+C6Weu68WephuOys
	aIXmTCe43lxfe/PxNRhtN5LN1Yv1rUyvOv/mM/v6v787CcIhsIZY6JLO6klahrRzwvwesP9oJoO
	CVPXQHDcjDjPIGyRX1QJ8NhUOiG7AWENv2iraq7vH5RXGHYk85LvBKHKfmMwQz3iO/687ch4mdE
	yQWEtlUT7n8RJWOaY0LrM8PYj9m2ZNinGwd4nVh05muEkFG2v8ViT8uNCZufkgbymq/ZWTo=
X-Received: by 2002:a17:906:7953:b0:c3e:34fa:611d with SMTP id a640c23a62f3a-c4d6db15eecmr154636066b.35.1794177357694;
        Sun, 08 Nov 2026 14:35:57 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ebc7b0sm859272a12.14.2026.11.08.14.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:35:57 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH 1/9] sparc32: inspect every PROM CPU cache geometry
Date: Sun,  8 Nov 2026 23:34:11 +0100
Message-ID: <20261108223516.1125534-2-linmag7@gmail.com>
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

Cache discovery runs from setup_arch(), before secondary CPUs are online.
Using cpu_online() to terminate the PROM walk therefore stops after the
first CPU node on SMP systems. It cannot determine the largest cache and
smallest line size across all modules when their geometry differs. Sparse
logical CPU numbering is not required to trigger this.

Walk every PROM CPU node on SMP and retain the single-node UP behavior.
Start at the first child instead of skipping directly to its sibling, and
track whether a CPU was found independently of the end sentinel. No mixed-
module hardware failure is claimed by this change.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/mm/srmmu.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index b491d7b32891..49d41b33aabf 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -964,17 +964,18 @@ static void __init init_vac_layout(void)
 {
 	phandle nd;
 	int cache_lines;
+	bool found_cpu = false;
 	char node_str[128];
 #ifdef CONFIG_SMP
-	int cpu = 0;
 	unsigned long max_size = 0;
 	unsigned long min_line_size = 0x10000000;
 #endif
 
-	nd = prom_getchild(prom_root_node);
-	while ((nd = prom_getsibling(nd)) != 0) {
+	for (nd = prom_getchild(prom_root_node); nd != 0;
+	     nd = prom_getsibling(nd)) {
 		prom_getstring(nd, "device_type", node_str, sizeof(node_str));
 		if (!strcmp(node_str, "cpu")) {
+			found_cpu = true;
 			vac_line_size = prom_getint(nd, "cache-line-size");
 			if (vac_line_size == -1) {
 				prom_printf("can't determine cache-line-size, halting.\n");
@@ -992,16 +993,12 @@ static void __init init_vac_layout(void)
 				max_size = vac_cache_size;
 			if (vac_line_size < min_line_size)
 				min_line_size = vac_line_size;
-			//FIXME: cpus not contiguous!!
-			cpu++;
-			if (cpu >= nr_cpu_ids || !cpu_online(cpu))
-				break;
 #else
 			break;
 #endif
 		}
 	}
-	if (nd == 0) {
+	if (!found_cpu) {
 		prom_printf("No CPU nodes found, halting.\n");
 		prom_halt();
 	}
-- 
2.43.0

