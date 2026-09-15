Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97D241A504;
	Tue, 15 Sep 2026 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473141; cv=none; b=CuBLtBF5VCBK4zscqB0FmHq/4PMqZYPBS2xjPzqReJ/ogiqdpIwwLYEWIsviDz7rUAuaTlQzjNnMQ4PLlOR6bXt7lghY/cbO2hOT8k1tj/MVYgkOZ3QQVYOq8P93OwM2T0sk6fSIR87aO2nAhmolCDb8f+JgCHl0GEf21G3nHOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473141; c=relaxed/simple;
	bh=ekDoF5aUkaIqLM1AvgKs+prcUXxdZryD2GdHfQi8iAA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SFy9DQbhI8cLINzzSCbtKGDENwPKJVzVPAu6JkfqvuTzgNYtUSuKuLlkOuHn0gp8Sq0tlceMgHFzmeAx7Z8L6c87+9ZwfiMfp7zRHtIHj49vz3Xhhk7BPDc0td2IruAZeMF206gLwnZ89KpIZgCaqffU2QmpWFROlwvm3iAfOWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gD24zazr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gD24zazr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F289F1F000FF;
	Tue, 15 Sep 2026 11:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473139;
	bh=ekDoF5aUkaIqLM1AvgKs+prcUXxdZryD2GdHfQi8iAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gD24zazrk8TigMiCd5ASn+dm6txgjVpHa5zvxMTtUFRuPgLF3PTUXkAm0k3tzbTVQ
	 kW4KsfY0HBGQif9CYx1pshd5pTSxWeoqAtmTVWdPBVqC5Vn35qXuEvnFfVWf0GTUKh
	 RUU6SoJAkl5L0Kq8QF9Rmz6Bec1Ua+EO9EvYsJxPA1pHKVceE0vbNalGCUnepaasCe
	 DK9cR0VwmXUnDDchOmLvDyG+u5nXi3gO659qnVPIeiexcntK9tyLliM401L/8g63N3
	 plW5ukJMt7+DcxaIYWdMgQ+GjvsoPq80PE5u4Yrt6L+3cW6+83I52c5iJrh0Haefuc
	 0OjHhKSvx0zPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 02/50] entry: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-csky@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-hyperv@vger.kernel.org, "Oleg Nesterov" <oleg@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>, linux-mm@kvack.org, linux-gpio@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, linux-m68k@lists.linux-m68k.org, kexec@lists.infradead.org, "Jan
 Kara" <jack@suse.cz>, io-uring@vger.kernel.org, sparclinux@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, kvm@vger.kernel.org, linux-alpha@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-snps-arc@lists.infradead.org, "Jens
 Axboe" <axboe@kernel.dk>, "Ingo Molnar" <mingo@redhat.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-2-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-2-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:52:17 +0000
Message-Id: <20260915115217.F289F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

> Reserving a descriptor with fd_prepare() marks the task with
> SYSCALL_WORK_FD_SLOTS. The syscall exit path already tests the
> syscall work bits so a syscall that deferred nothing pays nothing new
> and one that did takes the slow path. syscall_exit_work() commits the
> reservations before audit and ptrace.
>=20
> Architectures without the generic entry code grow TIF_FD_SLOTS bit in
> their syscall exit work in the following patches.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D2

