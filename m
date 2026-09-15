Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3986047A882;
	Tue, 15 Sep 2026 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474175; cv=none; b=DxzJQ/7YJ5K8gdd/8JCGgqSFj5TiBhziETuvD3vl1RgQ4s8UeKLzjwaG8wqXlJDy+/zjrdaiq8OBkhBUWbRPy8M+PA3v0x8K922UczzDiXV2h7ixkkuUstDXjJyy6iaCc1QSIEsieh2faZiZxrPpEGizvqyDIP/gHAHn2bwK1y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474175; c=relaxed/simple;
	bh=UYzMflbMuPv9H/GLK1g6J9E5AwtdI+O/+Pdc0wsdGlQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iF4jy3v5WFO366tNNO62FU02GXHO0ZuUlgdwxalzEdy+AaE7tlfrOG9iTL0xF3nCNghUetBzdK4JhmAZzMVAjkCjyFy0Pcy3+YujhjTv7OSdEm1HjGx6miv7ipxjX85w4TStK+em4re/2+GvYkGIKPyMeZUnfnFwXHm9byJ9OtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jH8MeFUt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jH8MeFUt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED881F000FF;
	Tue, 15 Sep 2026 12:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474173;
	bh=UYzMflbMuPv9H/GLK1g6J9E5AwtdI+O/+Pdc0wsdGlQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jH8MeFUt+Ca90GijJLK5hVAYB41iBAVkHXhYxlgSQZsl+pyWmTzGkAYZ9RXqYBDbG
	 rKZCB6pYmFyP5M1bk4Irpshq50uz2b5QkCnTtwMupHWy+yvoXlLhHmQpzBrkPJbweM
	 DOJFaJK8kjjNY5ZP2iw190s62x+TzNavmrmqQj5YP/0STVvoLNJYJafDKfgf5ojLUP
	 LuZmhYwmQV123gJgzbNrAwrP+hPwOyQBF3mK6DppyLtpzOvR8DpMm18peMtTYKiuPd
	 RpvHgbF2jJw+E059MS7iRdmviODCKeE/Aiqyn0EbGm/VrErx286rEzup2WusNoTIC3
	 +JC3oUetgOKKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 33/50] io_uring/zcrx: install the exported
 descriptor when the request returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, kvm@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, io-uring@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-parisc@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-gpio@vger.kernel.org, "Eugenio Perez" <eperezma@redhat.com>, linux-csky@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-um@lists.infradead.org, "Jens Axboe" <axboe@kernel.dk>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kexec@lists.infradead.org, linux-arm-msm@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-mips@vger.kernel.org, "Alexander Viro" <viro@zeniv.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, "David
 Airlie" <airlied@redhat.com>, linux-snps-arc@lists.infradead.org, linux-alpha@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-33-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-33-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:09:31 +0000
Message-Id: <20260915120932.0ED881F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D33

