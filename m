Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A9948A8DB;
	Tue, 15 Sep 2026 12:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474147; cv=none; b=GpTxuAZWGVtxP09bkjlORc0Ki2AnZXQFfGjWYtnpffrdco6FKAMo8kwSP8b4MAaOzyOeqWaKgdhlaoZiQ9qmGsGiKeoIVtIHyIZGy5Capb1Ry4d7RWcgALIXv6VIOgy8UUNpf9RVzVaXsOvEb0UncrSjVOh1zgFHYWTSxWrXpe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474147; c=relaxed/simple;
	bh=1io9HoRsGAc1uikZZU6WOsyCYXG2ohuKM/nD/zRqcpk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hCjSbTlY9go5GXMkvUzFY85IpHSVbV6dX/DWMFLzVEEprtk8B9fLcUYPO5cfZ3ietEgIR4d/bQ/n4jtTS+aSwpsbeCOEy8XXi0gMTbEJ3T5kBElAlklOEhy6o7h1D+42arbqGQJkBHt47RGxi9C0nX1/cIpbltJ5hKt4r1yVNJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8RCCHlV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8RCCHlV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C511F000FF;
	Tue, 15 Sep 2026 12:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474146;
	bh=1io9HoRsGAc1uikZZU6WOsyCYXG2ohuKM/nD/zRqcpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N8RCCHlVffAYpevobrB+HSSxJIDFQlpru+XuUbTtHjJ+eV1oIVuSwd7MGNhXxoQvE
	 0qXqjr2rait3fVxBCZ9NQmO10kK0KaPG6zwH9T5vPB8yCS66JjHDMs4as+k8T2Fk4v
	 e4FlPeCJiND/Nr5uQ9QzHHTvsCip6NFVrnbNCMKMQ1YJSo+H5BqiKdvJCfjdetXK15
	 IA8lwnZJYwWVEQfsXuIfAhEX4i1LbTqySG8jJzvB5s5qUpYo7CHSb+i+lKJf2KL3TS
	 6U9uLcqyT7Zv3ZiC4C+YKYpQCQ/wJlBcsNSQOQuLTJt3AVMsq3rQldu3icesMHZkog
	 thX6VB3gqrvHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 30/50] drm/vmwgfx: install the out-fence
 descriptor when the ioctl returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Eugenio Perez" <eperezma@redhat.com>, dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-m68k@lists.linux-m68k.org, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-hexagon@vger.kernel.org, linux-arm-msm@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-alpha@vger.kernel.org, linux-gpio@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Oleg Nesterov" <oleg@redhat.com>, linux-snps-arc@lists.infradead.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, "David
 Airlie" <airlied@redhat.com>, "Jens Axboe" <axboe@kernel.dk>, linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, virtualization@lists.linux.dev, linux-csky@vger.kernel.org, io-uring@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, linux-sh@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-30-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-30-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:09:04 +0000
Message-Id: <20260915120904.95C511F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D30

