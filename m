Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E77366816;
	Tue, 10 Feb 2026 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770736287; cv=none; b=F9VI4ZIoCqDT2XpknMCaHJsLv0Gej+8ezSLSJh3u1VckZmbOTF+eC92UmAMLSlgI1y9gh30O7WzyzFKTWO63USIONRxG6vAAMto9pyvhRVGjceqh0pDyeIt7sVo4zrsPmq6Cfv6GmoCpIK12rkdm0uPeuO0bHejGlIAIb+CIXL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770736287; c=relaxed/simple;
	bh=DrZA2lEnZtuNLdn/aPtjSDtEw66qk6VI5lqRaUZw6MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0cn7DgtPpvM9XxI1kMzn2KK8IfEtOUMygVTdaR14yPjbMJ7ioEccbHg349YGwLJOjz58j3ANaOfhiCpBGRua3qda3nbNBCEeCDFZcuJmpGRHpWjmp1hK0ufoeLKBYmKT9F4eqpoc6kXklq52TmR61fxp6J3yE5qz3hgqU1pTkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urq6vVA5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urq6vVA5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8C5C19421;
	Tue, 10 Feb 2026 15:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770736287;
	bh=DrZA2lEnZtuNLdn/aPtjSDtEw66qk6VI5lqRaUZw6MU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=urq6vVA5/zKz3Gz1KYHkENaWXWCJIrhCTsYUwnayOnesr9oKXBBLBNMjlu+XBMlsX
	 uvq+Efs174+4yyISyJyhtDzzs/cN02rvp2iUIhXHkx/anXX8qt9ZAmETpPgSslZHmi
	 dOfA+PMsiB9phlzplVn1h4BGTREeTKK/mGvc6yXqdxvQxzLhPLxFwqFd5ksvBLgBcA
	 bXe2QTazQVXJjMFOS7sSTsI47jqhux9/INIvbsc/ERm/5Uzn5QYdEvPtT9gAmiWW1c
	 l9kJ02GWTagzlQ4QKwDTfsaZp4dl08KF0CAozjxLRxRQf1YPFG1TFMTQoA3lk8WvtB
	 TCA+9Vof32JbQ==
Date: Tue, 10 Feb 2026 17:11:08 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Vineet Gupta <vgupta@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v2 2/4] mm: rename my_zero_pfn() to zero_pfn()
Message-ID: <aYtKjEYYiVDRi7vF@kernel.org>
References: <20260209144058.2092871-1-rppt@kernel.org>
 <20260209144058.2092871-3-rppt@kernel.org>
 <b932ac24-2465-4176-a5fa-d9b904600a15@lucifer.local>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b932ac24-2465-4176-a5fa-d9b904600a15@lucifer.local>

On Tue, Feb 10, 2026 at 02:52:56PM +0000, Lorenzo Stoakes wrote:
> On Mon, Feb 09, 2026 at 04:40:55PM +0200, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > my_zero_pfn() is a silly name.
> 
> Is it too late to ask for it to be renamed to lorenzos_zero_pfn()? I've long
> felt it was mine, due to the previous naming, and I feel like maybe it's time to
> make it official... ;)

It's not too late, but the pfn will go to the highest bidder ;-P

-- 
Sincerely yours,
Mike.
