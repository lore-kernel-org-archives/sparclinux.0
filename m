Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1AE4A5C38;
	Tue, 15 Sep 2026 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472886; cv=none; b=YF10+n3Mz8YQEzr7+dmykMsFGbQ4utp69KEPvtS0pZWaooooehw28lMZgR77WHs+mMQxo+L4NseFlad8+h3k5jiM09EcRFFW1MmTTLsofU1qUbDQ2OY6wlq9oge2QvAHlC/8xnYQUZ+PWcTebFf9tfINl8Xg1VJqVotJV/6rsPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472886; c=relaxed/simple;
	bh=EYRIdKp/FfwNNqSNi/pBExuEJpqL4OpkJpzESq5stW8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ieYgneg8R8vsJJrtqEg89YCP/jWjS6NFLWnXr+clXnWNaeAPNcrmRG5i+SlYxAIHck9YDF0rAUIoxa2LYVF+1lWETyAVpgBU16Wm97eA0rTlhp0qGLv5KAq8J/lKkOntERho0IjqHbdyjUmGf4+H/FMaSVAFqaAtO+ka9ru0VbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEA46w/j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEA46w/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BC01F000FF;
	Tue, 15 Sep 2026 11:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472885;
	bh=EYRIdKp/FfwNNqSNi/pBExuEJpqL4OpkJpzESq5stW8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KEA46w/jL9NKEBXKdpDRVvgUVpdw6hOUBCW8wQyHI6NwDPC4Am8sCmr7j0WvoKK5v
	 Bi5VQmzbc0sNbBRMKVoi5XBwnkMmxH9tNMHqDw3ItnBUybU4feNnNWv7cT2bB8AjBd
	 dY6wMyYKrW4Ezf2ZF1yg1nT3JYwFHCkXSv5QxKi4ShZMZv5F2iT044OEtU+pEb+idW
	 Tog3ab9yFoO5+qKuA6KwBgJKAx/c448Pa5xlXvcd0f4KIxP8erzSA5JNQBA/bgLLZB
	 IGHhr6D+xE3ldAUlwnI0HynOJtRl8do+l5clEE47V/0XL01LM1u7vq8zJwzIFJqQrv
	 ilAIi+rTQ2iFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 10/50] microblaze: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, kexec@lists.infradead.org, sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org, linux-snps-arc@lists.infradead.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-openrisc@vger.kernel.org, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-arm-kernel@lists.infradead.org, "Jens
 Axboe" <axboe@kernel.dk>, "Jann Horn" <jannh@google.com>, "Ingo Molnar" <mingo@redhat.com>, "Jan
 Kara" <jack@suse.cz>, dri-devel@lists.freedesktop.org, linux-um@lists.infradead.org, virtualization@lists.linux.dev,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org, linux-gpio@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, linux-hyperv@vger.kernel.org, "Oleg Nesterov" <oleg@redhat.com>, linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-10-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-10-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:48:02 +0000
Message-Id: <20260915114803.44BC01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

> Add TIF_FD_SLOTS to the syscall work mask. The return path rereads
> the flags after the system call and calls do_syscall_trace_leave()
> for any of them which commits the reservations before audit and the
> ptrace exit stop.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D10

