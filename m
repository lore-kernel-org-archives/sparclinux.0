Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7145322B7B
	for <sparclinux@vger.kernel.org>; Tue, 19 May 2026 02:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779158361; cv=none; b=X+UAnnHeg2oPk5W2cFmoiB8qXUyU80FNpmqW5I3wTKBu3MRT1Tk77DizxMofy/TEm2TLsSe0j71JqNhE5Eck00dYMJRWz4BSXvjxkgq603IF79rWyDhi7tcbfxPBIIuenoV0KVLi0o9zrVHrj35tcZ2Gbc0CFREjdyAZIpMcA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779158361; c=relaxed/simple;
	bh=axEuloCdAkJ7kANTevQ4Aav031O1vXQ9XvXVtXqtJ/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENPZYX1jjaGEvXsf0pXsXI8aID5hlsSb01nLDGNwRSMJczdB07HD8ovmHkc7Xt8ZsqJ2H5MY34MFMovqBQNTdZ5OVxjUQw6nzBI5wNJDOEGGB6QWPDTbsy3TFxaZYBlUoMMSOr68NgJ3csbhqZQE8ro1NkgBsmCHOQ4gjn+5h7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDhzCT4C; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDhzCT4C"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f30a4601bbso2704113eec.1
        for <sparclinux@vger.kernel.org>; Mon, 18 May 2026 19:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779158359; x=1779763159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axEuloCdAkJ7kANTevQ4Aav031O1vXQ9XvXVtXqtJ/Y=;
        b=dDhzCT4CLKmbPhoTS8GTwEcCbaf+0AXSHaPapNwiNYChGZJT+p8n2dMWUnkty3xzwB
         VmUD1jOvd9Fcqnsvb2Rvb8zhJlL8iccsDqFHg9RDdGkkFqx7Kfy8OepmoanhmZRNt9LN
         bsvhayJcXpB2hC4VTGAyb9SmXC/WsGDvOqTLvWZtLzb5z2pmKDut7Rkoh+UhY8NtU53h
         tBK+4pjzLiOF8Dt4s7ZSCtVsRrQrHiMwdwqvGdRAD31J9kT1Tb3nJYvuaPGLf5uLlN1X
         vrjawAbDKK4nPXh9keAYUQIrJKjlYY/vEI6Za4ZNcSOTjfdwxxFSsW4phhRlmLem5i8K
         /KOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779158359; x=1779763159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axEuloCdAkJ7kANTevQ4Aav031O1vXQ9XvXVtXqtJ/Y=;
        b=bcwll1/RDLe+3u40hlPQoNjd8IWY5ekXmFhZt7bURuUkhDGqKGJiCWi0AFCxtAJIiH
         W6LXrvS+EiY7mT4bDnpLHs3we6Zrs/x+EtjkuSWjls6MpV2R6h3w9asyCt3UwA+nZor7
         g2DHSYrqO6rAlt1TQw74IWQqHSLcP2qY+J4FV4OHmwcfKi0n39K84FM6588t2DlEt5pv
         9n9s/hG69nMdVWkeAfOj42vHsjIxAEFijPgRAiyNqhbZnh91JB1+tzlS7j4qs+N4sd+A
         RReBGQ87Zc2KCLceCojgNGhBWzStu8OTh6LD4aBvCH5JwbwE3Zj48zju8RbsROqLnyff
         QjUA==
X-Forwarded-Encrypted: i=1; AFNElJ9aqUKj9ugic3AYPmdmy/7oujpnWdT/H5yARZ9XdQk+hemUdvV1MTb/+Lu7vX5pvdVgK7cgroyvgn5Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxxrdKnzaCx/M5Z0DuoGX3fhhLp8b5bRxcUrjiHBhuwuH5+goRk
	2zMEXal9ziMi2UPA1P/6mz/RgNI4S6MnaPIq4i3/JRtDyBbYe/jYmrwg
X-Gm-Gg: Acq92OHlAMKujwX/zmJ+BXcGE58gu9RJY9c3RKkwfc/d/MsMRjQQH7oGNF4VDN9vbOt
	dpRWFwSPtuFvlggiC4zzJHPbrJUXMPFxip+56N0UbNAK7nBUm7MU5woPoEivqE55O0ZM/4wVxWx
	UoN3ziTUVjT6o3fgPbeJosi+nTGrPEf5bGF+S5vjL5tmkdAXdk+/Gd7KiU/3U9ksqFvSkFAjE7V
	+wtxhxMA9RVf8adGZ920j/OTFlYtcbp0QGot09O3VQZJXLLrHsEiC1aitCEvDCtU+lAcktwqX0o
	Uf5XHvs6++eEtZ3lmN5GaJeu0Xvwh1KVFtP4m+zkf+/kF5OT5puJyoAQoAa3AUNbcyezFpOGhL6
	p9HFsalzoqN4ZqoFS40MkXFEkD51yUM4DGxGqfCoVA4iFTVNs09piD5ln3Ni3aKpsKQ1Nmb+Dwo
	7UrX2KBbIlTF6e9dEwHBSlC4dn8Y81QQ==
X-Received: by 2002:a05:693c:2c8d:b0:2ed:e14:7f54 with SMTP id 5a478bee46e88-303986c4e76mr7839552eec.30.1779158358972;
        Mon, 18 May 2026 19:39:18 -0700 (PDT)
Received: from [192.168.21.192] ([67.170.89.46])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978afdd3sm15417143eec.29.2026.05.18.19.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 19:39:18 -0700 (PDT)
Message-ID: <f87eb942-425e-466e-99cf-f04a0503991f@gmail.com>
Date: Mon, 18 May 2026 19:39:17 -0700
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 1/1] sparc64: Fix tick/stick comparator equal-compare
 hazard
Content-Language: en-US
To: davem@davemloft.net, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, andreas@gaisler.com, tglx@kernel.org,
 thomas.weissschuh@linutronix.de, regressions@lists.linux.dev,
 glaubitz@physik.fu-berlin.de, linux@leemhuis.info,
 torvalds@linux-foundation.org
References: <20260518235632.5122-1-unixpro1970@gmail.com>
 <20260518235632.5122-2-unixpro1970@gmail.com>
From: Tony Rodriguez <unixpro1970@gmail.com>
In-Reply-To: <20260518235632.5122-2-unixpro1970@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Created a new patch regarding this topic.

Please see:

https://lore.kernel.org/all/20260519022421.5978-2-unixpro1970@gmail.com/

https://lore.kernel.org/all/20260519022421.5978-1-unixpro1970@gmail.com/

