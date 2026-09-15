Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BE64A6CD5;
	Tue, 15 Sep 2026 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472965; cv=none; b=gyJzVsPX8mlXELJL+zoDZvyydtIq9D4o6zMm82Wg3OkPH982mMmHlyq6nIqplMV4qwkVC8r3rL1DaIZiyz8goae18vka9Hov9gMTDvQuloPRR4xE5QXk0SG0FBkbmzSKrndMpMwBPFcHDEzZTQxfB6sDg0G+EkTWEjXLNWupiaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472965; c=relaxed/simple;
	bh=eGcmjxpZCTXHRxx6IkfvznZnwzxo/1rjhgD1Rv2Z/Nc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KpT89wh1m22a/rocWIntOkrxGotAHVgNxP7tzJWNMwanEkeil/IL8/xevflRYxPc0UDpwAohUrDP1wec3uNYD5RXl8K8JQ2D1TP28aaczNORXcVFQOdaPF8b1a+xn8jBirs97lWR5eZvQTwdVjuNU4Fyd2ur1QZB0XW6kkBFFkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVgUMcUd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVgUMcUd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3511F00893;
	Tue, 15 Sep 2026 11:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472963;
	bh=eGcmjxpZCTXHRxx6IkfvznZnwzxo/1rjhgD1Rv2Z/Nc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CVgUMcUdzZ3HeCX7d6oqPXdbOOpGnXFMxjmYOiUrDVNMDt6KSFLhwNsMaJoGe3qW3
	 gT6age4Ix8+ho3dxOuPdVPygCOYJmPGqaSEykNHcZv6dAOxJwunKYYu4Iy6A9HEIGW
	 hcxAvgkD63Nv91Yz6yOQLgb7Ly/W9NSezfZRhRwHurpZzKr7aOf2o+Cm4PxtjClXqh
	 MW7HRD1EbMfKOn51qnYtFwoyPkyekFswcsrTqcrSWt/vX+swYhoct8jk8UjXmMMElm
	 /5HuOJJSvXEi0+me6ynfkfTCY644nEmjpK012H06rZNZan+EQsBhkzseJGuSock+gz
	 vnG+SGZD+4dDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 08/50] hexagon: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Jann Horn" <jannh@google.com>, "Oleg
 Nesterov" <oleg@redhat.com>, linux-m68k@lists.linux-m68k.org, kexec@lists.infradead.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-csky@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, linux-hexagon@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-alpha@vger.kernel.org, linux-sh@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, bpf@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-arm-msm@vger.kernel.org, "Ingo Molnar" <mingo@redhat.com>, linux-gpio@vger.kernel.org, linux-um@lists.infradead.org, "Jan
 Kara" <jack@suse.cz>, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, io-uring@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-8-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-8-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:49:21 +0000
Message-Id: <20260915114921.AE3511F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

> Add TIF_FD_SLOTS and test it in do_trap0() once the system call has
> returned, before the ptrace exit stop gets to see the result.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D8

