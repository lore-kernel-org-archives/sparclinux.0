Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6D83E9580;
	Fri, 26 Jun 2026 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462092; cv=none; b=VOV9xB98BN8HbGn4308X7V8Kmaa3RSfcVcGM7DQmeWW0P5AVdsw8pJsD6l2PeaAZPZtqSyz0164NrvqOjYWY8ULahE+zsBprU+TTrV+NHtbOGn+pbPlmoNH9u1ulCgZfmPd8GAj9NiExM+fZbfM/U+dxw/Ft1UsD0SkSDl0fDgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462092; c=relaxed/simple;
	bh=HPslEfq9mDWkDQKVF0Ar/KP7GOp6hOeGT4HYwvwgRy8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=od5ahVJTCU535Lpft+UwSUT5t4d9UU9IQT2Lgp2yj/Om7sdWXOatDznY5vlqvJ5lrO97D/NwYcEI7WsBTq3Fm35zAB+tP2QAi/7b6fcfHuLLzEENR+m8qTRUMfDRZFovLyg095L1fGjFWZp7cIoh7hIGsmGTh0DJ4nDcUEWbouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5Lo7MDs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5Lo7MDs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21131F000E9;
	Fri, 26 Jun 2026 08:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462090;
	bh=amHqBGTdQawFVm0LwCwHTx4WOCHiePZ3qut6Gw9czoY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=d5Lo7MDsnDBM/WZunCT8elchDCzS+3C2c2lbeT2RSyY4SfuiwU/JuHgJcOlOwtDQj
	 xTs8KeqZ97q11hRxTGc6nX5sC8HyMT5fZT+4qSj8SryW2td/wtO9smFCvfjcxc87Ru
	 eLKRJlPdL6ayIsq8pXjYViiy3xT8buj1g0NlrmisaHekowwVrgLIe+N8x2ztJj0mHl
	 P2mUemccKTtOFMr2RIOTamnjYwOMVgAvn0oNX07Zb+nu/Qg5awHIX5oYSWKc3+tC3h
	 k5BC3dcthXef5b80m5peDldls/Zf3sAtajK0+0mGczG7pCQAJfwafDixrBN/6u/FYB
	 5mx3vhjFNnd6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1977339389E8;
	Fri, 26 Jun 2026 08:21:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/5] mm/sparse-vmemmap: Provide generic
 vmemmap_set_pmd()
 and vmemmap_check_pmd()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246207775.3816447.6521226918403076772.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:17 +0000
References: <20260601084845.3792171-1-songmuchun@bytedance.com>
In-Reply-To: <20260601084845.3792171-1-songmuchun@bytedance.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
 david@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 palmer@dabbelt.com, pjw@kernel.org, chenhuacai@kernel.org,
 andreas@gaisler.com, davem@davemloft.net, muchun.song@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org, alex@ghiti.fr, aou@eecs.berkeley.edu,
 kernel@xen0n.name, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Mon,  1 Jun 2026 16:48:39 +0800 you wrote:
> The weak vmemmap_set_pmd() and vmemmap_check_pmd() hooks are
> currently no-ops in the generic code, which leaves architectures that
> need PMD-level handling to open-code the same logic locally.
> 
> This series provides generic implementations for both helpers in
> mm/sparse-vmemmap.c. vmemmap_set_pmd() installs a huge PMD with
> PAGE_KERNEL protection, and vmemmap_check_pmd() verifies a present
> leaf PMD before reusing the existing vmemmap_verify() helper.
> 
> [...]

Here is the summary with links:
  - [v3,1/5] mm/sparse-vmemmap: provide generic vmemmap_set_pmd() and vmemmap_check_pmd()
    https://git.kernel.org/riscv/c/0b6073ff1574
  - [v3,2/5] arm64/mm: drop vmemmap_pmd helpers and use generic code
    https://git.kernel.org/riscv/c/f521f198b50a
  - [v3,3/5] riscv/mm: drop vmemmap_pmd helpers and use generic code
    https://git.kernel.org/riscv/c/abff0ecf7602
  - [v3,4/5] loongarch/mm: drop vmemmap_check_pmd helper and use generic code
    https://git.kernel.org/riscv/c/ecca7da924b1
  - [v3,5/5] sparc/mm: drop vmemmap_check_pmd helper and use generic code
    https://git.kernel.org/riscv/c/d3d58e946900

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


