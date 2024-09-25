Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A971BDCF;
	Wed, 25 Sep 2024 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274565; cv=none; b=qnKru/ZjETHK+O3IFTx63GUkZ2PpZispDZzi4PlaL1QKSbHUdjAhGql50GbSqwkXgMGBFvO+UicOuvOM9aJaopBVORfPM62xLGIt9eWF6Rcgeh4J+JzE7ZsvRu5jiWGqvh8q5AZQXlo+qwvWVDa+IhEkJoOKD3gp7KVeR4Q/Lks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274565; c=relaxed/simple;
	bh=b2MHpgVxiHOPdZ+iESJIZ3S/QUsPCnoF2Kft7tesW54=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=KUtBariSrseVnwTQ30Ad/iF/X3q4a+4GU1EjNv5QrdJzQunkyA2B7HL+oYpogEv4CTbED2oYXYaGdwzdnmzN46RXycBOFuWsVFNGFydn4Hbskrwa8dn0nHKzMyW2hBkEq4ReTz2tMgjzH+nV+fA7GYplsm9LoiJ2WELzn46ViIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=LzWdKZDq; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="LzWdKZDq"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4XDJmt66d1z1Fb3f;
	Wed, 25 Sep 2024 16:21:02 +0200 (CEST)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4XDJmt4mx9z1Fb3q;
	Wed, 25 Sep 2024 16:21:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1727274062;
	bh=Yuhv2WooNO44rsge5suSaRjghf7xfquk+37wOWGGdfk=;
	h=Date:To:Cc:From:Subject;
	b=LzWdKZDqb6fha9mC8NDhqDJPIASMR4smIsMP2Ytrr6azRjPBLcUtEVsVPLScNoBR7
	 dT/CvCps4eyJ7/QbjxmhsrEAayGSPwve7OARFCslI8YMVGMv+Vj0N/ZD4so2Lz76qa
	 nX9HpsAhHCzJSHkfyOk5CgByrZZPfYX+UD7YroSI=
Message-ID: <5a12dcda-6ac8-47c6-a749-7ce38cfbd2d8@gaisler.com>
Date: Wed, 25 Sep 2024 16:21:02 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Andreas Larsson <andreas@gaisler.com>
Subject: [GIT PULL] sparc updates for v6.12
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-6.12-tag1

for you to fetch changes up to d21dffe51baabf6729a95585181507f24bd695a0:

  arch/sparc: remove unused varible paddrbase in function leon_swprobe() (2024-09-13 20:12:11 +0200)

----------------------------------------------------------------
This includes the following changes related to sparc for v6.12:

- Remove an unused variable for sparc32

----------------------------------------------------------------
Alex Shi (1):
      arch/sparc: remove unused varible paddrbase in function leon_swprobe()

 arch/sparc/mm/leon_mm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)


Thanks,
Andreas
