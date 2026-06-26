Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11493E63B7;
	Fri, 26 Jun 2026 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462089; cv=none; b=X9ajK4f5TsE3Q6sinJQV5NJrhhW/fkau7LFiEWLz2LK0NpVIFPFEBSMCYKEurlrXiXl0oJWGjKJwHT9LFsj/zHY4KIeUqNn3o9zGJV5eIHVTFRpk3KFAbFMwwB6VwalP0Z7bha+j9vTc5JTxFvNC4x7LqgiePKOYze2N93StIZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462089; c=relaxed/simple;
	bh=FhxzUr3xSIqVmKLvLbWazz7YlCkIyFnNgG5krqvMrm0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nlFJBv/IfCoJULEApBddUwXA3QqpSAmtN53M8M3f/dEXSQB3W3sDP5XpiRdHhdLun5lzU1pxfsn3mVK7iWyWq6+RLNdgBsryA1O3OqCyqme2yP1s0VoZGj/ClLWPcGnnJN7rlJsxRpq/tJ/a5S0SH5hMX5+6AFs8ueXyAGXZP9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2rMods2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2rMods2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A8B1F00A3A;
	Fri, 26 Jun 2026 08:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462087;
	bh=8Gh35kQAbF9NJda9I6lHvwWhKBgWUfcBmP3w8KkXOio=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=P2rMods2RZJ2WUH9fceMLGk+MpRiyzpYQRjH4L1pJ6AqR61HFQvucLW938qDFyqSa
	 FrkrECMukEjHEVzuIjf3V5yv1Q9p5xzHWGE+6HTZgD9e8Q+Z7nOezHkV6X/Sw+wiEW
	 UPxEJFogBt7IvXPhQEsLsvxrjA2ZUZ+sJUU/SjGsUQqENcjHgmsRWXaKB8JJOigNrD
	 z/e7SPqqHF1NDBLkiCfywon1PNKm2pb6Q3QrCHZx2g16/jVLKpx0YZhOf14SdseVff
	 79jb5rym05v6a+Y09V7n67Wwd7zqoPAjo6ZU1rDj2vUgGPcpWRf3ejlG4/+MASOcl2
	 CdcLmqI3QOqjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199D739389E8;
	Fri, 26 Jun 2026 08:21:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/5] mm/sparse-vmemmap: provide generic vmemmap_set_pmd()
 and
 vmemmap_check_pmd()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246207479.3816447.9419541647213093704.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:14 +0000
References: <20260404071720.3577290-1-songmuchun@bytedance.com>
In-Reply-To: <20260404071720.3577290-1-songmuchun@bytedance.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: linux-riscv@lists.infradead.org, catalin.marinas@arm.com, will@kernel.org,
 chenhuacai@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, davem@davemloft.net, andreas@gaisler.com,
 akpm@linux-foundation.org, david@kernel.org, muchun.song@linux.dev,
 kernel@xen0n.name, alex@ghiti.fr, ljs@kernel.org, Liam.Howlett@oracle.com,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 ryan.roberts@arm.com, kevin.brodsky@arm.com, dev.jain@arm.com,
 anshuman.khandual@arm.com, yang@os.amperecomputing.com,
 chaitanyas.prakash@arm.com, wangyuquan1236@phytium.com.cn, ptesarik@suse.com,
 austin.kim@lge.com, vishal.moola@gmail.com, junhui.liu@pigmoral.tech,
 willy@infradead.org, alexs@kernel.org, chengkaitao@kylinos.cn,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, sparclinux@vger.kernel.org, linux-mm@kvack.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Sat,  4 Apr 2026 15:17:04 +0800 you wrote:
> The two weak functions vmemmap_set_pmd() and vmemmap_check_pmd() are
> currently no-ops on every architecture, forcing each platform that needs
> them to duplicate the same handful of lines. Provide a generic implementation:
> 
> - vmemmap_set_pmd() simply sets a huge PMD with PAGE_KERNEL protection.
> 
> - vmemmap_check_pmd() verifies that the PMD is present and leaf,
>   then calls the existing vmemmap_verify() helper.
> 
> [...]

Here is the summary with links:
  - [2/4] riscv/mm: drop vmemmap_pmd helpers and use generic code
    https://git.kernel.org/riscv/c/abff0ecf7602
  - [3/5] riscv/mm: drop vmemmap_pmd helpers and use generic code
    https://git.kernel.org/riscv/c/abff0ecf7602

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


