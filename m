Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581224;
	b=WAoi+bHTxytjnRBDY6FDyqEsJXUi7b6UOIDZQ9C0hdwdwE6n5vRqwBTF7M0NvdAZea1/
	 Q77t27j1m494kJD98Z74/wsE2D2xHnGA1/kmODT1ye2z6XzX6mnMIkrF7PA+VCV5uO1YN
	 O/Og791g2HTzj0+k2OiPhjwYhN1z4yF8U2o/Z4JJBfuGmtDlTgnR/MUQ4GKqeGZc+Cz0E
	 XdmsRKKo4RC244VVuH+/xxv17VFxLUVQc92KcZigS6GWzgGkUgq/vBV2ksFCL8FPIC6qP
	 k4u23KEre/FkUhQ+cj6NzEJsANmwqSKVL7znCu+fVREJ/YifjiFE3oc0KpGGvESGtzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581224;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8iFhNS/cSZy/uT9a2k3GwnpqRtfU1LnF+wkm5Z/CvKI=;
	b=rpMU/+891VykZmYirlx0kb1cGOpd8jNWthfd2ys72je4TX59iG/MJPuY/jSyO4VZ23a+
	 icSPGfp1+x0K1FlcIISzH3JnJ0DdNc1u/DUrd2XSo2HkclQEwmgWAT+xv5NohG6wTFa/j
	 bmiSut/796vtLlgBPS/hNu2xcWpJCpabWxq0vUdz1lDCJrshdoPvxTnbf6Xyr5yaadxf3
	 /E5cToodAcjewUhvBgTSobK1qxxICdXHL528q8f0mLhWq/zgE1Jjl0bVLpCjeYX56Sa+T
	 nUJ6UdwJeidYD80mAXnHuJaHXUeJD3kmmEbVQKo+/ZOlrd4ucjBnQJWkYqrMgv9rccw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRU7JR69;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB76606A327;
	Fri, 13 Nov 2026 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRU7JR69
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E501F000C4;
	Fri, 13 Nov 2026 14:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794581223;
	bh=8iFhNS/cSZy/uT9a2k3GwnpqRtfU1LnF+wkm5Z/CvKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cRU7JR698Ixq3jmRduWLbxHJtGfzgjeYsQmj6AmxBN6rYHa9iw3TkHJR9ZkgGz4ud
	 BIiHF7+rWJS0JSzU9p7HtY2+NZ0kwsghbDWlXFVGODppuiQASCJSU61L7ucmdlDjoJ
	 OOwcuGQTdDApA6Ba28JKJk5b+1s0yWbpk8nuJNZbnOJQR278M/AcFRgec/lzd8CYum
	 pBwT0EKhNzOBzSHcIo/zx97Zb5jmiBv/9EjZowkfnqBALUleSTIRN2kFR9l2MRIIBR
	 D4tCUITTKq+RDH5aGjdE2rw5coY2rjWqH5zxUBWdNlWgwIDp0XM7jRPWF9nzjUEj8I
	 o+/mJrPaY2wVg==
Message-ID: <sashiko-outbox-213010@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] sparc64: kprobes: Resume after a delay slot at
 the saved next PC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stian Halseth" <stian@itx.no>
Cc: sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261113144057.1697874-4-stian@itx.no>
References: <20261113144057.1697874-1-stian@itx.no>
 <20261113144057.1697874-4-stian@itx.no>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:47:03 +0000
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] sparc64: kprobes: missing Fixes trailer for relbranch_fixup()
  delay slot fix
--

commit a946035b56bae1c0df38ae8f1a539756818bbb78
Author: Stian Halseth <stian@itx.no>

> sparc64: kprobes: Resume after a delay slot at the saved next PC
>
> After single-stepping an instruction that does not branch, execution
> resumes at the saved next PC. The probed address plus 8 comes next.
> For an instruction in the delay slot of a taken branch the saved next
> PC is the branch target. Execution then goes back to the probed
> address plus 8. It should continue at the target plus 4.
>
> Use the saved next PC plus 4. For any other instruction that is the
> probed address plus 8.
>
> Link: https://github.com/sparclinux/issues/issues/110
> Signed-off-by: Stian Halseth <stian@itx.no>

[Severity: Low]
This fixes the real_pc + 0x8UL return value in relbranch_fixup().  Should
this include:

  Fixes: f08825896664 ("[SPARC64]: Fix several kprobes bugs.")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113144057.1697=
874-1-stian@itx.no?part=3D3
