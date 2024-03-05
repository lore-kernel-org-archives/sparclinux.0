Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D195FC0E
	for <sparclinux@vger.kernel.org>; Tue,  5 Mar 2024 00:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599879; cv=none; b=ZgmvJVbKMrFVYTbUGBXpZp207154UPmtV7dDY89stwOApRBE2akjNuBaEGIILUHxZIz6CspL6Xcji8WS/KRKW339YXeDIK0G1ueuWx56Izwe5YBeeKI00HgdFMuH/2bFqZG/IKLYNycmxst9MBjT/BKox+xpLzI81DznmgTe3b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599879; c=relaxed/simple;
	bh=wK8JuTd8nM8EJSY9ofq56Z0uYnZNseajGjvNBfcna38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LQcyn7yYio/oL6/ixnd7SYlk+cReOXKAsL87gbCgzo9WoMrFgMzgt2pggDHQwMGmypdGnr3ZZ+C0JcTD1WzBCFFHV54zUMNQyBsM+YGRxD6n4m0iOoMPSfwQjCtjj5NY/kee6bzxm+r+DcsdXmxOriMBZTEA8t9KamabjOHFjEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=XP9j8i2G; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="XP9j8i2G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709599875;
	bh=wK8JuTd8nM8EJSY9ofq56Z0uYnZNseajGjvNBfcna38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XP9j8i2GbeIRIQ/eFgcEtAca5GxRqxBFTdprLfh1GJYPpZTSm5veBPp5MZ9kaZNeb
	 52zRt0nrLX7dPHyIMT0Jc6Jst0em2KzlIBCN1lO4kgGSUAhGUK0Ahkh2/ljjKeRF/F
	 i09yhOK5Ra08AK0Pyb+0LjEpif3epQCmaIpmp50D4b1gs/0pr9tkdu2nTHwvdfEftR
	 sgKg+yGkiQft6wr7JpKbySYioDKgLvskj14IvKWIHDbLmOgXd6axEBQ6d5Ze4FMEum
	 sR+vAEW+YxN4W9C3ly/ZMm62PX6H/wQIA5/Kb2GBroC1PHrg873OEiGdlsZjqxdkU8
	 pGqMf19V+JMdg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpcSd38SYz4wc9;
	Tue,  5 Mar 2024 11:51:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, rick.p.edgecombe@intel.com
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, bp@alien8.de,
 broonie@kernel.org, dave.hansen@linux.intel.com, debug@rivosinc.com,
 hpa@zytor.com, keescook@chromium.org, kirill.shutemov@linux.intel.com,
 luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
 sparclinux@vger.kernel.org, tglx@linutronix.de, x86@kernel.org, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, "Aneesh Kumar K . V"
 <aneesh.kumar@kernel.org>, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC v2.1 07/12] powerpc: Use initializer for struct
 vm_unmapped_area_info
In-Reply-To: <20240302001714.674091-7-rick.p.edgecombe@intel.com>
References: <20240226190951.3240433-6-rick.p.edgecombe@intel.com>
 <20240302001714.674091-1-rick.p.edgecombe@intel.com>
 <20240302001714.674091-7-rick.p.edgecombe@intel.com>
Date: Tue, 05 Mar 2024 11:51:12 +1100
Message-ID: <87a5ndpklb.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rick Edgecombe <rick.p.edgecombe@intel.com> writes:
> Future changes will need to add a new member to struct
> vm_unmapped_area_info. This would cause trouble for any call site that
> doesn't initialize the struct. Currently every caller sets each field
> manually, so if new fields are added they will be unitialized and the core
> code parsing the struct will see garbage in the new field.
>
> It could be possible to initialize the new field manually to 0 at each
> call site. This and a couple other options were discussed, and the
> consensus (see links) was that in general the best way to accomplish this
> would be via static initialization with designated field initiators.
> Having some struct vm_unmapped_area_info instances not zero initialized
> will put those sites at risk of feeding garbage into vm_unmapped_area() if
> the convention is to zero initialize the struct and any new field addition
> misses a call site that initializes each field manually.
>
> It could be possible to leave the code mostly untouched, and just change
> the line:
> struct vm_unmapped_area_info info
> to:
> struct vm_unmapped_area_info info = {};
>
> However, that would leave cleanup for the fields that are manually set
> to zero, as it would no longer be required.
>
> So to be reduce the chance of bugs via uninitialized fields, instead
> simply continue the process to initialize the struct this way tree wide.
> This will zero any unspecified members. Move the field initializers to the
> struct declaration when they are known at that time. Leave the fields out
> that were manually initialized to zero, as this would be redundant for
> designated initializers.
>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Link: https://lore.kernel.org/lkml/202402280912.33AEE7A9CF@keescook/#t
> Link: https://lore.kernel.org/lkml/j7bfvig3gew3qruouxrh7z7ehjjafrgkbcmg6tcghhfh3rhmzi@wzlcoecgy5rs/
> ---
> Hi,
>
> This patch was split and refactored out of a tree-wide change [0] to just
> zero-init each struct vm_unmapped_area_info. The overall goal of the
> series is to help shadow stack guard gaps. Currently, there is only one
> arch with shadow stacks, but two more are in progress. It is 0day tested
> only.

I gave it a quick boot test, all good.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
