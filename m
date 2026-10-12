Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6B34B7A40
	for <sparclinux@vger.kernel.org>; Mon, 12 Oct 2026 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824513; cv=none; b=LAFD6V7fEdeZEVvqSJY6nxLA3nolXf0YcJys6rtT+o/UwaH79zf53sQoyDsPVloMiUrZjeJdmLthZpLGPEnoY2F0k+8wEYg6LG9Cq2ptarqRayPkTrIElXFy79t9x4QkNxJCYgrRuQClOboZ0Ir8z4e8uxpzo559U5tIHlbYwPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824513; c=relaxed/simple;
	bh=mk8XDZoJLrnz28nCgNWfaXENJFPufAikspSQ2eN5odI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBnFUiqlWThvX/SxT7Xx+VtsSfMI+O8HeTzhsgCxHpdBFr/j20olmArtbz41iPw3409mJ8OspzcsKOPQEncG1RuzFI9oEiXV7ZuL5vssvL4gcrp06jOybyLsdm/TRCqUUZdAyQvqbVtkekdqbrfU5jc+bSx7MXxeu+tD2daZLk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxnZ/1hr; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxnZ/1hr"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b1afcd2d23so1660148a12.1
        for <sparclinux@vger.kernel.org>; Mon, 12 Oct 2026 10:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791824505; x=1792429305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mk8XDZoJLrnz28nCgNWfaXENJFPufAikspSQ2eN5odI=;
        b=XxnZ/1hrslvw2d5+up2S+1Kgq7Ul+LVtCS5ifOO5lXEDhBOIDITrmmkYigNNSC0sDA
         SPZ+FYWiDa2u8FW9ptsZMZ+hduGBIsi1nN5XcvNQKx3N8xBZIHC2AQqcCgAk8FpWVPpe
         PbhVEfjtGPLB+hMOVSOCYN125JmvTzC99UDOUWB4yBdW7kT5c/VCAgUd+/BzvKg8XPJG
         rAL8TBv7EBF0a77YMQIOulgBKsOKt+clz8C92SkNK2FSFwWGMLcQFQ0lCpaRqDa843Qp
         b7vV7QvCaddmcVhquGtiMc99EsLQb8r63FyTy663udcBmZPFVbp8dcFWgYQEUWCYhHXE
         pE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791824505; x=1792429305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mk8XDZoJLrnz28nCgNWfaXENJFPufAikspSQ2eN5odI=;
        b=enAutchppJmcOUom7mgURYKmWtf6PN2uY2TEA04vSEcF5TEjg6HBYfzSzUjcpskWAT
         Nk61hpWFV5OTQvMFUJSbVd/nDk6dL/CwywQiB+i/JkHfSmby2bcobCbaH1aVO1VtlelN
         zAKZcqF/WJThbhHgddRUbaVKXNsqQAneYoDrRSW1z1MDGdSdrK4/rv4vuj485H5fQKSE
         LKLJS8WfsMJ8CQMzVaKfD0Fs4n/wT6NHsYFzvs47gBp8F/MpEfiXkZNX19x/jVV/wVpR
         +H9doF7KJNlPc6rvmEXyiHsyA57jjlbBH1uVYaDczUDWJyUojqm2UP0/TXuc3kVnfRGN
         iLVw==
X-Forwarded-Encrypted: i=1; AKwUvBylgs4p/XjzNluY5/TN8z584eBXb4fUxiqU05SjDdZz0ltzg7sUB9nX4HKu3xhJ171GAxpAuddD+v/Z@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8pNLwCjUe3z5xDvkAr8lHYnZ+WG1/bmoc8dqaqbsmS1vgIT5X
	d6o4TKY4TlyiKYvD+ATSFsblAyvHxvdDsnOmpBzjywRjchP9ABlwark/
X-Gm-Gg: AYBFou2vmV565T8Tigb/zlC+fTUVFpopR+o6EIUoTskIjdkeRSxjgbNVknR2SpHLUYY
	+5/NEtiVD1LudY+QE6sdgbOcjaMMtmu1us8V4KMOgNUEt+gTSbfZgaR2z3DFX/pupLe80Oeilse
	6Vf32CVIw/ghU7i8NfZCwJY6xmxXaTC2r4c6O8gl+Fbc1F/tpVlO0Jsf/wlqDUMWv/f7ElvO67h
	Wutfxxrwp60kPbr1ZOhzwizvpfTcXPG735c/Ggn+XPrJVr1WIBq/TmFNSd8sXMPrmjZhudBzIf2
	0GSr7QR3dNk4whwDRm4zgHuYKBkQqQ32g4ZRPWYpUZ7cUP+XbLY6ZVw2GVOqkBmF3UjPoZUDoO3
	0JjSAMmqvDrlriSsBOQx2nzA48daJtqb2FRfxpwpsPcTY+meYuVFLZKu8qOYVcW29RKdGq4mN50
	/yzzjtRVtxNBv7tQxGqQu+0e7fGtz6Zsn/xQfi55GZdHt3TzjVkzlYHu9VCJAfUrQEhuqoJ04IC
	is+vcL12CzPS+FmFZaNkZkVK2g+TJJVAY0qATjM
X-Received: by 2002:a05:6402:218d:20b0:6b1:827c:af27 with SMTP id 4fb4d7f45d1cf-6b1827cb0ccmr6636473a12.14.1791824505098;
        Mon, 12 Oct 2026 10:01:45 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b179dfff40sm5093730a12.34.2026.10.12.10.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:01:44 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: Imre Kaloz <kaloz@kernel.org>
Cc: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: Re: [PATCH] PCI: Avoid D3 on PLX PEX 8532/8533/8548 downstream ports
Date: Mon, 12 Oct 2026 19:00:57 +0200
Message-ID: <20261012170113.985649-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927105609.8813-1-kaloz@kernel.org>
References: <20260927105609.8813-1-kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Imre,

Tested this on a Sun Ultra 45 with PLX PEX8532 downstream ports and an
LSI SAS1064 controller.

Without the patch, enabling CONFIG_PCIEPORTBUS reproducibly causes a
Cheetah bus-error panic when mptbase probes the controller. The kernel
boots with pcie_port_pm=off.

With this patch, the same kernel and config boot successfully without
pcie_port_pm=off or pcie_ports=compat. The quirk is applied to all five
PEX8532 downstream ports, the LSISAS1064 initializes, and the modular
mptsas/ext4 setup boots through the initramfs normally.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
