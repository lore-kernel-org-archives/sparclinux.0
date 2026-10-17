Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCED3783BE;
	Sat, 17 Oct 2026 00:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198213; cv=none; b=PRJvnLAdwZS8sjGUkDOiXwjza6eRlSbPUQdj3RMl3n6tQHDBfKpEJg/YeNBL6iHa7oDC2y1fT4Z0cPKs9a33sGCKLK3FFyp3r2mtBdjXlvp3HgeUHwWyC7OlQd4gVGOttw9RMvYW5KVYEW9kAq0vM44Wp2vk3XNiqNmIMh9axos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198213; c=relaxed/simple;
	bh=oaDQP9nAO9YUphCmz2pU3Q78qr5RuazTLWYFq3rD/24=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CgJk+TJVrCBA2RXMFlmdlqHKPz2/TLp+23jh4kBtDeJFIaTBi17xTj0+Xxr1d+NTKM7bjzTodBVuhA/XKZLQKuc0+fTY8+08dUXhSubGlxlEPLD2bv0yrv7l21rWhmi6DLLCbexBxV4SZYHYT3Jq8VHWALXjjxrOGybbSvO8ZTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2R7idQv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2R7idQv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816C61F000C4;
	Sat, 17 Oct 2026 00:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792198212;
	bh=XryWVP0QAf8rIfBGXFxan/h01iVfkBwYZn2AuUnkxos=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=D2R7idQvStmi7tmzdkHhlIu9jU5kNnqegddrNWK5KrMdWSFQzMeXRwAd7Fiu8hq0/
	 u6i0vnINAcjgouiSt57TdoEnvvYIFkqi2Xx1mf+uagjsfvE2gUvZk8G1a8/rXm2Wj2
	 PCrKmGHYaTDXvLw9p1y7vD6tUcrPb6d+CA7dP81305BAPrMFjEYUMHL+XpB0XlQt1M
	 i8Qn6fYLhm22xf7kkDJxEgl01JUaYxarjRQkraqchv3fZKnjQ0v7DjI44HW/O1PTz4
	 nV4pXaXBQg86F1IVINeLNqZDzL2hsZKPkSA7qAm2t+ER4KBabHjpbGvkk8JAbCS6Xj
	 w4kXDlz+t4iLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 776F0380CED8;
	Sat, 17 Oct 2026 00:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] tg3: normalize inherited BCM5718 register
 byte
 order
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179219821101.1034269.14465914522472303351.git-patchwork-notify@kernel.org>
Date: Sat, 17 Oct 2026 00:50:11 +0000
References: <20261011194228.981141-1-linmag7@gmail.com>
In-Reply-To: <20261011194228.981141-1-linmag7@gmail.com>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 11 Oct 2026 21:41:58 +0200 you wrote:
> Firmware can leave BCM5718 vendor registers byte-swapped while standard
> PCI fields retain normal byte order. Detect this from the host-control
> revision marker, byte-swap bit and swapped product ID, without matching
> a platform model or PCI subsystem. Prefer the normal revision marker
> so already-normal controllers do not enter the normalization path.
> 
> Hardware swapping can accommodate big-endian register accesses, but tg3
> already initializes misc_host_ctrl with WORD_SWAP set and BYTE_SWAP clear
> on both little- and big-endian builds. Its normal MMIO path uses
> readl()/writel(); on SPARC64 these use little-endian accesses. Restore
> that existing register mode rather than choosing a mode based on host
> endianness. The swab32() on the initial write compensates for the device's
> inherited state; subsequent accesses use the normal driver path.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] tg3: normalize inherited BCM5718 register byte order
    https://git.kernel.org/netdev/net-next/c/4f9fbb30e341

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


