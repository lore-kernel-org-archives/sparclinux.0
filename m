Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC421474C3;
	Thu, 18 Jul 2024 23:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721343997; cv=none; b=G0i3sNv4Ihi8aMtCvb+Dv5Vpi1WbcUH4IBJ0buf5SmcluEug2daq8gy/5e2U4NqfSmjHypPvMoYcV6CpR3AL20Kg3WBk61XGJeM9IEZWvHjYIoNloXFMX/bAEWp9hyzK9toiYnpMlzHWq2UqvG2eAwMzXY/+GI6/TFx8ZGRWODY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721343997; c=relaxed/simple;
	bh=wsdTH3/Gv7lUA8D1r7yHT9UlUzfE3sPFcvm81Od6REQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dpqgPgi1+t2au8C283UuFZhd9TtChEQ5le/R74YNoq8EvvjoF896pf28J5FFa7nBGbudTY0fvKLLrC6IPV/yAU78m4ZMiVcWU9NVfkVRtWZe2zkd+YJm8IyPOEreOvmhz94mtjtraDLxiHVsV9+LI54kjGSvCH/jH6h7KrXPCLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSM6Jj12; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSM6Jj12"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2F21C4AF09;
	Thu, 18 Jul 2024 23:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721343996;
	bh=wsdTH3/Gv7lUA8D1r7yHT9UlUzfE3sPFcvm81Od6REQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lSM6Jj12BY4zacbe1F9GgKGSs1dRE8bWgkYe73LMFrI8i3L+ZojssaKj17jjlRvPd
	 z9HSRQagaDApQkHLgTUwgAs1PI3hObj/r5S+cUa9fCPvW5zu1khc1wjV5tYKjLP1ag
	 o7sZAMW4/Kj9jDazmuHq+Pfl7PJBtYgCaf41QA6vT0c+EbYHIukB0xMFeqC+8F13+d
	 Su+imVfKBDXDy8xdqyUTsM118kUgiIhyaMFSN74C2OdGlQyvuoyGcJipETODW0QKDN
	 djD2q2SP0XBM0ejlZW02crBZAIk5QCOthZHS/7VDHF6KO94OshdwHEdtSBNdUxd9OQ
	 YIxCL3RhqUf1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9355C433E9;
	Thu, 18 Jul 2024 23:06:36 +0000 (UTC)
Subject: Re: [GIT PULL] sparc updates for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <5bc02e66-dfa2-4d92-a4be-30746f2f1f76@gaisler.com>
References: <5bc02e66-dfa2-4d92-a4be-30746f2f1f76@gaisler.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5bc02e66-dfa2-4d92-a4be-30746f2f1f76@gaisler.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-6.11-tag1
X-PR-Tracked-Commit-Id: a3da15389112a28633e4c340e4841faab29df3b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7dd894c1bf65a9591ba27f6175cf3238748deb47
Message-Id: <172134399668.16085.7235502429792051277.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 23:06:36 +0000
To: Andreas Larsson <andreas@gaisler.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jul 2024 09:38:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-6.11-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7dd894c1bf65a9591ba27f6175cf3238748deb47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
