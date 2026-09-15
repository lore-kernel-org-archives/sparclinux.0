Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667E44A5C33;
	Tue, 15 Sep 2026 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474550; cv=none; b=AlIISyd3mPu1MozqA9Qv9umFW0xxUQ2Z3ahOEKaowQt0EEmV5d3szmDTc5poFsp66A6PV8h+T7rKbPGDMauAyXVmlr2NJf9LUu9t1eIAoxiaHHVMA/UgJVIjQvK/CSN4VdfdO+QlJmb9Stml/NFu5PbgMtdgE+m1JgwH62SpI/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474550; c=relaxed/simple;
	bh=xCl8jNs77PZZdSIvmzClNS4N5YJKQYnamGutVTepnCk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jovCp5g6ir/3zmeLVsMYgU5LHaEG8ZThWwGPsSr3KJfHNMf9W08E0dwe4tg6vOPU3WzQ1lw5PiczBYhJyKrLmQOGwFrjdsLywDoueXN1fwepw+OWk5rRVRajxbSIJvjVNJ1na3zDCcRhVcOfayhf9fSiR0frbkHduRk1lCmXk94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngAb15T/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngAb15T/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D50C1F00893;
	Tue, 15 Sep 2026 12:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474549;
	bh=xCl8jNs77PZZdSIvmzClNS4N5YJKQYnamGutVTepnCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ngAb15T/yAkTwE1+YE6SOVKj8Rli4aHVUkDtOhNqgXnslknQomnBjXDhGUUHHgw5c
	 t1KNN6ZH3zr5Gtf1iBmlLvi1+EedRg6qAtTNkQ7kQMdZyxrotp61A/kxMP1IsoWP3Q
	 0HPEwAzkXmBRniukPUCUyctzd9pxcukzIZA+ewzHxw/boCKe1Jar8qJFg1/aKtu5I/
	 dpLp1T084yx8feJuPVTuB36srOvPtJerVeDd4qv1zFiywDAW7LoZnflX7kr4TjuMev
	 HM37MdMxXfwNOlWakuuKYP5RXCJcKz7vv76rj0gWBeGPIn4OJc58aAB53O2zHvFgkb
	 1XTJ0zBTt12SA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 40/50] KVM: stop putting descriptors back on
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-alpha@vger.kernel.org, bpf@vger.kernel.org, kexec@lists.infradead.org, dri-devel@lists.freedesktop.org, "David
 Airlie" <airlied@redhat.com>, "Ingo Molnar" <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-hyperv@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, "Peter Zijlstra" <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-m68k@lists.linux-m68k.org, "Jann Horn" <jannh@google.com>, "Oleg
 Nesterov" <oleg@redhat.com>, linux-openrisc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, kvm@vger.kernel.org, "Jan Kara" <jack@suse.cz>, io-uring@vger.kernel.org, linux-arm-msm@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-fsdevel@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org, virtualization@lists.linux.dev, linux-mips@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-40-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-40-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:15:47 +0000
Message-Id: <20260915121547.9D50C1F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D40

