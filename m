Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE6E28507B;
	Sat,  4 Oct 2025 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759601949; cv=none; b=IFfPjJj7H4IWWgnV3YOsIsWd05bAWjBLgRCIO2O4xxuvPxsVX5A4FMbs6bq6+QG72IGyLAq8pO/ti/AyOozOoQ81KbNz76Aj5BbcF43f4dxhnfNSkB2KCWcYO6J6Ae0v3Yz9pklf1EtJkYXyR5w7WdgEqug2dG2sxnFcLdYXMDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759601949; c=relaxed/simple;
	bh=oFz8Np8+2oZHfnXnYlAE8THxx+MSYy1w9OtWqz4/+AU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l3fywL4t0nhh+ohVjfDNiKyb/kvWPpno+l2t9cThCGJ9v106dFAsSiFZg+3+SJ2thu8C3IfkjYELvarXsGO1AV2iab7GVj+/lO/5qPO5NQKt4Z+FXPCFcBPYjl7dxR6IvLntes3EIjqfgE7aq4KJSxTcq4DBICEvJ2kgx2AMlN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+trlSS5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+trlSS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A355C4CEF1;
	Sat,  4 Oct 2025 18:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759601946;
	bh=oFz8Np8+2oZHfnXnYlAE8THxx+MSYy1w9OtWqz4/+AU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=P+trlSS5Mjujr9ho2Dli79yNwaNxkAH+WMjPOcfA5w2WcvexC6dITvQVa7oHIEWQw
	 VkTJ0tSYENsHWTyOrV73PjUKRkuOgPKgVXjlRXLetxhIQJH3c5ZA9f6WuG86OLZSFR
	 eqabWiQeiXKenNqZkCDXWTSRCJ3pKSC8/BPtOnlhrOMgM+kOZp28Wk3IXeT2kORekT
	 Dy/Vw0dbDWs8+0T+teti0Szmf9OXAYhshXp2vG0yUe8xrubB4PgCynPmz0NJxV8LIv
	 y5/ZRbd3pgegsYeleQ7j3den98BUvMn0Poes6r738lO0baVOobV5NKT2xYyiuAPv7i
	 fQtgVWbLrczNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 352BC39D0C1A;
	Sat,  4 Oct 2025 18:18:58 +0000 (UTC)
Subject: Re: [GIT PULL] sparc updates for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <165c7a48-a7b5-4a79-98d6-4ffd520a3772@gaisler.com>
References: <165c7a48-a7b5-4a79-98d6-4ffd520a3772@gaisler.com>
X-PR-Tracked-List-Id: <sparclinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <165c7a48-a7b5-4a79-98d6-4ffd520a3772@gaisler.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-6.18-tag1
X-PR-Tracked-Commit-Id: fe0126702a40b2f3d315bc943ef10dc2f707e29d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4c8bcab18821e0c2852c38dece918512c60c732
Message-Id: <175960193669.404121.10660314142704863563.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 18:18:56 +0000
To: Andreas Larsson <andreas@gaisler.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 3 Oct 2025 16:03:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-6.18-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4c8bcab18821e0c2852c38dece918512c60c732

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
