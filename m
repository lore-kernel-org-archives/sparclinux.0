Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7003F4DD0;
	Tue, 15 Sep 2026 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474785; cv=none; b=rF9IewVy4xK/vW6uhnfMYVLnD7u/bxPnZSfqmgl+feEXAXZ5R/zf1GtoOH0tgVKhZ7OcBToaZs7/KPtkp9dF8rubw2XqHc6dRcvzOac86u6tw8nVAYb6TrV81yX6Z7a/1uB5ciB4cMMFCIPDsNDWjCOF9inC30+6M6dsHNeBG4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474785; c=relaxed/simple;
	bh=s+9PDH0CZ1Vr08YyoCof+UTThGpQ93yPbrI7mSCf5jg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iQIxf9fQlkJFpe+Ma3j8t46I+hnWQ4sPU3Cyt/SMR86iQ5kMUSENOrLe2TEgBSDADPq9VkfHhNM030irCqWJD8VYRXDW64HsKk/HnPrOJoiSFbynFDhHqB7dPR+H9nO/kKO/y5Xpn8de0pdNalizy2G6UEPWuC6XDMXT6kg29oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0z6lytA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0z6lytA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B431F00893;
	Tue, 15 Sep 2026 12:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474784;
	bh=s+9PDH0CZ1Vr08YyoCof+UTThGpQ93yPbrI7mSCf5jg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m0z6lytA0Lb7PeCTJJ9wan77NmP+WaqiiLFqlwKeXKPuaHqeXDGZgjSEE5Nqy5ZTD
	 uXplubyhODu8Q/NNq14/kXJbT/9AFQwToWT9BIY9E7L4zCHdhq4qOYWiAgbLHBLAxF
	 XtT+b1kvKyB39r1HyAihRAZd/uoRrMfxf0YZCrLmFzS7pKcK/CRl1fiGl+0H5LKWhV
	 PlUaIzcMF+cm9TI4V6HSienMOrDlPf4JHELixv0sjOAXsqO+TJlLMDqNaOXk1sfBNv
	 cjEFW+zAMBlSevojGz84ZSkbXhlbmUkgsft9l8Pqsgamb08/hqshJfCjYTrtd+Gp+Z
	 XZIjfnkZC6SUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 50/50] Drivers: hv: mshv: stop putting
 descriptors back on failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-hexagon@vger.kernel.org, sparclinux@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, virtualization@lists.linux.dev, "Peter Zijlstra" <peterz@infradead.org>, kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, kvm@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-fsdevel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-sh@vger.kernel.org, linux-mips@vger.kernel.org, linux-arm-msm@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, "Oleg Nesterov" <oleg@redhat.com>, linux-csky@vger.kernel.org, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-m68k@lists.linux-m68k.org, "Jens
 Axboe" <axboe@kernel.dk>, dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-um@lists.infradead.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-mm@kvack.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-50-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-50-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:19:41 +0000
Message-Id: <20260915121942.11B431F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D50

