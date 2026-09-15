Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531964AD7F1;
	Tue, 15 Sep 2026 12:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474518; cv=none; b=s/DbK9wydNC1IFOVLAmGuVFA5LO8aD0ogLugyiU9/WNWpBja/Vq/wxOapgp0VsYvFt7gYDPy7KTzlEpU9nGjk2SJoPHWHZLezCCXJ05lEz16mdk9aJPPBX0F/JI2cgGQyV3EyyVE0e5246tnr5TG+cNKi3fMKOPvGTRnyxvTNPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474518; c=relaxed/simple;
	bh=7Ki6bSBJwaxJJeHi7SKUuFLkbZmfL/7uuTnWaWs93uA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aGRlDkQhDqIVTZuS8m5xIHVbVVHC51JYqYCnkWdtJ93hyNNQaGg5eotlORh47N9r4TkMlGwtqJuDb/gtX6deSSrJmHNenYC296eQmcwI9JndXLVh9irtD/d1GFh0UI7wuopyEG9hiuKHGwpwkEtnNJm1ldu9JQ7qFPie+N6OgFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kI77b5Cs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kI77b5Cs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295751F000FF;
	Tue, 15 Sep 2026 12:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474517;
	bh=7Ki6bSBJwaxJJeHi7SKUuFLkbZmfL/7uuTnWaWs93uA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kI77b5Cs1CCH5C2TVxPIT8fy3wL5A+5GVvFbNqnc8ywtIl1xsP+kz2+YtB6oqe4rq
	 l5MIumARVSkDXAKZVkJf4FmmuUstog7U7WkwkoO47/GequtFboDqXFKBhm8gRVl+8O
	 R05h3rhCE8VlU3e70rQ0v5HNwr7mByz6nbAUN2qjsZ4EdPZrSzKMrkSw0ptkltPWdD
	 1K9aNz+rSv8p4Ksfg6V+iO9PxpNKvssHsTIw8bHe/sGHatYYCzuFLzRvKplACIwjle
	 MkbJfnFHm3eFE1Z3cOPmlWvybtFLHN5O2L13O1dy8fXdonFCUhJlZiezPlMPDhpdxP
	 QdqQbUTSLLEqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 44/50] drm/etnaviv: install the out-fence
 descriptor when the ioctl returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: virtualization@lists.linux.dev, linux-parisc@vger.kernel.org, io-uring@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Jann Horn" <jannh@google.com>, "Oleg
 Nesterov" <oleg@redhat.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-mm@kvack.org, linux-snps-arc@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-m68k@lists.linux-m68k.org, linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org, linux-mips@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-sh@vger.kernel.org, linux-um@lists.infradead.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, "Ingo Molnar" <mingo@redhat.com>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, kexec@lists.infradead.org, "Peter Zijlstra" <peterz@infradead.org>, linux-csky@vger.kernel.org, linux-openrisc@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-44-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-44-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:15:14 +0000
Message-Id: <20260915121515.295751F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D44

