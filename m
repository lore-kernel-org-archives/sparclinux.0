Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C9F83CA0;
	Thu, 23 May 2024 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716492483; cv=none; b=XTZwO+P10wR787Jm/nLLKBTvzNYJGDsCFQSGKjDxAsola0eoBeJovNuqHlYQoCUzZZ7ogMrxTjDqU+ely+plowIFea6tG5B8s5hbgar1jC4LC+amf7wspn7GgerYKVW0o3o90WVGoAmeNE3wDA6DJRjPI9cJ9Gr0u7aATti9qXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716492483; c=relaxed/simple;
	bh=czzE+Pk+7SNKBQO3Ifz4ek9/oi7iEFGyHx3MSWlOipQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KMeWIqnPvx/8rJ9QCQ72cTjtef3kARe8EFlCXStZqDuqWunRRRjiR8hBSDNC5rNir/DlNYJ541kP2wbCFmpvsJrflb6SPHNTgpAa9a7fkpnJ8qqGQB3qZNZniyv8t8XfT49JJJ81+g3h85S38isUYifFeKgaGRO/nXR62A492DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBM/I+Vb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBM/I+Vb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85143C32782;
	Thu, 23 May 2024 19:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716492483;
	bh=czzE+Pk+7SNKBQO3Ifz4ek9/oi7iEFGyHx3MSWlOipQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mBM/I+VbUPrboAzpTQeU3Z1kc56+wcqLFUFYKupaT7TM0OolsHMYyukd9XZPZPauI
	 7o7AG/HHXzRaD0002WfsCUy9h0n11Ftk++++an1o/9PibgmIsXm0twBGLKGm84aAR9
	 gd5jyTiQ11cAFIEYmIDdNDke5Lz9NRNkUnXxOMBgkM7b1tMiefS2a9X3M3mCQ0PPh7
	 7psqELV5QykDicOdtQrAZjXbBc7EyID/yBID9KqSYteScIfX3GRiOJhsnvNhKmpIfh
	 I9k05eEBI2p46Emf03Gv9puC509h6f2EJ05YJ56QOkjc3ZBfysc2vxyOGDLbIAfwY9
	 I1W9EeJNhqbXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7CE34C43617;
	Thu, 23 May 2024 19:28:03 +0000 (UTC)
Subject: Re: [GIT PULL] sparc updates for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <413928e9-8e8e-429e-bca1-5d55ed3314fb@gaisler.com>
References: <413928e9-8e8e-429e-bca1-5d55ed3314fb@gaisler.com>
X-PR-Tracked-List-Id: <sparclinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <413928e9-8e8e-429e-bca1-5d55ed3314fb@gaisler.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-6.10-tag1
X-PR-Tracked-Commit-Id: 1c9e709cde80fb612e07d9503ad04457e8a58da2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bca2a25d3be779fbdf912de8e1ded6dcd483845d
Message-Id: <171649248350.6115.5842625988978141439.pr-tracker-bot@kernel.org>
Date: Thu, 23 May 2024 19:28:03 +0000
To: Andreas Larsson <andreas@gaisler.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 May 2024 14:58:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-6.10-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bca2a25d3be779fbdf912de8e1ded6dcd483845d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
