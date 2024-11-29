Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A27156F2B;
	Fri, 29 Nov 2024 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732906450; cv=none; b=Zj/9Oj7CfpxkK3tkMujj0JfQhr2alSbYMRJm+yDgvPcx7eSGz+dI4k2ceOR0wYNOnFDRh1hL0IToo8GK3y8LrRCEXx0d5edIeDketBLFhdQkG8ZX80y/b2g2b8YnfiIm9l+WQQXmXMPq3UiZHEF997gnpCKvrxmSzGph6uA8xMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732906450; c=relaxed/simple;
	bh=9OJg33u/vFp0Ed9MMcQ3OD9SWOI2Dprq1EV0TkFYBKU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N+yp1VEfB/FYmhbQHMygrqX/FPQEO4wcMJnvro8TlklfednibqwZXSDSZgP4D6NBkk5lIKLr6QuYBOQClxkdq3l2+cjlc6wEsZCuhAvNDNpWUyghU3XkkJxx2dLX1Qtia9P6F2AXrNfIkN572ona3R0HLLK/JbnZz3HMRH4o7Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8RI/1Z9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8RI/1Z9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A94C4CECF;
	Fri, 29 Nov 2024 18:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732906450;
	bh=9OJg33u/vFp0Ed9MMcQ3OD9SWOI2Dprq1EV0TkFYBKU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I8RI/1Z9r6donh+LndouZG/mDDRYBEJ+8z8muJzkerJOgFM8HJkvLZyrhHPQT0xpG
	 LLBNnMT3Gv6Hfg18FsMtirjms3dWK0RClv2+q5y7SbKrJpk52YM/g8wx81osC8qUOw
	 eJ12vfwiX3zo7uFvkyU4fMvBTUpFBAeBz5MGqoL34y0sWVvZyZ9j6DRx7d8heBeNkm
	 CYrCjnltIx6l3k9aL0nCrZLfuljfjgs8ht3TNL+BD4r76iHL0QREYq3kqnd6XQ/+yW
	 DGBeyyhsYyL3ZWlHl2+hT2NSO7sF43LaqX0IgFpUb17+BWZ2dVPKDVb2IUQDcmP6VO
	 IBXGM8cyEosCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB02F380A944;
	Fri, 29 Nov 2024 18:54:24 +0000 (UTC)
Subject: Re: [GIT PULL] sparc updates for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <a124b567-d9a1-48f5-beec-de1bacac2140@gaisler.com>
References: <a124b567-d9a1-48f5-beec-de1bacac2140@gaisler.com>
X-PR-Tracked-List-Id: <sparclinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <a124b567-d9a1-48f5-beec-de1bacac2140@gaisler.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-6.13-tag1
X-PR-Tracked-Commit-Id: b6370b338e71cf24c61e33880b8f1a0dd5ad0a44
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbb3c22f908accfd6fd34b1dbdd304fc2609c78a
Message-Id: <173290646362.2148737.1892858841954174102.pr-tracker-bot@kernel.org>
Date: Fri, 29 Nov 2024 18:54:23 +0000
To: Andreas Larsson <andreas@gaisler.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 Nov 2024 13:33:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-6.13-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbb3c22f908accfd6fd34b1dbdd304fc2609c78a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
