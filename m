Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E50D4C4F47;
	Tue, 15 Sep 2026 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473252; cv=none; b=DZ/5v7NROS63ybxQRP/qCsqHVilLnZrunkAJT9xHpm0PYOtD8Gj11ijr9xIt/JItDDb/6KM0IHXXErugozMbB0n8PobpzeO30VP/LyPyp4fc7Omn9IfZkdvA71nSu2J0N/PBsXbLD8/9Kz2Qi9q7DrQhxgrlrDwE2PLlTziXETU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473252; c=relaxed/simple;
	bh=rEaooNHHSzMvHYDvwYrru6UOPRcxabqKjG95OLRLlN8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uEhisrO7ln0sQL0eXUSqbmDoIK7dHRWKiFBUbHxI3MaTHR8CA82tj/5EXHNEe1qlpbG0T069esc5KWbNbGoSmip4Lc3hksMQIxf1u61bRKrxM9UsODL1pQ1yfJkQ/7PFHldqB+WWjBbrY/92oDe0frpDhwqpXs4Ev46jui/A/w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEjnjHjN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEjnjHjN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8371F000FF;
	Tue, 15 Sep 2026 11:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473249;
	bh=rEaooNHHSzMvHYDvwYrru6UOPRcxabqKjG95OLRLlN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dEjnjHjNvNIuSaPYTHfj4KVcRdWnf0KMr5ngwYgP13UVEN4ixsOjP/LGTY00a1F7i
	 SrECUFxW1WISw+Sb9e943yH6GxglJXZz6/98X328DvWbvebyYY0VweNP2I8cG1QByw
	 Gji9eMFm2AAVp7PkwCHxT4RdIR9rAmD6kZzVeYGbasnMh8yVep7bz3ac2gDe5wmKNa
	 E60wDWY0t8sIf7wr0+2mcu/fK44J9sYDVuZZ9raSVBw8fhzXy625/hIuVibz2cM1G1
	 heryhbL45TCscgniXJxfFQxgFi5MNZtk5vPFvLwJbiB9YO/wiDhzcHs+qEgelm4u1w
	 O3GQp5W8DIzZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 19/50] file: require the syscall exit hook from
 every architecture
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: linux-gpio@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Oleg
 Nesterov" <oleg@redhat.com>, linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-alpha@vger.kernel.org, linux-fsdevel@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, virtualization@lists.linux.dev, linux-um@lists.infradead.org, linux-mm@kvack.org, linux-snps-arc@lists.infradead.org, "David
 Airlie" <airlied@redhat.com>, linux-arm-kernel@lists.infradead.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-csky@vger.kernel.org, linux-hyperv@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, "Jan Kara" <jack@suse.cz>, linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org, linux-hexagon@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-arm-msm@vger.kernel.org, =?utf-8?b?Q2hy?=
 =?utf-8?b?aXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, kexec@lists.infradead.org, linux-openrisc@vger.kernel.org, bpf@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Eugenio
 Perez" <eperezma@redhat.com>, io-uring@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-19-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-19-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:54:06 +0000
Message-Id: <20260915115407.5E8371F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

> Every architecture now either uses the generic entry code or provides
> TIF_FD_SLOTS. The fallback that deferred without ever committing
> can go. Make it a build error instead. A new architecture can't grow
> fd_prepare() callers without the syscall exit hook.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D19

