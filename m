Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F44A6CDD;
	Tue, 15 Sep 2026 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474491; cv=none; b=sQ77/tkPQyWaQx66hqCpqsz3IYq8LAboD12dLsflR3YB30tFCvzDfIMndI/9aVV0/4Nedks/A1hoWcq0QnbLUnt7ZdX7D/QI2xE/Zugqd2ZFK26wA2ixxMzywQUCY5odAdwSZuVtekvKl6lagH8hb860X5AoS4VHFLSsweDz7ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474491; c=relaxed/simple;
	bh=TgpDOnocVQOLMc3/AlRq1UjktGK6C7Gyd90Kux4DYfA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FYJqjZofMY+kYZqyFXXkfFKWGMvpGiOly+gG4FtlUpHuXB5yMgrKOIeg5ejRVrirR/zV/wQK9XMUpzoBDmJBnOE2/YNcdZjzi9Z7gUI3Q6czxWSDvX4Uctd3s9dzt+Bdb1gDFvQ1A7oeHq95I1hVtdWiLOqRn7CVX8f4GM8iHu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pfnv0gbx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pfnv0gbx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FAA1F0089A;
	Tue, 15 Sep 2026 12:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474489;
	bh=TgpDOnocVQOLMc3/AlRq1UjktGK6C7Gyd90Kux4DYfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pfnv0gbxXYPBW5ngDM1BPQQHDBEH64eQbCNBA7As7XQllaOVs9srOJocJTcOpC3XT
	 +tBSuUVsDjYLtskj1H/KnGHu64fvB/LKvoto8b/1C9TdPBUb2FGeqlDDsZw5ByIwHO
	 MoEzV8EHl67XJeuYV9ENqBOJt0ffAddHj7kVNT421bYVifya9Ag8OwSLhtmCFhxFob
	 paeFeWYGLzS3PmbOQNjlBr1q4j6FJm9IcULTM3aAnjn6WlDhkszRFKzaVJthzwN/5c
	 3uEdtqnuazTttbQPlVN1FAd3DR097y8tCWsB+WVkEH5KLWo19PePTQx30oDVv1BsOi
	 I4VTuIqYdWUzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 39/50] seccomp: stop putting the listener
 descriptor back on failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-arm-msm@vger.kernel.org, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-gpio@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org, linux-sh@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linuxppc-dev@lists.ozlabs.org, "Oleg
 Nesterov" <oleg@redhat.com>, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Jan
 Kara" <jack@suse.cz>, "Peter Zijlstra" <peterz@infradead.org>, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, "Jens
 Axboe" <axboe@kernel.dk>, "Jann Horn" <jannh@google.com>, linux-openrisc@vger.kernel.org, linux-um@lists.infradead.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-parisc@vger.kernel.org, "David Airlie" <airlied@redhat.com>, linux-mm@kvack.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-hyperv@vger.kernel.org, linux-csky@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-39-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-39-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:14:47 +0000
Message-Id: <20260915121447.E1FAA1F0089A@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D39

