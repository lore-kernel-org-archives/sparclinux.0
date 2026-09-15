Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38AB4AD7D7;
	Tue, 15 Sep 2026 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474501; cv=none; b=JPqOZsAIKETkxQFyK27czajszuKzBt+Msk9Rz5DvXdVObnoFiIcDBzwkMFgpiUn55sdffeeM4UAUGgXxXAVyuTVQ//b6GMl/itsX3wzUFROcljxSF0nl6DVFrKdVkJDVM5tX3L1WB/Xy0nQ/y/6KGMc1BvssomnZO6TPIorMrbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474501; c=relaxed/simple;
	bh=QRMZ7mmRdl98Hr0Jzx0dLUsIBC2R/cA4CuoG4//bR+w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eoYpi3As9qEyTP8CbBPqQO3cSdCEv9mDxwmmdPX8QCprr7sSi+fQSA+8UmkssE48sNpoYhg6vfu+8QF52KCUGPplm4dvojyIuu+8TSPCVxuoQWXhZr6BXi4H2smaGPMRfeIkyetw0WY02n2MkUHrxJWSoYc9+iNtMz4d5eHtNf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPGWfVIh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPGWfVIh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD1B1F00893;
	Tue, 15 Sep 2026 12:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474499;
	bh=QRMZ7mmRdl98Hr0Jzx0dLUsIBC2R/cA4CuoG4//bR+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XPGWfVIhJ/wSL6Jd1KV8QYkaPXQevpxTo5YKyPKDIrxlw9MIHMHo5cZnoqRuYBPzW
	 YAB/BBxKyr04OnAz1fXuFsMiapL3vJK/RuyN3woNJu65a7GotPewX23h9YHqDCxQPk
	 2CWF6CYq7PbvZJuYpGBlpn9YbalxW+tFPh2E8PMbxAki0JSstQ2YNM5+QlpENVA4OR
	 4S8OeAn9BG92ITePDtvvACim8Vy9KB2TGUTfda+kW7PhqaNdVyqOBZvhFMBFu6IU+R
	 cXVP4LUVIrc7LmnOQ3vKo+sFLx/fVgoMs3/93rCsxZ1sqN6D06XnUMiUCyDHo1Jf2m
	 gcjyzu+b66/Nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 37/50] tpm: vtpm_proxy: install the server
 descriptor when the ioctl returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Peter
 Zijlstra" <peterz@infradead.org>, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux.dev, bpf@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, "Jens Axboe" <axboe@kernel.dk>, "Eugenio Perez" <eperezma@redhat.com>, kexec@lists.infradead.org, linux-openrisc@vger.kernel.org, linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "David Airlie" <airlied@redhat.com>, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-alpha@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-csky@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-mips@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-gpio@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-arm-msm@vger.kernel.org, linux-parisc@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-37-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-37-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:14:57 +0000
Message-Id: <20260915121457.BBD1B1F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D37

