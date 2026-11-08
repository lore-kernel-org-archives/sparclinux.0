Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177361;
	b=iIYU1q7rOOR8CD1Zc8NnCPRu7eG3f1OzJHSNxSDZPRIujAjBrnJHHCF6pRvpHi+/BmN/
	 9tzQI8vsHX9A2DGSQ/kLLR2hncMs0/8E6qZV5rJzd03uNzvWM7b7/3hkbhjHg/3NgfB4N
	 4V/+tS1CSNEsnOD71Qv8w4uk6WvnsT6wVG/j+IkieM8j0Qk15W1edSgLj1Qw2VMa8wAMA
	 eBWAe+8fhnVO7RDlpT6QCyVFWL6nSkx/yT4uGBSa2wlHnQMx4UkHyhDY0DBI917vr5ISE
	 kjwvO167if3b7zFaIhP5JUxa7nd2TXM763uY2MpS9VcTDJHp5HwUBO6Qo+hrajvR/VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YTPXp+rfthb63UDmqgrgjjBHFcdZbohfcfTgb+voGVw=;
	b=w+YozOjQ2YB6XYXOZkMJYgOUV23FYkseHP9UjATSdJx/d+WKdRSGC+bF9JHU7tpi3XfQ
	 Bc1NUbClqPmTgv1AuVJePfnn7j776JUiy7cS8aaAKAjyF47VWGrei5gcM+0qqupBWoTxj
	 kFmc6jlKBeqs7c46dzVwsorIxoM4iCtK7sKr+ufKXU2xEuAmPR1HbWkIEqtGjzQtYp8zi
	 iUyY8oupI3nM1Bd60b9c6erUvEea+qBhqUYXcva0i1NcWpECKkq1ufHD8OV+V+4mnf1DN
	 Id6Kyklupf3rTxRRsBDjpmNo89XcOUS2jN7h9vro4mrdRB16nzBXcaQ0RNcsSqhsNzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="KmTq/tU2";
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD16606A336
	for <sparclinux@vger.kernel.org>; Sun,  8 Nov 2026 22:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AD16606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KmTq/tU2
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b5669a5100so414128a12.1
        for <sparclinux@vger.kernel.org>; Sun, 08 Nov 2026 14:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177360; x=1794782160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YTPXp+rfthb63UDmqgrgjjBHFcdZbohfcfTgb+voGVw=;
        b=KmTq/tU2byKqoGfA5Mu/teizX7wmKZmVmG0zXIJqaYIv82+6WSfzgcitUPk0ZP+fWl
         xaoMbh9h6RsO+eSsDtYNpE4O8jdqj+17O9UUVHgbqgnI19unpCIdXZXg/o8R/Wiy//dH
         c2nFnH9WX4o3urVTviABdOPGBLjGbpvoG+9tjlAcEl++Ozzsi7XBbp5rum2kj/XoDI7c
         PrnB6omsKvdr8kE3UOmemwFYzluI/NKCr7RtrVFNQfFqwt7sIxNUAWL/DiBB82mXBdCs
         TUyy/lLv9HSj7hm/teFcqEIY2T7Eb6N3M9PixI5kJrJQWU1pbN/YZ3N70NUn12MGp7eu
         kc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177360; x=1794782160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YTPXp+rfthb63UDmqgrgjjBHFcdZbohfcfTgb+voGVw=;
        b=S8p/qcazfZPVRclqxw1RLrQc5Yx3Ok02kt0LPyLT65V+W7sLua9S4t5BY9QZGSYfrT
         z/FgaqXYI6mH5x4xOpCRvBGDyzguIFt/FUp5mItIdo9YEFuPoIuzCsOExB+UF0n8vvGh
         iNrQ4oU9zPnKjiPbm3maXhMznTbe0tAhmoHKsVM0BHmedvnGeLv1ntaLjdmEoY7HfbhU
         Wk66UtI60Dbm+66WVT8xKUQ6yqHS8FoqwpdhPncAW+ABopHd27Ua8EzSdGKETicVC7c9
         mG4DJSDL/6MgGi0YBFdvvIdAP3yPd/KAeVSfX8bTPSgcDkoryIRLd56KqlyGr15FI1lj
         h05g==
X-Gm-Message-State: APuU4Z/50LjOfhivWAnjJNSrwg3J7Y7AskacfhbH6ocTnAvQihpLQe6a
	Pm5Jy4omH9TByhNvBXefCfrx/ylep5GzpU+hHzZPR9Pkx9Uecg7v84Pn
