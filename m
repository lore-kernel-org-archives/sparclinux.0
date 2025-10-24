Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8410306B12;
	Fri, 24 Oct 2025 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320327; cv=none; b=DQX8LLHmsz3Gl59hKuFCFiFTNY4PdSgl+tpVTWRkpBkX8OFnyq3a25xyn8aHFEyxNXNkE+N7rFb9ef2Cvq+gZ1DFg0gEREnUm+1F4mvSUiSU6HLVclg3obnd0gjHDdincv7hQVunxvZv6/oX4T7VQ7e9igKHTwni7+sQuBubY6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320327; c=relaxed/simple;
	bh=hrmLWBGeZqGWBqhXGkRmBVXABbzsbUQ/o/K+nxSGpPM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iPyDPHjp9qGlylMfDMpeX8T5ZHCXp84V0MnGj5jEkZsaBeX4NlB0Zknqk1pWcnz8vgnJM0DMfmRVvMZTWL1YudwLMxz6a64zYMUilVXKtSJMdqGlmi3smuNUw0JpX2MQwWhB9sPV5pukbxwA/2cgn1sJnxg9AYkdVi8tX4VKYO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=oQaaa7ce; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="oQaaa7ce"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=73Zwdq32M3wvIOvcsImSKjLgygutGdvwi4JFjWo6zTA=; t=1761320324;
	x=1761925124; b=oQaaa7ceAodPDU2w8Lj9e2jsuJ0d76IpS51MHIlaBeLHzLW425hiNEZyrk3j7
	CezylAUF8Mbdqp0b9mOayQ2w9BKAuCfMElPuXkg5MxDdKbgmQRMu1nKodQAoyWspB5uaxysVfynUL
	TS149hoQ6cpdZy3r7ynQkzoZNYOVMAHhJ+SBfo9pCiYd3sX3va76eadftlnl0nJa+4vy8UfPA0GTj
	cClqKCtP9Uj/DRbqXlKfIex8EmdxXeBN3KAYV7+zCXPGNf+JrsifbD2K3mZaXhwy65PPve5UBCuQ+
	yYVl2YbGJAWCW996sswc773BfJb2vQc/PD/Ke6BVggWnSiiCbQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vCJs4-00000000MJF-0C1i; Fri, 24 Oct 2025 17:38:28 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vCJs3-00000000KCV-30QZ; Fri, 24 Oct 2025 17:38:27 +0200
Message-ID: <fcd7b731d38b256e59edd532e792a00efa4e144e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3 11/13] x86/xen: use lazy_mmu_state when
 context-switching
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: David Woodhouse <dwmw2@infradead.org>, David Hildenbrand
 <david@redhat.com>,  Kevin Brodsky <kevin.brodsky@arm.com>,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev
 <agordeev@linux.ibm.com>,  Andreas Larsson <andreas@gaisler.com>, Andrew
 Morton <akpm@linux-foundation.org>, Boris Ostrovsky	
 <boris.ostrovsky@oracle.com>, Borislav Petkov <bp@alien8.de>, Catalin
 Marinas	 <catalin.marinas@arm.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>,  Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin"	 <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,  Juergen
 Gross <jgross@suse.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes	 <lorenzo.stoakes@oracle.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>,  Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Nicholas Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Ryan Roberts	
 <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>, Thomas
 Gleixner	 <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, Will
 Deacon	 <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Date: Fri, 24 Oct 2025 17:38:26 +0200
In-Reply-To: <cbe0d305cce6d76e00b64e7209f15b4645c15033.camel@infradead.org>
References: <20251015082727.2395128-1-kevin.brodsky@arm.com>
		 <20251015082727.2395128-12-kevin.brodsky@arm.com>
		 <f0067f35-1048-4788-8401-f71d297f56f3@redhat.com>
		 <348e5f1c5a90e4ab0f14b4d997baf7169745bf04.camel@infradead.org>
		 <70723f4a-f42b-4d94-9344-5824e48bfad1@redhat.com>
	 <cbe0d305cce6d76e00b64e7209f15b4645c15033.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Fri, 2025-10-24 at 16:13 +0100, David Woodhouse wrote:
> On Fri, 2025-10-24 at 16:51 +0200, David Hildenbrand wrote:
> > On 24.10.25 16:47, David Woodhouse wrote:
> > > On Thu, 2025-10-23 at 22:06 +0200, David Hildenbrand wrote:
> > > > On 15.10.25 10:27, Kevin Brodsky wrote:
> > > > > We currently set a TIF flag when scheduling out a task that is in
> > > > > lazy MMU mode, in order to restore it when the task is scheduled
> > > > > again.
> > > > >=20
> > > > > The generic lazy_mmu layer now tracks whether a task is in lazy M=
MU
> > > > > mode in task_struct::lazy_mmu_state. We can therefore check that
> > > > > state when switching to the new task, instead of using a separate
> > > > > TIF flag.
> > > > >=20
> > > > > Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> > > > > ---
> > > >=20
> > > >=20
> > > > Looks ok to me, but I hope we get some confirmation from x86 / xen
> > > > folks.
> > >=20
> > >=20
> > > I know tglx has shouted at me in the past for precisely this reminder=
,
> > > but you know you can test Xen guests under QEMU/KVM now and don't nee=
d
> > > to actually run Xen? Has this been boot tested?
> >=20
> > And after that, boot-testing sparc as well? :D
>=20
> Also not that hard in QEMU, I believe. Although I do have some SPARC
> boxes in the shed...

Please have people test kernel changes on SPARC on real hardware. QEMU does=
 not
emulate sun4v, for example, and therefore testing in QEMU does not cover al=
l
of SPARC hardware.

There are plenty of people on the debian-sparc, gentoo-sparc and sparclinux
LKML mailing lists that can test kernel patches for SPARC. If SPARC-relevan=
t
changes need to be tested, please ask there and don't bury such things in a
deeply nested thread in a discussion which doesn't even have SPARC in the
mail subject.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
