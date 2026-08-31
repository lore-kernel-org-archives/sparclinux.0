Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1413890F0;
	Mon, 31 Aug 2026 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210338; cv=none; b=SuMPSSWfuSNdg9MR/q5WVXmVbBHqPV1Np1s6EurhWkrqJ/mxiGggcum3WzTERZCmsRx0zBKAZNULXjEQJ2l906kbdPJTjodbAhUPl+VN+JjK69Gl97gVIUWaqLXpS6ZqPWgjX912OS8tX3YItgZ3UppXNmEvZa0DCbhLNhSASUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210338; c=relaxed/simple;
	bh=mVc1vdZun68WiZU+Wb15+WFO3PRMVzXqhAgtj8o/A2s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nGoGLUueGgBRnmJ/TACh0v15V68DgO5EgqZVh3Y2s2gnD9sIP6PU0mLkOjkjZpvj2o69DxrVLBm/if791qjRQsaec0oH+jMtXQ6EWs8lh41P/JUXyy3Bz3aZ29rUnBe/MAZ3+nwSEqU7UW8wX5CiijmPmeJ7vHfGw8I3JBE9p2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=KpCsKEMW; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="KpCsKEMW"
Message-ID: <18d7ea80efbb5dd3d81acbae926da4e027ebfed9.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1788210333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bUi1GFbDfxHMrgMJ75S0sKhIIA+8X13umM6ht8uiEAo=;
	b=KpCsKEMWHQaESCyKo8WeezcHXpxaPCT3jqFBqT+BHCCxUVfkYXALOKo2a+3tpogzzvsKCP
	W9oUxLXB0C5+pBg87BLMmPTljPYbVYBRYIvjK/Sy3t4hsQdBXR4VrXwW0q9HLW+3YxukIs
	u5Nl5sbSxXD4oOKQK7ugTOkH5lJOTPY=
Subject: Re: [PATCH v2] sparc64: increase kernel thread stack size to 32K
From: Stian Halseth <stian@itx.no>
To: Tony Rodriguez <unixpro1970@gmail.com>, andreas@gaisler.com, 
	davem@davemloft.net, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, david.laight.linux@gmail.com, 
 glaubitz@physik.fu-berlin.de, thuth@redhat.com,
 regressions@lists.linux.dev,  nroach44@nroach44.id.au
Date: Mon, 31 Aug 2026 23:05:33 +0200
In-Reply-To: <b46209d5-e518-4289-9b3a-5854a2512278@gmail.com>
References: <20260519075809.8993-1-unixpro1970@gmail.com>
	 <20260831172928.3082853-1-stian@itx.no>
	 <afaa8ced-0717-4d62-8ea6-4ecdbf489694@gmail.com>
	 <680606d594645568c21afcc552558882c4f59a96.camel@itx.no>
	 <b46209d5-e518-4289-9b3a-5854a2512278@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Tony,

On Mon, 2026-08-31 at 13:18 -0700, Tony Rodriguez wrote:
> Hi Stian,
>=20
> Just please continue to give me a=20
> mention in any patches related to this work, since I spent a=20
> considerable amount of time debugging, researching, and validating
> the fixes.
Sure. For now, no real changes have been made to your patches, so as
far as I'm concerned, this is entirely your work.=C2=A0
Will try help with the last mile, alongside some other patches I've
submitted.
And yes, the debugging, researching and validation is the hard part.=C2=A0
Writing a fix is often _relatively_ easy, when you have all the facts.
>=20
> When I last tested on 7.0 and 7.1, both of my patches worked:
>=20
> A)=C2=A0 =C2=A0 sparc64: increase kernel thread stack size to 32K
>=20
> B)=C2=A0 =C2=A0 sparc64: Fix comparator problem with timer interrupts
>=20
> I was able to debug and validate these issues on S7=E2=80=912 and T7=E2=
=80=911
> hardware.=20
Yes, and that's a very important data point. My analyzis is based on
the change itself, _and_ your validation/testing.=20
> I=E2=80=99m not sure if others have reported similar problems on T4 or T5
> systems.
Not that I'm aware of, and I haven't seen it on my T4-1.
>=20
> If you have a quicker or better methodology for reviewing stack
> usage=E2=80=94or=20
> any general suggestions=E2=80=94I=E2=80=99m definitely open to seeing the=
m, along
> with=20
> your config and exact procedure. And if you need help validating
> against=20
> S7=E2=80=912 and T7=E2=80=911 hardware, I can try to allocate some time t=
o assist.
I think that would be very helpful. Let's try to settle the 32K-vs-64K
question with more data.=20

The kernel has stack measurement built in.

The in-kernel method:
  CONFIG_STACK_TRACER=3Dy
  CONFIG_DEBUG_STACK_USAGE=3Dy
  CONFIG_SCHED_STACK_END_CHECK=3Dy

Boot with "stacktrace" on the kernel command line (arms the tracer
before built-in drivers probe). Then:

  cat /sys/kernel/tracing/stack_max_size   # worst case seen, bytes
  cat /sys/kernel/tracing/stack_trace      # that path, frame by frame

Reset with "echo 0 > stack_max_size" before a workload to isolate it.

For the 32K-vs-64K question, the most valuable data you could gather
is a stack_trace snapshot on the S7-2/T7-1 under your real workload
with mlx5 active, on a 32K kernel.=C2=A0

On our T4-1 the worst case is 12616 bytes, but doesn't have mlx5.=C2=A0If
your machines stay well under 32K, we have comfortable margin. But if
something approaches the limit, the trace will name the exact frames,
and we can judge whether the right answer is 64K or a targeted fix in
that driver.
>=20

Thanks!

--=20
Best regards
Stian Halseth

