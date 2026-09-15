Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4E13B442B;
	Tue, 15 Sep 2026 12:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473657; cv=none; b=RnIijoutlKG3raiVWP1lo6FXg74iXJ4PxL1LF0yizgRX6xWEumAECrgx7GfUtCwlAnCUgrYPu65JoefWDE39oLJ1ixnFLPvavE56hKgs0ZCRzkPB+yyNkRTzqZjzbhZxkjSkNJaWyaU0Hc2QyOyCYqvhhvelNBAjbHFNZ+jswj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473657; c=relaxed/simple;
	bh=MldQSLt+lfDM6akgn8f71Sps4Op9V02KPlLk0XcZRhc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W3fXaogXEnx6PD3UNWRN/9j7EbehOhzLNJuc9ereXiTti9p7vDHLoOtb9DjNJTJ1bbhmAIRlYM57U6kRKHZhG3358JaUiOM/9cJdhApU4ho9tt4Redl9mwJ8hGvKANon2Re7aPoWli/PkEcHYR69IVA3HxS+kfJ2W6VUFz0mcwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYtZVg6I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYtZVg6I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE4C1F000FF;
	Tue, 15 Sep 2026 12:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473656;
	bh=MldQSLt+lfDM6akgn8f71Sps4Op9V02KPlLk0XcZRhc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TYtZVg6I4Bh2MSIVyOp4GLsBjyldHMWNSOFvEULmB/p14azRXWqSnww77YB7+TPqN
	 ScvufVzu/TJTXHoXtbu6nkMmHWq4H4dMpP1MqQSi0Nmrto4rdEsiZifxC0Gp3ctWOs
	 gVm0pQG3DVlsqt2P+zJAnwEEyISNTbCWqNK7nqDQbAM5w/PqbddR2Jr7q9aHUm+QFp
	 3CM71ghQDVb22etuVzHNdfC2YmQHMxeMwBg3BFoQVgyoGYCR1SeIZz2CuWCHLj4qhZ
	 TcgsJSPylBVRit7lOZeS75JIgRGNA5o89jEC9Doqt4/emxXQvDifGb95FahnRJnIlz
	 1NumvA/sq5Uew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 23/50] file: open-code receive_fd()'s immediate
 install
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-sh@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-openrisc@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-hyperv@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jens Axboe" <axboe@kernel.dk>, linuxppc-dev@lists.ozlabs.org, linux-hexagon@vger.kernel.org, sparclinux@vger.kernel.org, kexec@lists.infradead.org, linux-gpio@vger.kernel.org, kvm@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Eugenio
 Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Jann Horn" <jannh@google.com>, linux-mm@kvack.org, "Oleg
 Nesterov" <oleg@redhat.com>, linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org, io-uring@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, bpf@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-23-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-23-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:00:53 +0000
Message-Id: <20260915120054.5AE4C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

> receive_fd() cannot defer to syscall exit as SECCOMP_IOCTL_NOTIF_ADDFD
> installs into the target task and hands the number to the supervisor
> and IORING_OP_FIXED_FD_INSTALL runs from an io_uring op. Open-code the
> get_unused_fd_flags() + fd_install() it did through FD_PREPARE().
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D23

