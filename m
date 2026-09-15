Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F76390C9E;
	Tue, 15 Sep 2026 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473715; cv=none; b=o5mtjdb1Ep+vYwnNUALVZYJ0Dpqr9hw5/MoKpoatDo4MaK0E3WJKuA+M83L58uvGxux3w7EyxWJjSNWpRufnPU8u+NLGzE7FkKp4Mtq3eraue7BBv07OH8DN0rdOONGCWfIOjJTx2a5zEwPaWbLHGplTeoTH7/FoauQQ3wsq+wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473715; c=relaxed/simple;
	bh=yaVzdP8lM5NkwsIfqLJMk1LB9QIq/dT8qJrlL2t7nR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ajUZKyFuCxd//1DjVMfjfrs/CtU6F9+ax1PAqokVDyNxLu0Xaj2Xrye1DYmVw7zM+jowKt9eFxV3lqQUhCqtYn0sxQ0ymgsJ+5mrj84IxXAWQcLXDxs8O6+Tw9/kfHBw06z75Pw6nKIRPU1juuV5ZpBco7tXFLqpezy9xIUzeFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l52++faI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l52++faI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79231F000FF;
	Tue, 15 Sep 2026 12:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473714;
	bh=yaVzdP8lM5NkwsIfqLJMk1LB9QIq/dT8qJrlL2t7nR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l52++faImdy1ik2llOoUzxFM8W+OJ2XgjjuOa2l8s+lX7brqaeHpAYmZ4NzMpai4G
	 ug3NGNC5p0QWw1N5SrcuH1JNzc0OyB6fZWD/NF1d6szX9grpxtdkUDi4tpXooy6x+p
	 JBH3hHZryEmAGb6mrRF6PVK9CJEilmARd5Me/4O9iSahRnJEixJ4iyWa0Fy2QMNHa/
	 679PRfPUgFWQNItfWZewH2Q2HBpXsprj9rAD8pmB/m3WtcE/OlAB27TA7JatQQXEIi
	 yV560hB9vQUixGJJc7XE9I7TKlEm3Q7gGxUx/GBKXr8HLMxp8z5pfujIabo5IiT+sh
	 wkx7+O51PlMkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 24/50] file: make FD_ADD() a standalone
 immediate install
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-arm-msm@vger.kernel.org, linux-um@lists.infradead.org, "Jens
 Axboe" <axboe@kernel.dk>, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxl?=
 =?utf-8?b?KQ==?= <brauner@kernel.org>, dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, sparclinux@vger.kernel.org, "Jann Horn" <jannh@google.com>, "Jan
 Kara" <jack@suse.cz>, "Ingo Molnar" <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-hyperv@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-csky@vger.kernel.org, io-uring@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, "David Airlie" <airlied@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Oleg Nesterov" <oleg@redhat.com>, linux-openrisc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-alpha@vger.kernel.org, linux-sh@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, virtualization@lists.linux.dev, kexec@lists.infradead.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-24-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-24-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:01:52 +0000
Message-Id: <20260915120152.C79231F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

> FD_ADD() was built on FD_PREPARE() + fd_publish(). Give it its own small
> macro that allocates the descriptor so it stays an immediate one-shot
> for the hot descriptor-is-the-result paths (open, socket, accept, memfd
> etc.).
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D24

