Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7242E62A6
	for <sparclinux@vger.kernel.org>; Sun,  1 Feb 2026 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769934919; cv=none; b=Jt7enfskKhWmFRkNx6KjCPwzNT/LCy8sBtmfMJ0G+xiy9uorAdbcZKKKeiMV5DIs7jMycwKAunIPFma2M6vN3oS5x4GeIAcC06MygZ2D4gGLQMqfKpHlfi8hC9KLnfK04yGDMk2PZ1tkGTZOAlgwClQM6FH8mmN1Evs54d4y4V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769934919; c=relaxed/simple;
	bh=Jq3TH0XhSi0dRpQ1ehkC4waWr/uSuDhMY8cMzjBNwKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jnLT4oUggImn9E4zl27oe8XtqJA70KzwbgvcDkhrvFbMlZCIb8+rUvz7M68TvP9JkeuCWNG5c/5UuRtTaAs29CIrj2+wjuRtZG+xst6fpyvL+jM/30cp6Jg9aMJfkZC1MjiZGrgsgmv9CeNyGt3FRpPgJZCgzOaFtAmG7DSDf/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmkSJyZX; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmkSJyZX"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8ca01dc7d40so87801285a.1
        for <sparclinux@vger.kernel.org>; Sun, 01 Feb 2026 00:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769934917; x=1770539717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6eutNLEmldLaIWi2QOrKdJ7W1VjSKq79ja0CoQ+cj7Y=;
        b=CmkSJyZXT4TCSklCAMBnTrMOqRAVOBOW+j8jX5enwgLpi50G10GL1DoQpHYUTVW9ns
         PQ890fskhIwzbDBr/uiqTk927yyjtkb7TZLlBbliSB+EbUpfY5cot2PQUNvPnvtBBi0e
         6AP/SVKXkCaX4F9HRkcFyuHghNMESFFt6V9BvgNK3nvD7+MKcnSlg+NrhK/NDtPWem72
         pXdAQNulLZLviRZtLAAs3EL9o8NQM+FFMUzzDM22SgTURrETW0qb4mefEl4WGTRIU6M2
         +PbTVwMQR7MtQEqgJ4Fs94TjhTempffamhbmHEIhwDzopPfxFBxIn8dNy0Oa5UkoJH8d
         8pZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769934917; x=1770539717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6eutNLEmldLaIWi2QOrKdJ7W1VjSKq79ja0CoQ+cj7Y=;
        b=IB5tQ488iDBa6dSirznz7mZN5jCofI3pJHG2Eu2Y6D9FjzxMVSSCXOXuJUkXY9kvj/
         GRZdgxFKUrSiaQa31s50mgzTVjyG0I6Qkdndt6aPSGdPE9+NEdOKqLrFKkadaZ9UZUoN
         Pmicobq9BOGLw5/NjmFoGIyatet9bOKbRTgzp5WrKmQlpwvICpC9Ky8q4yKYFnChwt74
         xLqp6UlNNebQObLgh8kTB7fee00bKl6CWQVzw56HsFdgvy7le+ixECpfx6Ug5kUgBzFy
         3FywEOHcHoexfvGF7nlhOhlHhWO/2FDwbmcp75FNN/UTxQu1epC/Bl8id2fSyrouu2BK
         QG+A==
X-Forwarded-Encrypted: i=1; AJvYcCWXkNZwdZJKooMp5wczGF/8xnKvGh8UPBr5s+3goBAyK2cbjCgM5OkUfZMsK83BBXTHItrUbg1lBZdq@vger.kernel.org
X-Gm-Message-State: AOJu0YwNlNjEgpomOWi8cmS7UJE0r0zPsUq4Xg8TqvipmiwidP6KxjPk
	VGTILYk/HmPr8RWBWgm8ppQfcwpX19QQvduBUmJdTlaMuFCEw48/Acjr
