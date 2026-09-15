Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6C13B2D1A;
	Tue, 15 Sep 2026 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472906; cv=none; b=marlFPXjplVPlMwjUCzea4dv7VZOSfEDk22eVFKyCmVnm0rhpSBoKtDnZhEa3YtPc/dBh+2+U/9wNcyZ1WLThKWBUOREEeS/hDfcT17l1NdHkvYVnAY6kp1k9JA2kbCwnCQAio/arSKYWgpRrLu6jGqEFZBU3LqZy2nmUp4SBjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472906; c=relaxed/simple;
	bh=snQOL0WONF4IRsaF3EIs3wlmLSFM44jqM+liurayMLQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DzQ1WQXO9ztJqJqqZc/664/MJE/EseAQE8XKOZK17IyVBmT7JhVGVNi3gUSYN0pOvJhwqPdE4ZOTfY3S/1bG6+eV0qICcxl3xF8qC+VFRJakj5ko53zXLrqSskxiZ/YiIfRlaxQxU1m6ZN3m1rIrqZFsz1N3acYJv/pcQ90xH2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=or6y3CyS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="or6y3CyS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB181F000FF;
	Tue, 15 Sep 2026 11:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472904;
	bh=snQOL0WONF4IRsaF3EIs3wlmLSFM44jqM+liurayMLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=or6y3CySlL1bdxzm9++3Y5GlWLcEPN0LrDGjXv4IhxYT8SwPi7kInte+CrlQcFfkp
	 1XQmoKBf113PXHQChs2avy8UGIIquFVuSvMCoCSNMtA9/3wH0G1HosQnaeUEIWka2B
	 wWhLR1WkDA4HzYixhD6H1F5tbulUxFG0FnA5+hj8l5IA14GNeQQ0O/Dk84ZVAgSj+v
	 HbNF4/Hpt5pQyZeE6+47+X/P7J02CVGZbdLDaKVKYgjpAgC0Jr6q5hx+PjdmH8SQ8K
	 ZwTjgJT8b9Hr2cJYcHzxNGopiariE1M/El0VM6I8g6qSqO3peUD5vDy8v1Fyu9cVcC
	 cthdt2i/NUkkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 04/50] ARC: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-hexagon@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-msm@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Jann Horn" <jannh@google.com>, "Oleg
 Nesterov" <oleg@redhat.com>, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-sh@vger.kernel.org, virtualization@lists.linux.dev, "Peter
 Zijlstra" <peterz@infradead.org>, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-openrisc@vger.kernel.org, kvm@vger.kernel.org, linux-csky@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-gpio@vger.kernel.org, bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-um@lists.infradead.org, "Jan
 Kara" <jack@suse.cz>, linux-alpha@vger.kernel.org, "Eugenio Perez" <eperezma@redhat.com>,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, dri-devel@lists.freedesktop.org, "David
 Airlie" <airlied@redhat.com>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, io-uring@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Ingo Molnar" <mingo@redhat.com>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-4-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-4-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:48:22 +0000
Message-Id: <20260915114822.DCB181F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

> Add TIF_FD_SLOTS and test it on the untraced return from a system
> call. A task that reserved descriptors takes the tracesys_exit path,
> where syscall_trace_exit() commits them before the ptrace exit stop.
> The traced path already ends up there.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D4

