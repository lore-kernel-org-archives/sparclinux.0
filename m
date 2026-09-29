Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A18752189F;
	Tue, 29 Sep 2026 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689446; cv=none; b=Ed7FZ6Uv1LBiKFLOVgQEs1OUhsosblgLND6OXLt86oU7TjxzWP6m0ejwiIKGxgJvB2iufttDS7VLTZiwqOo8u/fMe48wZW+5W1/XK+8F8sb1xZZQYvXMUsHFiyNJp2NKJ0rhvPdgw/O+AEaDZOIn4notoQ7nOweRrH5tmcI5RK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689446; c=relaxed/simple;
	bh=Dlx1qwQp9mVGQwK3o+ibNTmKwVanQGor+zMvNoebMHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nMZnd+39QE/kpn0FBLeA2SrJwD8aJCDFQloVxSmmezrdcGsVyD6k+xia8Ea5cf+nbbZu6pTKfL/sLa9hJC6YHJkO52WhGyU+TssavdwFlGjgv6Vg9PqVcZ1FxApoMbsqBdszGJWEM+CIbtso1/4WuZBsw4gUbd8Kcaayqll1UCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=fDuOBDD2; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="fDuOBDD2"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790689441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yo/Op/kFi4pbnucECzoipGpZ5J4U5anHb31dt3AXmgo=;
	b=fDuOBDD2A5GZ8iEI/xbbglVJi400KGevy8KPvjeLQaFlvJTmKaf6WEgCDLNE1ZgiXJW26k
	YSQfu43odvLLPl2ex6k67/PvqPicRfZR5ft9akRPo6qTzxwkqxcV+Cg3Uwogr2lcOxpexD
	IvDv4JyTg9NEpB5V+1+38Cfxuf7oGa4=
To: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH 0/5] sparc64: Report the M7 hardware capabilities
Date: Tue, 29 Sep 2026 15:43:48 +0200
Message-ID: <20260929134353.3879030-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A SPARC M7 lists 28 capabilities in its machine description. The kernel
only recognises 20, so AT_HWCAP is missing six the chip has.

The list is readable from userspace through /dev/mdesc. All 256 cpu
nodes on a T7-1 carry the same one:

    vis vis2 popc vis3 vis3b fmaf hpc ASIBlkInit ima pause pause-nsec
    cbcond mwait adp sparc5 cfr aes des camellia md5 sha1 sha256 sha512
    mpmul mont crc32c xmpmul xmont

Patch 1 prints what is not recognised. Patches 2 to 5 handle the M7
entries.

VA masking is not in the hwcap-list. The cpu node carries
va-mask-nz-mask instead, so patch 4 reads that rather than matching on
sun4v_chip_type.

AT_HWCAP before and after:

    T7-1 (M7)   0xf47fbdf  ->  0x1ff47fbdf
    T4-1        0x747fbdf  ->  0x747fbdf

The T4 is unchanged by design. Once patch 5 is in, its machine
description names nothing the kernel lacks, and its CFR stops at bit 11.

'cfr' is still reported as unrecognised on the M7. It states that the
CFR register is present rather than naming a capability. It cannot be
used to gate the rd %asr26 reads either: a T4 has the register but does
not advertise it.

Stian Halseth (5):
  sparc64: Report unrecognised machine description hwcap-list entries
  sparc64: Add the M7 capabilities carried in the hwcap-list
  sparc64: Report the extended crypto capabilities
  sparc64: Derive VA masking support from the machine description
  sparc64: Match the machine description's combined crypto names

 arch/sparc/include/asm/elf_64.h |  9 ++++++
 arch/sparc/kernel/setup_64.c    | 57 +++++++++++++++++++++++++++++++--
 2 files changed, 64 insertions(+), 2 deletions(-)

-- 
2.43.0

