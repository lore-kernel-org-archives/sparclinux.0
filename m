Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C8B459AED;
	Fri, 14 Aug 2026 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786706768; cv=none; b=ClcaJKGzWsyNru2cSbGho861yq8LLB0EvjEIcV1JaQxAb8nwOx5PHFt3LFjpac2HfzMqO+fqFOfTCL7b97n7qcXVdro5nvbz07L1Gi/Jn52wmp1bn43sqN+kgpA40dJCKZ2ylw/zjrY8sZGFQl43PmcApZKippJ+7oJK4jvIwdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786706768; c=relaxed/simple;
	bh=MPKz+69/IztIxRUpesLkh756egt5TFJZGiy0Q6OepBQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=reLwMDv91YJZC14oeedYUV/269wT//jLh5EH0gwEPJU6+/kwJI+fbaOp0+DAv+tsVEcvy536DSSkpMncYyp0uzGB/d+IesE9q7xBFgXLdSzQ7yMxtzWJPWlWvMnaQQ579RyhIOLJCBvN7Ycox5jnDYNs6G+u0KSLOWOSOYEJSaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=PTqtMQNe; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="PTqtMQNe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=8VnhwEN6bAkRBfzBKuvXgPG8cf6zllDT5gHo9nQZmeg=; t=1786706764;
	x=1787311564; b=PTqtMQNeWD/D0mpOUkKdGCITtkuuoNyDBrnVPZXJsoDIb3+UxP/EL/koSJWTb
	BpaczOhwhxk56C+knuUpf+R2l0UOLl36wfhE74J6U7Bn7UC5wjXyPEAs+zzMuR0RoGer9KX7uVK7Y
	7YnFM1sduBIt5bqj3eg0UCgeVW8COGq7mEQ50D3VrJFYzLTxpTGDyg2uiyJWjf+jSGcMqNpahlWX/
	5+R2x8uvddAqjE/oVXjOEVXfVZqhnpnSm7oPjTR5Nd8Ehs5yZ1GprHWwLro0uEnumQIYcAlo6QlpG
	sWCy+D1EYb9bmRb/JxZcvFEQXxNBiTAG2+7+7JBmxG/FJM3mJQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wuq2t-00000003Lrt-1UoJ; Fri, 14 Aug 2026 13:25:55 +0200
Received: from p5dc558fe.dip0.t-ipconnect.de ([93.197.88.254] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wuq2t-00000002Z2d-0ako; Fri, 14 Aug 2026 13:25:55 +0200
Message-ID: <0d428f9f8b6084d80b65145e148025b170703345.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/3] sparc32: allow a kernel loaded away from the start
 of RAM
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Magnus Lindholm <linmag7@gmail.com>, davem@davemloft.net, 
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 14 Aug 2026 13:25:54 +0200
In-Reply-To: <20260814105723.3454511-1-linmag7@gmail.com>
References: <20260814105723.3454511-1-linmag7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Magnus,

On Fri, 2026-08-14 at 12:52 +0200, Magnus Lindholm wrote:
> Many years ago I ran Linux on my SPARCstation hardware and tried to keep
> up with new releases, but somewhere around 3.x I hit a wall, sooner for
> SMP builds since they are larger. As the kernel grew it simply became too
> big for SILO to load. On this machine the last one that fit was 2.6.32,
> at 2598956 bytes against a 2605056 byte window: six kilobytes to spare.
> 3.12 was 184KB over. Fixing it turned out to need more than SILO changes,
> the kernel side needed work too, and I never got around to giving it
> serious thought. I recently dusted off my old SPARCs and picked the
> journey back up.

Awesome, thanks a lot for working on this!

Do you know whether GRUB would work on these machines as well or is there
anything that blocks the use on 32-bit machines. I'm currently not sure
whether there was any show-stopper.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
