Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C601DE2B7;
	Tue, 28 Jan 2025 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738084025; cv=none; b=n+wiRsaDN32JME3FFXvylYTtFP6DrVINqMmKVPnM3kU+ay/G92V9uG4teJocH/GhdQXv+6mHs7jg7g2dGEqdHRyKKHNuEL5hfsjjCvcN/rFHkzt71OY+I9qBUEjcpHuKxRFuOX5115hjW3+t+7dPpUFGJvfUgCxOB7QHVZgYIE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738084025; c=relaxed/simple;
	bh=r/IcO/479saJoKarzvzIGvV5Btmq7fkSmsQ6eFH7zmU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VM/5SC1wp+I1+qHXig1+EzWFTrWAqsK/edLZqQbXq8xbkbWJE2iWGKVGJMza3UsQEaDvE4coxwcdrZHn81EQ4kVPbvllDQYHwZK3MV1jHnZx8CVzyyE//7VB9Ha7dga5DOipJw/5IWwkpms+cEEUA9BTSi+95Vh1LznI3OsyemA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXAtWqWV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXAtWqWV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBDFC4CEE1;
	Tue, 28 Jan 2025 17:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738084024;
	bh=r/IcO/479saJoKarzvzIGvV5Btmq7fkSmsQ6eFH7zmU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YXAtWqWV89DumZMVtO7KDSjHc/v3L95Cayw5RiItaReWHldaEzMpKxc8XFDv/7kyt
	 RRrtRaZV/fUr6Ieps33oeMXpysAE/Qez1TRaXJnnXO3nznbgF9e+Gk/ljkvyRukhLw
	 3ywrHXj4i3Eal3aVJV7CrJnFmc1TQEoAWWuXRk7cN9CGD6iPAb3VuI9Xz/97laeR4O
	 j5oXnNccrD4SGsLd6SQSh8lYssXGWAR0OLfvi+lze8r4zcGp83NOrqLd80BMrGhFgD
	 rMIMnDxVpiSEGc+o7QlHneiW3NFTbQFGw0ZN+HqtNfY+c407Z95uoqnDWJ9ISBjOgj
	 YfBJPLfy3XIrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF9D380AA66;
	Tue, 28 Jan 2025 17:07:31 +0000 (UTC)
Subject: Re: [GIT PULL] sparc updates for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <35a42f8f-fb15-429e-9b90-11033f17fbeb@gaisler.com>
References: <35a42f8f-fb15-429e-9b90-11033f17fbeb@gaisler.com>
X-PR-Tracked-List-Id: <sparclinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <35a42f8f-fb15-429e-9b90-11033f17fbeb@gaisler.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-6.14-tag1
X-PR-Tracked-Commit-Id: 2cec2c4dc90cbf5194c1acef08c1e74f0437af95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a37eea94f775132866ecdd466fd88027d7125515
Message-Id: <173808405040.3856593.15940980270786962882.pr-tracker-bot@kernel.org>
Date: Tue, 28 Jan 2025 17:07:30 +0000
To: Andreas Larsson <andreas@gaisler.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 28 Jan 2025 08:33:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-6.14-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a37eea94f775132866ecdd466fd88027d7125515

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
