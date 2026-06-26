Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00FF3E834F;
	Fri, 26 Jun 2026 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462090; cv=none; b=UCqJNIkPZSghA7Hatz3YiNUtBWLWXJTCf9+NntmQDP9/0pB2frI93v3OrPnmfJdI2bzHiMVEscamktNUOLVjDTDuGk1aA5/RXjN+SU5yc3PV/LTWf6Ccv+S896LO3KBXoahUHzZyM3Xar1oclWzts85mz/4RDkMd+3Sc8aVwLDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462090; c=relaxed/simple;
	bh=Hx+qi2oa6VNdtzhKQzuQ+50ZrB4omidZvKjdgW+vH2Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VUAtbrMRSDP3jA/Pt4F0ANBawYuoK2Eq3YFWmjNYwfLkgpKjqMQrT9YDAmE4vRXjjj9FksO8j09C+CQvevNvUXnPZANuZcKYtqm2pXkVqfv9ADpnZrF6n7GZNgiNZNn1SZm4Fg3QlalC+vPKxQaJ+A0cQD/NfNrfiFXgNUDRdco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TplBEdU4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TplBEdU4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D0F1F000E9;
	Fri, 26 Jun 2026 08:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462089;
	bh=keBQ1PB9E9ulKt7uMx/nDlIJ5ohwmy4K2SVXnXfXhTo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TplBEdU4A/z/qEhUSGn77hXstHEYmJOXCCuN+UkQKeu1/I9KO0Qz+9fznYYYSxVbt
	 dEAkmVaUPl8uqq97GQ/QBYwsoc0KXBtQgIVRDSYX/BmQNjUqy58m/JzNQhPXP76cbH
	 796cf9T9XiQ2YthX//6M6kR5Jr/1DPvD/uF3QDIJADTCir7yryOiUIqr5YUUx2BjPK
	 rvUwIDrGMOB+2M+QznofiRmp9MYhl1iLrv41oa8p2m3DTiKv9PvMLlh8ejFDHpLNcB
	 rrMyEjK3cKyesdAwr/ZAIB8POB86Ebs36xbPg+VMubfbzyEUyPcu+wH7WOhXQQF2f0
	 BKzdbh/NP1Frg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9393539389E8;
	Fri, 26 Jun 2026 08:21:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/5] mm/sparse-vmemmap: provide generic
 vmemmap_set_pmd()
 and vmemmap_check_pmd()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246207624.3816447.4177031772329695086.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:16 +0000
References: <20260404122105.3989557-1-songmuchun@bytedance.com>
In-Reply-To: <20260404122105.3989557-1-songmuchun@bytedance.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: linux-riscv@lists.infradead.org, catalin.marinas@arm.com, will@kernel.org,
 chenhuacai@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, davem@davemloft.net, andreas@gaisler.com,
 akpm@linux-foundation.org, david@kernel.org, linux-mm@kvack.org,
 muchun.song@linux.dev, kernel@xen0n.name, alex@ghiti.fr, ljs@kernel.org,
 Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, ryan.roberts@arm.com,
 kevin.brodsky@arm.com, dev.jain@arm.com, anshuman.khandual@arm.com,
 yang@os.amperecomputing.com, chaitanyas.prakash@arm.com, ptesarik@suse.com,
 vishal.moola@gmail.com, junhui.liu@pigmoral.tech, austin.kim@lge.com,
 chengkaitao@kylinos.cn, willy@infradead.org, alexs@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, sparclinux@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Sat,  4 Apr 2026 20:20:53 +0800 you wrote:
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
  - [v2,3/5] riscv/mm: drop vmemmap_pmd helpers and use generic code
    https://git.kernel.org/riscv/c/abff0ecf7602

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


