Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961784C9542;
	Tue, 15 Sep 2026 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473309; cv=none; b=SL3tP95utBAVmrLnM04Bbw39Xhf95Uoe+/A/ieiolPUgOQlqLQs29HkxS1CZxTz/T9ao5ty3gjxuvL/YNHGbeyDDg8xD3XnpE+lD44ky978rUz7LXludMKa8BKEOi50dXR1mX/L5xORevcACLa8FlR4kKxtw5PhwbRq/ug4vM9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473309; c=relaxed/simple;
	bh=HMMRMhob7IkIe9e9mAPaP9M7mjfa9q2jKMemMrIPs6c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RG7fncWcjJdnoDV1mfxktLjC+liliBmfKYkn0gtYux2r+qt09T61CJw7q++AanjojHkEqKx7LuFBruuX0Ab32Jwu9Wa9k7c8S+AxEauUi59Q6w7yjMJeTl06yix/C8S8+5mGUXGlnBC/4Z10D784/7Cgj3BY3tfYFN8T7k1ELRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsQySeqW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsQySeqW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE761F000FF;
	Tue, 15 Sep 2026 11:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473308;
	bh=HMMRMhob7IkIe9e9mAPaP9M7mjfa9q2jKMemMrIPs6c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PsQySeqWE8JCmadPFY/hnc/12dyVnuAieOOYame4n2RSKPpHPzZEwa9aNXFW6Bh0w
	 jCKKPfvbQGd4w+kjCdDB1cDWPrLj1jH+ib+NTLKYU1wTD4r5SSCiyK6Bkhm0GPcOD/
	 n8VVrYov9a2DUD0P51p6sbyyDt7TrPEsZSbloBTRZV4lFnVfvS/4uwmg4s0o9mGPwE
	 J86aQbIHSTHc2gNUMi95Os/taOUoLSS+QNmmmSrckOC7X/ql9/XqZQkG5NLta2glDR
	 Mp2J42KjxHOY8m6wiQeHzVa1+u/idZU1hpvfr6kocKyTTL+rDtt1yEldFXNOgmmj2l
	 +dfiOWdDv0iJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 17/50] um: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: io-uring@vger.kernel.org, linux-mm@kvack.org, "Ingo Molnar" <mingo@redhat.com>, linux-hexagon@vger.kernel.org, virtualization@lists.linux.dev, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-fsdevel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-snps-arc@lists.infradead.org, linux-m68k@lists.linux-m68k.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-um@lists.infradead.org, linux-hyperv@vger.kernel.org, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, "Eugenio Perez" <eperezma@redhat.com>,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Oleg
 Nesterov" <oleg@redhat.com>, linux-csky@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-alpha@vger.kernel.org, linux-sh@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, kvm@vger.kernel.org, bpf@vger.kernel.org, sparclinux@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, "David Airlie" <airlied@redhat.com>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-17-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-17-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:55:06 +0000
Message-Id: <20260915115506.6CE761F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

> Add TIF_FD_SLOTS. handle_syscall() calls syscall_trace_leave() after
> every system call, so test the flag there and commit the reservations
> before audit and the ptrace exit stop.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D17

