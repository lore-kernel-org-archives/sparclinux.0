Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A505C13B792;
	Wed, 25 Sep 2024 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727288619; cv=none; b=pzV3awsdpMUjWrX0QwoIJ55KENDvxOwBAxgE7WP5eKD6LWOq+3fz4SHKwbmClGIpVJWRbQ7P2IwkF6tGNyD0ABjJw8F5450rvi7wmDprw3jpAqBpQfYCUgOLDMp92zHIqGSPvK23aZEAMn1xVrI9xEpJ9HvAk2a4F98C4sXKg8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727288619; c=relaxed/simple;
	bh=c3LTRwc6n1hP989JazFFkmk5j7SbGyG7HkXwaDXDiBc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=t4dZ3yT9v2iQiHHA6zpM46oQaQZvxY2Bps0/9Pry4hr+bwmCIb2hY4GYvAA8wQ/c2zCi98ikdazxzbV4mlmI5XdVS22XEX6Cp/WWyp1lfjziLnKTyJhkgRtIi3gF58UEQ5AgTO+Gg+rUeT5lKzhp4WbbEHHhh8bod4dCjL1hzFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mwcxm/DV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mwcxm/DV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849FFC4CEC3;
	Wed, 25 Sep 2024 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727288619;
	bh=c3LTRwc6n1hP989JazFFkmk5j7SbGyG7HkXwaDXDiBc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Mwcxm/DVTFObD3atOnM6pBhBCeizfNikt5mbaT7QeWyWC9EIReW+cbOvzKqt2atFY
	 3ynEriTefKN3q7FA4NUaBSQ3jgXSYvujmqnZS34YVJ6YqxC1DaOwZ1O1pa2s2fN8Wn
	 2EWp2KpWNB/WGDLVAeWIaiBcTT9rNxFwzdXeHUeRalMGC1m5/7scIrXyeQ+19PtE8b
	 71deqJJR/483RRFJp+z5JvRg9j0kQN/WTmRwqMk7nhZ69nHH1wZk/RrxsxwKBjiSqE
	 XctnqLPeN7sVu2mOcCKj5y3xJI0iW6d+5HnGBT7ntkdHBmPUsEruErfC+XsglXg4CT
	 p7eSn5j2Dh5bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343523809A8F;
	Wed, 25 Sep 2024 18:23:43 +0000 (UTC)
Subject: Re: [GIT PULL] sparc updates for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <5a12dcda-6ac8-47c6-a749-7ce38cfbd2d8@gaisler.com>
References: <5a12dcda-6ac8-47c6-a749-7ce38cfbd2d8@gaisler.com>
X-PR-Tracked-List-Id: <sparclinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <5a12dcda-6ac8-47c6-a749-7ce38cfbd2d8@gaisler.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-6.12-tag1
X-PR-Tracked-Commit-Id: d21dffe51baabf6729a95585181507f24bd695a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb5b0f9812fff72f82e6ecc9ad4dafaf4971a16a
Message-Id: <172728862176.682824.13822760805284171317.pr-tracker-bot@kernel.org>
Date: Wed, 25 Sep 2024 18:23:41 +0000
To: Andreas Larsson <andreas@gaisler.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 25 Sep 2024 16:21:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-6.12-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb5b0f9812fff72f82e6ecc9ad4dafaf4971a16a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
