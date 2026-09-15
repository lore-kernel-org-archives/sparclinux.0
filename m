Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FC34A5C2F;
	Tue, 15 Sep 2026 12:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474483; cv=none; b=UCUkM2gpVfTLyz0eQ1AvxwuUPz3JkXiFoQOLxm4v9IuwcqlGsGd9/c8BOZoDAQcRq3Mh4LsF0w1P4eCqISsgEZjgjbR/ARYkET0jMraEDQrFu6Jw5MZX3YYfAQRH/+8lcHH4tlZVOb2t3dpK4gZYIaoekSTg5PiUpbe+I3ADhCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474483; c=relaxed/simple;
	bh=sF9YfaIJizyBPu4rwmr1ugFHciRiaj3rpWpmWnplm2o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ARexZI1/kUWgy3Rxjxlwe7JN5gAXjP5I54XtThl5stnl+PWNeVRemFt9F4U2mbRuD/F5eXF/gw2aGCEgVx80wyG8Snzw7YsZ0gb7nUzaIv3mCk+4Ya6TChv8lC65+2g/a84vWGu9rdVLjzVw+s0z2yz7daI8g0oyuou6gP1789M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0i1edZo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0i1edZo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908681F00893;
	Tue, 15 Sep 2026 12:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474482;
	bh=sF9YfaIJizyBPu4rwmr1ugFHciRiaj3rpWpmWnplm2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o0i1edZoSZwfTDuavjm0jvg5VQXWhP0dWUGKIGTr8VBvqx0/C7n4xowvx9OTeZtCR
	 qz/PxHeE5NmuntDwErr/shj/5CjD5MPN3WutZ8jsJiT4+HZ7bYopL8U2z/U+F471Uc
	 sa15k+HBxjI1ws8oZIZWAKZYm3G/E31Ge9otNWzoXAUQ+Ib0yP/MS1/m8rv3aFEZmu
	 VV2JzWkAUzQkLxzgSbSwLB7ttoPZ88S25QNgaYCRv63tBmcFXoL6Vo+uFNON8iAfJn
	 gV8IlZbIRL7RHxvrFsH/t67nJiWg9k/SjrxxaMsoIiK6BszJu6OO6xdUylYjAEyJcP
	 HyYV4oBdSfuLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 43/50] drm/amdgpu: stop unwinding the fence
 descriptor by hand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, "Jens Axboe" <axboe@kernel.dk>, dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, "David
 Airlie" <airlied@redhat.com>, linux-arm-msm@vger.kernel.org, linux-csky@vger.kernel.org, linux-gpio@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-alpha@vger.kernel.org, "Jan Kara" <jack@suse.cz>, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, io-uring@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, kexec@lists.infradead.org, "Ingo
 Molnar" <mingo@redhat.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, sparclinux@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, "Oleg
 Nesterov" <oleg@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-hyperv@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-43-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-43-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:14:40 +0000
Message-Id: <20260915121440.908681F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D43

