Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257C74A49B1;
	Tue, 15 Sep 2026 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474666; cv=none; b=jl3MelEQo/UdbUGApBbSdSTFc7y0rXK8InaN0dFuAEWIV7IJWZsn0K6Xqa+ncCkFP5econeWiMTCJdDqaLIqP1pgshc5WIdch6mEi0ar+AUjbIqQqW8mMQtQTkO1j43878vEa+e4xVGEIYKm5uzy+bAHLlydhmLOHeKOmLMD8qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474666; c=relaxed/simple;
	bh=DwzX8JNIUuVMxDXzFkUeKbOg0dKKxVjarPGggP7ls3E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cM3uJ90peJ/B3yCInodSRifu2mpA0QoA83vkJeQxTg3htJ8JRRbenCQgoRSP/CTPxbHzR0wCRFrm+8CXbRmjZdDgSV70AxF8LLyitPJ3eaBYEIAPmV/gDW7uN+kUq8R1/Xa6UXGCVLksz1elbz3s8oz9jv3CYZZpcgMi9Ypp3gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+YTN+mc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+YTN+mc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00241F00898;
	Tue, 15 Sep 2026 12:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474664;
	bh=DwzX8JNIUuVMxDXzFkUeKbOg0dKKxVjarPGggP7ls3E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T+YTN+mc0FREo7pxVue32qEB7jpbaic9tPuOqusrLGz+h61wQ9mk1jbsp4T4uum+o
	 PyFcrywxhBL6lkrZRNcnpslokzefZeAzR3ILqmBsMGWMqYv8jIXs9vvVcxYbK2/0GC
	 eaxftvggM2rbYvLpD33hv5D2hCTVmB4HxTZAux7lFOj7n37ELzTfsQdzy7w4+7zax2
	 OOhtkPuMszdn+0PFv34fTrYHBBJ5CYYMe8NNjn6CDmjHaFQhZDHc4EM+U9KZ+/UGbq
	 UKCjWQKVffzLeaWI/mu8BEh57NXEGpdr4xo0iEchfSB7vEOpEOZ5gcwVOziN4Vzm0b
	 J0urwnVYa8Mjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 42/50] drm: stop unwinding descriptors by hand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: sparclinux@vger.kernel.org, linux-openrisc@vger.kernel.org, "Ingo Molnar" <mingo@redhat.com>, linux-csky@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-hexagon@vger.kernel.org, linux-arm-msm@vger.kernel.org, bpf@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-mips@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-alpha@vger.kernel.org, kexec@lists.infradead.org, kvm@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-sh@vger.kernel.org, linux-um@lists.infradead.org, "Jann
 Horn" <jannh@google.com>, linux-m68k@lists.linux-m68k.org, "Alexander Viro" <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, "David
 Airlie" <airlied@redhat.com>, linux-hyperv@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, io-uring@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, "Oleg
 Nesterov" <oleg@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, linux-parisc@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-42-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-42-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:17:42 +0000
Message-Id: <20260915121742.F00241F00898@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D42

