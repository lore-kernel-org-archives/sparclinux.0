Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286858;
	b=LUanwgroX6zoviZ/tlIXvJLUHFAygbCawC83sDymo5PtSgASzaiRDLTBOkijsW8vhAAC
	 tYNnnUhhxNAdfdfXT1nd4BhYWOJyFrGx1tZXpVjkuv5l0QshVnmq6NlKfg+HhFvY5ui/K
	 5bcY3qm+ic0jCG9zZKkLpmgRpU9mklwK7jxFFFbOzgdFZEKwZnn5fCoEV+0uWMwiSJPhj
	 3myVlvr22TLMs+r34N39T48lQUi7TjrZanV1n/H48Ud+6qB8qBBouTkJeGjrxAoaLRvkK
	 UN9s/xx670TrlhUDNHpr68MBsf1YvmLAFzRu4G52F76V9Ubla94d6vNI0QXo9WhgtUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286858;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=3Dz/ro20JO8NmFftptneHrpics2bpuemOoF941Sp1ZI=;
	b=evgldlSm8Lno1HWHKnO8rHRAhM4Lyg/FyVsxiAoWxYM8gRWKiX0jrdyk76921Qgu54+b
	 uJFKAM+tB55fwR2xWN8X/B9kZYC+vK/rQxYbdsmT2EoxffCp1fQs/xKqBgocQ2OC76i+6
	 LfH98pguxMpRMe5Bs3NtP8LzrfJCB9uiBxQHXo9EpluWa6I9uFToCQqB3rOPnxau5CP68
	 z2FnNviIR0oB81R4u2yOAUqPMUDh+Srsb39n7vg4Y12cyWh4IZYG9gqQ+U1Zbwjez6xhB
	 oM3lpwZHhmx5GT3X/2UufhzkQ7Xjya5W+zEb36uQBEyqfE/AueSEp2AUnNqFcoJ4lQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=OAGfoDAN;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=umo+suJE;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A44606A31A
	for <sparclinux@vger.kernel.org>; Thu, 29 Oct 2026 15:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39A44606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=OAGfoDAN;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=umo+suJE
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 4FCB81D00167
	for <sparclinux@vger.kernel.org>; Thu, 29 Oct 2026 11:14:17 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 29 Oct 2026 11:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793286853;
	 x=1793373253; bh=3Dz/ro20JO8NmFftptneHrpics2bpuemOoF941Sp1ZI=; b=
	OAGfoDANS23piFiK41asHl5aRNZq3ilMcEzyP2ttxgFOvBAdvbBSg5169TCshQaD
	N/8/oTn3KKRoJ0gv3WvbkX8sMIDywZqyY+PmNYVac06HJZ7VrT/xxYa3SIuaJv0j
	VTdifQHoft647dzMzhpujWgjThCv8NeVLbY78M/uHhr7eTWqooa3KJP+6VUlp5tE
	iNrUk7Frqwulxnpfy2bClUEknufJyxQFvUKG9045lG6xD+ox7dhsWb8zVgKUT97B
	kU9WT+T5AS9I4ph7VdDTfsECDoQ6E983Yv7FD4To9NYoVRU1M2YRJW5VzZ5535Wh
	DzpLET5emmpviKL/vgtOSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793286853; x=
	1793373253; bh=3Dz/ro20JO8NmFftptneHrpics2bpuemOoF941Sp1ZI=; b=u
	mo+suJEw3PeGJRIR2iSkZkUz8HWfIBz33aq7Xuv0K8IEXRcEnSIs6YYgDlcrm7/D
	IDrwfRez76ynS+nuKrrDWhZgMMSblodcqDNctke0n7rTQkr/81BJyGpOPqj769/t
	Pyv9EvN+DEs3kyaBYHQKoZ73WhPwrH2kIrZKg6FzxqxJYSwGU9zYIYx5hyWp1HC/
	pe82S+6yULidrWk9gk/RMlfUgKociS/A7GHQ0G3Q+wYg8TwcqKYal9nCoZs0vDjs
	5PIM/qk33KpMjb+8vBY4l3mIFzTKeE6f494lfPgBelcQbRMqYt7g3wUExrJ2IS2d
	MO+gd2ezu/rUXeVsDMcvA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793286853; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PHNwYXJjbGludXhAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:ATv7pN5diSy4UnvZHI2kAb9t5i63xRV2O4lEFyqgxVgZ5I+
	fW8sB8r30WDsOJpeW3FpIywdTFC+aTU9nwxM8H80t5K0opn8HjQrTBbHADnZK5Sw
	jM+8e884Z6H4GGL6AG1lKYZAOxL185hHGQlem2Du5E1D7fBYfgV4KR19sX1kd8pS
	lE+MrSYAz42OxmgEZAz7XvZxUBjU4QRjcHZUJrM7xhqZv6dvMpgxn/HoaFsLkHSQ
	+t3tDIli/qHAyOjDe4vsiePUxnIpSl51Laqt1M3NU04W1O459o1VeSJYtty80QzQ
	XVpVcwGol53zradtjIIU7ewRJYprASKv1z6Ee1g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:h8tTH65CTcGLnbqcGdI7hvWawfwV7AefhKqI4Noy6NQ=:gSavoSg4XA/c8ggO1GBeUx6d4zpVOWEZXQqYXGi+cbk=;
