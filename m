Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C78B47F791;
	Tue, 15 Sep 2026 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473027; cv=none; b=pfv2/9WLEUEV9fgRmowmWukGSlTVUX1WEVrx5KjXNPlIwX7eRqrsYxxEFIcfKWXO/Wpn7cVcUMdqY/83XLRkxJAQ5iybNNhYWVBf9mM6yE9zed4CCVmJb1aNnee5f/h05sU+QH1Bs/ucd26chGVmubsBeLC8N66cDjiIZCDAtTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473027; c=relaxed/simple;
	bh=+t+FFRs/FSCskcUDJ5SBPkwP/MmkDDT89W6QZ8CQfY0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BI5Agie8L4yyWrYRzIYZGcYBvxMIadeVLRutpkkUT9+nLzoyZYFYYona2UQ52j5ywjXqRCDq/edk8GdNbz15KZgt5S/HRw297FjYU/bKDccp4uRc49/oU7oP4gd9Unu4qz+k5F5hrMexjVStSfSdzbf9mjpcxm11GbgwgdppdeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K53ZeQCF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K53ZeQCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7B31F000FF;
	Tue, 15 Sep 2026 11:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473025;
	bh=+t+FFRs/FSCskcUDJ5SBPkwP/MmkDDT89W6QZ8CQfY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K53ZeQCFgiRlmkmUKqyt03ueVesYZEQr8ZHRmEnHJr7bteBPMY+FhF3KYLtuCparh
	 nKgFz0/6jbq1bui4jC+jYX4ySwDgwyBFWSGcoZrPkCnnSxGxTvfC6BSUPgQq6hQvNN
	 +1Spfhekga2XDw3G/J02TP4WSUtA8F4az2wYUgLljPdaWE7BVEbc0aUoQxQBuF0+j7
	 SIyPhVaxFVjk05zS3THf3p+jtDoLWiEkH1QK9B2j4QqMORMMx/IRGI5cyQTCspKNmd
	 5UGZ+jgOkWGk3ahuQaW3stL2pre2KPKFH28rNWpoqvzsKrFKXAxDwAFKyj9oMjB17X
	 ecSlXehy4baoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 03/50] alpha: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, "Jens Axboe" <axboe@kernel.dk>, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, kvm@vger.kernel.org, sparclinux@vger.kernel.org, linux-hyperv@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, linux-mm@kvack.org, bpf@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-csky@vger.kernel.org, "Oleg Nesterov" <oleg@redhat.com>, linux-snps-arc@lists.infradead.org, linux-m68k@lists.linux-m68k.org, dri-devel@lists.freedesktop.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-sh@vger.kernel.org, =?utf-8?b?Q2hy?=
 =?utf-8?b?aXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, io-uring@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Jann
 Horn" <jannh@google.com>, virtualization@lists.linux.dev, linux-alpha@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-3-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-3-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:50:23 +0000
Message-Id: <20260915115023.DF7B31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

> Add TIF_FD_SLOTS and test it once the untraced system call has stored
> its result. A task that reserved descriptors calls syscall_trace_leave()
> and joins ret_from_sys_call with the flag gone.
>=20
> We mirror the traced error path where the switch stack is set up and the
> return address and the syscall restart state are placed in callee-saved
> registers.
>=20
> Btw, let's remove alpha... It's a pain.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D3

