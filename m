Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AD44A0F09;
	Tue, 15 Sep 2026 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474870; cv=none; b=EISV6MIume40W4xCgi90vCRrjKpM9WVVgwxTv+qu0rChXv7jWq8I/pjf0deImsirUIwr/v+YwFDundSbIqhZSGQEfINx3IpEdA1C0kifX5NdVIpBWQkUzuwz0WL8oaS5YWF8rTOioHq3fejoeKOiyXy5jTGUI3kKW6pSVX9j4N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474870; c=relaxed/simple;
	bh=zfyJBviruOrXl2JCvdG1FvDmNuy7BpjW1g6Twwn8tGo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VKr35TxouesJHnMNVTws9BGX7q6XJzfkWaHZg1vJ9l6q8NDnCJdVT1uQs/1QOJ9BN1fYFo/ZsJQ6HE2nrnNwcT1CkAt/AFtbjF0dfIZ60Id+kP8fmHbLjzknB7N3ZOZ20XbtPKdKUcnEs8YU4CiUDuyzioqKPKHAZp3l09VXvnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gObKfAKF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gObKfAKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373A11F00893;
	Tue, 15 Sep 2026 12:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474869;
	bh=zfyJBviruOrXl2JCvdG1FvDmNuy7BpjW1g6Twwn8tGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gObKfAKFXTY0hrJS7QZn4qiNIiTIRIBlMSNnER3mXV89dBb57+qlUdDcC7JXNusYj
	 DN3AV6iDTkMMLCKiEUO0tLOW3BC8L8HfDFUz39G5Pai9HhjjNkui+WJehHBvCAlYI6
	 l1+furIrRu5FFpirKDF9oXFfJBGjua8Iyd0PslloNxEu3qlU5WfgMOvXrxDBbQLMUU
	 Hqf4H4ziX5u2zvxCwKkGT4L9W/w3y3hNNkeb0JCCYiu0nrv5MgfHg4dM1guzvKexB6
	 ypTSTOfhsabV+KeBEgLsJEWgU6XLC9cNbo4Q/j9aFrVeLGZ92YWgG0nY7ceyp4UFja
	 rQpYWXr+PJ5lQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 49/50] iommufd: stop putting descriptors back on
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-openrisc@vger.kernel.org, virtualization@lists.linux.dev, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, io-uring@vger.kernel.org, linux-csky@vger.kernel.org, kvm@vger.kernel.org, linux-sh@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, "Ingo Molnar" <mingo@redhat.com>, "Jann Horn" <jannh@google.com>, linux-kernel@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-mm@kvack.org, bpf@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxl?=
 =?utf-8?b?KQ==?= <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org, "Oleg
 Nesterov" <oleg@redhat.com>, linux-snps-arc@lists.infradead.org, linux-hyperv@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-49-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-49-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:21:06 +0000
Message-Id: <20260915122107.373A11F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D49

