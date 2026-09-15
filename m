Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1220D4CC604;
	Tue, 15 Sep 2026 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473447; cv=none; b=tx7WXRM33FrEGEuMDKHAELnzL2PUb2dsO1BAH3EKkUrgMMDiB1js0qY60IEAN7XET7calg+n2BY6TyL+eqtGNrrbbtaxP/QMoYafC8rCeIJoRWkmwKNyaIu+uTnmbnk7D8wijNlJ3XUmHwo0DmtXCOwMCJockVxb6vJtYdQm3fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473447; c=relaxed/simple;
	bh=foNXNPfm0YOXYb4+jKYd4+lAF9aF6NFtBcoJMDQD3PE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DuIGnzWNnFjdZRq9GNmI8ezKvPnwib1AVVTiFaQee1z7w33FLDUi6wb5+2Vn6fxCxPeuXKfjhdNth1agOYD10zMu1Ept0e9KbYbxD2LxsI9jB6bUNbtesWxcku8qjW1qRJUwvSkCiVZPJIoD+KXAH9avguhPpIcZW6NJOKzAXbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtnl/09N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtnl/09N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2291F000FF;
	Tue, 15 Sep 2026 11:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473445;
	bh=foNXNPfm0YOXYb4+jKYd4+lAF9aF6NFtBcoJMDQD3PE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vtnl/09NTEmqyW1tNPT+8T8JuOyDJguLBv2ERQfv5mV8sUbXuBe9nfRUxjy6D04/B
	 Hcm4AIGNtGqTcc2GGlKlSglke2u/FXcZ76lL25z2/NeeHWPcqygtSbbzmeVVztVUgW
	 hoS+iCHyLKT95UZw6JB3PNuoK4/zapEViq1/QVJmftEtEMsjVlV/1Wdd/5mzRfse5N
	 Hf4nzWabASK5Nn3pr5jvJ/Gt8VwGXr0IJhqiu3SrFCMh0A7gLPSMGtW3IAoUbAv4fC
	 i4vkJOaZ592ko8M1p7dcC3BjyfLFGQY4bZoyHYD9fIuFfPgwESBHAG9TF4alz32jll
	 rFcSGLJmW5YeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 16/50] sparc: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-csky@vger.kernel.org, linux-snps-arc@lists.infradead.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jens Axboe" <axboe@kernel.dk>, io-uring@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "Ingo Molnar" <mingo@redhat.com>, virtualization@lists.linux.dev, linux-parisc@vger.kernel.org, linux-um@lists.infradead.org, "David
 Airlie" <airlied@redhat.com>, linux-alpha@vger.kernel.org, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Oleg
 Nesterov" <oleg@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-hexagon@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Michael
 S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-openrisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, "Peter
 Zijlstra" <peterz@infradead.org>, kexec@lists.infradead.org, sparclinux@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-16-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-16-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:57:23 +0000
Message-Id: <20260915115724.2A2291F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

> Add TIF_FD_SLOTS and test it together with the other syscall exit
> work on the way out of a system call. A task that reserved
> descriptors calls syscall_trace() on sparc32 and syscall_trace_leave()
> on sparc64.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D16

