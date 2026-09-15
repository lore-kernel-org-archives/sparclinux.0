Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E1F48E0F5;
	Tue, 15 Sep 2026 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474284; cv=none; b=ju1FwFWYQQ/c2q/3XhlbeNYK5xMbM+ss+DrU9FGEkKJZasJin/Zqaf9pIAK82D0dP0wbGjRLaQvhNLkNpV87Fa/kGQ1ILKNeqAFcfn5vD5XHMW7ol35EfiDvr4NcsKFkLHKimixdbhm6RZojIAt8Hl095nYrW6rh8lTU/+rwdUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474284; c=relaxed/simple;
	bh=pymhjA3IHUvfc7ZhMmvcj6PWvzmH+JOQJc7von1cOC0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MSDDg2w/PnByx6K7Ptco/5r+aHl+lYes98kh+y+aB4omd1SAW/nmQvv5c8OrlEUt0N9N3SorFe2H8gkb9gtSSUjYoYabMHaUa6wbWAJz2nAJdbGG0hEf9pUjUAUaF5fKiDNDEO/PN9sqmuNfvzfQJn8JDpurA5JQYHGVBtnzFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JM7MUu1K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JM7MUu1K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DCB1F000FF;
	Tue, 15 Sep 2026 12:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474283;
	bh=pymhjA3IHUvfc7ZhMmvcj6PWvzmH+JOQJc7von1cOC0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JM7MUu1K3sK0BfbZuufGSUMTjcYng5dpse/wo3EWLf21O2gUgw322DSgVB01AFTtW
	 t52UvxD3bLuUqeuFrp1OK6t6wHAM7ouPbrca6pE9eJrANghgkKMIS9n0Gf/wy0wloB
	 LbU8P8uOHsEx8fNW9Woaznh5JHxhxpBoxXgSLs2p/Y+nXpZgm4aiuBP11/FKE+6Agh
	 dOG9FMxrGVQ/eMMAs/LGH2WwzJPb1jSL8PT90CSvhiLFlxbJWRZR7M9jUUHoxVSb0a
	 49DnQM0TYsO0aM6hSLHh3aoQiYMzGZw+8DgpMeFwYhEfOeLW9W3pCge4KeYSBScMZG
	 GXoCvsjJhnAaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 21/50] io_uring: commit fds per request
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Jens Axboe" <axboe@kernel.dk>, linux-m68k@lists.linux-m68k.org, linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Oleg
 Nesterov" <oleg@redhat.com>, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRh?=
 =?utf-8?b?YmxlKQ==?= <brauner@kernel.org>, sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org, io-uring@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-mm@kvack.org, "Alexander Viro" <viro@zeniv.linux.org.uk>, linux-sh@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-snps-arc@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, linux-mips@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-hyperv@vger.kernel.org, linux-hexagon@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-openrisc@vger.kernel.org, "Eugenio Perez" <eperezma@redhat.com>, kexec@lists.infradead.org, linux-csky@vger.kernel.org, virtualization@lists.linux.dev
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-21-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-21-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:11:20 +0000
Message-Id: <20260915121121.62DCB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

> io_uring requests don't complete on syscall exit of the task that
> submitted them. They complete:
>=20
> - inline from io_uring_enter()
> - from task_work on any return to userspace
> - from io-wq workers and from the SQPOLL thread
>=20
> The CQEs are visible to other threads before any syscall returns. So
> commit the reserved descriptors before the completion is posted. Commit
> them after ->issue() based on the request's result and before every CQE
> they post.
>=20
> Nothing reachable from io_uring reserves yet. Once SCM_RIGHTS is
> converted this keeps IORING_OP_RECVMSG working from io-wq workers and
> the SQPOLL thread.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D21

