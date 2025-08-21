Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B241F3FE9;
	Thu, 21 Aug 2025 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794769; cv=none; b=fS3li68+wKB01fwvqtoOTOO7hMdL0EO1+X/srXynni/Gpo3eNQKvcQWqA44XBLGUGStzv57C4xhFAVfyP1CVGpU6lG1NWZT0cehoLfhpbllmZfVrywFK8mnuk+M9eHF74Y7nR+F8agkXOOQCfUIbc3DMrBdYYyS7g+bT7RG7jNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794769; c=relaxed/simple;
	bh=I/Tl34IQszPYSGu6Nc7bOPUdLV3x2lP0DOwDq/ZmU88=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JsFzPgAJuCLpm4VB8v41FkBahoZFglv6+5uDFOHvAUxQ3ptHmAnZLVgKd+8DDRdE3AKWA3ksQrHFb3FTJ3nKYCE57dPm8eYtWEtiqliZFxiTv1SaHdjPpdKM+e3NU3vpwcfydA2ahXF+LJbpzjdJriSs9wDEV1tj/C/f1ZCKPQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=OIhElBT3; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="OIhElBT3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=nT6M89BssGCI89Lp5Hc0EB9rr0lMk+OkaA5nBVCLuZI=; t=1755794766;
	x=1756399566; b=OIhElBT3NlE8Jxm+g1GD/tv/bsBhJgI4rEFjPCco/gJn44HL8a38MR4j7hK79
	cq7ydmtN++FSJbwrSSNeSIq2RlCPgsWvDDxfRLYjeDy7JFzlvqWpBOdDVBpfDW/SJ7WP4rJG9q3Xj
	okiykpTNX7+XfGSRH0C+2noHhRQnh69Fqzw4I4qrVRpsxWCQKAg+56qe7nENDUd8TKNKsOgxoWiqF
	OrgjFfvqZPLygxEclPKCvpiIF+tZgIify4W0HWQregvp5EotexsYIBmt/MsPXVZSS74CyE9EPWrE0
	UVfMA3FQz+VY4+JAXqVt5dl5GV1W5yhiPLVMQHpKLAPTH9Egog==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1up8N2-00000002OiL-0eUG; Thu, 21 Aug 2025 18:42:36 +0200
Received: from dynamic-077-183-203-224.77.183.pool.telefonica.de ([77.183.203.224] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1up8N1-00000000urE-3mkh; Thu, 21 Aug 2025 18:42:36 +0200
Message-ID: <dcc3a478c4f31059686dca38691c4d135d16dc7d.camel@physik.fu-berlin.de>
Subject: Re: Found it - was: Re: [PATCH] sparc64: fix hugetlb for sun4u
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "andreas@gaisler.com"	
 <andreas@gaisler.com>, "anthony.yznaga@oracle.com"
 <anthony.yznaga@oracle.com>,  "davem@davemloft.net"	 <davem@davemloft.net>,
 "david@redhat.com" <david@redhat.com>,  "sparclinux@vger.kernel.org"	
 <sparclinux@vger.kernel.org>
Cc: "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "osalvador@suse.de"
	 <osalvador@suse.de>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "will@kernel.org" <will@kernel.org>, 
 "mroos@linux.ee"
	 <mroos@linux.ee>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>
Date: Thu, 21 Aug 2025 18:42:35 +0200
In-Reply-To: <611a33b02282130d4015b5b8feeda8c46d249320.camel@intel.com>
References: <20250716012446.10357-1-anthony.yznaga@oracle.com>
		 <35f5ec4eda8a7dbeeb7df9ec0be5c0b062c509f7.camel@physik.fu-berlin.de>
		 <7e1e9aa5-0529-4fb5-84fb-557b5cc1cd50@oracle.com>
		 <38f4469f48e6d36fa92b445c8ecef7a440be43e6.camel@physik.fu-berlin.de>
		 <b14f55642207e63e907965e209f6323a0df6dcee.camel@physik.fu-berlin.de>
		 <fc1555550f7a9b3c9aa5fb651769cf41ed859c77.camel@physik.fu-berlin.de>
		 <ff3d87634aedec28e7103f16a35031bfe86ca501.camel@physik.fu-berlin.de>
		 <b5b75976c94b7b46f86a5af4675a1a570aaf20cc.camel@physik.fu-berlin.de>
		 <2bcb018c8b237f7ab2356f4459e14ae81a6fec8b.camel@physik.fu-berlin.de>
		 <2daaa0648e9bcca42bf7a76d90580725f44fb4bc.camel@physik.fu-berlin.de>
		 <c50091bdbb0556ee74ec501381f1efc14a4e5929.camel@physik.fu-berlin.de>
		 <cd3c4a6a-abc5-4f4f-b829-72f86cfb5bde@redhat.com>
	 <611a33b02282130d4015b5b8feeda8c46d249320.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

On Thu, 2025-08-21 at 15:03 +0000, Edgecombe, Rick P wrote:
> And actually one of the architectures that was broken was sparc, which go=
t fixed in
> d3c976c14ad8 ("sparc64: Fix regression in non-hypervisor TLB flush xcall"=
). John
> was going to explore whether the fix might have been incomplete.

Investigations regarding the origin of the problem are still ongoing. The i=
ssue is
definitely related to SPARC-specific mm code, more specifically the TLB man=
agement
code on Cheetah-based UltraSPARC systems.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
