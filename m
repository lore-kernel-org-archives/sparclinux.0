Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544AE3B6379;
	Tue, 15 Sep 2026 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472757; cv=none; b=JEVCDpNHxneZzKAAAEAOa9wfWTYnMv8eqjgSp1FeRjTmaYFHJomzNhi4muNmN0JsPc9B7j3MbHo3j6XelRSz3HHgTi4Vl4bMF/oQU3y/1U/hfTOfs/Lm/j7R1zuzCSX8FvzylR47YNYooF/KOkPXab7orgRJ9aar6rCMjD6VDmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472757; c=relaxed/simple;
	bh=84qdWoL1LKc5gtdlqTMvnJT+oufAgjOVJobzRLdUed0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BPZvhH3gUUeZhMXpqSb5Rqt4wGmGJd2ArmOrcUszi+Sk2vTNHatxQ/t4KS7ikmmcGqYWGvXfZU0oyki9e14RKFfmpQ6bsOOOytfDTd+0BCTFP15gKh/R2hMmruXuiENgJQUaUqN9FwydgSxm3fW4+9ITc8RiW0uVBh1m6tQweN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvyMOoJ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvyMOoJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6688D1F00893;
	Tue, 15 Sep 2026 11:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472756;
	bh=84qdWoL1LKc5gtdlqTMvnJT+oufAgjOVJobzRLdUed0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OvyMOoJ/eHXXAGCUuAHV9UPjednx+3v2kDsPpsRiMt2vJNRigBckYplzs+k1CunG2
	 VWZZat6CVLgoaSJTbzAssnUcFLqBHnWcBIQrLSfCF6yx/37jt+iOEtPkQuPGH8kPjd
	 AcdsSWp6kCGfJlkts3qZap21GHGOxCB9xpK4lKpyaxS4E3Gaqn2VwY0tbDq0dM8cvD
	 +S2ZTPvYUXYUWl8wkJIZFxNOYN02VLCEE6CbGr+QmxOcs6ih+Z8gfikh487gD4do1z
	 HtstDA3lVNKx0gLEevE1N9RvYOxqvCFfMI9vHNdE7EnXbFWmMIRc5NCWTLObCYGVL0
	 9PhkPHo1Z/4SA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 11/50] MIPS: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: io-uring@vger.kernel.org, linux-gpio@vger.kernel.org, "Jens Axboe" <axboe@kernel.dk>, linuxppc-dev@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, linux-snps-arc@lists.infradead.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-csky@vger.kernel.org, "Jan Kara" <jack@suse.cz>, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, "Ingo
 Molnar" <mingo@redhat.com>, virtualization@lists.linux.dev, "Peter Zijlstra" <peterz@infradead.org>, linux-mips@vger.kernel.org, linux-hyperv@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org, linux-parisc@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-mm@kvack.org, "Jann Horn" <jannh@google.com>, linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org, "Oleg
 Nesterov" <oleg@redhat.com>, kvm@vger.kernel.org, =?utf-8?b?Q2hyaXN0aWFu?=
 =?utf-8?b?IEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-11-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-11-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:45:52 +0000
Message-Id: <20260915114553.6688D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

> Add TIF_FD_SLOTS to the syscall exit work. The return path rereads
> the flags after the system call and calls syscall_trace_leave() for
> any of the exit work bits which commits the reservations before audit
> and the ptrace exit stop.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D11

