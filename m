Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D84B5123;
	Tue, 15 Sep 2026 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473930; cv=none; b=FESXdIyAbw9VDt93daGkHiRx+LCZT6NNds26kvcjewrEnS3RZatC01/vF5RRAYktWcM2Twsn/ZZkAiaDDd3FihQDSFsTqlibxzTD3Wl76pfJlmcOQKGOD4/fOTA1iskTR65vQ+W5MrdkfK0hoSDU+e674Lum0kCsxGbPppL1kAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473930; c=relaxed/simple;
	bh=6NXKxiOzguyQnoEQO9LxNWTE3iRxMjdJkj6A9mUtc1A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gg2r7u9xQNgbKdkgXO0+i+Q4gdNqpgdJl0OmhshrAO2mp8qlFG7Z9nJgp6mR0p8Jp1umz4KawF5e81gqO0FeLmDUU/gWWreCPQqYZPIJ8sRcaX1SNNJUAb/CaJzqecJVtSZIgzhITZnNDsmb/6//Q2zK5RxUE5lDI+pasCscQkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDJd/hPe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDJd/hPe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A631F00893;
	Tue, 15 Sep 2026 12:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473929;
	bh=6NXKxiOzguyQnoEQO9LxNWTE3iRxMjdJkj6A9mUtc1A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FDJd/hPeWG0FQGFbVQjHL1xaPx+T4d5yH5y0Mqbs4pp43o2C3upF/W55cT90yNZY4
	 v0CafCNhn1kfUl9h7/L0G5/2wNT5neqTqXK1mtIHm20rdFzMa6a0JXvgrTKQDa2K0W
	 EpyGSa4pPf3XBWtOTiJWh7acs1xFeKBBUrITujioesXQ0DN26+ocUVIuUJXjh9lEiD
	 QW0DJtvJfkNM/dUEI+lhs0qoSh0U77pi23KqFNoxn/b6iLktEYEx4XGqLkDOAMdead
	 IPztuAKWtncrXXjrtf8THfsOVlqs6SliB8QXWO1MitwNOfsiyqey3a0R1jD39UUoJy
	 wXnPZLwUqx0VQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 26/50] dma-buf: stop unwinding sync file
 descriptors by hand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Oleg Nesterov" <oleg@redhat.com>, linux-hexagon@vger.kernel.org, virtualization@lists.linux.dev, bpf@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-csky@vger.kernel.org, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, dri-devel@lists.freedesktop.org, "Jan
 Kara" <jack@suse.cz>, "Eugenio Perez" <eperezma@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-alpha@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-um@lists.infradead.org, "David Airlie" <airlied@redhat.com>, linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-openrisc@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Jann
 Horn" <jannh@google.com>, linux-arm-msm@vger.kernel.org, "Peter Zijlstra" <peterz@infradead.org>, kexec@lists.infradead.org, io-uring@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-26-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-26-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:05:27 +0000
Message-Id: <20260915120527.97A631F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

> Rely on the fd exit path machinery.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D26