X-ME-Sender: <xms:wmLjajRbLF3MjxRolDgCQ37t_ZAcs2o_ADrf8O2Mj3L_8RifTx8nIw>
    <xme:wmLjavlgUo1EO1chtRDPwEqgPvrBWMDC5V44xAMd4HS-qfYeWiFMGSHvykVgmOmrl
    og5qIwWJ0RhfL5RduzatplkkXPRYuVnEQQ2V2171tVvkkGm7THnN_zv>
X-ME-Proxy-Cause: dmFkZTFPIb5Ns3wNTKQ9FOpsNHZ8i0K/UcXB8REBvxI41Ai009qX427oevKc0sIE3C8oeT
    7V719uGlKjdT3wXhi06U+yZjGG07Lq1E0/gqtRQCnhMFLk8PRZLHx7UVYOOaWtSiuhKYPE
    mQu1QEM5jktRXq+ISYFYlp/5ka5JYFMUADZOhZj6mROjk1QErbRrYj8lA5Kg2o95yQv6s2
    uBAvh+wGfg7I70W4HKu2CfQgj2whzQq6t+hoiPR6RGtp/yUCG86RsEqLrTbYtseFqbOgSm
    0L1YZ9qxZ3z+duYCUs9dIT4rd1PV+JIx/tDkwU1XkFbvhYfOlfpyei+mEbRphRmKEBNYEo
    D/+4Z8FqvfFxH1vIGO19hkMwtd+grdvqR98uLz1xCkrMDxLF7e0u036n2SbF9KQtGCU8NK
    dcvKCOOAgyC6xC9vm8gupWsnzn0JbZMw4hRsiLta3m2Z4w8yuNZybkyg7I+jNVDUF0XE1I
    upn72W59rnHrzLiRWqRGgAuLZTxSYLAhqPowRlM9fqkHe5v9Ze3aYimeSbxTp5Dzy/m5bD
    GSiUzScQ4lWLmKICBwwa1MNGAKE+pd5e4wlLztKoTi0TE+OGjgV7NMXkHRd572jbt/sH7i
    DcpS7IDMSAAcXinGwvBY4UKkGS6nAENWhDaH1CQ3jGV6vyZDr0uXSL6EN4pA
X-ME-Proxy: <xmx:w2LjaucF1eavZ0pjlXsP5S5H4bEVx-iUIuDjd1CtbvgSdxQek82DDw>
    <xmx:w2LjahJn8XJWfXe4DukHaxR2L_zNlGHbPGsoNs9CUjfjghy_dudcpg>
    <xmx:w2LjarFWNMoSOzF7uCc7JhL4eKJC3gYNT0wQTfVfw0qKnkJGMpI2ng>
    <xmx:w2LjasAwyX6WU8uNvohqZBS2w1L8h-AMxeHRWLnAqxHqh2mYMCBK-w>
    <xmx:xWLjaoFtAcDy6HLHPSc-2y1-YdmUx_mz8kY-rxCEO3OK7OHzIRdpcsM3>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id EAC6432A0093; Thu, 29 Oct 2026 11:14:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AkBENj9svcUo
Date: Thu, 29 Oct 2026 16:13:49 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Julian Vetter" <julian@outer-limits.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <e26b3c92-5213-44f3-8914-5ee8fb2d662a@app.fastmail.com>
In-Reply-To: <20261029145309.132218-1-julian@outer-limits.org>
References: <20261029145309.132218-1-julian@outer-limits.org>
Subject: Re: [PATCH] sparc: Remove IO memcpy and memset from sparc code
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 29, 2026, at 15:53, Julian Vetter wrote:
> Remove the IO memcpy and memset from sparc specific code and fall back
> to the implementations from lib/iomem_copy.c. They use word accesses if
> the buffers are aligned and only fall back to byte accesses for
> potentially unaligned parts of a buffer, while the sparc versions always
> use byte-wise readb()/writeb() accesses. Other architectures, such as
> arm64, csky, loongarch and parisc, have already been converted to the
> generic implementation.
>
> This does not drop any memory barriers. The sparc versions don't use
> mb(), and the rmb()/wmb() implied by readb()/writeb() on sparc32 and
> sparc64 are only compiler barriers.

Hi Julian,

I suspect the sparc64 patch is wrong because the generic
code relies on __raw_readq()/__raw_readl() to produce
native-endian data, while the sparc64 version looks like
they work on little-endian data the same way as readq()/readl().

Do you know if the PCI host bridge on sparc64 does an implicit
byte swap for memory space? If it does, the __raw_ accessors
have to flip swap the data another time for this to work.

      Arnd
