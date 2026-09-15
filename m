Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A383E4ACC6B;
	Tue, 15 Sep 2026 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474498; cv=none; b=gs6GDCrdc+gbkW1nevYKyI4EEeLp5+NKrmjKifHFbb/44kTiK1PASQKVTTzy9l9XnppzZAtc6PsVp4hLm4+Oq1lPzNzoiznuNBjbmoGa7N8vlPII6QG8yR+8P0yI2U1NxiotyPkWCG9yK1lKb+QvrO8XZ1S02m2RlqYS4fVp/Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474498; c=relaxed/simple;
	bh=ejtHf7OrVCONiSGbsU0Szkqhw/V3NKRKJBvDExa4qrI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VX+G+vyMQj3McEtMQ6eqkVlEjZDnbv/bCuuPRE3Y0vcZCku9GMp+Wv4dtLUtQuQKBVecJkSjQuQZEz32lRYt0A3pYgBAzqAUo7Fm2FN+yChVt/0PvyjHsTSk2HGpiZT5Eq9FzwYGt/KqzKW7l7UPcF1WQ/cwph5dJWaYQ8q0xSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQ3aDU0Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQ3aDU0Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398E91F000FF;
	Tue, 15 Sep 2026 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474497;
	bh=ejtHf7OrVCONiSGbsU0Szkqhw/V3NKRKJBvDExa4qrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SQ3aDU0Q8GsPtoMGWFzUtgXPVhQk5j3tT2hP5/IYPK7pNnGp/W35LdJkurCxq/UDj
	 jXECYSMyRfHDZKzN98Ln98DAG1rH6aAR4ISmzyGlU1rsDvw5Q93DNzrkBW2qSN7IRC
	 YJr9cCfLCK65yz/lnkKU0h/88SazD0WGxzlXFRwUnZmmA1pIC11CPHPte6Jw/NVEZ8
	 jp0yJWYB7+6Cgap52rqfdYHOC0u+j0XckjkUTQa+uZ9aKsrGomUpcl6BdIHpYiyzm/
	 Rqj2wKLDgmWRUAKCkxgoX9x9LTH43+wakiVHy5v4VFxVPQvMYbRVfHWWmjs+K15B5a
	 6EBFBzK+SsdcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 34/50] sctp: install the peeloff descriptor when
 the syscall returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: "Peter Zijlstra" <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, "Eugenio
 Perez" <eperezma@redhat.com>, io-uring@vger.kernel.org, linux-mm@kvack.org, linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org, linux-parisc@vger.kernel.org, virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, kexec@lists.infradead.org, linux-arm-msm@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, "Jann Horn" <jannh@google.com>, dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-sh@vger.kernel.org, linux-mips@vger.kernel.org, linux-alpha@vger.kernel.org, linux-openrisc@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, "Jens Axboe" <axboe@kernel.dk>, "Michael S.
 Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-m68k@lists.linux-m68k.org, "David
 Airlie" <airlied@redhat.com>, sparclinux@vger.kernel.org, linux-gpio@vger.kernel.org, linux-csky@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-34-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-34-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:14:54 +0000
Message-Id: <20260915121455.398E91F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D34