X-Gm-Gg: AZuq6aIQq4XGd4SG7cPDF1NSyzYJi1xInxDG9ydfJ/WzWf+BQcEtZb2Nu7WcST19qbf
	/nF/fFMa7NP0tNhXhQUvkZ/4U007FrcEgCk7DSoJ4iqu/KDkMD8HkFhzTrT/6R0Z4MxYKCDSiqT
	5FTsAEF32BRJjFo1GvDZe5QsSG3MuZk2NCXi2NQjYaA3we/VxernElqPbnvgX7wPGCVNKwTY3rM
	CV+TAR6HPXUgsv0EXj5dJMxIIcRuYhQGphU2IeNT0+4iEZM8OTKpOBbBbDpLr+nA1Q12Ony62o7
	WXTpT6xaDS+oML2AxDNTTyxWlz0VpilK4ca+ydHp5OqFUopQwsai4qMeQdUYCOTepm9CVCYfvan
	ZgjZdtx9Diw0kOzmYnFcz/I1ek7IY1FwRH3dmq57a1NkW92SDAlBdLsDSrpWn9XRA0oCq44fume
	Or9ATn718VQuYGrKXGdWMxZMTNU9Ap299r4LXa6QWhzg==
X-Received: by 2002:a05:6a00:21c3:b0:821:7d75:f42d with SMTP id d2e1a72fcca58-823aa710b20mr7502550b3a.42.1769927743937;
        Sat, 31 Jan 2026 22:35:43 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b6b2bdsm12149294b3a.30.2026.01.31.22.35.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Jan 2026 22:35:43 -0800 (PST)
From: chengkaitao <pilgrimtao@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com
Cc: kevin.brodsky@arm.com,
	dave.hansen@linux.intel.com,
	ziy@nvidia.com,
	chengkaitao@kylinos.cn,
	willy@infradead.org,
	zhengqi.arch@bytedance.com,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	chengkaitao <pilgrimtao@gmail.com>
Subject: [PATCH v6 0/2] Generalize vmemmap_populate_hugepages to sparc
Date: Sun,  1 Feb 2026 14:35:30 +0800
Message-ID: <20260201063532.44807-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change sparc's implementation of vmemmap_populate() using
vmemmap_populate_hugepages() to streamline the code. Another
benefit is that it allows us to eliminate the external declarations
of vmemmap_p?d_populate functions and convert them to static functions.

Since vmemmap_populate_hugepages may fallback to vmemmap_populate-
_basepages, which differs from sparc's original implementation.
During the v1 discussion with Mike Rapoport, sparc uses base pages
in the kernel page tables, so it should be able to use them in
vmemmap as well. Consequently, no additional special handling is
required.

Changes in v6:
- Ignore handling of altmap

Changes in v5:
- Remove [PATCH v4 3/3] sparc: Remove unnecessary whitespace

Changes in v4:
- Add commit message
- Add verification that pmd actually maps a large page in the
vmemmap_check_pmd function

Changes in v3:
- Allow sparc to fallback to vmemmap_populate_basepages
- Convert vmemmap_p?d_populate() to static functions
- Split the v1 patch

Changes in v2:
- Revert the whitespace deletions
- Change vmemmap_false_pmd to vmemmap_pte_fallback_allowed

Link to V5:
https://lore.kernel.org/all/20260111074453.66728-1-pilgrimtao@gmail.com/
Link to V4:
https://lore.kernel.org/all/20251219115812.65855-1-pilgrimtao@gmail.com/
Link to V3:
https://lore.kernel.org/all/20251218174749.45965-1-pilgrimtao@gmail.com/
Link to V2:
https://lore.kernel.org/all/20251218130957.36892-1-pilgrimtao@gmail.com/
Link to V1:
https://lore.kernel.org/all/20251217120858.18713-1-pilgrimtao@gmail.com/

Chengkaitao (2):
  sparc: Use vmemmap_populate_hugepages for vmemmap_populate
  mm: Convert vmemmap_p?d_populate() to static functions

 arch/sparc/mm/init_64.c | 47 ++++++++++++++---------------------------
 include/linux/mm.h      |  7 ------
 mm/sparse-vmemmap.c     | 10 ++++-----
 3 files changed, 21 insertions(+), 43 deletions(-)

-- 
2.50.1 (Apple Git-155)