X-Gm-Gg: AYBFou0Ce0/7xeljF8qJAQobxqwhgqXRrbcg7P3WsIN9zZIazsX0qIPxUxg1XsmXydF
	WyavtezOmqsFLH03kWYKNyhq2JxroQuKqfHRRWZeLbbU0DWQ17d7dxy3UK4LMIRoaPwzxI2aB+r
	fVC/3L8IB7+Vmz82trAbqIv9xrhDQHzyaHp9o3Kv1qjg0SpN50/PFs4jnjstsBPvKUnk8irTKuM
	+KNl7XBpw1qJbAf+ZdC8dgLQqgV1HZVNNCG8nP04fQQwggD6KgjpuXhqQFTOGvVRVj5ni02DRIV
	5VuZMbDZCVb/XhCYkIE0ubgKlcIgvlOcPigD7OlFNN9IbnJgARneB98DylZWWSed9149JAVUZh+
	q4Gl+Vdjb04pLnOrShqzEWUR/DtIeNox8FjOHA7x89VNOskPb+KrH49cn70uFKwzW9P0pbEqlSo
	0CpLPef1YKHh4T6MjyeWhZqbQkVSAA89zYQhwd2C6kic/1u/i2kumTfMJaoycBVqSdq4vROz26v
	az6E+qT8iOZeHhPlmdEnaIK33+pRWCJX0VQ8HfiNeLqWqhuoS836rJa91s+CS1O1+wi+j3/9mu2
	JfilsfQkO+hzdGnP++1HdggZvjgxeTcO3HZNmh3Xg+Fp9k6ETtSSYZVoVXWhotomMcvtkzc=
X-Received: by 2002:a05:6402:4504:b0:6b5:4baf:ad96 with SMTP id 4fb4d7f45d1cf-6b7224194a7mr1543782a12.17.1794177359944;
        Sun, 08 Nov 2026 14:35:59 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ebc7b0sm859272a12.14.2026.11.08.14.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:35:59 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 3/9] sparc32: do not flush a NULL address in flush_dcache_folio
Date: Sun,  8 Nov 2026 23:34:13 +0100
Message-ID: <20261108223516.1125534-4-linmag7@gmail.com>
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

sparc_flush_folio_to_ram() is sparc32's flush_dcache_folio() and takes the
address to flush from folio_address(). For a highmem folio that is NULL,
so it flushes virtual address 0, and 0 + PAGE_SIZE and so on for a multi-
page folio.

On HyperSPARC, hypersparc_flush_page_to_ram() probes with
ASI_M_FLUSH_PROBE, finds nothing mapped at 0 and returns, so nothing is
flushed at all.

Returning early would be wrong: flush_dcache_folio() is also the barrier
taken before reading a folio userspace may have dirtied, as in
filemap_read() when the folio is writably mapped. Fall back to the whole-
cache operation, which reaches user aliases at any colour and on SMP is
cross-called to every cpu.

Do that only when the folio is mapped by userspace; otherwise the only
other mapping is the kmap_local slot, which arch_kmap_local_pre_unmap()
writes back on teardown. Without that test block_write_end() makes every
buffered write discard 512 KB of VAC, which cost 106 s against 56 s on a
64 MB dd.

With the mapping live and a reader on another cpu, 150 of 150 reads
returned stale data before and 0 of 150 after, every first mismatch on a
32-byte boundary, the VAC line size.

The separate HyperSPARC mapped-folio fix completes the lowmem and PKMAP
colour handling. The highmem fallback can be expensive for GUP: each
mapped folio may require whole-cache maintenance on all CPUs.

Fixes: 665f64029454 ("sparc32: implement the new page table range API")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/mm/init_32.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 7b53ee9f061f..9cf0065fc2d4 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -131,6 +131,16 @@ void sparc_flush_folio_to_ram(struct folio *folio)
 	unsigned long vaddr = (unsigned long)folio_address(folio);
 	unsigned int i, nr = folio_nr_pages(folio);
 
+	/*
+	 * No kernel address to aim at. Only a user alias can be incoherent
+	 * here; the kmap the kernel used is flushed when it is unmapped.
+	 */
+	if (!vaddr) {
+		if (folio_mapped(folio))
+			flush_cache_all();
+		return;
+	}
+
 	for (i = 0; i < nr; i++)
 		__flush_page_to_ram(vaddr + i * PAGE_SIZE);
 }
-- 
2.43.0

