Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305407;
	b=WxBKLLNbLi/4rOqTAKYkdIPg1zdpxYHVMpfmfyyYo/S/+o/in4SAmV7mBcLxQFYofsgq
	 fQ+7qXuWIIEA9KjUPi7GfN7FJe/Txyc+j4FvFVmhe5DwcLcwV7GhRATTZWx5TOspKo1TO
	 70I3g5vItHDr5jfswGaWAuWPbCR+8+4WqZOOxW/IfLpAYzhc1IhOaGdzfaluEfL9T5LxK
	 pJho+6EbYFh2i0hjNqo+06fsHQLh12lP6UzJEV8y5Rw+BnW0in36D8q6J8FhLhv+qeJXb
	 l0JVvSU65N3pAwawqHT8kdtcU5poLYRYev1gzf2BfZNuRYJPhQeJP8NRx8a2n8Ax/4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=El/8JBBP72rDx75dqpDC2klSCHMZgsc/9NFgTGKU9aI=;
	b=KbMf2KYruFcGN11sQM9+lHFPhw1nPd8mE1r8z0j1OFkhjAdwCak/k/gH6x9fIjA0jtUO
	 ARIwMydfNGUzxsAJJvB4uOQu7B4BQ07B9T4wnwYuRi6+172ITnKntGMwbtw1qjwJzNHdQ
	 5CmMLl2ft6b+BSwsCNgIyi6AIwHTI8Ayeuh59jMIbcfIsep/d8yIzqc3+CsahomJRnKzv
	 +qwICBUNJnWZfXBV9hAfsziAht+vb5MIHHFqWzeUbrLmp/SUuFLpMckuXiZDCqtvTZKDL
	 SFl9Fje6f0afi2XfhmO+ifQsY0J+1UuneOJSRzCFQ9tQosO+ardnF2ktU3UcdeeF2lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mwx4KcBE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5B7606A33A;
	Tue, 10 Nov 2026 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mwx4KcBE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58371F0089F;
	Tue, 10 Nov 2026 10:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794305407;
	bh=El/8JBBP72rDx75dqpDC2klSCHMZgsc/9NFgTGKU9aI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Mwx4KcBEIY4KrxoXxGbJZF0oTJsu18oVCIlGM0PjWRLbRS4oKjSeQrRQi7jkNxKjU
	 vye7nCZkKdN7NYvsakkU8aBjlShrznTfxbybz9TRMci12/Zxc541jMKxcAb/1lcl3l
	 TSD6A5xhbbxJQDzIDOec/OFt8/sUS8TDK9Dy0lT7cooCo5alxhiEjEHyPrNd7Cll9U
	 S5Abey03UkVO/jnP+yDM26u44anI4kab0UTufNScnAE+M/nH/FVLxrtT1+ugeszvE/
	 iYevgmtPpLwx+nGrDZvFFJeKoqpkdbXP9HkwgkdEyFFFq9h2Z9UN5NEyAEfwQE11h/
	 GCbvq93A0tE1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D82EC391B148;
	Tue, 10 Nov 2026 10:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: add SO_PASSCRED_THREAD to get a
 thread-specific SCM_CREDENTIALS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179430540568.3843312.3120284833105457561.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 10:10:05 +0000
References: <20261102-halaney-scm-creds-thread-v1-0-0b4d75dbf35f@amutable.com>
In-Reply-To: 
 <20261102-halaney-scm-creds-thread-v1-0-0b4d75dbf35f@amutable.com>
To: Andrew Halaney <andrew@amutable.com>
Cc: kuniyu@google.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 brauner@kernel.org, richard.henderson@linaro.org, mattst88@gmail.com,
 linmag7@gmail.com, tsbogend@alpha.franken.de,
 James.Bottomley@HansenPartnership.com, deller@gmx.de, andreas@gaisler.com,
 willemb@google.com, arnd@arndb.de, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 02 Nov 2026 17:12:33 -0600 you wrote:
> Currently, SCM_CREDENTIALS carries the pid of the thread-group leader,
> despite carrying the uid/gid of the actual sending thread.
> SO_PASSPIDFD_THREAD lets a receiver identify the sending thread, but
> only through a pidfd. If you just want to know what the tid of the
> sending thread is you have to do something like:
> 
>     1. Setup SO_PASSPIDFD_THREAD on the socket
>     2. ioctl(thread_pidfd, PIDFD_GET_INFO) per message
>     3. close(thread_pidfd) per message
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] selftests/net: pass socket options to the scm_pidfd test flows
    https://git.kernel.org/netdev/net-next/c/5fb7b21d2971
  - [net-next,2/3] net: add SO_PASSCRED_THREAD to get a thread-specific SCM_CREDENTIALS
    https://git.kernel.org/netdev/net-next/c/d006eac7b099
  - [net-next,3/3] selftests/net: Add tests for SO_PASSCRED_THREAD
    https://git.kernel.org/netdev/net-next/c/032bc8ef0456

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


